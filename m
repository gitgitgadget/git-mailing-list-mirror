From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: bash completion broken on ubuntu 10.10?
Date: Wed, 20 Oct 2010 22:50:18 -0400
Message-ID: <20101020225018.46f7e70e@montecarlo.grandprix.int>
References: <20101020230409.GB1767@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 05:28:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8lpf-00053c-4y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 05:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab0JUD2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 23:28:41 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:39459 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab0JUD2l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 23:28:41 -0400
X-Greylist: delayed 2296 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Oct 2010 23:28:40 EDT
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1P8lES-0007w2-Qc
	for git@vger.kernel.org; Wed, 20 Oct 2010 19:50:20 -0700
Received: from montecarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id A55DE101F82
	for <git@vger.kernel.org>; Wed, 20 Oct 2010 22:50:19 -0400 (EDT)
In-Reply-To: <20101020230409.GB1767@neumann>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159481>

On Thu, 21 Oct 2010 01:04:09 +0200
SZEDER G=E1bor <szeder@ira.uka.de> wrote:

> Hi,
>=20
> Git's bash completion script offers possible arguments to some
> options, e.g. it lists pretty formats after 'git log --pretty=3D<TAB>=
',
> merge tools after 'git mergetool --tool=3D<TAB>', refs after 'git com=
mit
> --reuse-message=3D<TAB>', etc.
>=20
> On a three day old ubuntu 10.10 install these don't work anymore; the
> completion script offers the list of files in all those cases.
>=20
> After a bit of investigation I found that when I press TAB after 'git
> log --pretty=3D', then ${COMP_WORDS[COMP_CWORD-1]} contains '--pretty=
'
> and ${COMP_WORDS[COMP_CWORD]} contains "=3D".  Weird.
>=20
> Then I remembered that we had some COMP_WORDBREAKS issues in the past
> (db8a9ff, bash completion: Resolve git show ref:path<tab> losing ref:
> portion, 2008-07-15)).  So I looked at my $COMP_WORDBREAKS, but didn'=
t
> see anything suspicious (it contains "'><=3D;|&(: ).  Removing the '=3D=
'
> makes the listing after 'git log --pretty=3D' work, but breaks many
> other things badly.
>=20
> I don't have any ideas what could possibly be wrong here (but it's to=
o
> late here for any bright ideas anyway...).  Could someone confirm or
> deny this behaviour on ubuntu 10.10?
>=20
>=20
> Thanks,
> G=E1bor
>=20

My guess is that it has to do with Bash 4, the equal sign must be seen
as a new word. I'm running Ubuntu 10.04 and have the same problem.
I fixed the problem locally, I just don't know if that works on Bash 3
and I doubt it will work on Bash 3.

I changed the script only for git log, not other commands yet, like=20
git am --whitespace=3D<tab><tab>


--=20
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes

WordPress Plugin Developer
Blog: http://blog.avirtualhome.com
=46orums: http://forums.avirtualhome.com
Twitter: @avhsoftware
