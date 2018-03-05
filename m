Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F421F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeCES3V (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:29:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44617 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeCES3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:29:18 -0500
Received: by mail-pg0-f66.google.com with SMTP id l4so7159301pgp.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12B3YBO0LTIJq29NSJfB4n5DLISWcDusGfzPCNQCoaA=;
        b=ZcuuJOKETVapOj3+m2uOpKnkTrD/rVRAZHD88DttwSP9cvxtbT6lC9APzcNK0dUF5d
         4hKYGheiSfdgkIGyFDgnqJ2L5F3rhibv8TVliOWJaJEh1LWCFSKRp8Vu/lNokFg+26m+
         QGhv2JwvQG/7PrQ3TDMigz3TQQ6kYrtBAEPwdynEc2yWsoaklzssDt33fIwNykUdpA1E
         h49F8AFNMg6uvLSlAQZRO+vEBXpPAexceZZCNxo+obCgx2GrexN1RghdAdiyM1+xLEx/
         MhKFtyqKhqOoANj4aSwsgmQBBgRC0yu61zpwipLyXx327VdmlolH9zs+V0N7MA3GhhRd
         RELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=12B3YBO0LTIJq29NSJfB4n5DLISWcDusGfzPCNQCoaA=;
        b=St4JFBg4iJHMRKKHzighNnQrGmqYgxx9sqWzSED9hurownF3rdt4YWP3s147zutSH1
         upuzXQzuZbvPPvB0EglZ9d89CltpWrMfB1sRONohN4u9F0RCjrR+YudBZ+WNOvHhhQbz
         oh3/cCRXS2Rnafa16w3A7mLw4+Lo2mIXnrr/meJal8KIjKhvNX1kKggjEUthzppLICef
         XoWv7e92yHwdRwOOnhpLK5oqZdAMZLG33WAlXgj0LvaHwC36OZ4XEmhMmhe/ASlo0u5V
         ZsddgbIEqPZ80/+bJaxDqi7zkQJn7gsQG9r3Zwy/gajR00CDQUaLi/8GPAV/7k716qHR
         W4ww==
X-Gm-Message-State: APf1xPDdBdi3WFtji45MwAahmCxfqNlkcszCA0E+NIuy+CkwfzJS5zfF
        nVk25gqlGVrofNLpehvdQpE=
X-Google-Smtp-Source: AG47ELvCiSBE/ZYsnaZPPY4PvuelPluAsaKO/t41nEz+FFCO1dn2GoxhOhgkrnp410Jng+rMchiOtA==
X-Received: by 10.99.96.73 with SMTP id u70mr12475420pgb.199.1520274557727;
        Mon, 05 Mar 2018 10:29:17 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e25sm24413028pfn.67.2018.03.05.10.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:29:16 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:29:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@jeffhostetler.com, gitster@pobox.com, pclouds@gmail.com,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180305182914.GD28067@aiede.svl.corp.google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
 <20180303044338.GD27689@sigill.intra.peff.net>
 <20180305182155.GB72475@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305182155.GB72475@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 05, 2018 at 10:21:55AM -0800, Brandon Williams wrote:
> On 03/02, Jeff King wrote:

>> It also accepts "refs/h*" to get "refs/heads" and "refs/hello".  I think
>> it's worth going for the most-restrictive thing to start with, since
>> that enables a lot more server operations without worrying about
>> breaking compatibility.
>
> And just to clarify what do you see as being the most-restrictive case
> of patterns that would should use?

Peff, can you say a little more about the downsides of accepting
refs/h*?

IIRC the "git push" command already accepts such refspecs, so there's a
benefit to accepting them.  Reftable and packed-refs support such
queries about as efficiently as refs/heads/*.  For loose refs, readdir
doesn't provide a way to restrict which files you look at, but loose
refs are always slow anyway. :)

In other words, I see real benefits and I don't see much in the way of
costs, so I'm not seeing why not to support this.

Thanks,
Jonathan
