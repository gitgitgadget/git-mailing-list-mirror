Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2787920248
	for <e@80x24.org>; Thu, 18 Apr 2019 05:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfDRFp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 01:45:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 01:45:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so1266796wra.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0hJhW0t9KS7h8hc8isb4QkzhyOciYmLS1DsqvHJ9tgk=;
        b=WvfH1FH/AyvmacNKCt4yOGDTqtk/WGmcIHjZNARXLciuIygtBTCoCQkDsJCt2uqUDk
         VZj9XEZ4CDFIciAALUmf66TxnfS6MQpwHMNzkroCx2b5R1N6gkbIB2tnGpwf5qjbLxc4
         8HmvwOGv1gddKRjC2NKr5u8azgw8DO4XNplbssc0r+TCIprGvBQ3Fy90fYgq06wjU/Vc
         fkz77BBv/RzCql4fNkI/Kse2D3UQ8+Sg5e61T7gCdONt1NxYk0dbsgRtMWfCQgb7Rto8
         btIQ5JbER8D+Ef+s/pUezueWRCfu6ERWACh8GGI0GxovmLAHVh6kfrdYTpsRxoEoF9eT
         yfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0hJhW0t9KS7h8hc8isb4QkzhyOciYmLS1DsqvHJ9tgk=;
        b=P1rGxc2IPjkY7d0bSg1AIUWVO+6aNvpfG0jqYD8mPikaWewkxmXQUSI8NSeLwmLBwa
         YPcBvyryc+Uzu8bcSHG/RXz4rOeLvIQTx5fg1WaFNflt7mdRCiW+T68FlHojXtad8Int
         CIsmU7CmqjiHVn/wcCkOQ5qCbL7TdUYp1+JvIXvj7fvQx6rNwQ9qv0XNxP5+tBZeq5iu
         bP4y/0PPX5oiXVTjxQTSmw95lbMuL7ChU1xbZr1YoCWqAFFeYp2McrR3bHFhSvpPSUiX
         QzCdBLy/auZImXGmIrs59dlkKcYI7TBEZtcXsoXlOBZcLBab7cMyBgpig0xTfROkWARH
         snvA==
X-Gm-Message-State: APjAAAVNp1hBFfUkQptXzvWAJhEIYyr88WBNtiFR6azB6bQjvUc01GQS
        VljLbcU6P0l+kRJd6qGMntQ=
X-Google-Smtp-Source: APXvYqxo/7Yf3715JPMjGBpsErEWAbwdaedQljK3v7OGytFjG9nNcd1jkE70y0jp07q46XQvLWhsKw==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr11438166wro.244.1555566357540;
        Wed, 17 Apr 2019 22:45:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h2sm1650460wro.11.2019.04.17.22.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 22:45:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vadim Kochan <vadim4j@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] configure.ac: Properly check for libintl
References: <20190418050419.21114-1-vadim4j@gmail.com>
Date:   Thu, 18 Apr 2019 14:45:56 +0900
In-Reply-To: <20190418050419.21114-1-vadim4j@gmail.com> (Vadim Kochan's
        message of "Thu, 18 Apr 2019 08:04:19 +0300")
Message-ID: <xmqqftqfhnmz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vadim Kochan <vadim4j@gmail.com> writes:

> Some libc implementations like uclibc or musl provides
> gettext stubs via libintl library but this case is not checked
> by AC_CHECK_LIB(c, gettext ...) because gcc has gettext as builtin
> which passess the check.
>
> So check it with included libintl.h where gettext may unfold into
> libintl_gettext which will cause check to fail if libintl_gettext are
> needed to be linked with -lintl.

Let me make sure I can understand the above correctly (otherwise,
that is a sign that the proposed log message is lacking) by trying
to rephrase (iow, this is not me saying "your log message should be
rewritten like so"; it is "if I read what you wrote above correctly,
I think what I am going to write here is also correct"):

    Some libc implementations have function called gettext() that
    can be linked via -lc without -lintl, but these are mere stubs
    and do not do useful i18n.  On these systems, if a program that
    calls gettext() is built _with_ "#include <libintl.h>", the
    linker calls for the real version (e.g. libintl_gettext()) and
    that can be satisfied only by linking with -lintl.

    The current check to see if -lc provides with gettext() is
    sufficient for libc implementations like GNU libc that actually
    has full fledged gettext(); to detect libc with stub gettext()
    and libintl with real gettext(), aliased via <libintl.h>, the
    check to see if -lintl is necessary must be done with a sample
    source that #include's the header file.

Is that what is going on and why this patch is needed?

I think the only possibile kind of system this change could break
that currently is working is the one that has a usable gettext()
in -lc, but does not offer <libintl.h>, as the new test program
added by this patch will fail to compile, but I do not think that
is possible in practice---our own gettext.c #include's <libintl.h>
so there is no way such a hypothetical system that would be broken
by this change could possibly have built Git successfully.

Assuming that the way I read your log message is in line with what
you wanted to say, I think the patch looks good.

Thanks.


> Signed-off-by: Vadim Kochan <vadim4j@gmail.com>
> ---
>  configure.ac | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index e0d0da3c0c..be3b55f1cc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -763,9 +763,19 @@ AC_CHECK_LIB([c], [basename],
>  GIT_CONF_SUBST([NEEDS_LIBGEN])
>  test -n "$NEEDS_LIBGEN" && LIBS="$LIBS -lgen"
>  
> -AC_CHECK_LIB([c], [gettext],
> -[LIBC_CONTAINS_LIBINTL=YesPlease],
> -[LIBC_CONTAINS_LIBINTL=])
> +AC_DEFUN([LIBINTL_SRC], [
> +AC_LANG_PROGRAM([[
> +#include <libintl.h>
> +]],[[
> +char *msg = gettext("test");
> +]])])
> +
> +AC_MSG_CHECKING([if libc contains libintl])
> +AC_LINK_IFELSE([LIBINTL_SRC],
> +	[AC_MSG_RESULT([yes])
> +	LIBC_CONTAINS_LIBINTL=YesPlease],
> +	[AC_MSG_RESULT([no])
> +	LIBC_CONTAINS_LIBINTL=])
>  GIT_CONF_SUBST([LIBC_CONTAINS_LIBINTL])
>  
>  #
