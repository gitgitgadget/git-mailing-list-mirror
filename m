From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/3] git-bundle.txt: Bundles as [remote ""] is a feature, not an example
Date: Sun, 24 Feb 2008 14:42:21 +0100
Message-ID: <1203860541-12365-1-git-send-email-sbejar@gmail.com>
References: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 14:43:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTH8F-0004oV-G5
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 14:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbYBXNmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 08:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYBXNmb
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 08:42:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:13718 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbYBXNma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 08:42:30 -0500
Received: by fg-out-1718.google.com with SMTP id e21so928218fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=XloDaA1eaWh+FfHKtbjclE/Ehu4eCSIdBzfwk+jchGY=;
        b=mO3LYPAQY+aLgD0LwVbWX6auGYaih6eD8yqOqZNlyuQSn9TIwkgiwWSBZyrhvGtkJobEIUaB7AvIvEFMNxRJJzFyug0ggs1KrvmZvhsJohnAjoyIsLreKGTARrQ8B4CQVtdJNjY3tGtXOn8Zx2lxfyVIk1wMDw0Pz+s9vEv1XFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=xyfluTr6v2i1KnGwq6rJXJ/CM6ofdYeCedCGHataWwQPB7kR/+wLcNNMtFVkg6biCpWO4g8nkDfLlmLiBBFziHL/232fLubBU7IH0PxLeSqCBeGJo0Qt2XOlblBEPU3DkUA43nrCwIgGaqBD04e/Mbn/X3BsPwsxSBkFn5t6TW4=
Received: by 10.86.53.8 with SMTP id b8mr1641119fga.64.1203860549582;
        Sun, 24 Feb 2008 05:42:29 -0800 (PST)
Received: from localhost ( [91.13.69.136])
        by mx.google.com with ESMTPS id 4sm3723411fgg.4.2008.02.24.05.42.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 05:42:28 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
In-Reply-To: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74931>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/git-bundle.txt |   38 ++++++++++++++++++++--------------=
----
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
index 72f080a..1143cdc 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -92,6 +92,26 @@ It is okay to err on the side of conservatism, causi=
ng the bundle file
 to contain objects already in the destination as these are ignored
 when unpacking at the destination.
=20
+REMOTES
+-------
+
+With something like this in your config:
+
+[remote "bundle"]
+    url =3D /path/to/file.bdl
+    fetch =3D refs/heads/*:refs/remotes/bundle/*
+
+You can place a bundle in /path/to/file.bdl and then these commands:
+
+------------
+$ git ls-remote bundle
+$ git fetch bundle
+$ git pull bundle
+------------
+
+would treat it as if it is talking with a remote side over the
+network.
+
 EXAMPLE
 -------
=20
@@ -121,24 +141,6 @@ $ git-fetch mybundle  refspec
 where refspec is refInBundle:localRef
=20
=20
-Also, with something like this in your config:
-
-[remote "bundle"]
-    url =3D /home/me/tmp/file.bdl
-    fetch =3D refs/heads/*:refs/remotes/origin/*
-
-You can first sneakernet the bundle file to ~/tmp/file.bdl and
-then these commands:
-
-------------
-$ git ls-remote bundle
-$ git fetch bundle
-$ git pull bundle
-------------
-
-would treat it as if it is talking with a remote side over the
-network.
-
 Author
 ------
 Written by Mark Levedahl <mdl123@verizon.net>
--=20
1.5.4.3.293.gac81
