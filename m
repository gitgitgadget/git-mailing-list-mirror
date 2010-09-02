From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/25] gettextize: git-merge remaining cmd_merge messages
Date: Thu,  2 Sep 2010 19:40:34 +0000
Message-ID: <1283456446-22577-14-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgP-0006jt-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656Ab0IBTl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab0IBTlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:51 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5bJ2CY0UF51Ll31dn8+cDHzsYkPSqhOEb1D4AEzd1F8=;
        b=tTJJk7q4sJc8UZ6EnSzLaOSZ+xT8zYIOHXwef+JWx1kvPdckx9JKKPqN2r7gUBQ89P
         KWtDvwO9xizAuMXnVLXtLiasLE6rjE2QR/N0uVEvpA80RjJMhVHjXZJNwlpmweGvmOCk
         yqQYt9kePwlF2O8Gy/0SCJtdPoqcnZ7k3uK3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=c7NkGcovnzHoEpeb7umlXSuNECHJisWNwFecwDdCGr65XPoeYaFyWecA3CIXCzskMf
         8vaBTBymgL4NmotOIQ8eqtRn93c34UlxCIJ+CjJxAU9MH8AdYb4+XXB9CljEAOzZ94Gp
         bJ3RGeob7JJaS+ULbwSuJ3O90g2scS2SMdTMQ=
Received: by 10.227.154.196 with SMTP id p4mr16330wbw.195.1283456511192;
        Thu, 02 Sep 2010 12:41:51 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155181>

Translate "Already up-to-date.", "Fast-forward", "no commit created"
and other cmd_merge() messages.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9121c7b..ce831bf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1078,7 +1078,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
-		finish_up_to_date("Already up-to-date.");
+		finish_up_to_date(_("Already up-to-date."));
 		return 0;
 	} else if (allow_fast_forward && !remoteheads->next &&
 			!common->next &&
@@ -1095,10 +1095,10 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 				hex,
 				find_unique_abbrev(remoteheads->item->object.sha1,
 				DEFAULT_ABBREV));
-		strbuf_addstr(&msg, "Fast-forward");
+		strbuf_addstr(&msg, _("Fast-forward"));
 		if (have_message)
 			strbuf_addstr(&msg,
-				" (no commit created; -m option ignored)");
+				_(" (no commit created; -m option ignored)"));
 		o =3D peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
 			0, NULL, OBJ_COMMIT);
 		if (!o)
@@ -1156,7 +1156,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date("Already up-to-date. Yeeah!");
+			finish_up_to_date(_("Already up-to-date. Yeeah!"));
 			return 0;
 		}
 	}
--=20
1.7.2.2.614.g1dc9
