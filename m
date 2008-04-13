From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: How to fetch missing pack
Date: Sun, 13 Apr 2008 11:41:31 +0200
Message-ID: <20080413094131.GA9437@xp.machine.xx>
References: <slrng019fg.nd8.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Apr 13 11:42:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkyj6-0000tH-Iu
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYDMJlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 05:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbYDMJlf
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:41:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:55509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754814AbYDMJle (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 05:41:34 -0400
Received: (qmail invoked by alias); 13 Apr 2008 09:41:32 -0000
Received: from g227036251.adsl.alicedsl.de (EHLO localhost) [92.227.36.251]
  by mail.gmx.net (mp008) with SMTP; 13 Apr 2008 11:41:32 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18PE9RIm8YPD2Xjtc4J/0PH7q9rkygEwtU5wfXoPY
	akHnR8f14xPTAR
Content-Disposition: inline
In-Reply-To: <slrng019fg.nd8.joerg@alea.gnuu.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79401>

On Sat, Apr 12, 2008 at 12:07:12PM +0000, J=F6rg Sommer wrote:
> Hi,
>=20
> I'm missing a pack. My history of the git repository is broken:
> % git show --pretty=3Draw e0fda6ab|head -7
> commit e0fda6abd11c567b72f29ec0ee06c541404a9cb7
> tree 77a7e4a849bbec646d88ae863f80ea3f519e26bd
> parent 1ab58e8d6f728cdde0057f7ee88daab3a1c2d06f
> author Wincent Colaiuta <win@wincent.com> 1196066088 +0100
> committer Junio C Hamano <gitster@pobox.com> 1196109124 -0800
>=20
>     Fix typo in draft 1.5.4 release notes
> % git log --pretty=3Doneline e0fda6ab | wc -l
> 1
> % git show e0fda6ab~1|cat
> fatal: ambiguous argument 'e0fda6ab~1': unknown revision or path not =
in the working tree.
> Use '--' to separate paths from revisions
>=20
> Can I somehow tell git fetch to check the whole history for holes and
> fetch missing packs?
>=20
> Bye, J=F6rg.

Try using git fsck --full to check you repo. If you are missing some
objects, you could just grab them from another valid repo which still h=
as
them. (e.g. copy all packs/objects from the other repo into yours and t=
hen
do a git-repack -a -d -f)

-Peter
