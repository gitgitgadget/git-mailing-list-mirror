Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6321F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeB0SJk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:09:40 -0500
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35709 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeB0SJj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:09:39 -0500
Received: by mail-yb0-f171.google.com with SMTP id v135-v6so6838251ybe.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ujguNxiePRzZbcjq1BloUWtkb8t9dAQvHVUCLoIM7Fk=;
        b=fkxPzkPgIB6ycp0sh52e4IgASHJMdoRNZCIQA3/XSRXxCOXL04W0AFsEV6+hYIVlbZ
         w10Fy4vBKbJUp6E+qBUzvRk1FJxeEuuPDAiwD13NbDL/e2xZ/dYCGWMTkBcw9l+zDggJ
         N3WH0DXuqnlvIkH++ZJf0PULQ8m1gXF5MzjX3TlUN2/Q03i3Zz8tAichgl3nKMWE7vQS
         0ObywBJyB9HXv+IQZis36iv85KyNAMLzDF7dV9O3soxhojBmsdAQS7VnAPXJH6qQIe/7
         DhvgUC+ycShttLkf+hRe2cGZEHwq8sYZv/aWYtiCNIExooTiKkiH4Cy0QwxlJp6iuLHm
         yHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ujguNxiePRzZbcjq1BloUWtkb8t9dAQvHVUCLoIM7Fk=;
        b=Yeu6Antyfm4VCjF8bN4App065CI6UMBYVS0WCCiKL9vFFyCHBcL97sPtjlurUdpuRv
         je6a7pKY8skgQpg8ewcKWgyOzEnCFhyIVCoCb8zofa1PZt/p3J8o/ncPfiX677kelt2m
         JSE9GB0utstdwzFj4I/nAgpDRTbQzx2WMarOjNYcOV/3H63A+5W90BkGojCRHBfHNfyQ
         NcyGn2KaBEn04i9xL2fjhl9jNXNGHl1Ew/53/KGudI3nvpQ015HxoJg8totpJXTmc7n4
         OQyHdcKZus2MNVOJI8sdzt7Y13Gm5sxcNoQofRJVt8PdgdH5v4YyGBGA+c3+oKfXVJmF
         LaUQ==
X-Gm-Message-State: APf1xPABR64lX9EY4cUreZ7sjt1IuvhFNAKFEsCDJge/bWcwNT2o9SJY
        9tDbFQt8saQkvS6MFZOqk2n9F7QDuCNJdOc97oJ+Bw02/jc=
X-Google-Smtp-Source: AG47ELvG+wjeDL/Yz+NDYtSKcx852fVLmGgRd8lowVHnXzll9WHQK0up5gOEpm6jKRkpIe+B3Tau1foOb8LbcIGdL0A=
X-Received: by 2002:a25:3781:: with SMTP id e123-v6mr464735yba.247.1519754978528;
 Tue, 27 Feb 2018 10:09:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 10:09:38
 -0800 (PST)
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com> <20180227095846.9238-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 10:09:38 -0800
Message-ID: <CAGZ79ka5MEk89+1MxR5Fsjg8PSSRQWehxKCNcacA3be9+pQ9+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Delete ignore_env member in struct repository
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 1:58 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> v2 fixes the incorrect use of consecutive getenv() and adds a comment
> to clarify the role of old_gitdir
>
> Interdiff:
>
> diff --git a/environment.c b/environment.c
> index 95de419de8..47c6e31559 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -14,6 +14,7 @@
>  #include "fmt-merge-msg.h"
>  #include "commit.h"
>  #include "object-store.h"
> +#include "argv-array.h"
>
>  int trust_executable_bit =3D 1;
>  int trust_ctime =3D 1;
> @@ -148,18 +149,34 @@ static char *expand_namespace(const char *raw_names=
pace)
>         return strbuf_detach(&buf, NULL);
>  }
>
> +/* Wrapper of getenv() that returns a strdup value. This value is kept
> + * in argv to be freed later.
> + */

/* comment style, see also Erics reply */

I do not understand why we need to use an argv_array here?
I see that the push calls xstrdup and then puts it into the array.
So to me this looks like a clever way that we can easily free them all
at once using the predefined argv_array_clear() after calling
repo_set_gitdir.

That makes sense, though is confusing at first; I would have expected
a set_gitdir_args_clear() function that just frees all its strings, whether=
 they
are NULL or not.

But given that we are clever with not pushing onto the argv_array in case t=
he
getenv returns NULL, this seems to be less work in the usual case of no
env variables set.

Ok, I think I like it.

> +static const char *getenv_safe(struct argv_array *argv, const char *name=
)

I would have expected that we already have such a (or similar) helper
in wrapper.c, but it turns out we always take care of getenv manually,
and we do not have a wrapper yet.

So only the comment style remains as a nit.

Thanks,
Stefan
