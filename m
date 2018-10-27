Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B966A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 10:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeJ0Svs (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 14:51:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54480 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbeJ0Svr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 14:51:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so3661960wma.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SNXSlQbA5slH99YeRxC0Zx/sZ6B1HtBJ/7dTo6hYCt4=;
        b=M3SJeH0QI8WgOU8e7NSoexKLcUaTYIrtXjNHUiaZwpbB34o2uhsBgZmXERIOyZQlqI
         VuBZVS5PJVl7zshGm40Mdcu64rQBchn2nkMmU1EbVf4Xw3wwuhLSxGlagVV9mSMO7NSM
         NUP2Z1HY8llkIy3l4/UnZEt91IEwB8uiuGX95T/arDcWv6MIdlz1I9EAX+09+OZq2Bds
         YT54pHOx1SVl+QjksxLCiBJ4xmm53JViXv3++Si2jSWH+NAW6Bq8IebPCexf7eo/Sn8w
         hVhh0E6xCErPeonr4Cv5xV/x7EKGa6Fnt4q7q5/7Xk0WDo2/ZFFqxtDlgTyXwiYSgIQ6
         +jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=SNXSlQbA5slH99YeRxC0Zx/sZ6B1HtBJ/7dTo6hYCt4=;
        b=TptviRYZDg3LdnEseIlKHy4k6xBJ5jED2KWd4pnnzz4goiXthDiP9ZbzO4lOmHi/KR
         oTgaJQQNWOijYkBuErnNhL44rz0DveOuCz+d7Q4dl0jqIvfkQ2lwcyHxgKZ3YHPq4eK9
         lGOaXhWU41m66BQXMM2cYtzTCtd4pomYAdQBvvEKoRnpGtXR+sYoZKKhS90Y8ZXGqZX6
         nmPSkrIPAkPGQddD6oAgl0jNm5vKdlxCZDxDIrij2A+c9DLZFeQ5p1Bha19HhQMs0nkL
         PCBjIA5lxv2ZXQYNFZZHcotP2qw/1ve3mQ+mLiYzIjLkhvvxmAUrD7tchrU2I8o6x4SV
         JVBg==
X-Gm-Message-State: AGRZ1gIHCQNOl5YdoB0ueHRuyapOxpeNLoR1TET+6VNdMSDRjwIIo6EO
        duEgOgXYyPadzV8PsK6CZcM=
X-Google-Smtp-Source: AJdET5cGtBx4AUEgZJLaKbc/neTjZfk33aL3yONgbOv6T9Zf9Ug0rjfEjw97bYVak1ZGX1jSQSfzuw==
X-Received: by 2002:a1c:5689:: with SMTP id k131-v6mr8303338wmb.119.1540635078880;
        Sat, 27 Oct 2018 03:11:18 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egq108.neoplus.adsl.tpnet.pl. [83.21.80.108])
        by smtp.gmail.com with ESMTPSA id o17-v6sm18110048wro.2.2018.10.27.03.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 03:11:18 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com>
        <20181022202241.18629-1-szeder.dev@gmail.com>
Date:   Sat, 27 Oct 2018 12:11:18 +0200
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com> ("SZEDER
 \=\?utf-8\?Q\?G\=C3\=A1bor\=22's\?\=
        message of "Mon, 22 Oct 2018 22:22:33 +0200")
Message-ID: <86va5n4s3d.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> On Mon, Oct 22, 2018 at 05:36:33PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>>
>> The current gettext() function just replaces all strings with
>> '# GETTEXT POISON #' including format strings and hides the things
>> that we should be allowed to grep (like branch names, or some other
>> codes) even when gettext is poisoned.
>>=20
>> This patch implements the poisoned _() with a universal and totally
>> legit language called Ook [1]. We could actually grep stuff even in
>> with this because format strings are preserved.
>
> Once upon a time a GETTEXT_POISON build job failed on me, and the
> error message:
>
>   error: # GETTEXT POISON #
>
> was not particularly useful.  Ook wouldn't help with that...
>
> So I came up with the following couple of patches that implement a
> "scrambled" format that makes the poisoned output legible for humans
> but still gibberish for machine consumption (i.e. grep-ing the text
> part would still fail):
>
>   error:  U.n.a.b.l.e. .t.o. .c.r.e.a.t.e. .'./home/szeder/src/git/t/tras=
h directory.t1404-update-ref-errors/.git/packed-refs...l.o.c.k.'.:. .File e=
xists...
>
> I have been running GETTEXT_POISON builds with this series for some
> months now, but haven't submitted it yet, because I haven't decided
> yet whether including strings (paths, refs, etc.) in the output as
> they are is a feature or a flaw.  And because it embarrassingly leaks
> every single translated string... :)

There is similar technique called "pseudolocalization", meant for
testing i18n aspect of software.

In one of most common forms, the string

  Edit program settings

woukd be translated to

  [!!! =CE=B5=C3=90i=C5=A3 =C3=9Er0=C4=A3=D0=AF=C3=A3m s=C9=99T=CF=84=C4=B1=
=D0=98=C4=9F=C2=A7 !!!]

(possibly using mirrored locale, i.e. right-to-left order).

The brackets [!!! ... !!!] are used as a "poison", to detect
translatable text, and to spot issues with truncation; it also helps
with finding "lego" translation.

It would also stress-test Unicode handling...

Regards,
--=20
Jakub Nar=C4=99bski

