From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 10:40:43 +0200
Message-ID: <46B2EA0B.9030805@fs.ei.tum.de>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de> <46B2309E.3060804@fs.ei.tum.de> <6715F560-FE69-4F15-8C5F-B5B6071D97ED@zib.de> <46B25FC3.6000205@fs.ei.tum.de> <46B26DA8.6010102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGsiI-0002Gv-8R
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 10:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbXHCIkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Aug 2007 04:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXHCIkr
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 04:40:47 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:51949 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbXHCIkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 04:40:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 1028F280EA;
	Fri,  3 Aug 2007 10:40:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5xEtrIOlMowG; Fri,  3 Aug 2007 10:40:44 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-227.dclient.lsne.ch [85.218.11.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 8C3FF280E3;
	Fri,  3 Aug 2007 10:40:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <46B26DA8.6010102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54691>

Michael Haggerty wrote:
> Simon 'corecode' Schubert wrote:
>> Steffen Prohaska wrote:
>>> BTW, togit creates much more complex branching patterns than cvs2sv=
n
>>> does. The attached file branching.png displays a small view of a
>>> branching pattern that extends downwards over a couple of screens.
>>> I checked the cvs2svn history again. It doesn't contain anything
>>> of similar complexity.
>> haha yea, there is still some issue with duplicate branch names and =
the
>> branchpoint.  if it doesn't get the branch right, it will always "pu=
ll"
>> files from the parent branch.
>=20
> This sounds very much like the problem reported by Daniel Jacobowitz
> [1].  The problem is that if you create a branch A on a file, then
> create branch B from branch A before making a commit on branch A, the=
n
> CVS doesn't record that branch A was the source of branch B.  (It tre=
ats
> B as if it sprouted directly from the revision that was the *source* =
of
> branch A.)  The same problem exists if "B" is a tag.

I think I have covered this case quite well.  I believe "my" problem ha=
ppens when there are files being copied manually within the repository =
and then branch names being changed (or just branch names being changed=
).  However, the name change just happens only on a subset of files and=
 branches, so you wind up with a commit which is part of two branches. =
 Or something like that.  I really should have the time to investigate =
this.

One elementary problem with CVS is that you can assign two branch names=
 to the same branch.  During conversion you need to choose one over the=
 other.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
