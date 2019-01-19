Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707881F453
	for <e@80x24.org>; Sat, 19 Jan 2019 16:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfASQs2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 11:48:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34114 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfASQs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 11:48:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so12716611lfc.1
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l+6uJhdl4mwWdC0Fn51DWjTUEFYr25kdblpc+5C7UEo=;
        b=tZFJRXE16QVqf+Iv/P9n2ZjZ1dCvWr7DqM7+Tv8PZ2emyKj3FEkxZeM/tnMMano4VB
         ns+ijVHp+GmRsQ2w6OW1FGlt7IDo0gE2UJjuoY+A5soSAXa0grvYivoZpf0IduXPa5OM
         Br0sgVhi10AWvspWU7ZY362a0CzBNOmCaM0EFEezzRlFv0cLnxtl54kSJ2mtHVoV4igH
         E8C13LKlVnEyc/Ud5q8AeR62q5Q/H7XkAdo1F1ReDoOg45gzF3c3DG9qBcgm1Cxqfv7R
         rbnuHdsIlzxqDZyGVvRX5bQ14RgLLpy/P/J/R/1+H9Rm+G24drg4d1gjuIds2BYHH0lR
         HFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l+6uJhdl4mwWdC0Fn51DWjTUEFYr25kdblpc+5C7UEo=;
        b=ecf3C+2pktrRNhk2QWAkwbOkFLahCQLwMKBla8rPu4vsPtnHPaXr4wCVkJVGYNfoT6
         xLZ55w2zSGqcYxryQjntYSy+d0G3hMte/931iGBJFuK+Av4Q7PYTnnP6IVNaUX2BRJH/
         +t09tLG4ymlcxTK/h6xPCQ2/cbxE3Uyy1Z3A2jOEQLABfc3ZGwL4LLxv9ga89FOtWnR3
         y/pacP7D9iqjZTK7/3Rf14pBRHMr6SAdLPycUk/ausQ+qAUbVLU6nhFR8+Xv4gttrW4N
         5A6kqzf3VOviJ40qLjASuI38NayuU076AA4MXCcPocgMdcViXwXPBoDDoL/LzZzv5gMF
         m4yA==
X-Gm-Message-State: AJcUukcVcXiNj3rQthc1h8QYHofiGzYmDVq4e8B16v3I9o1Ge7/fZXSh
        +5IjXclrErekNiuS8mlhBcnf8KZR8kPX2QgZhKjYCRxE
X-Google-Smtp-Source: ALg8bN55qVujcF7IdS5ktQb90YsexFZBxVovmVKxMYmxUzqHXS/v4WmEEtLZX7Ro9QWrLNS03Ns5swBpVI4eZXwYlo4=
X-Received: by 2002:a19:5510:: with SMTP id n16mr14765487lfe.68.1547916505624;
 Sat, 19 Jan 2019 08:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20190119033530.4241-1-brandon1024.br@gmail.com> <20190119154552.12189-1-martin.agren@gmail.com>
In-Reply-To: <20190119154552.12189-1-martin.agren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 19 Jan 2019 17:48:11 +0100
Message-ID: <CAN0heSocQu+w9V3HUJDQVtFZ-NT++dubyt49QOMfvHpJSfNgZA@mail.gmail.com>
Subject: Re: [PATCH v3] commit-tree: add missing --gpg-sign flag
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 19 Jan 2019 at 16:46, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
>         # commit.gpgsign is still on but this must not be signed
> -       git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
> +       echo 9 | git commit-tree HEAD^{tree} >oid &&
> +       test_line_count =3D 1 oid &&
> +       git tag ninth-unsigned $(cat oid) &&
>         # explicit -S of course must sign.
> -       git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
> +       echo 10 | git commit-tree -S HEAD^{tree} >oid &&
> +       test_line_count =3D 1 oid &&
> +       git tag tenth-signed $(cat oid)
>  '

Or, a bit simpler:

  oid=3D$(echo 10 | git commit-tree -S HEAD^{tree}) &&
  git tag tenth-signed "$oid"

Martin
