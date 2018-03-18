Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4FF1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeCRPz5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 11:55:57 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:39636 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCRPz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 11:55:57 -0400
Received: by mail-oi0-f44.google.com with SMTP id q71so2130277oic.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0AsEt32u4uLW662sxN+vK8uiY/Q7qGDa6RtppbH8UEs=;
        b=Fw9MiHU3WXVKTXOVBOhZ3kou4tDsfOZE3j4HeKncfve3/+EFnTJixjyyg7fnRcV2dl
         WKF6imlD97drZJZJeo9o8QqvQIiDUrTLqZdDVYgbP1W+Y8TFUPd5MAP1gUN8G7JppWuw
         NBItqa/zMGT6ujAPNUw62aTeg49RpfioR+N8nB6enGhqA66WSeyPQ6swpexLdyL9yY5M
         rMOGUEXqnSenUZsS7ouvEW1YN3H5rmr2cJUe2m1Wi7bWYduK+FckCZsY/V5poc5h8eXF
         1UVgj4mmcTuoz1I6uivExkgpiiXICQ2uJHg7H3DLKBU8+SZDb0U9vTPF0zXy+zF7V1fQ
         DK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0AsEt32u4uLW662sxN+vK8uiY/Q7qGDa6RtppbH8UEs=;
        b=rVZN72hbYz/TV73uh7vylkZ5MbToFTvGOIpFMbGG3oZ86mM7MaPUkt3r3kblE6R3YZ
         S+eTJ5SHBaruQxh1oSwnatKj7njmBRmSNpQUYdTJ2I1FQWueFL6DmI1lqbPkEsgZD/ug
         l8zIneE+Wdp3nM8to4tYKXzyE5zls5CejzDZm9GVpqP8Vym9k4ccFkFSErcz8oDF5xCn
         9jeVTGMO6EYYk8+dRV6A2Hkh0M2iEUuz5RgMvBHudq9k/kfbDfZFTgK6BAjR4h7a0N9E
         xA+SZJeiTfbxTJbouK/UApFCBWQMS3xA9/wAefhXNIqziUEivLpJkmDiTonMRO/Jo2s+
         7QIw==
X-Gm-Message-State: AElRT7GVaJeEI76Hh/JLjLUJQylgFh20YrJrKdEt+6L1gKTaA4CQMTBs
        806oKfYda8mA4wfVGH4S08V6o4QAJBBFfKdOpEg=
X-Google-Smtp-Source: AG47ELtkqzCAetwHzRiqKN4DkzPOoTrwbZXQ4M+sQdPk0xDT2tWvEzD4obJKfuhK8GwiwppM2O7DnLwgRLELCYJKxeU=
X-Received: by 10.202.64.85 with SMTP id n82mr5506995oia.30.1521388556482;
 Sun, 18 Mar 2018 08:55:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 08:55:25 -0700 (PDT)
In-Reply-To: <20180318081834.16081-1-pclouds@gmail.com>
References: <20180317160832.GB15772@sigill.intra.peff.net> <20180318081834.16081-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 16:55:25 +0100
Message-ID: <CACsJy8BOCpHiMxJ0K=_-WPf9b4yh0W0i3m9sAo5-Sk5fY9x1+A@mail.gmail.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 9:18 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> +ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPIL=
ER_FEATURES))),)
> +CFLAGS +=3D -Wextra

Another thing we can add here is -Og instead of standard -O2 (or -O0
in my build), which is supported since gcc 4.8. clang seems to support
it too (mapped to -O1 at least for clang5) but I don't know what
version added that flag.
--=20
Duy
