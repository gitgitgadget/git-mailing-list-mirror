From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 015/144] t0204-gettext-reencode-sanity.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:20 -0700
Message-ID: <1395735989-3396-16-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhZ-00079D-4H
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbaCYI1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:12 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62673 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbaCYI04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:56 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so133319pbb.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0kLWEYTvM4MBNCc4xR62qX8rPsYzr9881UYKD7Q2xmM=;
        b=PdhVxWNCKUcSOmoquD3mjuJ8wDN1idqtro1pMbk0G7mDoadFIM+Hphy95RLguYKCCW
         tXJDG4rmh3WNnJ8N21ew3jLVMzbx4N/tU/+DRFwI08gmnCJp+k9SDvCQmXU9aVMsaqVp
         eFy8o7jcYuOU6/qF5mqoLPeQryr/nQOGmeTLLB4AzIrhTqKBDX99ySGpE7/7eRH3JiO6
         6IgVGzT96MgzCn9+saxUVTjP8/1aL2TPG1MAPzX9g9TDIF1QxbnQj08LlLRYrV4ssh8P
         APt9u0RZ9Ch/b/POU7pesYWFnosruBL/iZaI2PrPod4/cHyAnJu8Y52AkOLFnTHpbHpf
         gx7w==
X-Received: by 10.68.200.133 with SMTP id js5mr14398199pbc.138.1395736015727;
        Tue, 25 Mar 2014 01:26:55 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244915>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t0204-gettext-reencode-sanity.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 8437e51..fc9f21e 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -58,7 +58,7 @@ test_expect_success GETTEXT_LOCALE 'gettext: Fetching=
 a UTF-8 msgid -> UTF-8' '
 # How these quotes get transliterated depends on the gettext implement=
ation:
 #
 #   Debian:  ,einfaldar' og ,,tv=C3=B6faldar" [GNU libintl]
-#   FreeBSD: `einfaldar` og "tv=C3=B6faldar"  [GNU libintl]
+#   FreeBSD: $(einfaldar) og "tv=C3=B6faldar"  [GNU libintl]
 #   Solaris: ?einfaldar? og ?tv=C3=B6faldar?  [Solaris libintl]
 #
 # Just make sure the contents are transliterated, and don't use grep -=
q
--=20
1.7.10.4
