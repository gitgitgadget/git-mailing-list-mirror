From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Git very slow ?
Date: Sun, 8 Mar 2015 19:02:44 +0000
Message-ID: <20150308190244.GA32504@milliways>
References: <20150307013007.GA13250@milliways>
 <20150308155136.GA6273@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin D <me@ikke.info>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:02:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUgTU-0002o7-FI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbbCHTCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 15:02:47 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:52993
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbCHTCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 15:02:46 -0400
Received: from localhost.localdomain ([81.106.150.188])
	by know-smtprelay-7-imp with bizsmtp
	id 172k1q01J4481jl0172kfJ; Sun, 08 Mar 2015 19:02:44 +0000
X-Originating-IP: [81.106.150.188]
X-Spam: 0
X-Authority: v=2.1 cv=cpwVkjIi c=1 sm=1 tr=0 a=DGj713NdaxKrsjjgQne7PA==:117
 a=DGj713NdaxKrsjjgQne7PA==:17 a=J0QyKEt1u0cA:10 a=IkcTkHD0fZMA:10
 a=NLZqzBF-AAAA:8 a=emO1SXQWCLwA:10 a=JxLVWPy8jrL77hS19n4A:9 a=QEXdDO2ut3YA:10
Received: by localhost.localdomain (Postfix, from userid 500)
	id 57A7C8887A; Sun,  8 Mar 2015 19:02:44 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20150308155136.GA6273@vps892.directvps.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265102>

On Sun, Mar 08, 2015 at 04:51:36PM +0100, Kevin D wrote:
> On Sat, Mar 07, 2015 at 01:30:07AM +0000, Ken Moffat wrote:
> > Hi, please CC me if that is not your usual fashion, because I am no=
t
> > subscribed.
> >=20
> > I use git for my build scripts - those are accessed over nfs.  Sinc=
e
> > I started using 2.1 and later (I don't think I used 2.0) commands
> > such as 'commit' take a long time before anything happens.  I
> > assumed that the newer version meant this would take longer.
> >=20
> > But today^Wyesterday I was bisecting the kernel on a local
> > filesystem - even when the number of revisions left to test was in
> > the single digits, git bisect took a long time to decide which
> > revision should be the next one to test.  The filesystems are ext4.
> > Is this sort of delay normal now?
> >=20
> > What really prompted me to ask is that I ran git blame on a script,
> > to see when I made a particular change so that I could add that
> > information to a ticket, and almost gave up waiting because it felt
> > as if it was taking for ever.
> >=20
>=20
> What kind of repository are we talking about? How many files, how big=
?
> Git should not have become significantly slower recently.
>=20

The comments on git bisect were for linus'skernel tree, on a local
disk.  2.3GB of repo, just under 57000 files.

My own repo of build scripts, where I have noticed the delay before
git commit lets me type in the message, is an nfs v3 mount from
another of my machines in the same room - ping between them gives
times of 0.25 to 0.3 seconds and I think the nfs part is irrelevant.
Here, the size is 70MB and 12133 files [ about 1500 scripts total,
so the rest is from the commits ].

Some of this might be the drives - on the desktop with linus's tree
the machine only supports SATA2 (3GB/S), but the machine serving my
scripts goes back further and probably only supports SATA1 (1.5GB/S)

> Also, might there be anti-virus software that slows down file access?

No, this is all local access on linux machines.

=C4=B8en
--=20
Nanny Ogg usually went to bed early. After all, she was an old lady.
Sometimes she went to bed as early as 6 a.m.
