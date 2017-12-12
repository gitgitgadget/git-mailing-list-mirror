Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03F61F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbdLLXVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 18:21:39 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:41850 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbdLLXVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:21:38 -0500
Received: by mail-wm0-f52.google.com with SMTP id g75so1737625wme.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 15:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SgxxOivBJCKea5iJpOh7jqBDh8SUMEIudA1sObbzoSU=;
        b=DAfVAb/VY6aeTNyHH3XX4GEagw64pbc+ThanL9TzBskoDw8g1XmtItAevsO7vD3KfP
         L6k0lXGVvMZWs5VkxrlUAxRCFxfF1kXwGmXUyqRf02FJR0vf1Nm5nw/Hmh0DwlJvAfrM
         1I9eDXd4OKZu3ZN4x07PfekOYt/zf5xPsAG/+Mw73zcxZdEMVPT0TCeT45cckURqTyoR
         ScUjl36fwTZSj/AiXGZXNPHsObTG5DVcN23DZ2Pdfugze3WTR76SiCGc//Wp7aWBZIEk
         ve5nAtn8Nxjck++cf/xCNd4r88vaMgE9e4jmELK/xb0OmnaLziQGt7zWTvbN+nULGl+S
         7MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SgxxOivBJCKea5iJpOh7jqBDh8SUMEIudA1sObbzoSU=;
        b=XLWQG0ExX97Xgph+RJNwOtwsyriyWzEOHvDB97MY7aHQItL6n2fWLxEbmcCM/bT0Ia
         v8DsCiLJqr1EhEUQetuiyl0ieKZLBBCdCEqh8Ovccg9m5+f1Yro6uuZgsCtYDtmFqqkX
         osGDUUi7XXoP2UtlHFogTkne6zHpIs5EGy57mPaRUDnOTIios+YqJEhYvtVVYFU+PSZs
         QI+mGdrbqcx7rH4Lrnl/9yuPalgXSLN0jA673GPy4MSpJLtWOGP7sCXzYkSFZl6G34UH
         ehun975GORCg3wP8OdiyauAi2V4H32djNpHz4QFwei6pVPLnfZMh+4LqyBkQD0wqRVTY
         sBPw==
X-Gm-Message-State: AKGB3mL/bV6s2r2FdEY21AnGO+8hSkJF7tOQIgV5RwRrFNlgZQ7cZUzS
        YIRAZ01HHST/frZmWhCJoQU=
X-Google-Smtp-Source: ACJfBotRMyWBJEop9/HC412Pl4YLcodv7GHSQqPZSxawI0DETAMS380dMDq9xCTDDSI1iuBDMZgAoQ==
X-Received: by 10.80.179.137 with SMTP id s9mr4982124edd.164.1513120897457;
        Tue, 12 Dec 2017 15:21:37 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b30sm384141ede.53.2017.12.12.15.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 15:21:36 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eOtrj-0007Ck-6w; Wed, 13 Dec 2017 00:21:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com> <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com> <CACBZZX4DFXYNZyU-QPrun2g4zTpt8u6yE6DsEGsQvOEhUNRd8Q@mail.gmail.com> <xmqq609bziz5.fsf@gitster.mtv.corp.google.com> <xmqqy3m7y2mz.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqy3m7y2mz.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 13 Dec 2017 00:21:35 +0100
Message-ID: <877etrcz28.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 12 2017, Junio C. Hamano jotted:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>>> I actually think that the block can go even further down, perhaps
>>>> close to the run of choices "what variant are we building?" we make
>>>> at around we have "ifdef NO_CURL".
>>>>
>>>> Ævar?
>>>
>>> Makes sense to me, do you want to squash this + your proposed edit &
>>> I'll pick it up if there's another version, or I can re-submit.
>>
>> OK.  I'll squash in the 'move it further down' to the original
>> commit that removed DC_SHA1_SUBMODULE and added NO_DC_SHA1_SUBMODULE
>> when rebuilding 'pu' branch.
>>
>> Thanks.
>
> Another minor thing I noticed (which I do not have any squashable
> fix for) is that "make distclean" does not even work without
> submodule or this environment, which feels a bit too excessive.  I
> haven't tried to figure out how involved a fix for that would be yet
> and I do not mind leaving it broken if it would be too much work.

Yes, that sucks. I can't think of a better fix for it than this massive
hack of outsourcing printing the error to the header itself, which'll
only be executed if we actually compile:

    diff --git a/Makefile b/Makefile
    index ba3e061edd..881cf55159 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -1022,9 +1022,7 @@ GIT_USER_AGENT = git/$(GIT_VERSION)

     ifndef DC_SHA1_EXTERNAL
            ifneq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
    -$(error The sha1collisiondetection submodule is not checked out. \
    -Please make it available, either by cloning with --recurse-submodules, \
    -or by running "git submodule update --init".)
    +               BASIC_CFLAGS += -DERROR_SHA1COLLISIONDETECTION_SUBMODULE
            endif
     else
            ifdef NO_DC_SHA1_SUBMODULE
    diff --git a/sha1dc_git.h b/sha1dc_git.h
    index be1d48abbe..93a9be976a 100644
    --- a/sha1dc_git.h
    +++ b/sha1dc_git.h
    @@ -1,5 +1,11 @@
     /* Plumbing with collition-detecting SHA1 code */

    +#ifdef ERROR_SHA1COLLISIONDETECTION_SUBMODULE
    +#error "The sha1collisiondetection submodule is not checked out." \
    +       "Please make it available, either by cloning with --recurse-submodules," \
    +       "or by running \"git submodule update --init\"."
    +#endif
    +
     #ifdef DC_SHA1_EXTERNAL
     #include <sha1dc/sha1.h>
     #else

But maybe I missed a way to make the $(error) path work only if certain
targets were about to be compiled.
