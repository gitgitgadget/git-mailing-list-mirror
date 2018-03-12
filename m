Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6981F404
	for <e@80x24.org>; Mon, 12 Mar 2018 21:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCLVQk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 17:16:40 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34475 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbeCLVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 17:16:39 -0400
Received: by mail-vk0-f42.google.com with SMTP id z190so7203371vkg.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kyZ34J4qUjQDnviK8LABpyHH2ckUy1+mrMUmyHNi098=;
        b=W0AUWTnMOzdRT91IfUiMx8SRFu/jSBGSwD5Zub/ATW/eSDPxyR01rL1pjbxh93M03L
         porN6qey5AiHZWF4W2nCocv2bB4pp+tQrmzQipgQB5blU69yGtCGcuBe4qmKai4eG8Lo
         DY6+rqdvhSIsUiLh5tZiKr9NnJUTQmPvDYmDlcS+N+df0iPQy4Sqagdk4+C2HXaRdRA8
         zK9n9LkUa7E2Asujifjbt/J78JGtwgMiNxgQSfCnLMn9gOyjs5//eM8nL+Oq6LzyuheD
         hZy358YKTXJBq+PdHuH17UZgq00q5FVA0vi8OZNuIZRyegb2rs6nRFcFOkhRlIWySvdM
         6acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kyZ34J4qUjQDnviK8LABpyHH2ckUy1+mrMUmyHNi098=;
        b=i11DwnV18qhiXi5Qj18nKT9Frrd/AyIQ4gMAa9hUhmpPmY3hA4yYombInVVT5O94Hp
         dDOZeYSZ8eglhebVQBZ/z665r8BppRWBFX+839XoV+RGJa7pynbooS7Ts0yJ5ZbLSJBt
         twIqRdWAF+sgF8K8HnC4miKXrDKYQ8ZoKZF54uAw7h0Yx6d55r841VcDjH844DMbB9ta
         uakUCkCgHaEASHqnQ7LhtnwlOuHM3JlGbwVi/3AE8ggvPpco+USPRUoYc1wt4X3Y65P+
         SURa9xZaAIqPi7LeY/JU7qZSoFspLl48YudJqFNm7yx+CMAlcesxVYj1fCyW2VNyjcZm
         bWgQ==
X-Gm-Message-State: AElRT7ETECJVaKC37NRsg9V5mSj7aaiFBb8J+okeXyjwjIu3tGzk0HzO
        E3exDQaocviW/vFEZnC5ROllBLdddAzW1o5B5iQ=
X-Google-Smtp-Source: AG47ELsdf86C8qT1+d27tePPUejIsdU/v9b3Npi2O+LWxkHMd1mVMCoMgUMhP3YhzgPKT/XrKavEnnN6tqA01sGeWbg=
X-Received: by 10.31.194.78 with SMTP id s75mr4241778vkf.118.1520889398437;
 Mon, 12 Mar 2018 14:16:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.191.140 with HTTP; Mon, 12 Mar 2018 14:16:17 -0700 (PDT)
In-Reply-To: <87bmftqg1n.fsf@evledraar.gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-4-pclouds@gmail.com> <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com>
 <xmqqd10f20k6.fsf@gitster-ct.c.googlers.com> <87bmftqg1n.fsf@evledraar.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 12 Mar 2018 14:16:17 -0700
X-Google-Sender-Auth: aFMCrA2lFdwuoekPp1eDK8Ps5qw
Message-ID: <CAPc5daUcA8MVKH515gvDzUXBThq=8+EXouOQ2zxZGmp5YH5nfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to
 "repack -ad"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 11:56 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As someone who expects to use this (although hopefully in slightly
> modified form), it's very useful if we can keep the useful semantics in
> gc.* config values without needing some external job finding repos and
> creating *.keep files to get custom behavior.
>
> E.g. I have the use-case of wanting to set this on servers that I know
> are going to be used for cloning some big repos in user's ~ directory
> manually, so if I can set something sensible in /etc/gitconfig that's
> great, but it sucks a lot more to need to write some cronjob that goes
> hunting for repos in those ~ directories and tweaks *.keep files.

Yeah, but that is exactly what I suggested, no? That is, if you don't do an=
y
specific marking to describe _which_ ones need to be kept, this new thing
would kick in and pick the largest one and repack all others. If you choose
to want more control, on the other hand, you can mark those packs you
would want to keep, and this mechanism will not kick in to countermand
your explicit settings done via those .keep files.
