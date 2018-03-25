Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8873D1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 00:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeCYAkO (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 20:40:14 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43541 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeCYAkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 20:40:13 -0400
Received: by mail-qk0-f196.google.com with SMTP id g184so16707842qkd.10
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 17:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=l57r8Maole50mW0rOKI4FJOsjiBis57aCt2ozv8o9N8=;
        b=CeAR7KV9orgczf+Q+XpEPYTqzIILu1+G6yaG5aIXr95i0kUkKDlFuAufn3tWBG0H5V
         5Fgdjrfq/F1Unv9D5Oi2VktgT2WjEYgkV14k2wQ2Nr5tggo1tvlXxfMddBGfJINXG2uh
         f9HJZ1bQs8DC2MXUGNLXjWTDvIMr/qH/FQ4O9qV0awH69/unx20P9I7VsFC+SHVKdssE
         UMZykxhJb9INaSzdy87kqNlgdQvvdRwXRmzjrOxrh3SoOeIUgbMdQmEbDtT8FB4L11yu
         EsuqdGkjSjLFSlNJh6EqNoEuBBV0lflbpl+nkm2OkRmdU2mq8fv2vwAghyjRRVPqVho3
         dYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=l57r8Maole50mW0rOKI4FJOsjiBis57aCt2ozv8o9N8=;
        b=CikhjR+a4gWF6TCraym5HAIufW5Je6EiWPC5wJroDjhUAtz1OxKJ+cZkPxTJBwXSCW
         Dl5vNadKVk2/n9Fypf+Hrizuc0PkSL+d7eukor7XeBxH19iQtqU+YOD5C6PUnOgC0Dgm
         YZSRq/KsKGg61V+k1VVAlmOXj84N9FVoIPB0btrVPOG9oZkUM45bGOQlsVFhMXMfGzHA
         5R/jDnvF2ldZ+gWdz4fGe15IpFAAh1/a7n0nQ+LCi8vXscloFpcKnmOtGPy7QF2pN0IA
         cHfSx53I0GVNB+YjHEatunos+Ou90UYMI8Tr7wWoMtXKUOf8Yp4YspI2TDBLsT47uvC2
         09yQ==
X-Gm-Message-State: AElRT7EQQPrk4yX0Fhyatv85cN02QgHHfmOpgN7BRHbcZ8ieefkOS7sf
        TiRtkiTOEFiQpDu+Jub5W7fnSOnQgu4OxxD0ItQ=
X-Google-Smtp-Source: AG47ELtmeNJejXVx5p8yOmd5xBPCnTgTZ+eZj18ztit9JWibVOV6FIR8FRidjGJLz6aeaowTX0ZcbHu3LiHO4/DDG4E=
X-Received: by 10.55.22.28 with SMTP id g28mr48085348qkh.152.1521938413010;
 Sat, 24 Mar 2018 17:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 17:40:12 -0700 (PDT)
In-Reply-To: <20180324125348.6614-1-pclouds@gmail.com>
References: <20180318081834.16081-1-pclouds@gmail.com> <20180324125348.6614-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Mar 2018 20:40:12 -0400
X-Google-Sender-Auth: KEO3IxV94tDFAHQhj5aihRpReTI
Message-ID: <CAPig+cQAufB=DDgkSwz+EDkkTKEx32KJBGPdeDxuzZTdoM2Nrg@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 8:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The set of extra warnings we enable when DEVELOPER has to be
> conservative because we can't assume any compiler version the
> developer may use. Detect the compiler version so we know when it's
> safe to enable -Wextra and maybe more.
>
> These warning settings are mostly from my custom config.mak a long
> time ago when I tried to enable as many warnings as possible that can
> still build without showing warnings. Some of them those warnings are

s/them those/those/

> probably worth fixing instead of just suppressing in future.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
