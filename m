From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] diff: release blobs after generating textual diff.
Date: Sun, 6 May 2007 23:36:26 +0200
Organization: Dewire
Message-ID: <200705062336.28201.robin.rosenberg.lists@dewire.com>
References: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.99.0705061301190.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 06 23:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkoPJ-0003Iu-Gs
	for gcvg-git@gmane.org; Sun, 06 May 2007 23:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXEFVgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 17:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXEFVgd
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 17:36:33 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1199 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbXEFVgc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 17:36:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9D4EF8027F7;
	Sun,  6 May 2007 23:30:27 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11496-02; Sun,  6 May 2007 23:30:27 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 38B7F802655;
	Sun,  6 May 2007 23:30:27 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.99.0705061301190.24220@xanadu.home>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46379>

s=F6ndag 06 maj 2007 skrev Nicolas Pitre:
> On Sun, 6 May 2007, Junio C Hamano wrote:
>=20
> > This reduces the memory pressure when dealing with many paths.
> >=20
> > An unscientific test of running "diff-tree --stat --summary -M"
> > between v2.6.19 and v2.6.20-rc1 in the linux kernel repository
> > indicates that the number of minor faults are reduced by 2/3
> > (153k vs 49k).
> >=20
> > Signed-off-by: Junio C Hamano <junkio@cox.net>
> > ---
> >=20
> >  * This is still a WIP, not in the sense that it breaks anything
> >    (it doesn't seem to), but in the sense that it is not known
> >    if it is useful in general and would make that much of a
> >    difference with a project much larger than the kernel.
>=20
> This can only be good.  People are really starting to use Git with=20
> gigantic repos on limited memory hardware.

This did wonders on the usually unreasonable diffs on huge repos. The o=
penoffice
diff mentioned in the openoffice thread went from 6 to ~3 minutes, and =
most importantly
the computer was perfectly usable meanwhile. Git memory usage dropped f=
rom 1,7GB to
400MB.

A more reasonable test diffing against a recent branch , master vs v33M=
4-patches, in=20
the eclipse repo some of you have didn't gain much in performance, but =
memory usage
dropped from 700MB to a peak just under 400MB, which makes a huge diffe=
rence in
responsiveness for the other applications that I have, since they were =
not swapped out
during the diff.

-- robin
