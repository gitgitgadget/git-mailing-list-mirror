From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 24/25] worktree move: accept destination as directory
Date: Wed, 11 May 2016 00:43:16 -0400
Message-ID: <CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
	<1460553346-12985-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 06:47:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0M3f-00042L-QN
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 06:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbcEKEnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 00:43:17 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33669 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcEKEnR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 00:43:17 -0400
Received: by mail-ig0-f194.google.com with SMTP id rc4so3191374igc.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 21:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=iNMHGQVrfVfU/UmyravXeH2VxXq5U6mfAMNoS1nr1p4=;
        b=FuLgBQEuW/lBHxh7giJPhwrCAdK0kMCOUm4rjz2+OwHiW9BqeACWKNhnzyOLRwFdku
         wIePEJRljgO4mSD4YaENj5QinkzS7OUH7O4niw41850dN1h8gzM6fT4ByBzbyo/pl7ln
         y1RJYN0Cd0TKTIwiTh4JX+Qzps7fpCQtHo9p47CWJ9NbMjs8SGfAD8dopH0zmN1U6c0H
         9zzWGLNyBluKb+Qz2g1zExY8wohbDgom9A5gPl4sNRj4yIBhkqHA7Lv7Qlza+o29tB11
         S+cVfNXMo4mFB49yGxb3SdvXcYsskAPzpuTQGhJvcG16hkRdY5ccX7An8+QuNC5PHGOp
         yT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=iNMHGQVrfVfU/UmyravXeH2VxXq5U6mfAMNoS1nr1p4=;
        b=I3qgC+lcVIhKFRnL9b7ikY7AmZ1g0MFRuj4WjCkMInOjGE0NIOA4jCkZELeM+4OTiy
         gVAcWUx7xK+GE0bEpBUIgeGzJhfrKf71b12x1VujCjlHiPFMB5yQHVUn0L9Mt4aCe9xU
         RWzsKGsnaOJ09Ex/rWOz4insQDl7Ap9P5rZwWJ0rzTgoALtxUKfSz1cYtq8oOP5m3sJl
         fu0tnixjErGKONPXmgZElBtMfyg4MvZCyrG7nJvUCW3jdI8FK2E70KvNELsyrNNHe7SA
         LTbe/nai3BmVYepgT34EaMG3JV/eAYKHE6/eXc5CMoJeDJyBqv6O7/Qp8VgSwqNkUOuX
         aNpA==
X-Gm-Message-State: AOPr4FWFO8v13nhwwMcanGByQlGcztbQofTOrneY/xZ0SAfc8qM2tFZ6LFXOd0aDyf7BOVd5yZ74sO+WaDhxzw==
X-Received: by 10.50.205.42 with SMTP id ld10mr20577502igc.17.1462941796102;
 Tue, 10 May 2016 21:43:16 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 21:43:16 -0700 (PDT)
In-Reply-To: <1460553346-12985-25-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: elspf2b-Xx7GOmKkqOBtuNaMzfM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294226>

On Wed, Apr 13, 2016 at 9:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Similar to "mv a b/", which is actually "mv a b/a", we extract basena=
me
> of source worktree and create a directory of the same name at
> destination if dst path is a directory.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -538,7 +538,13 @@ static int move_worktree(int ac, const char **av=
, const char *prefix)
> -       if (file_exists(dst.buf))
> +       if (is_directory(dst.buf))
> +               /*
> +                * keep going, dst will be appended after we get the
> +                * source's absolute path
> +                */
> +               ;
> +       else if (file_exists(dst.buf))
>                 die(_("target '%s' already exists"), av[1]);
> @@ -558,6 +564,17 @@ static int move_worktree(int ac, const char **av=
, const char *prefix)
> +       if (is_directory(dst.buf)) {
> +               const char *sep =3D strrchr(wt->path, '/');

Does this need to take Windows into account? Perhaps git_find_last_dir_=
sep()?

> +
> +               if (!sep)
> +                       die(_("could not figure out destination name =
from '%s'"),
> +                           wt->path);
> +               strbuf_addstr(&dst, sep);
> +               if (file_exists(dst.buf))
> +                       die(_("target '%s' already exists"), dst.buf)=
;
> +       }
