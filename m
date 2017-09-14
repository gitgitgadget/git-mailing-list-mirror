Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770C920A21
	for <e@80x24.org>; Thu, 14 Sep 2017 18:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdINSk1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 14:40:27 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:51294 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdINSk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 14:40:26 -0400
Received: by mail-pf0-f179.google.com with SMTP id b70so118513pfl.8
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgS5k4ZD9O9PmWl72xecTu4+BC++7OlkWtJyKfGLuOs=;
        b=sHqgt1LJa0VFq6VlebKTbjE5z4rJyKjmejg093Txzit3NKTk6+lkMT4+UOojioRPoG
         ZtqXQZUL5JqhfcIdW7X7njL+nFsBjko465MTqNPOYwLW1DWySsg67kjZDeKG+vYKLc3H
         cty9o1J0lDlBrzlQTLE0XRuDJsBOPXrhj0Aoc/qKnbVUEGqum4+/uMoXATUwWbuiJMVk
         7LlnM7m+afHa5qgcloRCPKE5yINEdgiMI91cZsN45r08OTDoeedlVUz2Sl5RhmcvJ64e
         Qo4CFLTvgUSoH9hOBNN77v+oDW2fZle8VVsYWyqtScXlaZPXx5Evh3CaT8i6EA5Yxouc
         9Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgS5k4ZD9O9PmWl72xecTu4+BC++7OlkWtJyKfGLuOs=;
        b=dmsqqEN+MvVTGavVGlA6mEIRXogsbDw5oF68Y+DOcefgVRVHLqyfsydZvw+hngo33K
         3d+/00nEEuvhRLCQoXhrnCIyMdPMyaVGK1Blo7M3ab2fa2ytez9wDSQaiQ0IuyAVoLtC
         N1Yf9QXyJbqEHb77nmzCZzv0sMNdKTM5CQJ94Vf6w8zxZtYb0f/FLE1gDLYsrZ6rWpfO
         d02DiqNlTrf6V9Xt1tKxafx7It4Bccpe6zMcqcu9xhjn89kV9E+HSnwV6idOwZZjZ/x7
         CokjgEvdJJiE5lIp7VBu8Q1JzktADKVB/CjX0GDK+kSRwqnZJqXulSMfT4ea4a8jJutj
         n/+Q==
X-Gm-Message-State: AHPjjUioxDnduuTNni3vwsahY17lNWZTfoHMtFVNADGMLYw+3V3pzeL2
        U7ZP6Gm+6IZ6bA==
X-Google-Smtp-Source: ADKCNb4H3JHtTYvJX6IcDcoM7cWg5jUhyJrAoixETkoGcM6sLVoLr2lfDmoz+LA2JiYzQBxIKSRUJA==
X-Received: by 10.98.34.219 with SMTP id p88mr21886992pfj.121.1505414425519;
        Thu, 14 Sep 2017 11:40:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:539:86cc:e014:7a2])
        by smtp.gmail.com with ESMTPSA id b63sm32908552pga.27.2017.09.14.11.40.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 11:40:24 -0700 (PDT)
Date:   Thu, 14 Sep 2017 11:40:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170914184022.GB78683@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <20170913225158.GR27425@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709141754240.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709141754240.4132@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Wed, 13 Sep 2017, Jonathan Nieder wrote:

>> [3] https://www.imperialviolet.org/2017/05/31/skipsha3.html,
>
> I had read this short after it was published, and had missed the updates.
> One link in particular caught my eye:
>
> 	https://eprint.iacr.org/2012/476
>
> Essentially, the authors demonstrate that using SIMD technology can speed
> up computation by factor 2 for longer messages (2kB being considered
> "long" already). It is a little bit unclear to me from a cursory look
> whether their fast algorithm computes SHA-256, or something similar.

The latter: that paper is about a variant on SHA-256 called SHA-256x4
(or SHA-256x16 to take advantage of newer instructions).  It's a
different hash function.  This is what I was alluding to at [1].

> As the author of that paper is also known to have contributed to OpenSSL,
> I had a quick look and it would appear that a comment in
> crypto/sha/asm/sha256-mb-x86_64.pl speaking about "lanes" suggests that
> OpenSSL uses the ideas from the paper, even if b783858654 (x86_64 assembly
> pack: add multi-block AES-NI, SHA1 and SHA256., 2013-10-03) does not talk
> about the paper specifically.
>
> The numbers shown in
> https://github.com/openssl/openssl/blob/master/crypto/sha/asm/keccak1600-x86_64.pl#L28
> and in
> https://github.com/openssl/openssl/blob/master/crypto/sha/asm/sha256-mb-x86_64.pl#L17
>
> are sufficiently satisfying.

This one is about actual SHA-256, but computing the hash of multiple
streams in a single funtion call.  The paper to read is [2].  We could
probably take advantage of it for e.g. bulk-checkin and index-pack.
Most other code paths that compute hashes wouldn't be able to benefit
from it.

Thanks,
Jonathan

[1] https://public-inbox.org/git/20170616212414.GC133952@aiede.mtv.corp.google.com/
[2] https://eprint.iacr.org/2012/371
