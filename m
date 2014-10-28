From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Tue, 28 Oct 2014 07:45:34 +0000
Message-ID: <20141028074534.GB7762@dcvr.yhbt.net>
References: <1414452388.89217.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 08:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xj1TW-0002MD-PM
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 08:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120AbaJ1Hpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 03:45:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36788 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725AbaJ1Hpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 03:45:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BE71F665;
	Tue, 28 Oct 2014 07:45:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414452388.89217.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> >Eric Wong <normalperson@yhbt.net> wrote:
> >> Which SVN version are you using?=C2=A0 I'm cloning (currently on r=
373xx)
> >> https://svn.r-project.org/R using --stdlayout and
> >> unable to see memory growth of the git-svn Perl process beyond 40M
> >> (on a 32-bit system).
> >
> >git-svn hit 45M and took 11:44 to finish.=C2=A0=C2=A0=C2=A0My ping t=
imes to
> >svn.r-project.org is around 150ms (I'm running this from a server in
> >Fremont, California).=C2=A0 I'll keep the repo around and periodical=
ly fetch
> >to see how it runs.
>=20
> I'll apply the 10 patches against 2.1.0 and see then. As I wrote
> in my last reply, my 3rd clone took about 8 hours to finish,
> and the max resident size is about 700MB (according to GNU "time").

The "time" command is not a good measurement since it includes child
process memory use (which may be file-backed mmap for git repack or
"git cat-file --batch").  My measurements are just the RSS of the
git-svn Perl process (from "ps aux" or VmRSS in /proc/$PID/status
on Linux)
