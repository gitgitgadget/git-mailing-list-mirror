Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC4C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 23:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiI1X74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiI1X7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 19:59:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F254715804
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:59:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so2253166wml.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=Y4c9CMm4o6JMMUDKRMZAvhUktLvFylWwHyWmx1GR7ow=;
        b=QY1gkiH2+Jy0DLHox/QXwdg1qUWAvO4uQYysVdgUeoWk5xYzyGWCkY/gMehKQncsdR
         uTPf4hcT3MovtJHzLn6PbqqJzhbm6ThIkuRQ1RXJsVWH3VDIU7yIMatVCl1nQEkXrBLT
         wkEvZH7S2kh2oer7y4A7z9kyObeNs/GmLyDFemBBNZKxXc0mK5d7tQK80gIy/fnFoUUY
         ShDx/lrQRkOq5M7H2noGYcXpSIyC7Qz81+AqjYlWidvThlm7safe1/SR2y0S4q+KSscU
         Lj9tvZzWMP0XixQxOgRwOAxSC7mjUy9dGfp2b3U169CWkBYaQdbRYobUnA3QH2rm9Ypl
         +ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y4c9CMm4o6JMMUDKRMZAvhUktLvFylWwHyWmx1GR7ow=;
        b=YP2a3+Pqlhc7c4S9cjeeIvqFbp5ooQuccqQJvILh38t+01iau4RixF97ArUXBUIWT1
         2F6MBbv7oTBglAoBi1psTMn28DKASYNcO0GWASdK7HSndQ2wtXY9o3RM2ZOxpuPrUkGm
         ZlE290fSaNJ8zeryZyJb6OxpUr+DskOHPOE4I9HO7TJKUxyuY8yygHpw2Ylem7G6LRu5
         jcYowo10DtWzNioA0ZY7X10CnLC3dZOU/KyBYXIGuNIlcEXAIWARh7oIxW/SzxEOVfrM
         hihoLmJZvTPprb1jMCAIppWMTFTR+FBWr5JinGZFpn3hhN6gqvWRf7FOPHSxQV/B3pWU
         u/ew==
X-Gm-Message-State: ACrzQf0iKI+gBxuLMN7X/LOIowOJ6yJ7xMuQ2Nds+PKszWpLionUIHP4
        3jh74b3falv0ennP83plk0t+juxn/6Zfeg==
X-Google-Smtp-Source: AMsMyM70zc0cSmx1HV28NOC6tepSc+yBUOWM0RECPGPIltQcosZhTlRpIX2GO4x6QgUsmQgp7dIIjg==
X-Received: by 2002:a05:600c:1910:b0:3b4:bb80:c951 with SMTP id j16-20020a05600c191000b003b4bb80c951mr8721235wmq.81.1664409576507;
        Wed, 28 Sep 2022 16:59:36 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600016ce00b0022aeba020casm5338622wrf.83.2022.09.28.16.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:59:36 -0700 (PDT)
Subject: Re: [PATCH] branch: description for non-existent branch errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com> <xmqqleq6ovh4.fsf@gitster.g>
 <26a5cbe2-d821-e7f6-e56f-4ad90ef2cf2d@gmail.com> <xmqqedvw1mmu.fsf@gitster.g>
 <xmqqzgejtmkd.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a55cf3b7-218d-3c8b-ae1c-c09d49caeda8@gmail.com>
Date:   Thu, 29 Sep 2022 01:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgejtmkd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/9/22 19:50, Junio C Hamano wrote:

> But stepping back a bit, in the longer term, we might want to change
> the behaviour of "git branch --edit-description", at least when no
> branch is specified on the command line and we are on an unborn
> branch.  It is merely the matter of setting a variable in the
> configuration file, so there may not be a strong reason to forbid
> 
>     $ git init trash
>     $ cd trash
>     $ git branch --edit-description
>     $ git commit --allow-empty -m initial
> 
> while allowing the same sequence with the last two commands reversed.
> 
> After all, renaming a branch with "branch -m" does not to require an
> existing ref that points at a commit, i.e.
> 
>     $ git init -b master trash
>     $ cd trash
>     $ git config branch.master.description "describes master"
>     $ git branch -m master main
> 
> does work fine and you end up with branch.main.description at the
> end.
 
Indeed. And "--set-upstream-to"? I haven't found any reason why we
shouldn't allow it for an unborn branch too. "--unset-upstream"
already works.

Those changes I think are worth doing along with the fix for the leak
of 'static const char *head'.

And then the error descriptions.  Not just the capitalization but
some similar but different messages too.

I'll reroll this path with the test for the current errors.

Thank you.

Un saludo.
