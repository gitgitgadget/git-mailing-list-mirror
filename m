From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/5] worktree: add "unlock" command
Date: Mon, 23 May 2016 00:39:42 -0400
Message-ID: <CAPig+cRFx8eAB4LgcCO2efB5qLSJT=u+_QBrJF7uu+BQg3U_jg@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522104341.656-1-pclouds@gmail.com>
	<20160522104341.656-6-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:39:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hee-00089s-1b
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbcEWEjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 00:39:44 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35260 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcEWEjn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 00:39:43 -0400
Received: by mail-it0-f47.google.com with SMTP id z189so20368800itg.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=bCgX5CaWuEvC0fdWq8o4sPYC0fZXsldWE0rvEJ3JkBo=;
        b=WoeNrdELmHaUvhL6diawKuC3NrhaWpPzl0jwyMZoCV9YCidftY8jumMD4Yf7K85Nqc
         Te3SF7b2UwkJeOUD/RW5WUxuAi3X6ICLIdsd+I4zfDNEF5NabnKtZcpdUkCp2tTbP8fE
         LaV1PI4xWZU/eMdoPJyW0+xCeoMJv0OfaFJDjiOR8P/RhuXAEBh5rU9xK7RhLPGCOsFA
         wS5lRnJA+TSnYUV6XnQAl4Byu8Lv/oiZuKwM63sMa8R6qe14DlNem8togNj9jkAQ4olu
         NtqdxoTQd6oV/V+O5GhPcZBuiM+RktohqUlN9ci1QX0Aq0MBlBCxmrppRiVXaHvtmtMr
         YL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=bCgX5CaWuEvC0fdWq8o4sPYC0fZXsldWE0rvEJ3JkBo=;
        b=MEavFcsDzvePQoC27ukqtFL6qSWysYNyP/fZ/TYDlNdn6hHD8/f8lBV025orGLt4mQ
         Us9z8eduQZp4Zhpbqd0wyokZqcRMYxlGZkjk0MkWe0JBtGO5BaavGqWY+4mWj8N94g/1
         uh3uTLP8jwhNWL2LBw2ORDAtwww0Mq4XBZuGUI80tydEAp/1vs0+hpQbEVJRDKgHJbBl
         X3DNCaHi5LFGFcr7K/QGMWuFD58NkvYQdICoqJttRMKmsRxedE5o0fcbx+Rf8TdR+VVR
         e26n0cQ+x7zbsZz9/YAzNvVKCShGSgC+Kf0HV+v49CXpyn7IwzvT51QsL5LxfWcIffru
         QX8g==
X-Gm-Message-State: AOPr4FX9cz3LzVCd6BppjsyMDjnnqRahIL5SP5tvt5ATIONPJeUTSCmWhMPB/HN9zMeD+IP9fOXn/XRRBb79Hg==
X-Received: by 10.36.55.141 with SMTP id r135mr9220696itr.73.1463978382701;
 Sun, 22 May 2016 21:39:42 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 21:39:42 -0700 (PDT)
In-Reply-To: <20160522104341.656-6-pclouds@gmail.com>
X-Google-Sender-Auth: EpFMxMfp6xeIU-BiZV6rSvXWU_c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295308>

On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -500,6 +501,37 @@ static int lock_worktree(int ac, const char **av=
, const char *prefix)
> +static int unlock_worktree(int ac, const char **av, const char *pref=
ix)
> +{
> +       [...]
> +       wt =3D find_worktree_by_path(worktrees, dst.buf);
> +       strbuf_release(&dst);
> +       if (!wt)
> +               die(_("'%s' is not a working directory"), av[0]);
> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working directory"), av[0]);
> +       if (!is_worktree_locked(wt))
> +               die(_("not locked"));

Could be _("'%s' is not locked"), but not worth a re-roll.

> +       ret =3D unlink_or_warn(git_common_path("worktrees/%s/locked",=
 wt->id));
> +       free_worktrees(worktrees);
> +       return ret;
> +}
