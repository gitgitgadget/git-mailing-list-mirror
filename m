Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEBB1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 22:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfGDWx4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 18:53:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44573 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGDWx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 18:53:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so6582946edr.11
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=83qKW8kdJ0qb80L6cYOuR3hWCw+V8UrLinvfiGmDkFQ=;
        b=Y8QWYQGa6H+ldL7PcpBq1MVodm3dkZ4qhbe6axwMDaZHivP94khNkiJuq2iFm9VHlN
         CuhiY6+JjCzosMF3iljObJlcqehK8K/AYOJBRhZV2BiGPYBKTdrz4ZU/gdC+36lnZMok
         clA8ATIRAmmPMvAopytM78t+fqMX8U5aoUojdlM+1+dqdyT3wAIvmDjUIDBr+BslIjFF
         MgA/zmWdSkFZR+1knaQVbvdAgW9i98hYTNnNjUL5thwZHoocuRbFxgGdQdKuJrlDlZmE
         utij1PCN5P/Z9uERhcDCxN/7uDfD+nP+sybNsYGNz1c5CyGu9soL/BleQZ3orHjZHooT
         wDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=83qKW8kdJ0qb80L6cYOuR3hWCw+V8UrLinvfiGmDkFQ=;
        b=AcXHVXfifjREujOYZandJ/QhlFsGkGvaTygkq339m+ihXvItFmBJ9O1s52+dVKJmgv
         Yv00+4Pm8Onn8TnMSEvjKI45v41BecrGM1hBwob2QoDfxhXcqQkQhq24yUf0PcVLU5Go
         4P+tXS1Q8OSoWhaDg5TNpvhNCROfRUb8iiSbUCSWS9+t7/Dz24tiRmNrr5gEYHp6b2Pu
         +npqmcNWTDAyIu0rK5XL48sCXkbMLeWkJ6rIr6Z4KB8kLUI5UEwVV4mHcPwK6zX7OmzK
         85CIwG/grq4XQEQQWkGQBGJCcgiPxoqhBNpKm9txPfJQ4MoseuRJ3bRqiZJdiyKLtuGe
         LQlg==
X-Gm-Message-State: APjAAAVRuC3f9csa+5OeMWjH7wyVUxURhppZq1PSoRgPTXkywechkrbQ
        bW7i7OGUlQys0tO7jF1gm2mlcyQq
X-Google-Smtp-Source: APXvYqybi+E63lyBvGJy9HPfLf8J8rSzzq8gE6erg0+yzWITjiNVXh+y/RUVOx8RcsyZFzIwzv2QRg==
X-Received: by 2002:a50:b6e6:: with SMTP id f35mr1063230ede.82.1562280833796;
        Thu, 04 Jul 2019 15:53:53 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id o21sm226835edt.26.2019.07.04.15.53.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 15:53:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] gettext: always use UTF-8 on native Windows
References: <pull.217.git.gitgitgadget@gmail.com> <pull.217.v2.git.gitgitgadget@gmail.com> <2d2253faef14e5157f8aac4534d9ac9640f3d5fa.1562186762.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <2d2253faef14e5157f8aac4534d9ac9640f3d5fa.1562186762.git.gitgitgadget@gmail.com>
Date:   Fri, 05 Jul 2019 00:53:52 +0200
Message-ID: <87o92976nz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 03 2019, Karsten Blees via GitGitGadget wrote:

> From: Karsten Blees <blees@dcon.de>
>
> On native Windows, Git exclusively uses UTF-8 for console output (both
> with MinTTY and native Win32 Console). Gettext uses `setlocale()` to
> determine the output encoding for translated text, however, MSVCRT's
> `setlocale()` does not support UTF-8. As a result, translated text is
> encoded in system encoding (as per `GetAPC()`), and non-ASCII chars are
> mangled in console output.
>
> Side note: There is actually a code page for UTF-8: 65001. In practice,
> it does not work as expected at least on Windows 7, though, so we cannot
> use it in Git. Besides, if we overrode the code page, any process
> spawned from Git would inherit that code page (as opposed to the code
> page configured for the current user), which would quite possibly break
> e.g. diff or merge helpers. So we really cannot override the code page.
>
> In `init_gettext_charset()`, Git calls gettext's
> `bind_textdomain_codeset()` with the character set obtained via
> `locale_charset()`; Let's override that latter function to force the
> encoding to UTF-8 on native Windows.
>
> In Git for Windows' SDK, there is a `libcharset.h` and therefore we
> define `HAVE_LIBCHARSET_H` in the MINGW-specific section in
> `config.mak.uname`, therefore we need to add the override before that
> conditionally-compiled code block.
>
> Rather than simply defining `locale_charset()` to return the string
> `"UTF-8"`, though, we are careful not to break `LC_ALL=C`: the
> `ab/no-kwset` patch series, for example, needs to have a way to prevent
> Git from expecting UTF-8-encoded input.

It's not just the ab/no-kwset I have cooking (but happy to have this
take that into account), but also anything grep-like is usually must
faster with LC_ALL=C. Isn't that also the case on Windows? Setting
locales affects a large variety of libc functions and third party
libraries (e.g. PCRE via us setting "use UTF-8" under locale).

> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  gettext.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/gettext.c b/gettext.c
> index d4021d690c..3f2aca5c3b 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -12,7 +12,25 @@
>  #ifndef NO_GETTEXT
>  #	include <locale.h>
>  #	include <libintl.h>
> -#	ifdef HAVE_LIBCHARSET_H
> +#	ifdef GIT_WINDOWS_NATIVE
> +
> +static const char *locale_charset(void)
> +{
> +	const char *env = getenv("LC_ALL"), *dot;
> +
> +	if (!env || !*env)
> +		env = getenv("LC_CTYPE");
> +	if (!env || !*env)
> +		env = getenv("LANG");
> +
> +	if (!env)
> +		return "UTF-8";
> +
> +	dot = strchr(env, '.');
> +	return !dot ? env : dot + 1;
> +}
> +
> +#	elif defined HAVE_LIBCHARSET_H
>  #		include <libcharset.h>
>  #	else
>  #		include <langinfo.h>

I'll take it on faith that this is what the locale_charset() should look
like.

I wonder if it wouldn't be better to always compile this function, and
just have init_gettext_charset() switch between the two. We've moved
more towards that sort of thing (e.g. with pthreads). I.e. prefer
redundant compilation to ifdefing platform-only code (which then only
gets compiled there). See "HAVE_THREADS" in the code.

It looks to me that with this patch the HAVE_LIBCHARSET_H docs in
"Makefile" become wrong. Shouldn't those be updated too?

We also still pass -DHAVE_LIBCHARSET_H to every file we compile, only to
never use it under GIT_WINDOWS_NATIVE, but perhaps fixing that isn't
possible with GIT_WINDOWS_NATIVE being a macro, and perhaps I've again
gotten the "native" v.s. "mingw" etc. relationship wrong in my head and
the HAVE_LIBCHARSET_H docs are fine.

It just seems wrong that we have both the configure script &
config.mak.uname look for / declare that we have libcharset.h, only to
at this late point not use libcharset.h at all. Couldn't we just know if
GIT_WINDOWS_NATIVE will be true earlier & move that check up, so it &
HAVE_LIBCHARSET_H can be mutually exclusive (with accompanying #error if
we have both)?
