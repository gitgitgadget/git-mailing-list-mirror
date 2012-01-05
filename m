From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: checkout on an empty directory fails
Date: Thu, 5 Jan 2012 12:13:32 +0100
Message-ID: <87d3ayz9k3.fsf@thomas.inf.ethz.ch>
References: <4F0576D9.4030207@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?B?UmVuw6kgRG/Dnw==?= <doss@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 05 12:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RilGa-00058w-22
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 12:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab2AELNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 06:13:36 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:17477 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab2AELNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 06:13:35 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 5 Jan
 2012 12:13:30 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 5 Jan
 2012 12:13:32 +0100
In-Reply-To: <4F0576D9.4030207@gmx.de> (=?utf-8?B?IlJlbsOpIERvw58iJ3M=?=
 message of "Thu, 05 Jan
	2012 11:09:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187971>

Ren=C3=A9 Do=C3=9F <doss@gmx.de> writes:

> I have a clean derectory ang the git database. Now I want check out
> the master.

Ok, but why?  What problem were you really trying to solve?

> red@linux-nrd1:~/iso/a> git checkout master
> D       SP601_RevC_annotated_master_ucf_8-28-09.ucf
> D       rtl/ether_speed.vhd
> D       rtl/ether_top.vhd
> D       rtl/ether_tx.vhd
> D       rtl/takt.vhd
> D       sim/makefile
> D       sim/tb_ether_top.vhd
> Already on 'master'

git-checkout considers this an uncommitted change compared to the
current branch (HEAD).  It actually ensures that you do not lose such
changes.

To get your files back, you can use the file-argument form of checkout

  git checkout -- .

or the "really give me back the HEAD state, period" form of git-reset

  git reset --hard

Both of those *will* destroy uncommitted changes with no recourse or
backup, so be careful.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
