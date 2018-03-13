Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABE61F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeCMVXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:23:16 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34909 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeCMVXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:23:14 -0400
Received: by mail-pf0-f178.google.com with SMTP id y186so454445pfb.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XxooFHQh5MTMsAFqKFRFD/urZbjDdLOZt8ySvrfeKI=;
        b=I0C/FwriN6agpNR3DNrWj1t5vlhHXMba/5ReWJeU4HXGiCbbMkD9m80ulA8L16JrZr
         QwamAnl6BON2gDHkv3e8yQHRkzgfP5CVl4kjKaVr677uw1FECzHFhjY6QaHt+sZAlhJ/
         4Lkeqdc2mAeZP6owmZbfEpWQ6iT7qzrBxNg69jLNTGqJ5qoUuEHYdPZA6T8lMazj5fE9
         H2noMPb5p1G5GLMUyQSLDb9KJrr/9lP7guuUJYNS7Oyv/QbTBmFdtzlVF5rGHTJE93pd
         q6nVZrCxN4LSBU2tNIcmWf3Ipa/MBuWMGjG3XJCK7zK8B/umDqlFHbEBOyDQkLaykCe3
         krAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XxooFHQh5MTMsAFqKFRFD/urZbjDdLOZt8ySvrfeKI=;
        b=hA/0TFTcwA3rH39TXuhu6zd8oVzOgayKYDuoMB07mQM3OAsojjUmtxBILUsbQmoSBc
         o5/rVLCskIfsR9kEGtSTV99FffeR2wgAloUljCfrmZh+SfeBZ2WaN0GoVcGvsAMjBDUY
         aGanD8sRnKkxKmo+PW3LrPTpMEx1g4fT86VImIaH8Pc2p3QNR/rsAW5TL3QkonJzmY+r
         at3kK1LxyI3O0M0ymEdssNND/6z/K0zXVXxVYJEORYvfO0BefxCSlaZ5ckWo7awJ8Nqd
         WuxBW1NaNTxG2u+Ey+hgIhsHNpmP30ZDU1+VvvGQk19ksCYI/pilO0fzXXBHq2XqoBtq
         IRgw==
X-Gm-Message-State: AElRT7FrE2NIAWqf0M89DQ1hIRAieyAIgRu+BN1SMajBkyzm/p/QWFLN
        p4WHTjRN0D7tAUitLzTxsmLjLQ==
X-Google-Smtp-Source: AG47ELtpKR9ng6dWftqhebYzXSAweX2k9wFE5gukbEw+CQsgpMr9znHROEkh0x6xwwGDEBTbGZq8mQ==
X-Received: by 10.101.89.74 with SMTP id g10mr1615441pgu.415.1520976194011;
        Tue, 13 Mar 2018 14:23:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id s89sm201191pfk.54.2018.03.13.14.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:23:13 -0700 (PDT)
Date:   Tue, 13 Mar 2018 14:23:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180313212312.GC7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
 <20180303044338.GD27689@sigill.intra.peff.net>
 <20180305182155.GB72475@google.com>
 <20180305202813.GA5953@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305202813.GA5953@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/05, Jeff King wrote:
> On Mon, Mar 05, 2018 at 10:21:55AM -0800, Brandon Williams wrote:
> 
> > > Hmm, so this would accept stuff like "refs/heads/*/foo" but quietly
> > > ignore the "/foo" part.
> > 
> > Yeah that's true...this should probably not do that.  Since
> > "refs/heads/*/foo" violates what the spec is, really this should error
> > out as an invalid pattern.
> 
> Yeah, that would be better, I think.
> 
> > > It also accepts "refs/h*" to get "refs/heads" and "refs/hello".  I think
> > > it's worth going for the most-restrictive thing to start with, since
> > > that enables a lot more server operations without worrying about
> > > breaking compatibility.
> > 
> > And just to clarify what do you see as being the most-restrictive case
> > of patterns that would should use?
> 
> I mean only accepting "*" at a "/" boundary (or just allowing a trailing
> slash to imply recursion, like "refs/heads/", or even just always
> assuming recursion to allow "refs/heads").

For simplicity I'll change ref-patterns to be ref-prefixes where
a ref must start_with() one of the provided ref-prefixes.  Clients won't
send '*'s either but can send everything upto but not including the '*'
as a prefix.

-- 
Brandon Williams
