From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 12/41] builtin/update-index.c: use error_errno()
Date: Sun, 1 May 2016 14:40:17 -0400
Message-ID: <CAPig+cQmjXcsDsCO0A7dgeDg2ho_eFFf9wCouz528kBk_W=b9w@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462101297-8610-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:41:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awwIf-0001U6-KF
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 20:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcEASkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 14:40:19 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33441 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcEASkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 14:40:18 -0400
Received: by mail-ig0-f193.google.com with SMTP id rc4so7602973igc.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=yPVbIOV8zKgQAqI6D5XMuvXcGiTkueuZm4wDzNTwwnU=;
        b=qz11jO1AtYXV+Nhd8YGk9iDE9mKr427DSCbf/DOLbdGsRCePmVsZhPozQTTU8qJsYn
         APiuKjXCDNBjf+66A6b8hXly/F9HbcZiPbrP5CXm/a8l0BQ5jTcgLoMJLuy2YdM7hisO
         l8poNs71xsgkWowSQLzeaTkyoLTDZpxUIPs9dSDrkBUc4PjtvBVTDZaRwibCJZOXA+vl
         o1orV87/U+RCJD3KfSMXVSCFl/dt8TcorzQ10k63nvp/ONiAslqvKCnTgIB9gg5MI/I8
         d+hmC9x8y+YrONhgoyZzrncqoZmfv9BA6DToBt69FbFrmWs7+FzaTf8BlqmLyMWrm0SU
         33XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=yPVbIOV8zKgQAqI6D5XMuvXcGiTkueuZm4wDzNTwwnU=;
        b=D2xAYixejfVD53s+SGT9cItFXHe9fo6v1TrGZLB3F/WlOVaaB1t0dCDJbC4uLU4SMq
         o2FZkQMwLq7WGgNzJp6FSy5mpm9+zcXo/+U/SdUSdPmlB4IWoB+DbuMsf5iZ7V2hsjDm
         bYvw7JeDyG/JNiZgH/+DX1SKSMDkyPvyos3AWxLIjG1OVs3VJgyD4wu92/G9YJSMvTHZ
         vJbaxEu1L6lg2Q9z8VAVMv9dWK7B5uI5Ood1otPHYUp+JkYWhGYBvxiKcdscETW145h/
         a5lpvQqe0hGv3QW1jYT8UKNFy7RZSIwyY6Ax0Ye+r44twwXNE9RrjNrIYZDSJsCOnWG/
         tX6g==
X-Gm-Message-State: AOPr4FVhzbZRiZ2utgusUeoq5jn6f5NRAbUtz3OQ1RlebrUlPfE4/ZzoXdX2bqG/hXFdBNm7FKmI+9NQng8SRQ==
X-Received: by 10.50.205.42 with SMTP id ld10mr16033859igc.17.1462128017580;
 Sun, 01 May 2016 11:40:17 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 11:40:17 -0700 (PDT)
In-Reply-To: <1462101297-8610-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 0tCT5o--zgnSmWS_0zyjfOvWAM4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293205>

On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> "err" is deleted because it just causes confusion when "errno" is als=
o
> used directly in process_lstat_error().

Despite the function name which may imply that it is consulting errno,
this change makes me feel slightly uncomfortable since it increases
coupling. Whereas consulting of errno had been explicit, with this
change, it becomes implicit, and someone changing the code needs to be
extra careful about ensuring that errno does not get clobbered.

Not a big objection, but a nagging doubt...

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> @@ -251,11 +251,11 @@ static int remove_one_path(const char *path)
> -static int process_lstat_error(const char *path, int err)
> +static int process_lstat_error(const char *path)
>  {
> -       if (err =3D=3D ENOENT || err =3D=3D ENOTDIR)
> +       if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
>                 return remove_one_path(path);
> -       return error("lstat(\"%s\"): %s", path, strerror(errno));
> +       return error_errno("lstat(\"%s\")", path);
>  }
>
>  static int add_one_path(const struct cache_entry *old, const char *p=
ath, int len, struct stat *st)
> @@ -382,7 +382,7 @@ static int process_path(const char *path)
>          * what to do about the pathname!
>          */
>         if (lstat(path, &st) < 0)
> -               return process_lstat_error(path, errno);
> +               return process_lstat_error(path);
>
>         if (S_ISDIR(st.st_mode))
>                 return process_directory(path, len, &st);
