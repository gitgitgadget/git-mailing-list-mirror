From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 66/73] gettextize: git-gc "Auto packing the repository" message
Date: Tue, 22 Feb 2011 23:42:25 +0000
Message-ID: <1298418152-27789-67-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vK-0000K1-4O
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab1BVXpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:09 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab1BVXol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:41 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QIsGw1CzySzJDR/foMFugVQPo1lQUKGZ/8zNC8k07i8=;
        b=tOUrJr5wgogTGx37/91xQ6M2jHY8xa7wHe0mLcyU4QCoWapv6icYp4V0euT5BIV+vi
         9W2tAo6BBHbFRcr8MxFbcI6mijbY6EUxcqH/DqX+mqSnHd64VurdP/v+n0jTjQgQ/pWr
         xkhIk9Zhr/pSRlFbIreBJX9mASvU+89IIeah8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lPON4Zocvlt/v9yq4M8uUlsatlg68/XSG0B+SkDZRRUPE07oUNVRfzJJxWyiP/amKk
         6zg+hYLyNCwZSepsQ6U01CK2tzecwBX51ye3gmtaA9O6UAW9vnB4rSwa5s3490jZou7f
         ivks0sLaLCD+g6CYKJzHxg2XFntoZh6zNRxeo=
Received: by 10.204.123.5 with SMTP id n5mr3059878bkr.58.1298418280551;
        Tue, 22 Feb 2011 15:44:40 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.37
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:38 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167624>

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
