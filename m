Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C83C77B6C
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDEVuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDEVux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:50:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228834C1F
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:50:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f22so31580592plr.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731452;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaY9F3ltzZoeuwdXyraR8o9XtYvSLxnNITn/6mffZSQ=;
        b=Ye4e7fSjSQ+g7j4a54QaW/YuioUBUVNrcvc7E9ulTXnHZvUvIseO6siYQVlVh+n59h
         iZZ/n53LvxJv9Kx2CF8Ct+2wNOWyuzfuABQQqkZwTMDvmXd0yUDTg1JP4Qp1aBwVeyc8
         X7FJsmUU59Cn2acg4SiMbEZFlURpktrtspmP5DdmT1y8ieumUX4JqYbFSpraY8+k3UyQ
         T5EmMtE5zES+LBU7rOu0WHReyLvsivY5D8zoWZUV/87QSAiUiuAbIRHnWgOWIotwSOvc
         6QVr8wLpFg2cAnpvHDIxVnmpD9EtdOM3t/dLty9S8/g/2giYd+gMyGtCKOPZQxikaOZT
         p30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731452;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CaY9F3ltzZoeuwdXyraR8o9XtYvSLxnNITn/6mffZSQ=;
        b=xWOF3DHBule2duOPV2eOBdilLgCeIl8vcrp6U/FhwOsfSyu/kyi4vI+c/M6Py2xwZc
         HHWdXPedg44+4PQsQZL3FqbD4tutj5xGpF+AGUzPRia/EQxaBw/mT+Ie10VEZQIrQryt
         kl+MFL5dygiYoFEuo7rmIk2nDlveJ0plZ/aarAzoSoq7t8MLn9WNBQYnOOsjgZiUNjRg
         ETvyGNhnhZ65VPaNamLnc67dJ6tejMakijOKHTPfQ7Ok6yBUw3PxmahVbVZbAPomNA15
         F9M3BxQ2a1BenEdBw3nBjMfQ+hLEqV7OfhGIHEbYDDEAb+Vk5sjV4f337HFWc5rwItmt
         tSDw==
X-Gm-Message-State: AAQBX9d37spHnbjeVIDQ78vIGi1QZh7anVbElUhwnBxRwiIJ3BCbWFE0
        zXfQiZbLAc+LJZavU6jsIYM=
X-Google-Smtp-Source: AKy350ao/SqX4jzvY4DoAMkFmBtGvjDnjKpdjlaazt3doInXs1+BqFXdLQ37zVPenbx4qN2fo6fuOw==
X-Received: by 2002:a17:90a:195a:b0:23f:962e:825d with SMTP id 26-20020a17090a195a00b0023f962e825dmr4150384pjh.1.1680731452483;
        Wed, 05 Apr 2023 14:50:52 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902968a00b0019f3cc463absm27432plp.0.2023.04.05.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:50:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Watson <ozzloy@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: clarify MUA discussion with "the"
References: <ZC0yey+S+OD/S2tt@trent-reznor>
Date:   Wed, 05 Apr 2023 14:50:52 -0700
In-Reply-To: <ZC0yey+S+OD/S2tt@trent-reznor> (Daniel Watson's message of "Wed,
        5 Apr 2023 01:34:03 -0700")
Message-ID: <xmqqsfdet2v7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Watson <ozzloy@gmail.com> writes:

> Without the word "the", the sentence is a little harder to read. The
> word "the" makes it clearer that the comment refers to discrete patches,
> and not portions of individual patches.

Thanks.
