From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Fix core.worktree being used when GIT_DIR is not set
Date: Mon, 28 Dec 2009 01:08:09 +0100
Message-ID: <200912280108.10113.robin.rosenberg@dewire.com>
References: <200912071115.48085.robin.rosenberg.lists@dewire.com> <1261920513-25189-1-git-send-email-pclouds@gmail.com> <7viqbsw2vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 01:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP39z-0007xa-J6
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 01:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbZL1AI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 19:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbZL1AI0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 19:08:26 -0500
Received: from mail.dewire.com ([83.140.172.130]:23323 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbZL1AI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 19:08:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0DDF8147DF86;
	Mon, 28 Dec 2009 01:08:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yaRVZsmaXLiH; Mon, 28 Dec 2009 01:08:13 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 735B38003BB;
	Mon, 28 Dec 2009 01:08:12 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; i686; ; )
In-Reply-To: <7viqbsw2vn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135720>

s=C3=B6ndagen den 27 december 2009 21.58.20 skrev  Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
> > According to config.txt:
> >> core.worktree::
> >>         Set the path to the working tree.  The value will not be
> >>         used in combination with repositories found automatically =
in
> >>         a .git directory (i.e. $GIT_DIR is not set).
> >
> > This behavior was changed after e90fdc3 (Clean up work-tree handlin=
g -
> > 2007-08-01) and 9459aa7 (Do check_repository_format() early (re-fix=
) -
> > 2007-12-05). If core.worktree is set, even if git_dir automatically
> > found (and git_work_tree_cfg set), git_work_tree_cfg will be reset =
to
> > core.worktree. This makes core.worktree effective even if GIT_DIR i=
s
> > not set, in contrast to config.txt.
> >
> > This patch makes sure it only checks for core.worktree if GIT_DIR i=
s set.

=2E..

>=20
> Given these background, I am not sure the "fix" is addressing the rig=
ht
> issue.  What does it mean to have "core.worktree" in a configuration =
file,
> but that configuration file was found in a "git directory" that was f=
ound
> thorough the repository discovery process due to lack of $GIT_DIR?  T=
here
> are only two cases I can see:

I'm inclined towards fixing the docs. Overriding a config setting in no=
n-
intuitive and nobody has complained.

-- robin
