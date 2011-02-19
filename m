From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 34/72] gettextize: git-fetch split up "(non-fast-forward)" message
Date: Sat, 19 Feb 2011 19:24:17 +0000
Message-ID: <1298143495-3681-35-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTm-0003Eb-JV
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab1BST2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:00 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab1BST1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:54 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=gN+jOkT1SX2olHF9/3I2Dv/U8vVno2bIVa2vQE9/BQk=;
        b=SRz0sKTyMN+CZ6KNjLg1K03xGKHPcsCY2+v3Agb1ZLY+BoArk7FW85LE9CJkv0GCiB
         npSeC15lB1Kt1ygf2JSU6zCKFaQf1TWuwXrscfPz9offNChXxVL87R7NOTptzqvZaGyH
         kFligK9mr5EFEdQZhLJvCQtdLXjzZeaNCJkAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oEqH7CLi4+GqfRD/T195CWkcBPP7c4+b3oTSbXlqbzO/oB8/jfHyYGeDvm0IEnTb18
         jYORDpc4R0j3eNi7A3P3Foi8TsNDss6Q55pX7VTnFFm1dB7vxBequvFs/Qmq+p6bo7wy
         D5kxz5Bm4+mOCzXnro5CUpysdKKlm7OukyEuc=
Received: by 10.14.45.79 with SMTP id o55mr2430210eeb.24.1298143673938;
        Sat, 19 Feb 2011 11:27:53 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.53
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:53 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167333>

Split up the "(non-fast-forward)" message from printf directives and
make it translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4f622fd..ee2c5f5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -317,9 +317,9 @@ static int update_local_ref(struct ref *ref,
 			r ? _("unable to update local ref") : _("forced update"));
 		return r;
 	} else {
-		sprintf(display, "! %-*s %-*s -> %s  (non-fast-forward)",
-			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
-			pretty_ref);
+		sprintf(display, "! %-*s %-*s -> %s  %s",
+			TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
+			pretty_ref, _("(non-fast-forward)"));
 		return 1;
 	}
 }
--=20
1.7.2.3
