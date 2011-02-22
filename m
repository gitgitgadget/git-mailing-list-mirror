From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 21/73] gettextize: git-checkout: our/their version message
Date: Tue, 22 Feb 2011 23:41:40 +0000
Message-ID: <1298418152-27789-22-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wq-0001H8-5l
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab1BVXny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:54 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab1BVXnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:52 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aTb3WLNT0wzrILy7VDdeq+FRSJr0dm3zZKHucif0uwk=;
        b=SygkhFwNzRX5mknXQIlN7Usi4GO71jkjFyf4X8+jYrIyf4eiw5+p683AnbNAu7eshR
         RQqXFPDXGylbjCqkxyeuL+QcnieoFuYKhs3X8DsJyqQwLY+UOpUHFPHuztKz+Y2E78NB
         YZxydO3FbcklEYfiJRL5wa8GmSZmlKU8pzYmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HtRPtUm2ASwQTfMw/rOcO/NhdCt7ci1kA0omPQJ0kLxHkxZwtwaB2uOB7yCUL/MpTK
         GqoVRIVUdMPqnZZtV2gyI7pNBvCe4PMNtL57BVjmVEpkb0CtIOnqNdSflZHBGLzt8Fe+
         vtyE8EOyeF/VnsTghJ1Fa/LXyLCkOIyIltr5Q=
Received: by 10.204.81.72 with SMTP id w8mr3105198bkk.205.1298418231928;
        Tue, 22 Feb 2011 15:43:51 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.51
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:51 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167643>

Split up the "does not have our/their version" message to make it
easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5060ab..7ba0788 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -103,9 +103,10 @@ static int check_stage(int stage, struct cache_ent=
ry *ce, int pos)
 			return 0;
 		pos++;
 	}
-	return error("path '%s' does not have %s version",
-		     ce->name,
-		     (stage =3D=3D 2) ? "our" : "their");
+	if (stage =3D=3D 2)
+		return error(_("path '%s' does not have our version"), ce->name);
+	else
+		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
 static int check_all_stages(struct cache_entry *ce, int pos)
@@ -130,9 +131,10 @@ static int checkout_stage(int stage, struct cache_=
entry *ce, int pos,
 			return checkout_entry(active_cache[pos], state, NULL);
 		pos++;
 	}
-	return error("path '%s' does not have %s version",
-		     ce->name,
-		     (stage =3D=3D 2) ? "our" : "their");
+	if (stage =3D=3D 2)
+		return error(_("path '%s' does not have our version"), ce->name);
+	else
+		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
 static int checkout_merged(int pos, struct checkout *state)
--=20
1.7.2.3
