From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sat, 29 Apr 2006 20:27:02 +0200
Organization: At home
Message-ID: <e30b48$ovk$1@sea.gmane.org>
References: <20060429165151.2570.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 29 20:26:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZu9W-0005Xs-Bf
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 20:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWD2S0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 29 Apr 2006 14:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWD2S0a
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 14:26:30 -0400
Received: from main.gmane.org ([80.91.229.2]:43749 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750776AbWD2S0a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 14:26:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZu9B-0005Tc-0d
	for git@vger.kernel.org; Sat, 29 Apr 2006 20:26:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 20:26:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 20:26:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19313>

On Sat, 29 Apr 2006, linux@horizon.com wrote:
>=20
> Well, the only reason that you need ANY commit in the repository is
> because it's part of history, and comparing it with other versions is
> meaningful.=A0=A0So=A0what=A0trees,=A0not=A0already=A0in=A0the=A0ance=
stry=A0graph=A0of=A0a
> given commit, are useful to compare to?=A0=A0In=A0particular,=A0usefu=
l=A0for=A0some
> automated process; manual comparisons can always be done manually.
>=20
> Nothing's jumping out at me.=A0=A0Any=A0suggestions?

See below.

Not necessary all those require connectivity.
Most of them are not my ideas.

 * "prior" - heads=A0that=A0represent=A0topic=A0branch=A0merges

=A0=A0=A0=A0This=A0is=A0the=A0"pu"=A0branch=A0case,=A0where=A0the=A0hea=
d=A0is=A0a=A0merge=A0of=A0several
=A0=A0=A0=A0topic=A0branches=A0that=A0is=A0continually=A0moved=A0forwar=
d.

=A0=A0=A0=A0topic=A0branches=A0=A0=A0=A0=A0head
=A0=A0=A0=A0=A0=A0,___.=A0=A0=A0,___.
=A0=A0=A0=A0=A0|=A0TA1=A0|=A0|=A0TB1=A0|
=A0=A0=A0=A0=A0=A0`---'=A0=A0=A0`---'=A0=A0=A0=A0,__.
=A0=A0=A0=A0=A0=A0=A0=A0=A0^\_____^\____|=A0H1=A0|
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0`-=
-'

=A0=A0=A0=A0+=A0some=A0topic=A0branch=A0changes=A0and=A0a=A0republish:

=A0=A0=A0=A0=A0=A0,___.=A0=A0=A0,___.
=A0=A0=A0=A0=A0|=A0TA1=A0|=A0|=A0TB1=A0|
=A0=A0=A0=A0=A0=A0`---'=A0=A0=A0`---'^=A0=A0=A0,__.
=A0=A0=A0=A0=A0=A0=A0=A0|^\_____^\____|=A0H1=A0|
=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0`--'
=A0=A0=A0=A0=A0=A0,_|_.=A0=A0=A0,_|_.=A0=A0=A0=A0=A0=A0P
=A0=A0=A0=A0=A0|=A0TA2=A0|=A0|=A0TB2=A0|=A0=A0=A0=A0=A0|
=A0=A0=A0=A0=A0=A0`---'=A0=A0=A0`---'^=A0=A0=A0=A0=A0|
=A0=A0=A0=A0=A0=A0=A0=A0^=A0=A0=A0=A0=A0=A0=A0^=A0=A0=A0=A0=A0=A0=A0=A0=
|
=A0=A0=A0=A0=A0=A0,_|_.=A0=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0=A0|
=A0=A0=A0=A0=A0|=A0TA3=A0|=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0=A0|
=A0=A0=A0=A0=A0=A0`---'=A0=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0,__.
=A0=A0=A0=A0=A0=A0=A0=A0=A0^\______\____|=A0H2=A0|
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0`-=
-'

=A0=A0=A0=A0key:=A0=A0^=A0=3D=A0parent=A0=A0=A0P=A0=3D=A0prior


 * "bind" - for subprojects

   bind links from master project commit to externally managed embedded
   third-party project, for example Linux kernel for some mainly usersp=
ace
   project, or library or engine for some application. Additionally it
   provides root dir where to attach subproject.

=20
 * "original" for rebase

   before rebase:

             A---B---C=A0topic
            /
           /
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/
=A0=A0=A0=A0=A0D---E---F---G=A0master

   after rebase

              ------A---B---C
             /      ^   ^   ^=A0
            /       :   :   :
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=A0=A0=A0=A0=A0=A0=A0=A0A'--B'--C'=A0=
topic
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=A0=A0=A0=A0=A0=A0=A0/
=A0=A0=A0=A0=A0D---E---F---G=A0master


   where ':' denotes "original" link. Note that old branch is not point=
ed by
   any head, and would be pruned without connectivity


 * "original" or "cherrypick" for cherry-picking

   =A0=A0=A0=A0=A0=A0=A0=A0 A--------B---C=A0bugfix
           /         ^
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/          :
=A0=A0=A0=A0=A0D---E---F---G---B'---H=A0main


 * "revert" for reverting commits

--=20
Jakub Narebski
