From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] worktree: add "unlock" command
Date: Sun, 15 May 2016 20:42:55 -0400
Message-ID: <CAPig+cSN284FS6P_hS0FRe5+JfQ9+=XYPezEKxL18BVwwifJfg@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-5-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:43:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b26ce-00082D-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbcEPAm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 20:42:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34236 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcEPAm4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 20:42:56 -0400
Received: by mail-io0-f194.google.com with SMTP id d62so11840794iof.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=rlylz2dGAQFuaOgdDvHc5ATIOkuNB3sDOeztXbOMPEg=;
        b=uaW5/lqArHmJA2+mXgu2BCB9VEHhjwwFSKrgRsfZa3/RVn/ffRRO9PzCkji2Wa/bc/
         BHWAwOrfMl5mTkk3fC8MbpKcXSGBU300EvHSLbNO7Mex7caxNp7bIXyNzfvh5HOrx1cg
         3OgJy+rJC8gJioPRaJMb4jLQI5mTFbKxKRQTgW4blSwzJFqa93FZMXrXIRbH+mcEuqvz
         Lrm9fgUJVroTsTuzZgYOvBGQi0L6/jsesAjrwbb+WUC/3Q1T+PZro630jrgX+Q/s0eoV
         5mvsCuFCndeqDJwRmULezPTYW4yyD32uqqC2Y59v0HPq7ylXfMHu2cWNQMwW74ec7bur
         u8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=rlylz2dGAQFuaOgdDvHc5ATIOkuNB3sDOeztXbOMPEg=;
        b=Mgnzvivw4Bl88EQE9/n+dCDz5ycmcQzB7FA9nYEvBLLrLeiqiB/5xIbVFtuRRul8AN
         PzdcZvzKWBM3jqf8x+qVrO2mmqUaxXtbvMlFWeZNX1GFbthUHoo9SdP6kEn7TtJA6gkF
         ePkl3AhBnlANeF1sb9DccHFR9UgqC4ZghKqxk4ZgnQUXW+cxPpYqhWx1D6Ibcly75Jis
         E6C+IBtHXii5gFxUUpDbBnZNc8TO665twRWpGdVKPf5BEX7IWb6/ALIxOon5h3RwkA2G
         M7zLcrPWfvEPkByqrO3FVgTUqeqglfaGL5h4xNNnKsTI9zUDu+CMuQ+DukEVuBEQ+v5I
         3Unw==
X-Gm-Message-State: AOPr4FXKUYVCrys6nRaxRSvPbdDKGbAZMRZp7EMU/C7zJNKCiWC9LNV0QQM29evDzY3/dXUxfCmg+D2u5eeUEA==
X-Received: by 10.107.132.66 with SMTP id g63mr19702595iod.34.1463359375297;
 Sun, 15 May 2016 17:42:55 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 17:42:55 -0700 (PDT)
In-Reply-To: <20160510141729.23063-5-pclouds@gmail.com>
X-Google-Sender-Auth: psOV4f9hzxAp8RD_XcKnSjXU-8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294710>

On Tue, May 10, 2016 at 10:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -498,6 +499,34 @@ static int lock_worktree(int ac, const char **av=
, const char *prefix)
> +static int unlock_worktree(int ac, const char **av, const char *pref=
ix)
> +{
> +       struct option options[] =3D {
> +               OPT_END()
> +       };
> +       struct worktree **worktrees, *wt;
> +       struct strbuf dst =3D STRBUF_INIT;
> +
> +       ac =3D parse_options(ac, av, prefix, options, worktree_usage,=
 0);
> +       if (ac !=3D 1)
> +               usage_with_options(worktree_usage, options);
> +
> +       strbuf_addstr(&dst, prefix_filename(prefix,
> +                                           strlen(prefix),
> +                                           av[0]));
> +
> +       worktrees =3D get_worktrees();
> +       wt =3D find_worktree_by_path(worktrees, dst.buf);

strbuf_release(&dst);

> +       if (!wt)
> +               die(_("'%s' is not a working directory"), av[0]);
> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working directory"), av[0]);
> +       if (!is_worktree_locked(wt))
> +               die(_("not locked"));
> +
> +       return unlink_or_warn(git_common_path("worktrees/%s/locked", =
wt->id));
> +}
