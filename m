Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FA1201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbdBVSSU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 13:18:20 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:37564 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932766AbdBVSSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 13:18:18 -0500
Received: by mail-it0-f51.google.com with SMTP id 203so7662348ith.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YGsroRehSHzT80SWzIBzM3DwMqgkEsWVcsWZoGg+Ckk=;
        b=o1GYtwDepr5wdDi4a8zgxSLBQ2gs1aE8fKuUM4/B+X+3ui/4pWt8yEqeAkPV9COD6K
         CkSuaeZ9cLpmqOJLwU23GckyTyeg22+HXGVB5S/yxnaRcS8JkOJNoMKoaGC3ow/D0g+k
         JmjOnh4PTWGq4e1FmgZaCOu6TUr6/Uc9qlQOtu+qAAU7TSo0m1/u1lOFmNRhQabkgMWe
         JJ9VmP7Ml+n52g383/ZOOuyHpHt2Aq/rYNERzjiWg+tPmOQ3NQlKZzO4Ons00nxniLWt
         j/oPD3l3gtamAqjgaR/vbg06p/gseBtPTIUecvFeGONXBcinjWB6eHrgB+lhZmnNwlru
         LxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGsroRehSHzT80SWzIBzM3DwMqgkEsWVcsWZoGg+Ckk=;
        b=YSKkDxhC9JG1YxOBQLlr8pnEdGjHx4Gef2ks1GVvdzKTYi11Gb3556dvKlOu3TGUen
         43COU+enJ+ZWJpj6JNi3fls1nRBJ76SSMqSDJ7zKiVcSvbXqIJ6JrX35k1s/ydB+fHq5
         4zIkWtorvwF4fVqJeohT6mk+AyH4WeT9Jv+0trQ2YlAhKeSQOUTnvFJTHQzYvNOcBiv8
         T6E/gINI3azul6G5swW4cj2FvHthr4X1Fy2+T67o4yPeuvtga0Q2yb27DC7plPYg1BWo
         uRY7c4bazpb+LObFhc0E7Dm6h8xuL9q5v1kLAvZW2zdJl0WwDYbYEDX7DfRomMlud0Ir
         92mA==
X-Gm-Message-State: AMke39lCBK41FVvc9Qov128vM3SkXVzv25982jxCJ796wyjC8mNvrHxLIuBY1b18KlK/nmscYA2ep90AtgOAFQqa
X-Received: by 10.36.1.197 with SMTP id 188mr3130016itk.116.1487787496807;
 Wed, 22 Feb 2017 10:18:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 22 Feb 2017 10:18:16 -0800 (PST)
In-Reply-To: <20170222140450.30886-2-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Feb 2017 10:18:16 -0800
Message-ID: <CAGZ79kZTr924RrvG6RsasmhT1yswN875XShtmrrcJ8ztaAGJUw@mail.gmail.com>
Subject: Re: [PATCH v5 01/24] refs.h: add forward declaration for structs used
 in this file
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 6:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  refs.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/refs.h b/refs.h
> index 9fbff90e7..c494b641a 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1,6 +1,11 @@
>  #ifndef REFS_H
>  #define REFS_H
>
> +struct object_id;
> +struct ref_transaction;
> +struct strbuf;
> +struct string_list;
> +
>  /*
>   * Resolve a reference, recursively following symbolic refererences.
>   *
> @@ -144,7 +149,6 @@ int dwim_log(const char *str, int len, unsigned char =
*sha1, char **ref);
>   * `ref_transaction_commit` is called.  So `ref_transaction_verify`
>   * won't report a verification failure until the commit is attempted.
>   */
> -struct ref_transaction;

Leaving the detailed comment about ref_transaction dangling?
I can understand if you don't want to move it with the declaration,
as you want all declarations terse in a few lines.
Maybe move the comment to be part of the first large comment
(The one that you can see in the first hunk, starting with
" * Resolve a reference, recursively following")

Maybe Michael has a better idea how to make this comment
more accessible to the casual refs-reader.

Thanks,
Stefan
