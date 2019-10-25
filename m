Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18001F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 08:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408088AbfJYI7y (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 04:59:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41695 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405717AbfJYI7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 04:59:54 -0400
Received: by mail-io1-f66.google.com with SMTP id r144so1532279iod.8
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c1tMDhXYNUV+jo5B2oXHosJje3l9Cc1832ffn7rXeaY=;
        b=A1niM2I5uIAEtWuA+Ol2eMVSsV+z0TVD3csTvNOm3qTegaHqO34mjKAd4u5Z63SC/n
         tsiSeBRY8l/sHItOa4bNRx5w8DX+Q1pww1mwKyfZZEJU1ym7zO6jBEyqFxhN7vKcCgsa
         SwNx91hPJkOfJXXbWcZ/U4QgiAzPnYeA7ZWWvc/39iNat2UmaZ5jtu5VU4nhQWarhVDO
         qo9ZSEvsDz9hL2LLIN6PJjgmFVotsUrVraS+/5mQfcA7IsFlJAViRfBGGl54UWY8wzCI
         TfRnpCG7go54ugv3bklKATD90cRMtK45beDpFNqDsZrgiuJWzZe/WwEDBhvFTWMOMGhU
         zN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c1tMDhXYNUV+jo5B2oXHosJje3l9Cc1832ffn7rXeaY=;
        b=JkjjyFOguAHIjo2C83yafftha3ShzGjZ4mJb6oZ6HT+ahKvOjIADpbfOMYbUTN7ceQ
         UDfKgLiY7FaUv0Jz72SquHR7wOOOW0yKNCIAGvZuoWyKawRqlsZlzW0fq4/OxwlpWoOl
         9XUfcc1u5sqf13n4UWE+uNyDZJhL6M2Ac1icqgjjSt88mg6WwW5MQjztpU1yO3HKtR2H
         H3Gb0qfp0qGU/4/2/rHC/wqV4urnmF72gNpqoNSnTX/JPUUJNODr4LpVYViQp1o5qIjN
         cs1lfjIWdOIDOO2py0j5YKktomFCQHm8Fy8hswtvk2ZF58oyjDvhIvy+OPuK1vZxTz9a
         OgfQ==
X-Gm-Message-State: APjAAAXg2pe74sGc8yCJgR2ha4eVZqwOWdf6gQx+VQ/mQffPed3uxadt
        GDL/RJMvoiMzeDno4hubUmEk1IO93BoI3P8Qs7/jivWk
X-Google-Smtp-Source: APXvYqzRkRlB/WkWOIKZNsz9IAHl4pe/RjYkBjpVlrDOGDkqzFjuCM1oSKyswNtiswRaqR49zOVuZFsH3ro/JgP+NIU=
X-Received: by 2002:a02:c544:: with SMTP id g4mr2804730jaj.79.1571993993754;
 Fri, 25 Oct 2019 01:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
 <xmqqmudpee57.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmudpee57.fsf@gitster-ct.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 25 Oct 2019 10:59:42 +0200
Message-ID: <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, then after discussion, finally the issue tasks would be:

- Add path_exists() that will work same as file_exists(), keeping for
now the latter.
- Use path_exists() instead of dir_exists() in builtin/clone.c.

And also:
- Rename is_directory() to dir_exists(), as it is the equivalent to
path_exists()/file_exists(), isn't it?

Best,
Miriam


El vie., 25 oct. 2019 a las 4:46, Junio C Hamano (<gitster@pobox.com>) escr=
ibi=C3=B3:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > The first callsite is:
> >
> >     dest_exists =3D dir_exists(dir);
> >     if (dest_exists && !is_empty_dir(dir))
> >             die(_("destination path '%s' already exists and is not "
> >                     "an empty directory."), dir);
>
> Yup.  The primary/original reason why the helper exists is to see if
> we can create directory there, so the function is asking "is this
> path taken?"  It might have been cleaner to do all of these without
> using such a helper function and instead take the safer approach to
> "try mkdir, and if we fail, complian", which is race-free.  But the
> above is what we have now X-<.
>
