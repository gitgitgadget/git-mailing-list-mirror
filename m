Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C8C1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 00:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfG2AJ2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 20:09:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45817 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfG2AJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 20:09:28 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so116237736ioc.12
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lIVk+cSUVbRM6EJ8BKEC9FdMv88tRJqP4WNaSXgKwEI=;
        b=BTDTUiL4HLNrTiTSzKSWWzmXrgXSpF7sa7kAXg99MHJy4EkJXEfzVnZ+5PZA3KnQfc
         wd00Psh+8SprWUC/39eMSf98MW9djan1c0xf31oGTJvIIjBNwfRzGV4FL5+WEOcO8I/b
         iYfso+FE5NgfykoKU2UNljNO+9pjzDieM+FS3pDZ6qxiycAYxFUAiNtd0YsamMX7tRIO
         fdk+itjrrRBBKzfl1DPj3iogfzaMPjGr29DKoDPN4wYSGWtnMt8F0WWxisPiPS2zrXEg
         V+KDE2aKXg9u+xZCFFRAq4dVioBTkjJg1lSEvHmrioag2LVxNNmsjhtCCllmA0B54tBM
         t4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lIVk+cSUVbRM6EJ8BKEC9FdMv88tRJqP4WNaSXgKwEI=;
        b=WiJMVGS347LpJmoXcEXLLiNJUV1kJ58Wx+3dc33Tpf6Jsa3BK70zdvIlOaSe0ZkCKv
         kN6uQGQmdyPVeMKP8V749NJC9CgSfnhTfMFmrLus9eJ5qWdeBgu+hk5sIbr08ACtZ5HR
         Sw12w9Qh2aRLwVXNr840MMwpjymdsEnnIDDhzuKMLUNzVF7AwthCUpyYqHpkIPaeP1dM
         tl+V9SfvilsUyb3xpMEskJ/yCWXYlfWUkqg7jdqiITrjrwONjGk0InBHm8257h1TyALr
         13xhRZPKw1p89KhKznh1A5qe6r6r1qQA4+TFtcJrKUPM3fbFSJP2tYVzOgNazF4hB4Bv
         LXDg==
X-Gm-Message-State: APjAAAUYg+4kB2x/gqb5hjsx4KlU4fm6Ng+IzPqgkC0/K8gNlyXUjLTV
        tM8MUrUZ8gCOszhUIxEEXkixPCD+5Ihy/rLSBvvhady/
X-Google-Smtp-Source: APXvYqxloqQqqbhrtlG2EilEOnfKVQ+TNB5RqqC35yd+trK6a3sv3bRl6MKPb+LQxlQqvdQ7y7Kp4nPNz/OADl7xc2U=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr53819790ioa.161.1564358967180;
 Sun, 28 Jul 2019 17:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com>
In-Reply-To: <20190728235427.41425-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 17:09:16 -0700
Message-ID: <CAPUEsphhsbdeutJ8=XrBx-y0shf+64O9o55AeQBhnXYso_1PyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 28, 2019 at 4:54 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> @@ -125,6 +126,12 @@ int grep_config(const char *var, const char *value, =
void *cb)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "pcre.jit")) {
> +               int is_bool;
> +               opt->pcre_jit =3D git_config_bool_or_int(var, value, &is_=
bool);
> +               return 0;
> +       }
> +
>         if (!strcmp(var, "color.grep"))
>                 opt->color =3D git_config_colorbool(var, value);
>         if (!strcmp(var, "color.grep.match")) {

using git_config_bool_or_int, as I am hoping a future version will use
a third value (maybe -1) to
indicate JIT will be tried first, but then the interpreter will be
used in case JIT is not available (as
recommended in PCRE)

not sure also about the right name and where to document this flag, as
this is not only restricted to
the grep subcommand and the issue it is working around will be also
relevant for log (including pickaxe)

Carlo
