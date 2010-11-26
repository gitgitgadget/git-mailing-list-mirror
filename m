From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/47] git-rev-parse.txt: clarify --git-dir
Date: Fri, 26 Nov 2010 22:32:31 +0700
Message-ID: <1290785563-15339-36-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 17:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0mU-0003J9-Lv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab0KZQEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 11:04:09 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:42883 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab0KZQEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:04:07 -0500
Received: by pzk26 with SMTP id 26so460555pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Op8Iys+nbFBtUAGoQIYcDSAqIOTkuP1qiH6IrSWv1s4=;
        b=TL2MVXde/SGN1zuO+GEvKEmaM5WkjUntLQ0CgSFtyvIMXgTFkMYGUyV1gOCyIx7XX2
         uga0VwZCh3ntkkxPYeiHccZOFEsUYwD+T0VFf/d5G/AlRaArqoTXWnTiZBoGr+Zn9wGU
         feg5doR7P17zdt29SyByeW//oI66EMAyfteYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qqFsOZ+XBTstJwrdIjWkra02ViSb9yikXy6u70H0mX1UeUm/JNBT0y8BQQ6GHbmD3C
         cHBiikWBCGyRQs/SnIi4xqUR64qO6vVNqkeGcVTyvEKeFAEXjLnLpykBjmrBy8XGyWM+
         +HDek1D8KPO4wk5d99chOQtBuVd5ve8iEDkek=
Received: by 10.142.165.19 with SMTP id n19mr2544861wfe.6.1290786439486;
        Fri, 26 Nov 2010 07:47:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2684367wfd.7.2010.11.26.07.47.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:47:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:46:03 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162262>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

The current behavior is often to print an absolute path rather than
a ../../etc string, but callers must be ready to accept a relative
path, too. The most common output is ".git" (from the toplevel of
an ordinary work tree).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rev-parse.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 4a27643..ff23cb0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -136,7 +136,12 @@ appending `/{asterisk}`.
 	directory (typically a sequence of "../", or an empty string).
=20
 --git-dir::
-	Show `$GIT_DIR` if defined else show the path to the .git directory.
+	Show `$GIT_DIR` if defined. Otherwise show the path to
+	the .git directory, relative to the current directory.
++
+If `$GIT_DIR` is not defined and the current directory
+is not detected to lie in a git repository or work tree
+print a message to stderr and exit with nonzero status.
=20
 --is-inside-git-dir::
 	When the current working directory is below the repository
--=20
1.7.3.2.316.gda8b3
