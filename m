From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and gid
Date: Sun, 14 Mar 2010 21:51:29 +0100
Message-ID: <201003142151.29969.robin.rosenberg@dewire.com>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com> <alpine.LFD.2.00.0904270757410.22156@localhost.localdomain> <86skjudr6u.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Mar 14 22:13:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqv8G-0007ys-Qh
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 22:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078Ab0CNVNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 17:13:47 -0400
Received: from mail.dewire.com ([83.140.172.130]:16189 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933027Ab0CNVNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 17:13:46 -0400
X-Greylist: delayed 1334 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2010 17:13:46 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 717C68006B7;
	Sun, 14 Mar 2010 21:51:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0N+MDugLU+nH; Sun, 14 Mar 2010 21:51:30 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CA4BE800396;
	Sun, 14 Mar 2010 21:51:30 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-20-generic; KDE/4.3.5; i686; ; )
In-Reply-To: <86skjudr6u.fsf@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142156>

m=E5ndagen den 27 april 2009 17.58.17 skrev  Kjetil Barvik:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Sun, 26 Apr 2009, Junio C Hamano wrote:
> >> I like the end result.
> >>
> >> But I am not sure about dropping the nanosecond resolution timesta=
mps.
> >> The area was extended recently in preparation for ext4; we can tak=
e
> >> advantage of it to reduce the chance the racy-git avoidance codepa=
th
> >> triggers if we keep it.
> >>
> >>     fba2f38 (make USE_NSEC work as expected, 2009-02-19)
> >>
> >>     c06ff49 (Record ns-timestamps if possible, but do not use it w=
ithout
> >>     USE_NSEC, 2009-03-04)
> >
> > Hey, we can leave the NSEC support in. Admittedly removing that was=
 about
> > half the patch, but even with it left in, it would be a cleanup.
>=20
>   I think we should have the NSEC support, as it is a performance
>   impromvent, at least on my laptop.  OK, not a huge improvment, but
>   still.
>=20
>   For git version 1.6.3.rc3 I made a litle test, and the difference w=
as
>   the following for the 'git checkout my-v2.6.25' (from my-v2.6.27):
>=20
>                  for git compiled with    for git compiled without
>                  'make USE_NSEC=3D1 ...':   the 'USE_NSEC=3D1' part:
>=20
>    OK open calls:       13872                   14386
>    OK close calls:      13872                   14386
>    OK mmap2 calls:        102                     649
>    OK munmap calls:        61                     608
>=20
>   so, an improvment of 514 open() and close() calls, and 547 mmap2() =
and
>   munmap() calls, for this particular test on my particular slow lapt=
op
>   disk.
>=20
>   As I wrote in fba2f38 I would guess that the improvment is larger f=
or
>   a faster disk, and a SSD disk should be able to see a larger
>   improvment that I did above.
>=20
>   -- kjetil

Did something pop up that I don't know of that prevented inclusion of t=
his=20
patch, other than the NSEC option, or will it do if just refresh the pa=
tch?

-- robin
