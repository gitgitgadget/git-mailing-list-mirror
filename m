From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 65/72] gettextize: git-gc "Auto packing the repository" message
Date: Sat, 19 Feb 2011 19:24:48 +0000
Message-ID: <1298143495-3681-66-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTt-0003Eb-Ua
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab1BST2a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:30 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50839 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182Ab1BST2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:22 -0500
Received: by ewy5 with SMTP id 5so1970575ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=QIsGw1CzySzJDR/foMFugVQPo1lQUKGZ/8zNC8k07i8=;
        b=LoRKs+nXuYxQwvoSoMrRMv3TZfCXLXYt/Y+qsU6F6hjD+ub2jPbxcPqgEQcr0EzGml
         QiSm7YQwzr42jSIuu7unWkEfsooeIqLVKpZWwqKXK+NBFeYQlCT5bVEFZuuuUnJ8B7dd
         w39jHeMv/tkm9pDYH2Qn6ksR0rGUYXhR0A0xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=I8pOlWRE99Zlxqdlfq7qseTaynz7oIUD7IM6nStWQE4mxtObF+R7SkAX7EzApWQAOF
         SDKep402HqvlL0vLTM5sW46+dIgFfNJ3Ymr4KcqkkkqWPKHVe5vm6IHYScQjRqgNReT1
         3wVoc42Xn4WA3m5LM1CeAmHhxXy3lRxqe/WR4=
Received: by 10.213.4.134 with SMTP id 6mr2552483ebr.14.1298143701576;
        Sat, 19 Feb 2011 11:28:21 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.20
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:21 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167347>

Split up the "Auto packing the repository" message into quiet and
verbose variants to make translation easier.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/gc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a2be62a..ff5f73b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -219,13 +219,13 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		fprintf(stderr,
-			"Auto packing the repository for optimum performance.%s\n",
-			quiet
-			? ""
-			: (" You may also\n"
-			   "run \"git gc\" manually. See "
-			   "\"git help gc\" for more information."));
+		if (quiet)
+			fprintf(stderr, _("Auto packing the repository for optimum performa=
nce.\n"));
+		else
+			fprintf(stderr,
+					_("Auto packing the repository for optimum performance. You may a=
lso\n"
+					"run \"git gc\" manually. See "
+					"\"git help gc\" for more information."));
 	} else
 		append_option(argv_repack,
 			      prune_expire && !strcmp(prune_expire, "now")
--=20
1.7.2.3
