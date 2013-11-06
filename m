From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed,  6 Nov 2013 16:04:21 +0100
Message-ID: <1383750263-32495-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 06 16:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve4eu-0008MY-8y
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 16:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab3KFPE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 10:04:26 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:60578 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756443Ab3KFPEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 10:04:25 -0500
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 783BF8058F;
	Wed,  6 Nov 2013 16:04:24 +0100 (CET)
Received: (nullmailer pid 32534 invoked by uid 1000);
	Wed, 06 Nov 2013 15:04:23 -0000
X-Mailer: git-send-email 1.8.4.652.g0d6e0ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237353>

Hi all,

This comes as a result of the discussion starting at [0] about
git-push assuming that a server will always support thin packs. Most
out there in fact do, but this isn't necessarily the case.

Some implementations may not have support for it yet, or the server
might be running in an environment where it is not feasible for it to
try to fill in the missing objects.

Jonathan and Duy mentioned that separate patches for receive-pack and
send-pack could let us work around adding this at such a late stage,
so here they are. The second patch can maybe lie in waiting for a
while.


[0] http://thread.gmane.org/gmane.comp.version-control.git/235766/focus=
=3D236402

Carlos Mart=C3=ADn Nieto (2):
  receive-pack: advertise thin-pack
  send-pack: only send a thin pack if the server supports it

 Documentation/technical/protocol-capabilities.txt | 20 +++++++++++++++=
-----
 builtin/receive-pack.c                            |  2 +-
 send-pack.c                                       |  2 ++
 3 files changed, 18 insertions(+), 6 deletions(-)

--=20
1.8.4.652.g0d6e0ce
