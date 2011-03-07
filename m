From: Shawn Pearce <spearce@spearce.org>
Subject: Re: --max-count useless with git-rev-list's --reverse
Date: Mon, 7 Mar 2011 11:40:21 -0800
Message-ID: <AANLkTikTQfxK8B3fN6y5UZ=tRaM_iWXcfq=ukK4vPq2R@mail.gmail.com>
References: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 20:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwgIR-0005Pd-T9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 20:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab1CGTkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 14:40:42 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36684 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab1CGTkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 14:40:41 -0500
Received: by vxi39 with SMTP id 39so4014505vxi.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 11:40:41 -0800 (PST)
Received: by 10.52.95.66 with SMTP id di2mr2748215vdb.196.1299526841114; Mon,
 07 Mar 2011 11:40:41 -0800 (PST)
Received: by 10.52.162.33 with HTTP; Mon, 7 Mar 2011 11:40:21 -0800 (PST)
In-Reply-To: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168606>

On Mon, Mar 7, 2011 at 11:17, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
> From the manpage:
>
> =A0 --reverse
> =A0 =A0 =A0 Output the commits in reverse order. Cannot be combined w=
ith
> --walk-reflogs.
>
> Shouldn't --reverse be applied *before* --max-count?

No. Its applied after, otherwise things like "git log -n 5 --reverse"
wouldn't let me review the last 5 commits in chronological order. It
also would take a long time to find the first 5 commits in a project
the size of linux-2.6. Most users don't care about the first 5 commits
of a project, but they do care about the most recent X commits that
may have occurred.

So yes, sometimes the reverse doesn't occur where you want it, but its
so rare to want the first X commits of a project's history that its
just accepted. In theory we could add a
--reverse-from-beginning-of-time flag to do what you want, but I don't
think anyone has cared enough to implement this. Most users who want
the beginning of time are OK with something like `git show $(git
rev-list --all | tail -1)`.

--=20
Shawn.
