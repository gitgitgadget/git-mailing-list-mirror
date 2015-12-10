From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 13:52:30 -0500
Message-ID: <CAKfKJYt__uD_=E=NBxsVSbv6TO4E7-GvsCdFnSuPPv8n-owhJA@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
 <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com> <xmqqoadyi1q2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:55:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a76Mo-0000f7-5b
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbLJSwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:52:54 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33729 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbLJSwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:52:51 -0500
Received: by qgea14 with SMTP id a14so157883371qge.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 10:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IT95WAnw1Awk2VtIZRPAcrge9i2A/BvLuXDrHavppX4=;
        b=HBx1LyI2/8lQ6p2dQ/uXM2pG+DIV2rVfSgLJqOz7lwiOWa7O2R2SCPZXDS5hokPE8F
         dhXy+SExJSc7joKHRR7/xcX9Ke/COUlK94cYk8BanOrwIHL1Zgtrk3PzoFije3NidQwN
         RssduWITpvUPtVQpmoHgAQZuE9WqldvShyxeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IT95WAnw1Awk2VtIZRPAcrge9i2A/BvLuXDrHavppX4=;
        b=l1JJ/V84940auQtazTtH40uhxD2IZgyfVII2bqtDlOc+v3Hho87l8roebVuucmAC1B
         OuHq3uvuG3QeB0kM/BgZKQltXzUyZplVzVjOhuo0glamyxVuind9025BCw7gkmoKDMbz
         gouJKow/NSXpOYRNos96Fbm255MI6ZgRyh3kfNywC82wYQChPyM68GP5dBRYt9nam+A0
         zzXQE/EkMyaXycaE2Kd31o960lo5jOTPEZnJi+aWBN1cZ0JAd2py5XY2C1MUOFVtZm1z
         BfmiB42hed6OPbEiaUNscfsDTtlhGoQOIUJHns4MCC9mvKxmVkz9MPRTn42H0/AFOFWv
         iv0w==
X-Gm-Message-State: ALoCoQnO1EVFcvvwb2pE4tVTls4YkZLnRStNavLpYxmCXS6l2Ydx/iCcEVP0vBghkFwIH8BcpbhHOS+llp6fUx/nJpnYGzKpBA==
X-Received: by 10.55.79.207 with SMTP id d198mr16681728qkb.49.1449773570461;
        Thu, 10 Dec 2015 10:52:50 -0800 (PST)
Received: from mail-qg0-f41.google.com (mail-qg0-f41.google.com. [209.85.192.41])
        by smtp.gmail.com with ESMTPSA id g132sm6537404qhc.46.2015.12.10.10.52.49
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Dec 2015 10:52:49 -0800 (PST)
Received: by qgea14 with SMTP id a14so157882403qge.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 10:52:49 -0800 (PST)
X-Received: by 10.140.254.69 with SMTP id z66mr8893917qhc.5.1449773569434;
 Thu, 10 Dec 2015 10:52:49 -0800 (PST)
Received: by 10.55.128.198 with HTTP; Thu, 10 Dec 2015 10:52:30 -0800 (PST)
In-Reply-To: <xmqqoadyi1q2.fsf@gitster.mtv.corp.google.com>
X-Gmail-Original-Message-ID: <CAKfKJYt__uD_=E=NBxsVSbv6TO4E7-GvsCdFnSuPPv8n-owhJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282224>

On Thu, Dec 10, 2015 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Well.. reflog needs it. So either you disable reflog at clone time or
>> define name/email via config file. I don't see anything wrong with
>> this behavior.
>
> Hmm, I am not quite sure about that.
>
> In the codepath that computes ident_default_email(), which is one
> half of what the "reflog" code you cite wants to do, copy_email()
> calls copy_email() which in turn calls add_domainname().  If your
> getpwuid() gave you some username, but your gethostname() gave you a
> NULL, we do not barf but add "(none)" as and then issue a warning.
>
> Perhaps we can do the same by returning a structure with members set
> to a set of fake values.  Because we already have checks in places
> that really matter to the recorded history (read: not reflog) in the
> form of *_ident_sufficiently_given() functions, potential damage due
> to having phoney names returned from here would not be too bad.
>
> Totally untested...
>
>  ident.c   | 13 ++++++++++---
>  wrapper.c |  4 ----
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 4e7f99d..2ccae2c 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -31,7 +31,7 @@ static void copy_gecos(const struct passwd *w, struct strbuf *name)
>          * with commas.  Also & stands for capitalized form of the login name.
>          */
>
> -       for (src = get_gecos(w); *src && *src != ','; src++) {
> +       for (src = w ? get_gecos(w) : "&"; *src && *src != ','; src++) {
>                 int ch = *src;
>                 if (ch != '&')
>                         strbuf_addch(name, ch);
> @@ -117,7 +117,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
>          * Make up a fake email address
>          * (name + '@' + hostname [+ '.' + domainname])
>          */
> -       strbuf_addstr(email, pw->pw_name);
> +       strbuf_addstr(email, pw ? pw->pw_name : "unknown");
>         strbuf_addch(email, '@');
>
>         if (!add_mailname_host(email))
> @@ -332,8 +332,15 @@ const char *fmt_ident(const char *name, const char *email,
>                                 fputs(env_hint, stderr);
>                         die("empty ident name (for <%s>) not allowed", email);
>                 }
> +               errno = 0;
>                 pw = xgetpwuid_self();
> -               name = pw->pw_name;
> +               if (!pw) {
> +                       warning(_("unable to look up current user: %s"),
> +                               errno ? strerror(errno) : _("no such user"));
> +                       name = "unknown";
> +               } else {
> +                       name = pw->pw_name;
> +               }
>         }
>
>         if (strict && email == git_default_email.buf &&
> diff --git a/wrapper.c b/wrapper.c
> index 6fcaa4d..16ab45f 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -605,11 +605,7 @@ struct passwd *xgetpwuid_self(void)
>  {
>         struct passwd *pw;
>
> -       errno = 0;
>         pw = getpwuid(getuid());
> -       if (!pw)
> -               die(_("unable to look up current user in the passwd file: %s"),
> -                   errno ? strerror(errno) : _("no such user"));
>         return pw;
>  }
>

Yes, this looks better.

+1
