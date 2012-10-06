From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gitignore.txt: suggestions how to get literal # or ! at the beginning
Date: Sat,  6 Oct 2012 15:38:21 +0700
Message-ID: <1349512701-29729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 10:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKQ0z-0002nE-Sf
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 10:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab2JFIpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 04:45:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64675 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab2JFIp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 04:45:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2648551pbb.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=dHONDH25OARtMOxZtRcAVYuoME+x/PCd8nKnTuPaMnI=;
        b=ngAJVHsb+1DnLWvXOcGUpGa4D5Szz7+V3q8Gpnj0CUMuZyhksJCAeOI8uyXbgyhTcS
         uVW44pVfnLHHqkqehFXX1SP3GlprfdFcoHCMTBK2sJL8xiDn6GbhYwyHI98d8+EHcW4H
         Hb7UVD51P0dLYEh928WD1fASN9MjA6GbaQsQ8oQv3W941SgDHqTujw+G+PkpIWrREhjv
         fZcPjpWIgbY4dcpBxieEHibr7uj945ZHONf1qUJAd0hYuifLpnMxIkC7g8MZw0eaHKb/
         3reFrg8G84b5VY5pGUtlUNAIJ94P1iVsegnGbI8ak5CrawVhcAeGRYk308s+SxMigxXJ
         9A7Q==
Received: by 10.68.225.199 with SMTP id rm7mr37518698pbc.150.1349513127614;
        Sat, 06 Oct 2012 01:45:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id gg6sm1084379pbc.38.2012.10.06.01.45.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Oct 2012 01:45:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 06 Oct 2012 15:38:27 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207139>

We support backslash escape, but we hide the details behind the phrase
"a shell glob suitable for consumption by fnmatch(3)". So it may not
be obvious how one can get literal # or ! at the beginning of a pattern=
=2E
Add a few lines on how to work around the magic characters.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Asciidoc 8.2.6 does not like me writing
 "Put \# if you need a literal #.." so I go with "backslash" and
 "hash" instead. `\!` displays fine both in man page and html format.
 '!' changed to `!` because it looks clearer in monospace.

 Documentation/gitignore.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 96639e0..8c03ed4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -74,11 +74,14 @@ PATTERN FORMAT
    for readability.
=20
  - A line starting with # serves as a comment.
+   Put a backslash in front of the first hash for the patterns
+   that start with a hash.
=20
- - An optional prefix '!' which negates the pattern; any
+ - An optional prefix `!` which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   override lower precedence patterns sources. Use `\!` if
+   you need a literal `!` at the beginning of the pattern.
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
--=20
1.7.12.1.406.g6ab07c4
