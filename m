Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA7D1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 10:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeKYVbf (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:31:35 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53240 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeKYVbf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:31:35 -0500
Received: by mail-it1-f195.google.com with SMTP id i7so24097068iti.2
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T/7q41HZbPope4YPOEpOHuLdFL3LES27OAwkLBleF+8=;
        b=ngMCF+g81dI1racEoEGOTnSkjLq1EqBueeVwUQdH85F6sp4On6AmKzZ5tlNY1d54+h
         31L9EXHv3/B3eHkG3fTqFANtnuaFHGygztkn40fcn5wq/V93At5XISW9M/h8dUHb4Xax
         ppChPGBRPSsU15vFKXmxWP3OzlwNumeurniXnKRs/a9kWALctRr1aPoQy1KZDi4i34LZ
         FP48EGrSamFUlHgyShf8aF5cYhUcX1PSENvwaojELNduloZjlJinq9X1tkHQm/cQjktE
         aZR2gT1igee6XKHSXwCuiofSH3XlcT2+wEf0TgwfQkb8K9yQ4YUm0IfZ8HrW5L89lk0H
         UWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T/7q41HZbPope4YPOEpOHuLdFL3LES27OAwkLBleF+8=;
        b=R5FcgD7vM0xyaYKk9rrn1br8JCv936EOlwwt3Su6oWql7LgIVMUhdmLrp3ZtUpmhnw
         mU6x4R6fqi+z+2EZ44/y676GEDu6XKCpOPTJeTz9V0tc/SOPmDcrBvR8t3gbEm6wCMyZ
         AlnUOU4ke8ybdtWZNO38SZGeGY/T9cOyVxfYw3OouDCDM+EXBOXJiHJPuU4B8qNnSo+7
         lfIVkRMc63zOUM97VBEwfiUoyh3DKqduDDg0eGc52qXHdqbby4na1PFN1yRMYsBoCEu1
         SgLJ8Q0LzqMdXUj30tYi+hj6HJlM99rF74dhj7A/edC6eOPmGG+VpUkzvDLZoKtSt9dB
         6oTg==
X-Gm-Message-State: AA+aEWavoqM/Z+NMUedLunDsgtmzGFhn0Nru0juHM4YthYAQva9UQpBy
        K1TSK3WyX6rB7+XxNmiML96oGXF28a94e+h/MKM=
X-Google-Smtp-Source: AFSGD/VlrjgM+Bue5zORv4jBiKNinrdNg/zdZbfKaPFwA3go2e6Rm06+I6575ySejMJX7Z3X6hYi3B7dlejbJC6rDss=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr19115274ith.123.1543142448082;
 Sun, 25 Nov 2018 02:40:48 -0800 (PST)
MIME-Version: 1.0
References: <87a7ly1djb.fsf@evledraar.gmail.com> <20181125045816.12185-1-pclouds@gmail.com>
 <CAPUEsphe9eXk8zLE35iRq-M9a-tukj8APQ0gHzR6PHfNZNLxLA@mail.gmail.com>
In-Reply-To: <CAPUEsphe9eXk8zLE35iRq-M9a-tukj8APQ0gHzR6PHfNZNLxLA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 25 Nov 2018 11:40:21 +0100
Message-ID: <CACsJy8AJZ52XuWoCiMT_2=RT_a3OaAhSuekc1YY2-B9zc6y64Q@mail.gmail.com>
Subject: Re: [PATCH] files-backend.c: fix build error on Solaris
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 11:19 AM Carlo Arenas <carenas@gmail.com> wrote:
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> clang with -Wpedantic also catch this (at least with Apple LLVM
> version 10.0.0); recent versions of gcc also include that flag and at
> least 8.2.0 shows a warning for it, so it might be worth adding it to
> developer mode (maybe under the pedantic DEVOPTS), would this be
> something I should be adding?, what are the expectations around
> warnings and compilers?

make DEVELOPER=3D1 DEVOPTS=3Dpedantic (with either gcc 7.3.0 or 8.2.0) can
already catch this. I have no comment if this pedantic should be part
of default DEVELOPER=3D1. But at least in controlled environments like
Travis, we could turn it on to catch more.
--=20
Duy
