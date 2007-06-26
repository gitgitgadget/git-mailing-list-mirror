From: Sam Vilain <sam@vilain.net>
Subject: subversion and merging [was: Re: git for subversion users]
Date: Tue, 26 Jun 2007 19:48:33 +1200
Message-ID: <4680C4D1.6050408@vilain.net>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com> <46809733.2060200@vilain.net> <200706261302.10056.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Patrick Doyle <wpdster@gmail.com>, git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 09:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I35nA-00049L-Jb
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 09:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbXFZHsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Jun 2007 03:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbXFZHsl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 03:48:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35284 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXFZHsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 03:48:41 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0B14213A502; Tue, 26 Jun 2007 19:48:38 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 7F11E13A4F8;
	Tue, 26 Jun 2007 19:48:33 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <200706261302.10056.litvinov2004@gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50953>

Alexander Litvinov wrote:
> So, git-svn just a offline-capable version of svn client with linear =
history.=20
> Sure. you can fork your own branch and then merge it into svn branch =
again=20
> but you should really careful about this.
>=20
> I even does not know the way to solve this problem.

The problem is the SVN model.  Only now that people have woken up en
masse to the fact that tracking merges is actually really important are
they adding it to the core.

Their system=C2=B9 is of course completely incompatible with the predom=
inant
tool for this SVK (no complaints there).  Thankfully it looks based on
the other major solution out there, svnmerge, so hopefully only minor
incompatibilities can be expected.

My first analysis of the solution is that they have approached this on
two levels: commit merge ancestry and file merge ancestry.

=46ile merge ancestry, while central to tools like Perforce, is a prett=
y
alien concept to git and almost certainly can be derived (probably more
reliably in practice) using git-cherry-type algorithms.  I describe thi=
s
as the "smash patches to pieces" development model on my git-svn tutori=
al.

Commit merge ancestry is however a basic feature in git.  They are even
going further than that and allowing cherry picks to be tracked as well=
=2E
 This information is currently derived in git using git-cherry.

Sam.

=C2=B9 http://subversion.tigris.org/merge-tracking/design.html
