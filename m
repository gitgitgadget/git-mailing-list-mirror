From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 13:47:34 -0800
Message-ID: <CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
	<20150226030416.GA6121@peff.net>
	<xmqqmw40l777.fsf@gitster.dls.corp.google.com>
	<20150226213356.GA14464@peff.net>
	<xmqqa900l57y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:47:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR6HU-0006E5-Qf
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbbBZVrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:47:36 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37446 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbBZVrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:47:35 -0500
Received: by iecrl12 with SMTP id rl12so21743205iec.4
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 13:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FIlQcWmkpMB6so7MMuTbGzMxruQuee+pFT3/RTCSAkY=;
        b=hARKhjH/C4ugEE77jhvl83GV6wd7LUAbfu1Kpt1rlxI73+RMb5QzaQYmBPCxNmXTJE
         Thqq4IDfps67FCYSV4bCPOkpZFPo5bxBgDYq/nCMYE+29Dl8pT8E3KtxGYYw3kr1TpRQ
         SM+GAnd3prR/3W96aZFESQ9p2zQjcWezYPDIcam88tba+Zs7Yo2c2yUETlsP53M3Zjl4
         bZkvr44+dvL6iq7w75rqGah1VWuE3E4Fg7nMBPzNeXZcpU67XmzORM2L6UrUP+kMm+Ka
         6TrijLwMDKnCTyCInb+XlaKxdZf2sCq6gzi1hOfloFmqnTQgAfC7cTAv53MRZdfDUFLD
         SrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FIlQcWmkpMB6so7MMuTbGzMxruQuee+pFT3/RTCSAkY=;
        b=Pyq6O7OcDxOCEo/SJeK3y+WlQlYi1saQ+z1XzRFQTm33PWRhbepnzYfCBvNTN0OCen
         UL21lFiMNVei8OWIzrVVoAJwx1vWCER1/8PHAvsa48kFZeMYqFWF59BvkMgq7bn+TiBw
         46OCDVpuEB55xRcQPOtpJ74JZHXqTPNLviBfaQ8GXpzpThKAXwN7CZt37wYo8JXAua+3
         V6R2T/JHvC23szuiUuRgTbFln2OeXWedq+M5u/IWAcaTuA+EA5QGSom2UVNp25N49L+I
         FkFDPX13PIOxwWkDvL1CLa9/vK0N09qnOdIiri9SOffOxiZrbyyOxmrp6bf9QQVnd1K7
         0CzQ==
X-Gm-Message-State: ALoCoQkVWzs3EA44Rooc2mnGoGilc1UYfT+unCbib0gO4fRrXyX4PmXxEfqswGex65oqE27lId/S
X-Received: by 10.42.83.147 with SMTP id h19mr11984920icl.95.1424987254915;
 Thu, 26 Feb 2015 13:47:34 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 13:47:34 -0800 (PST)
In-Reply-To: <xmqqa900l57y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264470>

On Thu, Feb 26, 2015 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:>
> Here is what I queued.  Thanks.

I did not follow the thread if there are any intermediate patches,
though it applied cleanly.

Applying this on top of f18604bbf2c391c689a41fca14cbaeff5e106255
(http: add Accept-Language header if possible) still doesn't compile for me.

http.c:1001:20: error: static declaration of 'get_preferred_languages'
follows non-static declaration
 static const char *get_preferred_languages(void)
                    ^
In file included from cache.h:8:0,
                 from http.h:4,
                 from http.c:2:
gettext.h:68:13: note: previous declaration of
'get_preferred_languages' was here
 const char *get_preferred_languages(void);
             ^
http.c: In function 'get_preferred_languages':
http.c:1010:2: warning: implicit declaration of function 'setlocale'
[-Wimplicit-function-declaration]
  retval = setlocale(LC_MESSAGES, NULL);
  ^
http.c:1010:21: error: 'LC_MESSAGES' undeclared (first use in this function)
  retval = setlocale(LC_MESSAGES, NULL);
                     ^
http.c:1010:21: note: each undeclared identifier is reported only once
for each function it appears in

Rebasing this on top of current master (Post 2.3 cyle (batch #5)) also fails:

http.c:1013:20: error: static declaration of 'get_preferred_languages'
follows non-static declaration
 static const char *get_preferred_languages(void)
                    ^
In file included from cache.h:8:0,
                 from http.h:4,
                 from http.c:2:
gettext.h:92:13: note: previous declaration of
'get_preferred_languages' was here
 const char *get_preferred_languages(void);
             ^
http.c: In function 'get_preferred_languages':
http.c:1022:2: warning: implicit declaration of function 'setlocale'
[-Wimplicit-function-declaration]
  retval = setlocale(LC_MESSAGES, NULL);
  ^
http.c:1022:21: error: 'LC_MESSAGES' undeclared (first use in this function)
  retval = setlocale(LC_MESSAGES, NULL);
                     ^
http.c:1022:21: note: each undeclared identifier is reported only once
for each function it appears in




>
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Wed, 25 Feb 2015 22:04:16 -0500
> Subject: [PATCH] gettext.c: move get_preferred_languages() from http.c
>
> Calling setlocale(LC_MESSAGES, ...) directly from http.c, without
> including <locale.h>, was causing compilation warnings.  Move the
> helper function to gettext.c that already includes the header and
> where locale-related issues are handled.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  gettext.c | 25 +++++++++++++++++++++++++
>  gettext.h |  2 ++
>  http.c    |  1 +
>  3 files changed, 28 insertions(+)
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
> index 7671d09..e539482 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -65,4 +65,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
>  /* Mark msgid for translation but do not translate it. */
>  #define N_(msgid) msgid
>
> +const char *get_preferred_languages(void);
> +
>  #endif
> diff --git a/http.c b/http.c
> index 8b659b6..71ed418 100644
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
> --
> 2.3.1-280-g2531f2d
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
