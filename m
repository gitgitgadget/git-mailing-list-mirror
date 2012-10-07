From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] gitignore.txt: suggestions how to get literal # or ! at the beginning
Date: Sun,  7 Oct 2012 10:13:54 +0700
Message-ID: <1349579634-13521-1-git-send-email-pclouds@gmail.com>
References: <7vr4pbqwz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 05:21:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKhQS-0002Tx-VH
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 05:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab2JGDU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 23:20:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37971 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2JGDU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 23:20:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2991409pad.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yLJuY/GXL7o320OWEovMZZxtH2MkrOsdvXxyH/L/K8Q=;
        b=T1OWpib/AykV/n46wm/LMzOFpie62E465IrT94y+ixR2hDBg/E9ZkR8EY8xWfAq6x/
         U6pAyyJuia6AaN+KQZtHSUOdH71qT2dK1wkZ7M9NWjEe6LSAsnhaUwVLc5dC4DQCZHjw
         WEdbMx7aytIUYN9+7Hr7PY/G4hDt6R2FjOV3fIF5EYKB/lk0y7Sy6xgRiEqWLuuESKBn
         fYklMlq2eZ/NkDx7CuC+KAc8D3PNT2HzsZWqZ1qMoUcCweZmogMfo/Clm3kD7w+j06Tl
         MVVFIrYVv5/tX3QzN8K7bSe0wT+p8PK0JOgfp16fMyX0TSewymV+3UvBISXwFNfYcbHu
         pFqg==
Received: by 10.68.195.195 with SMTP id ig3mr43259666pbc.108.1349580057679;
        Sat, 06 Oct 2012 20:20:57 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id gg6sm2210307pbc.38.2012.10.06.20.20.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Oct 2012 20:20:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 07 Oct 2012 10:13:56 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <7vr4pbqwz7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207175>

We support backslash escape, but we hide the details behind the phrase
"a shell glob suitable for consumption by fnmatch(3)". So it may not
be obvious how one can get literal # or ! at the beginning of pattern.
Add a few lines on how to work around the magic characters.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Back to spelling out, which works with 8.2.6. No examples for \#
 because '\' in '\#example#.txt' is eaten.

 Documentation/gitignore.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 96639e0..90106c4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -74,11 +74,15 @@ PATTERN FORMAT
    for readability.
=20
  - A line starting with # serves as a comment.
+   Put a backslash ("`\`") in front of the first hash for patterns
+   that begin with a hash.
=20
- - An optional prefix '!' which negates the pattern; any
+ - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
+   Put a backslash ("`\`") in front of the first "`!`" for patterns
+   that begin with a literal "`!`", for example, "`\!important!.txt`".
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
--=20
1.7.12.1.406.g6ab07c4
