Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3690720281
	for <e@80x24.org>; Mon,  2 Oct 2017 22:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdJBWk4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 18:40:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37335 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBWkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 18:40:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id o1so6182259pga.4
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9dFA1YrwMnRNSO5xa++XKlEcfePMN3gI+WFDOuEcg0=;
        b=ttJxdUMb7fdGrD3wSVA8IMe5rIpNuKQMaH52jyyKkg34PAfV0drbkIpMLcpx0+Nv+N
         Ot63oP5oaInNQ0c0DB7Q2ckLnNko4EwFA8NVCZURgGybRGXHAod6EIiAiSNo0TKBrI2N
         GumoAX9jOyXzwqDNYdqLiXQODZNCNkNRVy/nHNVbSbiCqccnRY5n2C9vzZNvSkUuAzI8
         /Iq4/VDl9HFjDE5ZHxDDH5dIO5Ht7CgGY4t7KArklXhGScaBj/kVkcKJV4C5Ezg84cv8
         2bwuHSP7ReAv46HbgtnMIIFdJzifJwqH2X/bSHqgB+Ww49Av22O63e/uE5hM/CSwS13+
         eu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9dFA1YrwMnRNSO5xa++XKlEcfePMN3gI+WFDOuEcg0=;
        b=IQ1aOHDj3lVwdRlzReNw2flRRfq6h6RwVbCmTSYnUR/fz3CyOYWHYQNr7IbBh3mr9n
         VLkj+rEyd3LQYFvpSVvCH5NfNrCP5gqnvZ1Hlgjp9YyEq4BDo9fcIpol3TM8Ov1YCmXB
         MpcLTWCnFD1RIXxp+E1BLcRyUBNpddP584MWzzNLtwMA28v+on9mMvQG14vA67cEvL27
         oTi6AkRHJ6Zzk8DN1wkvBYRhsMhQGstbga5wCYDYDxtwfvQMhAtmnBs5IRfj4uoGmTqw
         1SDP92xtNPD2RAyN7J7Vf8VYP163LYRqrIl0DemUt/yTz0KQWxk8tjQEnwLbvjqYCKmL
         EGZQ==
X-Gm-Message-State: AMCzsaW/gz1QH5/mh90e2deR2RrJPHLY0+pgLAx/EpLFpaAltWij36Nq
        c4ch6C5FiiHqwjNIcPG2wrcFq4wI
X-Google-Smtp-Source: AOwi7QAFiHP92E26JahbN2JxtvSnVT2hO/jsmN0Qb1tEukwA50vDDT/zk/kfcZScXkWh/mBARBM0Pg==
X-Received: by 10.98.60.21 with SMTP id j21mr1231171pfa.312.1506984054720;
        Mon, 02 Oct 2017 15:40:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id w27sm8107712pfi.18.2017.10.02.15.40.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 15:40:54 -0700 (PDT)
Date:   Mon, 2 Oct 2017 15:40:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom
 parsers
Message-ID: <20171002224052.GR19555@aiede.mtv.corp.google.com>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002161034.44867-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002161034.44867-1-me@ttaylorr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:

> Peff points out that different atom parsers handle the empty
> "sub-argument" list differently. An example of this is the format
> "%(refname:)".
>
> Since callers often use `string_list_split` (which splits the empty
> string with any delimiter as a 1-ary string_list containing the empty
> string), this makes handling empty sub-argument strings non-ergonomic.
>
> Let's fix this by assuming that atom parser implementations don't care
> about distinguishing between the empty string "%(refname:)" and no
> sub-arguments "%(refname)".
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c            | 10 +++++++++-
>  t/t6300-for-each-ref.sh |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)

The above does a nice job of explaining

 - what this change is going to do
 - how it's good for the internal code structure / maintainability

What it doesn't tell me about is why the user-facing effect won't
cause problems.  Is there no atom where %(atom:) was previously
accepted and did something meaningful that this may break?

Looking at the manpage and code, I don't see any, so for what it's
worth, this is

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

but for next time, please remember to discuss regression risk in
the commit message, too.

Thanks,
Jonathan
