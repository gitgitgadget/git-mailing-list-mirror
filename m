From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] worktree: add "lock" command
Date: Sun, 15 May 2016 20:40:19 -0400
Message-ID: <CAPig+cQ-weDTCnKuxapwaBp8W2T_VNuJSXPE_mRWPbjnO1krxQ@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:40:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b26aB-0005kU-7h
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbcEPAkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 20:40:21 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33599 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcEPAkU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 20:40:20 -0400
Received: by mail-io0-f182.google.com with SMTP id f89so192373760ioi.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 17:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=0V1Exn5o69Bf1rzj3AgK6+p50KccuBQbjJK5S1nlbnQ=;
        b=xbfIbNP32dNXIrVqVeIjQRB0aVINlcRpes2hPVlqAMNwO6CuhVPH5fJgwUTDc8aYRg
         OjtVvdSO7MxEXaE0QhJbIX2hxtsIt8LxAAgFnwyDCPgXBpUSz4rc4RwJBph17CnTdz+l
         0IwBVMbIuOWAEE59QVC1IqqS2DFtzGVKVg6yra/MqMkEbQqgcB/nTGxBoz+0Bb72rbhz
         uxequU/adAWdgsL/VvKpAXIjitC/90h+XMFXWD4vvwUZdCGveXyLnZ4dLJEHu8UARBH1
         X8rJTs9ErZhSQ9LgIU11HiA92pQyB1tzy6+UCmYRRvUREh506Ky7Ui+lDQAs57iMJLQR
         z4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=0V1Exn5o69Bf1rzj3AgK6+p50KccuBQbjJK5S1nlbnQ=;
        b=U/3+sfm4u990D39+yIQAp+ymndAF5G/9dud+24xpoA/URM8neodmcVSaAl3tu1vv9b
         afloTto0dAitC7X7HtFhaYYExcHJi3Way11GkzxVt6cjpafViJWLI/HGe28S+mDzDXl/
         G+56rmUWocVeyQl8+22T5qSGbt4TLvjm41XPMRXW+ptP1/kpOjVWD03raPQJbFuK72tW
         LJnPIZSPPexHQsRIetPjr2OnEfYLFby9q9OPSYxS3hN3yo2VfrqFFHglJw5fLiNVyMzu
         3PTri/+ZRhGlfHU6mw19BP0qV0aJDOOW8tGlC2JRX12hrnBy9WIDunR0c2HeoZJKQLT6
         LDjA==
X-Gm-Message-State: AOPr4FV+KKfIdt299a1JJKQtQvi65tmxJeGPeCr+h+IBvUJBhzjO/zQpQna6KgW55MhJRROdEmC0WttE99i1Yw==
X-Received: by 10.107.47.37 with SMTP id j37mr17220201ioo.168.1463359219077;
 Sun, 15 May 2016 17:40:19 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 17:40:19 -0700 (PDT)
In-Reply-To: <20160510141729.23063-4-pclouds@gmail.com>
X-Google-Sender-Auth: rTPNVmHPwbEC76n7WbKHgkM2sqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294709>

On Tue, May 10, 2016 at 10:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> +static int lock_worktree(int ac, const char **av, const char *prefix=
)
> +{
> +       const char *reason =3D "", *old_reason;
> +       struct option options[] =3D {
> +               OPT_STRING(0, "reason", &reason, N_("string"),
> +                          N_("reason for locking")),
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

Oh, I forgot to mention in my previous email that this is leaking
'strbuf dst'. It could be released right here at its point of final
use.

> +       if (!wt)
> +               die(_("'%s' is not a working directory"), av[0]);
> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working directory"), av[0]);
> +
> +       old_reason =3D is_worktree_locked(wt);
> +       if (old_reason) {
> +               if (*old_reason)
> +                       die(_("already locked, reason: %s"), old_reas=
on);
> +               die(_("already locked, no reason"));
> +       }
> +
> +       write_file(git_common_path("worktrees/%s/locked", wt->id),
> +                  "%s", reason);
> +       return 0;
> +}
