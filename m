From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: document CWD effect
Date: Sun, 08 Apr 2007 14:28:30 +0200
Message-ID: <4618DFEE.8080707@lsrfire.ath.cx>
References: <esc64d$d2u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Nick Williams <njw@jarb.freeserve.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 08 14:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaWW1-0005MO-8T
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 14:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXDHM2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Apr 2007 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXDHM2p
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 08:28:45 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:51584
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755AbXDHM2o (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2007 08:28:44 -0400
Received: from [10.0.1.201] (p508e56dc.dip.t-dialin.net [80.142.86.220])
	by neapel230.server4you.de (Postfix) with ESMTP id 8428D23004;
	Sun,  8 Apr 2007 14:28:43 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <esc64d$d2u$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44001>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

Nick Williams schrieb:
> git-archive only archives the current working dir (and sub dirs) even
> when no paths are specified. For example, if I do
>=20
> git archive --format=3Dtar --prefix=3Dgit-1.5.0.2/ HEAD > ~/test/test=
=2Etar
>=20
> from with in the Documentation dir, then I only get part of the tree.
>=20
> Is this the intended behavior?
>=20
> The reason I ask is that from my (mis)reading of the man page I expec=
t
> to get all of the tree unless paths are specified.

Sorry about the late reply.  Would these two additional manpage lines
clear things up for you?

Thanks,
Ren=E9


diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 493474b..b688330 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -17,6 +17,9 @@ Creates an archive of the specified format containing=
 the tree
 structure for the named tree.  If <prefix> is specified it is
 prepended to the filenames in the archive.
=20
+Only the files and directories in the current working directory are
+included in archives created locally (i.e. without --remote).
+
 'git-archive' behaves differently when given a tree ID versus when
 given a commit ID or tag ID.  In the first case the current time is
 used as modification time of each file in the archive.  In the latter
