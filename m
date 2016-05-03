From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/41] Add and use error_errno() and warning_errno()
Date: Tue, 3 May 2016 12:55:21 -0400
Message-ID: <CAPig+cRb6w944VrniU-Wq9ET5kvPtYXyTqkUDrNzKS=JY-Qg-g@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:55:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axdbb-0003EO-1p
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933760AbcECQzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 12:55:23 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36303 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933585AbcECQzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 12:55:22 -0400
Received: by mail-ig0-f193.google.com with SMTP id c3so2859133igl.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 09:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=gY9Qcx8lfBoLSp1/qcS8hVRyQFSQgm7i8ypbygVKoo4=;
        b=Q/Th6BiQiYq76I3sq0TKeG6Mp+znshxuR9fee0GLJQIkrudboQFxAAU6W51WyghT0P
         Gyr6Y0OZerHxuSzNNufS9xHXKr9950OQT+NBxh9tlJTlklIGckTgIK4ye4aMqLAx974z
         8W4zmswi8r8py6OCyQIQJadG4/z9YYqW9uA5cmiiahWMI9oObXIjwkvPpra2D7ljEZdn
         CuAw0tiNRbci65TCdgFV4uG/3BpSNYXv9+1XFyOzD8di6msfWkfURX6TFFpN3+0N0X4j
         qda3C9nbkUZvmtCEX0Jsyj6wpyfeAA7ggeyGdXBcd1IR/NQC6NnUHi/fpZO8vu4Bmi3z
         r0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=gY9Qcx8lfBoLSp1/qcS8hVRyQFSQgm7i8ypbygVKoo4=;
        b=i+w9AhSkUyHvV0Jti1mmYyWrDr0dwKCtYW9IcikRGpDqh9azIjZSnIA8+xZ0a2Teos
         A49L07WKi/cyI8mNC8Ia8Rd3wOviovHIxovXnBdcp2qERLnS3okyRChVQ9llLeVI4aAe
         5zWkzcx9C5qOStgVZuGijL9t0PDVpPaIUkJAbWSCg7d6jA4nekHH3lkaHy5SHcJTbAtj
         +LXYQB0rHan1qKO6BHzVUUQR4fsmUHVp1lQVDV1aHu/p61Ta/WPF4/RY407y9YdDpvWl
         S7x4cXBrDUDEp7R3wAKouy3ucKNpcN05K+6eoeaRO3nL9B5/YMPe0GKh+mm+2UmuYhpK
         ax6Q==
X-Gm-Message-State: AOPr4FWY2jPGfgwtunlSeItWw5ZH42fuZC1mqodMaiVMUmb220MjQKpykhwMIVtSC+uX6DlAT14Jr1ywlSksWw==
X-Received: by 10.50.36.9 with SMTP id m9mr29319051igj.91.1462294521478; Tue,
 03 May 2016 09:55:21 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 09:55:21 -0700 (PDT)
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 9FrpJerl_b8Ek5jgYppmF5wR8VQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293418>

On Tue, May 3, 2016 at 8:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Changes are in
>
>   [01/41] usage.c: move format processing out of die_errno()
>   [02/41] usage.c: add warning_errno() and error_errno()
>   [12/41] builtin/update-index.c: prefer "err" to "errno" in process_=
lstat_error
>   [17/41] compat/win32/syslog.c: use warning_errno()
>   [27/41] grep.c: use error_errno()
>
> 12/41 is basically a revert with s/strerror(errno)/strerror(err)/.
> Interdiff from v1

The interdiff looks quite sensible. Thanks.


> -- 8< --
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 0c539ed..b8b8522 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -251,11 +251,11 @@ static int remove_one_path(const char *path)
>   *    succeeds.
>   *  - permission error. That's never ok.
>   */
> -static int process_lstat_error(const char *path)
> +static int process_lstat_error(const char *path, int err)
>  {
> -       if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
> +       if (err =3D=3D ENOENT || err =3D=3D ENOTDIR)
>                 return remove_one_path(path);
> -       return error_errno("lstat(\"%s\")", path);
> +       return error("lstat(\"%s\"): %s", path, strerror(err));
>  }
>
>  static int add_one_path(const struct cache_entry *old, const char *p=
ath, int len, struct stat *st)
> @@ -382,7 +382,7 @@ static int process_path(const char *path)
>          * what to do about the pathname!
>          */
>         if (lstat(path, &st) < 0)
> -               return process_lstat_error(path);
> +               return process_lstat_error(path, errno);
>
>         if (S_ISDIR(st.st_mode))
>                 return process_directory(path, len, &st);
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 1c2ae18..6c7c9b6 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -28,7 +28,7 @@ void syslog(int priority, const char *fmt, ...)
>         va_end(ap);
>
>         if (str_len < 0) {
> -               warning_errno("vsnprintf failed:");
> +               warning_errno("vsnprintf failed");
>                 return;
>         }
>
> diff --git a/grep.c b/grep.c
> index 87c1890..4f3779a 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_so=
urce *gs)
>         if (lstat(filename, &st) < 0) {
>         err_ret:
>                 if (errno !=3D ENOENT)
> -                       error_errno(_("'%s'"), filename);
> +                       error_errno("'%s'", filename);
>                 return -1;
>         }
>         if (!S_ISREG(st.st_mode))
> diff --git a/usage.c b/usage.c
> index af1b7d1..1dad03f 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -109,9 +109,8 @@ void NORETURN die(const char *err, ...)
>         va_end(params);
>  }
>
> -static const char *fmt_with_err(const char *fmt)
> +static const char *fmt_with_err(char *buf, int n, const char *fmt)
>  {
> -       static char fmt_with_err[1024];
>         char str_error[256], *err;
>         int i, j;
>
> @@ -129,12 +128,13 @@ static const char *fmt_with_err(const char *fmt=
)
>                 }
>         }
>         str_error[j] =3D 0;
> -       snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, s=
tr_error);
> -       return fmt_with_err;
> +       snprintf(buf, n, "%s: %s", fmt, str_error);
> +       return buf;
>  }
>
>  void NORETURN die_errno(const char *fmt, ...)
>  {
> +       char buf[1024];
>         va_list params;
>
>         if (die_is_recursing()) {
> @@ -144,16 +144,17 @@ void NORETURN die_errno(const char *fmt, ...)
>         }
>
>         va_start(params, fmt);
> -       die_routine(fmt_with_err(fmt), params);
> +       die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
>         va_end(params);
>  }
>
>  int error_errno(const char *fmt, ...)
>  {
> +       char buf[1024];
>         va_list params;
>
>         va_start(params, fmt);
> -       error_routine(fmt_with_err(fmt), params);
> +       error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
>         va_end(params);
>         return -1;
>  }
> @@ -171,10 +172,11 @@ int error(const char *err, ...)
>
>  void warning_errno(const char *warn, ...)
>  {
> +       char buf[1024];
>         va_list params;
>
>         va_start(params, warn);
> -       warn_routine(fmt_with_err(warn), params);
> +       warn_routine(fmt_with_err(buf, sizeof(buf), warn), params);
>         va_end(params);
>  }
>
> -- 8< --
