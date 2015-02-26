From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 14:26:05 -0800
Message-ID: <CAGZ79kar4Uf-mCwXpexPvNztwd_vfjdCoT_dDXULkOrCqUhG=A@mail.gmail.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
	<20150226030416.GA6121@peff.net>
	<xmqqmw40l777.fsf@gitster.dls.corp.google.com>
	<20150226213356.GA14464@peff.net>
	<xmqqa900l57y.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
	<20150226220609.GA24663@peff.net>
	<20150226220759.GB24663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:26:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR6sn-0000Wn-6x
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 23:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbbBZW0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 17:26:08 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46409 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbbBZW0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 17:26:07 -0500
Received: by iecvy18 with SMTP id vy18so22115106iec.13
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dxR4EdqO9MPecHje0qSHBtneytu8QJXPBiZ5I5hgsZE=;
        b=GLppneAsZ5keGdMW/3byORUYbPdje3FVyPTiW1Sf5zM2vQk5BU/mfOj7UIX/0oIZjT
         aEwx8FZyZ663TU4Wztx1b3xRs/wmjwSzLBM9M5rZnJsM+16E5a+sd/GdIx04KezpZLX3
         /ORyY6vkiDzl229i6oktD8a1xxH38mC7QpXmEUfqB22uE9DL8Nxm4fAwesf+Eo8ujaB5
         DoxRRHn0K5aEechkGekUTbobA8Zxaxuofr0kT7nCWLwii1qymdbDBnuEE+cUxleEbGfX
         Bossl8QY/fwuAJPzRI/dBZgO9RYn3xM1fk9OpQDYH8la2e1EVqq/ksyfmJPJPqvGGnPU
         uOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dxR4EdqO9MPecHje0qSHBtneytu8QJXPBiZ5I5hgsZE=;
        b=Nit9WC02En3gTWjbjw2svcLwiQpY5tK6vp6RPIRCTr4mGpJbqycy4oRtLjXN2oMpIq
         7sHAL/RJMo/yfp8CbdEXkciijyklaBT02u2BX3MRodVdwpVIJKDBmQwwdvqvigXiXGuM
         a7xbpeKxBcBfHlUMNbmZniSYTReX+Yz1kjSzwSKYkFyFR2raNmFsPUM8yJMpCNjswBUe
         UC/cw7VyopHUMlVfA06z7LbKpw97W6Ls6nF+zKnS6BQjQWTrH+Gz7dnptfehNwhUfW0Z
         +LoFHvKoDApzDX47GeAjZkR9zj2KTGN7Mi+QGneYWGLoP5GeO5IskTBdKFDCpUrLHG2P
         nEYw==
X-Gm-Message-State: ALoCoQmVG0xAGXSSK1+AART7+a1sYxea9ix7No8su1YN41qsjZFc28cH9iPxZpUYjtwN35oI/8GD
X-Received: by 10.50.39.65 with SMTP id n1mr316845igk.37.1424989565822; Thu,
 26 Feb 2015 14:26:05 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 14:26:05 -0800 (PST)
In-Reply-To: <20150226220759.GB24663@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264475>

On Thu, Feb 26, 2015 at 2:07 PM, Jeff King <peff@peff.net> wrote:
>
> Here it is, with the commit message and the missing hunk. This works for
> me both with and without NO_GETTEXT defined.

This compiles here though a warning is spit:
In file included from cache.h:8:0,
                 from userdiff.c:1:
gettext.h:92:1: warning: function declaration isn't a prototype
[-Wstrict-prototypes]
 const char *get_preferred_languages();
 ^
so I guess I can still add a
Tested-by: Stefan Beller <sbeller@google.com>

>
> -- >8 --
> Subject: [PATCH] gettext.c: move get_preferred_languages() from http.c
>
> Calling setlocale(LC_MESSAGES, ...) directly from http.c,
> without including <locale.h>, was causing compilation
> warnings.  Move the helper function to gettext.c that
> already includes the header and where locale-related issues
> are handled.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  gettext.c | 25 +++++++++++++++++++++++++
>  gettext.h |  2 ++
>  http.c    | 27 +--------------------------
>  3 files changed, 28 insertions(+), 26 deletions(-)
>
> diff --git a/gettext.c b/gettext.c
> index 8b2da46..7378ba2 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -18,6 +18,31 @@
>  #      endif
>  #endif
>
> +/*
> + * Guess the user's preferred languages from the value in LANGUAGE environment
> + * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
> + *
> + * The result can be a colon-separated list like "ko:ja:en".
> + */
> +const char *get_preferred_languages(void)
> +{
> +       const char *retval;
> +
> +       retval = getenv("LANGUAGE");
> +       if (retval && *retval)
> +               return retval;
> +
> +#ifndef NO_GETTEXT
> +       retval = setlocale(LC_MESSAGES, NULL);
> +       if (retval && *retval &&
> +               strcmp(retval, "C") &&
> +               strcmp(retval, "POSIX"))
> +               return retval;
> +#endif
> +
> +       return NULL;
> +}
> +
>  #ifdef GETTEXT_POISON
>  int use_gettext_poison(void)
>  {
> diff --git a/gettext.h b/gettext.h
> index dc1722d..5d8d2df 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -89,4 +89,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
>  #define N_(msgid) (msgid)
>  #endif
>
> +const char *get_preferred_languages();
> +
>  #endif
> diff --git a/http.c b/http.c
> index 0153fb0..9c825af 100644
> --- a/http.c
> +++ b/http.c
> @@ -8,6 +8,7 @@
>  #include "credential.h"
>  #include "version.h"
>  #include "pkt-line.h"
> +#include "gettext.h"
>
>  int active_requests;
>  int http_is_verbose;
> @@ -1002,32 +1003,6 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>                 strbuf_addstr(charset, "ISO-8859-1");
>  }
>
> -
> -/*
> - * Guess the user's preferred languages from the value in LANGUAGE environment
> - * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
> - *
> - * The result can be a colon-separated list like "ko:ja:en".
> - */
> -static const char *get_preferred_languages(void)
> -{
> -       const char *retval;
> -
> -       retval = getenv("LANGUAGE");
> -       if (retval && *retval)
> -               return retval;
> -
> -#ifndef NO_GETTEXT
> -       retval = setlocale(LC_MESSAGES, NULL);
> -       if (retval && *retval &&
> -               strcmp(retval, "C") &&
> -               strcmp(retval, "POSIX"))
> -               return retval;
> -#endif
> -
> -       return NULL;
> -}
> -
>  static void write_accept_language(struct strbuf *buf)
>  {
>         /*
> --
> 2.3.0.449.g1690e78
>
