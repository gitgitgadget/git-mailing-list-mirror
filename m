From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 22/48] i18n: git-submodule "cached cannot be used" message
Date: Sat, 21 May 2011 18:44:03 +0000
Message-ID: <1306003469-22939-23-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCo-0001Bj-5D
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab1EUSrC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:02 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab1EUSpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:22 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444635eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ZunIiVcEyigb5a3lLU15xknZXcwfjd6wJOxIlWLM7zE=;
        b=F/hmnLCtdD3L59djb3SYXXtN9kVnIJ8XN0S5z4OpEFuJ/udfddmnaYwlXYcQLGT9Ep
         eOxiBMDK2MKBMAJ7Rw2Io5539H0Rm1YJsgTScabRaezLeskBhi5NJ+gbTnzT8vJoKWd1
         bYplWPyY/Wy8u1KxEW6UBHRl4Ml5AbgLE4T7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vsqYGJh/5ptlzf7GzVpVasgdfogq4x1/6QdAHheKJMweNZWzRK/nukbdBhSm3pZLI7
         kV8aeHzC9HTWTpNQVNYUntL/f+1EdetaFz9iCfAiNTnsd/J6dsDjMjUXsoqBa3HC6EOh
         4pwSxufJHE5UTbs8X5iwGU8x9Xxqke+6+eBJA=
Received: by 10.213.26.152 with SMTP id e24mr607175ebc.125.1306003522155;
        Sat, 21 May 2011 11:45:22 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.21
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174157>

Gettextize the "--cached cannot be used with --files" message. Since
this message starts with "--" we have to pass "--" as the first
argument. This works with both GNU gettext 0.18.1 (as expected), and
the gettext(1) on Solaris 10.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7eb1de0..444e1c5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -617,7 +617,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "--cached cannot be used with --files"
+		die "$(gettext -- "--cached cannot be used with --files")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
--=20
1.7.5.1
