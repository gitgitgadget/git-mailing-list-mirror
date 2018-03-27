Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A7F1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeC0PDq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:03:46 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:45538 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeC0PDp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:03:45 -0400
Received: by mail-ot0-f182.google.com with SMTP id h26-v6so17362906otj.12
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h1bGb4VnHk90drfY1Z3hJD1H9OlT7CzofFAEbwnkR5M=;
        b=uW9/xp9Y6i5SSJOZjS5hc6bK3cWoemvjk4IFeCZ0BoJbYczH+h3Tw9ko0dEKc6QyYd
         XVj1kNeyCMBhp2JvsDM03lIjjTygEqxRtZGu/qR0178OQYn22c1sHSqi+GCBsXVmWbBf
         7u173W40wwZfvX2I9j635ZuZ9hPNjAepu5Jt77QqTIEOxFNeJkP874szd0ck8LFXVJ3B
         U5dZO7vk6UmWRfEIgqkQA51zoMB5T3jpRrw3R27mt9MNWQkFlZh1tZwXmVpKAJiwc5Zg
         z83l4XZOR8BbTCI/W65Tu6pdBnLqdPn3/0g4GyT+zi0BIWpQ5wSU1ken7Uou7jVj/HKw
         HKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h1bGb4VnHk90drfY1Z3hJD1H9OlT7CzofFAEbwnkR5M=;
        b=AQ8BcloJVDyUvj4gpDNWcJ6bStWy7nzUUoK9l/HG41YgPEjYYHvDpOXq2AlupMJRgd
         YB7CNm2u4q28kD5HWU/t2FmwZtctJyvzOCr6gabNi4DYBnxH01yILF39hr9xHd+1izu2
         dzuKEdK3hUx8jcZKcWenknmkyTAil3Fq+Tv2brVjiJGZy2AgyvxK/GWabH3+F+uNBav5
         mam9p5A4IiJ9nUWflputjZIEByeIFxxyvj/NGzpJ2kcDTScUqsklzswrg/j8YAOHOcLJ
         +ExskMvryF40+fPZ8qKDZzUDEGIiINlNLk1XJfP5HwDm5ei+8a3CVJYuIxMoVCh77GJl
         zmhw==
X-Gm-Message-State: AElRT7Fy0VdudJJw6x6Ty8y+u6JZ3YkSKY8R/8Dr3Fd2Jqytb/xqy56f
        Vzak6IeVRvDkyH5FFWbanx1lspKHyKvEdqjTZg4=
X-Google-Smtp-Source: AG47ELt7g7dqu3uz2X0NnAJgg+AwP+iS+YMS5OGOBFXttzwRcmC9PoB1t9XhFzdJDl1YHqJR5qq3UaE30jwPs3fwu3Q=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr23039008ota.152.1522163024785;
 Tue, 27 Mar 2018 08:03:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Tue, 27 Mar 2018 08:03:14 -0700 (PDT)
In-Reply-To: <xmqqlgeebiml.fsf@gitster-ct.c.googlers.com>
References: <20180318081834.16081-1-pclouds@gmail.com> <20180324125348.6614-1-pclouds@gmail.com>
 <xmqqlgeebiml.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Mar 2018 17:03:14 +0200
Message-ID: <CACsJy8B_KPGroNVWskeTXu9NuYoSUAoSvYpfapda1_0A1PUwPg@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 12:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> The set of extra warnings we enable when DEVELOPER has to be
>> conservative because we can't assume any compiler version the
>> developer may use. Detect the compiler version so we know when it's
>> safe to enable -Wextra and maybe more.
>
> This is a good idea in general, but we are not quite ready without
> some fixups.
>
> Here is a quick summary (not exhaustive) from my trial merge to 'pu'
> (which will be reverted before today's integration is pushed out).
>
>  - json-writer.c triggers -Werror=3Dold-style-decl
>
>  - t/helper/test-json-writer.c triggers Werror=3Dmissing-prototypes
>    quite a few times.

I expected these (and it was a good reason to push this patch
forward). I think people also reported style problems with this
series.

>
>  - connect.c -Werror=3Dimplicit-fallthough around die_initial_contact().
>

This I did not expect. But I just looked again and I had this option
explicitly turned off in config.mak! gcc-6.4 and gcc-4.9 do not
complain about this. gcc-7.3 does. What's your compiler/version?


--=20
Duy
