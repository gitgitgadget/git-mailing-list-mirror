Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BC120706
	for <e@80x24.org>; Tue,  5 Jul 2016 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbcGENAZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 09:00:25 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36852 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbcGEM7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 08:59:47 -0400
Received: by mail-wm0-f45.google.com with SMTP id f126so136440698wma.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 05:59:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JvU2/7H5dn/skk3ECGJbuamVvufirndbho0i+pBryHQ=;
        b=04IQXnRia9UNmFCDBxEVfBFD4+k4mB8awO+wClT2c902JNbylSiESWhuLy/Gb9kJ0g
         p3kUXQXLUA21vFSZwP+yTePOyK/b7KQ7Kvs3B+Fu+gOa3jNWmyjyDG6/Nv/yVMZODOOj
         011q45AyIymoWHDGtjkzxzRqzdUn/RcFhP1oeui7WoPXw2rRDdVbDQ/nDQZoxSccv/kw
         BUk+McHmKIy6u8WQTJ0BviHPxGRjYrGd6kE0RUhDZJ+O5aFXrVNC0tit6BBwTyGbNfaT
         MA6kfSMa6qQbUu5yDwPNUxDsLUIIYSbVRgVSAnoOq/i83VUZSbDpGwg2SJ9WjaubjCPt
         gZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=JvU2/7H5dn/skk3ECGJbuamVvufirndbho0i+pBryHQ=;
        b=XQIXVxEJ/QJovW3wyBzMsxtnXY0zgT7Aj7Zp7F79NjHq28A6PRWUb3hI3IflUcPX6Y
         rfumkyQPJp/dP8JWyYnIOFifqDKXbr4IBuSCKEy9GYvEJmZ9mxtU+aNf6WQodN71DK/V
         sUnNv1+8pl+SqyYc7ELyazSO5kc+1bT4bUeJ35HPbjIZHUJJcfBGOoJli9eKOzec3nAy
         fN4LAMBK/XazNo9zJ+/+QYvlnW8CcdCzXGEoHvRkY+pSgZIKfaKlI7jNp79STdv2X6lp
         wFccLOyK7YAGIeQ9jbp+7vQMEExuHhg0TmvDYX70Ttl2n1oMybpgIs8tLfX5o4gDGgsS
         uqyg==
X-Gm-Message-State: ALyK8tIiDjyrhYgr0uv7N9PItOrWhHpJ7XDg5ujtCGzIVVHLWA/7tQzUMQtEawTzSxgeYw==
X-Received: by 10.28.46.129 with SMTP id u123mr15436027wmu.19.1467723586121;
        Tue, 05 Jul 2016 05:59:46 -0700 (PDT)
Received: from [192.168.1.34] (acvd198.neoplus.adsl.tpnet.pl. [83.11.109.198])
        by smtp.googlemail.com with ESMTPSA id ur2sm2102637wjc.33.2016.07.05.05.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 05:59:45 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <xmqqlh1n1w84.fsf@gitster.mtv.corp.google.com>
 <20160629223007.GA4726@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607051339040.8378@virtualbox>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577BAF3C.90601@gmail.com>
Date:	Tue, 5 Jul 2016 14:59:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607051339040.8378@virtualbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-05 o 13:43, Johannes Schindelin pisze:
> On Wed, 29 Jun 2016, Jeff King wrote:
> 
>> I haven't thought hard specifically about merge bases computation, so
>> perhaps that is a case that isn't helped at all.
> 
> I guess it is not helped by generation numbers.
> 
> But then, we often ask: "is commit A an ancestor of commit B" e.g. to
> check whether we can fast-forward. The way we do it now is to compute the
> merge base (singular: if there are more than one, we stop at the first one
> we found) and then look whether commit A is identical to the merge base.

I wonder if this query can be answered faster than finding the merge base
(the common ancestor) with Git core, and if it would be worth it to expose
this functionality to shell...

> If we had generation numbers available, then we would have to change those
> computations in order to benefit from them when determining ancestry.

Generation numbers (node level / topological rank) can help with such
query.  First, if level of A is greater than level of B, then A cannot
be an ancestor of B.  Second, when following from B we can prune path
if we get to node with level lower than A.  This is so called "level
filter" in literature.

FELINE indices cut search space even more... though I don't know if
they would help with finding common ancestors. Perhaps some other
technique would be better (taking into account Git use of EWAH bitmaps
for reachability of objects).

> 
> But then, reachability would accelerate that even more than generation
> numbers.

I wonder if Git uses bitmap indices here, if possible -- they are generated
sparsely.  They can help both in reachability queries (is A in reachability
of B, or in reachability of one of ancestors of B?) and in finding merge
bases (intersection of reachabilities of A and B, or their ancestors...
or something like that, I think, probably more complicated).

-- 
Jakub Narębski

