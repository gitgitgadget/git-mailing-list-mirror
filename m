From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 5 May 2008 12:45:38 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805051240150.32269@woody.linux-foundation.org>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <8663tsbqg0.fsf@blue.stonehenge.com> <alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org> <905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com>
 <86fxswa7ra.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tarmigan <tarmigan+git@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon May 05 21:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt6e6-0004nH-Gx
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 21:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYEETpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYEETpu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 15:45:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46135 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752982AbYEETpt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 15:45:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45JjeTP017417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 12:45:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45Jjd8n001579;
	Mon, 5 May 2008 12:45:39 -0700
In-Reply-To: <86fxswa7ra.fsf@blue.stonehenge.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.422 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81307>



On Mon, 5 May 2008, Randal L. Schwartz wrote:
>=20
> As I posted in a followup, without twiddling anything, ZFS on OSX
> is case *sensitive*, but apparently still "normalizes", which is caus=
ing
> the trip-up.  I'll look to see if there are any parameters I can twea=
k
> to keep it from doing that, but I doubt it.

Well, the good news is that while the utf-8 normalization is crazy, you=
're=20
pretty unlikely to actually hit it in practice. The git archive has the=
=20
M=E4rchen file on purpose to find these kinds of issues, but it's harml=
ess=20
appart from the annoyance.

Yes, some projects will have i18n support that may have files with spec=
ial=20
characters on purpose, and they can cause problems. Not least exactly=20
because OS X does all the normalization exactly the wrong way (ie it ch=
ose=20
the _unusual_ way to do things, expanding strings to their longest form=
at=20
rather than their shortest format), but I would expect it to be very ra=
re=20
in general, partly because it doesn't really matter what SCM you use to=
=20
track things, and you'll have similar issues if you ever develop anythi=
ng=20
across OS's.

We can fix it. Junio hasn't merged my stupid infrastructure into core g=
it=20
yet, and I still don't really care enough or have a OS X box to test on=
=20
(I've got a couple of mac minis, but they run that other OS ;), but we'=
ll=20
get the insane OS X crap handled *some* day.

			Linus
