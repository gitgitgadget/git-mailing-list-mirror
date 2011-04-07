From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Thu, 7 Apr 2011 19:27:57 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:51:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7vER-0002t4-JU
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719Ab1DGTvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 15:51:01 -0400
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:38030 "EHLO
	herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab1DGTvA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 15:51:00 -0400
X-Greylist: delayed 727 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Apr 2011 15:51:00 EDT
Received: from herc.mirbsd.org (tg@localhost [IPv6:::1])
	by herc.mirbsd.org (8.14.5.Beta0/8.14.5.Beta0) with ESMTP id p37JRxtZ028551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Apr 2011 19:28:03 GMT
Received: (from tg@localhost)
	by herc.mirbsd.org (8.14.5.Beta0/8.14.5.Beta0/Submit) id p37JRwPd009314;
	Thu, 7 Apr 2011 19:27:58 GMT
Received: by S/MIME Plugin for MirBSD 10 Kv#10uAE-20110220 i386; Thu Apr  7 19:27:57 UTC 2011
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171085>

Richard Hartmann dixit:

>git natively. metastore exists, but its binary storage format is

According to the documentation, metastore supports saving/restoring
POSIX Extended Attributes (however I got EOPNOTSUPP trying to setfacl
and setxattr, so I couldn=E2=80=99t verify the claim). It does *not* ho=
wever
track the stuff visible using lsattr(1) on ext2fs.

Personally, I think this should definitively be tracked in git, not
in extra files (like =E2=80=9C EA DATA. SF=E2=80=9D in OS/2) managed wi=
th external
tools (reminds me too much of things like umsdos and Rock Ridge as
well). Support needs not be part of core git, especially restoring
can be dangerous (consider SELinux), plus it=E2=80=99s very platform an=
d
filesystem dependent, but seeing that people seem to want to use
git for keeping their /etc (I use RCS, myself, but volunteered my
C skill to change metastore if it needs be) there is definitively
a market for having it there, in a standardised manner.

bye,
//mirabilos
--=20
=46WIW, I'm quite impressed with mksh interactively. I thought it was m=
uch
*much* more bare bones. But it turns out it beats the living hell out o=
f
ksh93 in that respect. I'd even consider it for my daily use if I hadn'=
t
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mks=
h
