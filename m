Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFD61F661
	for <e@80x24.org>; Wed, 12 Jul 2017 21:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbdGLVDM (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:03:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35275 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLVDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:03:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id u23so1257494wma.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yrRqBj0ED7tMAeILuE/f1OD+aN1njGmy24U+Jg0hC+A=;
        b=CGikvlQ5LclQxo5YC/YijuqN4TI8H5rtumprPywql90ExWZpUNBq75i2wpmnSEzaDV
         Znv+viye9X+WWGjTnutmwoyO6Gbq9DTVaZ5ec/U7tiUvkk+PKuCJgKc1WVyJ2+Xyg7jP
         Rx4BUs6y5moAZjNM6J9svKPcJdsPyQVv/Px4HUi5+ee3hRxlzzRO5jlQWZl6u2si+fDj
         PEVK5WXPTPuuF53een9C50iXyHXts6AgcZKimNenh8Wwd4sMM4MgDUWR3qaBtltNbbOB
         Zc/N9Ko2HoA5L5vP20Iv9+jI31Zumk7h3QShfaTUbK2qyQlxoW9aseNoNlDxQgwdMTH2
         VoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yrRqBj0ED7tMAeILuE/f1OD+aN1njGmy24U+Jg0hC+A=;
        b=Awfjadlowg+/n56QZl3/GI9xDoyrsE2NjxPSNhKw/wwmByK1D5ekNVf9ZA5lxbuJBR
         qh24XfJqVdFJgaVkoXX/vLw4SljJCSU9xCiTgZuWLQi6NzIIR6Vnz69TjjToGLThcvZd
         d6y1aL6B470qujTc3eGJhmp1+jYNJLQ8zbIbhV4aPy2Mz25RZjpwWNyC6lC62uhmyX84
         hzewzlVa35NzrW2CFrnKFizEB2xdL73jPi5gEL8fhb+Ma42ozlr24BwOoY5/qalkoGxU
         YZhcBDGm8vsbvJRZvfZqFRIjGxQBQ+QSotzSzhQH11fV65hpcBDEnzroXiFws7fm764G
         wBng==
X-Gm-Message-State: AIVw1138HZ4qb2Fhsyr2/WYAqLECwHSFRDY2EMnHO43PXnH/LHdoZek1
        Re3NA1690tXQad8kQV8=
X-Received: by 10.80.192.154 with SMTP id k26mr306814edf.136.1499893390223;
        Wed, 12 Jul 2017 14:03:10 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id b30sm1644848edd.6.2017.07.12.14.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 14:03:08 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dVOmp-0006Ye-TN; Wed, 12 Jul 2017 23:03:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
References: <20170711233827.23486-1-sbeller@google.com> <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 12 Jul 2017 23:03:07 +0200
Message-ID: <878tjtz7uc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 12 2017, Junio C. Hamano jotted:

> Stefan Beller <sbeller@google.com> writes:
>
>>   I want to force myself to think about the design before pointing out
>>   memory leaks and coding style, so the least I would wish for is:
>>     *.h
>>     *.c
>>   but as we have more to look at, I would want to have the most abstract
>>   thing to come first. And most abstract from the actual code is the
>>   user interaction, the documentation.
>
> This is exactly why I invented the orderfile in the first place.
> But such a "policy" is not something a project would want to enforce
> its users all the time; it is left to personal preference of the
> participants.
>
> Just set diff.orderFile to suit your taste without bothering other
> people, I would say.

I very much like Stefan's approach here[1]. It's very useful to be able
to set something like this in a config on a project-wide basis, so that
wherever patches are reviewed (in Gitweb, Git[hub|lab], git-format-patch
etc.) they look as the project prefers.

As Stefan points out we're already accomplishing this with Documentation
as a result of a hack.

But I see why you'd be concerned about this. If you're looking at random
git repos there's a limit to what we'd like to allow them to customize
without causing confusion. The diff order is relatively innocent, but
you might make the case that other diff settings should be adjusted too
(e.g. -U0 on certain file types), and that's quite the rabbit hole.

Still, I think this is innocuous enough to stright the right balance
between intrusion and usability. Some would find this *very* useful,
think projects that for whatever reason need to commit e.g. verbose XML
config along with their code, and the framework they're using happens to
rely on conf/ and src/ directories.

1. Although nit: let's call it .gitorder not .gitorderfile, that it's a
   file is implicit. We don't have .gitignorefile, .gitattributesfile
   etc.
