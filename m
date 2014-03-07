From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATH] branch.c:install_branch_config():Simplify code generating
 verbose message.
Date: Fri, 7 Mar 2014 03:55:42 -0500
Message-ID: <CAPig+cQTSMZq1X7131cbnAB7py_3GXf60ricX4hq6DNB7uHsbQ@mail.gmail.com>
References: <8889967.JbMR8CXVSx@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>
X-From: git-owner@vger.kernel.org Fri Mar 07 09:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLqZj-0002dN-Bo
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 09:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbaCGIzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 03:55:44 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:38408 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaCGIzn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 03:55:43 -0500
Received: by mail-yh0-f43.google.com with SMTP id b6so3918839yha.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JPPa5Z2M1MrsaoXoXNVCclp1Ud7mq8AKPd0Gk1ZImHc=;
        b=Aux6ML9K/lwB+VCCZxeI8SCtfuOOlAmViNpC466EMSOdlL8yDGPv166vRWNK4r7MRl
         gC9yGfEoJb52HCKWzs88Hmk05m4PsLUhKBJOsvFbZ/9uxu1+TC+erOZ01JMbZxoTKTQD
         MwIFvlJdmxml08mRuYDUUyHyif/Nlu8Z7fdXtp8GRtx3tkrxOYpVNbLHHIct9WHGA82Q
         XF68R4Mu/zFgGfP/HaMW3RA+3+qfW3fnvmOOGykzKyM0KYcgAV/XsdruBaRbnd17QOeX
         8ErlZLSIRetEuAzXObSZUBr2xethbf0Vefr5PUQoHk3uciatv209MX1VzXjIXc3GldVd
         TXtw==
X-Received: by 10.236.99.38 with SMTP id w26mr21311371yhf.18.1394182542841;
 Fri, 07 Mar 2014 00:55:42 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Fri, 7 Mar 2014 00:55:42 -0800 (PST)
In-Reply-To: <8889967.JbMR8CXVSx@endymion>
X-Google-Sender-Auth: gbmCcHAwFqOWK_Y3ex8sBQ40y8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243608>

Thanks for the submission. Some comments below to give you a taste of
the Git review process...

On Thu, Mar 6, 2014 at 2:58 AM, Pawe=C5=82 Wawruch <pawlo@aleg.pl> wrot=
e:
> From adfcfa0a334378a6242347efc0d614fa193610db Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Pawe=3DC5=3D82=3D20Wawruch?=3D <pawlo@aleg.pl>
> Date: Thu, 6 Mar 2014 00:05:00 +0100

Drop these lines. They are extracted automatically by "git am" from
the headers of your mail message.

> Subject: [PATCH] branch.c:install_branch_config(): Simplify the long =
chain of
>  if statements. Threre was a long chain of if statements. The code ca=
n be more
>  clear. The chain is replaced with table of strings. New approach is =
more
>  compact.

The Subject: also is extracted automatically from the email, so it
should not be pasted here. Instead, when you compose your commit
message, write a very concise summary of the patch as the very first
line, then a blank line, then the meat of the description using as
many lines as needed. Wrap the lines to about 65-70 characters. "git
format-patch" automatically uses that concise first line as the
Subject: of the mail message. This is all explained in section "(2)
Describe your changes well" of Documentation/SubmittingPatches.

Write in imperative tone. Rather than "There was a long...", say
"There is a long...". Rather than "The chain is replaced...", say
"Replace the chain...".

You misspelled "There" as "Threre".

Your patch sign-off is missing. It should be placed right here above
the "---" line. See Documentation/SubmittingPatches.

> ---

The Git GSoC page on which you found this microproject suggests
mentioning that this is a GSoC submission so that reviewers don't
overlook it. Either do so by adding [GSoC] to the subject or by
mentioning it right here as "patch commentary" after the "---" line.

>  branch.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..ebc2172 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -77,29 +77,23 @@ void install_branch_config(int flag, const char *=
local,
> const char *origin, cons
>         strbuf_release(&key);

Your patch is whitespace damaged, and thus not easily applied. This
probably resulted from pasting it into your email client. Using "git
send-email" avoids this problem.

>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote=
 branch %s from %s by
> rebasing.") :
> -                                 _("Branch %s set up to track remote=
 branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local =
branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local =
branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote=
 ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote=
 ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local =
ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local =
ref %s."),
> -                                 local, remote);
> +               const char *messages[8] ;

Drop the space before the semicolon.

On this project, we avoid intermixing declarations with code, so move
the declaration of messages[] to the top of the block.

> +               messages[0] =3D _("Branch %s set up to track remote b=
ranch %s from %s by
> rebasing.");
> +               messages[1] =3D _("Branch %s set up to track remote b=
ranch %s from %s.");
> +               messages[2] =3D _("Branch %s set up to track local br=
anch %s by
> rebasing.");
> +               messages[3] =3D _("Branch %s set up to track local br=
anch %s.");
> +               messages[4] =3D _("Branch %s set up to track remote r=
ef %s by rebasing.");
> +               messages[5] =3D _("Branch %s set up to track remote r=
ef %s.");
> +               messages[6] =3D _("Branch %s set up to track local re=
f %s by rebasing.");
> +               messages[7] =3D _("Branch %s set up to track local re=
f %s.");

Rather than hardcoding the array size and then assigning the elements
individually, perhaps you can construct the array with an initializer.
Use N_(...) rather than _(...).

    const char *messages[] =3D {
        N_("..."),
        ...
    };

> +               const char *name =3D remote_is_branch ? remote : shor=
tname;
> +               int message_number =3D rebasing + 2 * (origin !=3D NU=
LL) + 4 *
> remote_is_branch;

Move the declarations of 'name' and 'message_number' to the top of the =
block.

I don't know how other people feel about it, but it disturbs me a bit
to see message_number computed from these other variables without
ensuring that their values really are 0 or 1. I checked the
implementation of the functions from which these variables are set, so
I know that they are indeed 0 or 1, but doing so was an extra burden
which wouldn't have been required if this code was more explicit about
their values. For instance:

    int message_number =3D !!rebasing + 2 * !!origin + 4 * !!remote_is_=
branch;

> +               if (message_number < 2)
> +                       printf_ln(messages[message_number], local, na=
me, origin);
>                 else
> -                       die("BUG: impossible combination of %d and %p=
",
> -                           remote_is_branch, origin);
> +                       printf_ln(messages[message_number], local, na=
me);

Again, it disturbs me to see messages[] indexed without ensuring that
message_number is within range. At the very least, an

    assert(message_number < ARRAY_SIZE(messages));

after computing message_number's value would help to protect against
programmer error in future changes.

>         }
>  }
>
> --
> 1.8.3.2
