From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 18/26] verify-pack: set up gitdir gently
Date: Tue, 16 Feb 2010 23:05:09 +0700
Message-ID: <1266336317-607-19-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ77-00072y-LT
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab0BPQRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:17:13 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:38433 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201Ab0BPQRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:17:11 -0500
Received: by mail-yw0-f197.google.com with SMTP id 35so4826857ywh.21
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wTLjcXCTP2ULT7h33x1mqSqnEDbIMuFweGTaVLEM9vE=;
        b=R8Yq8LlWH673pymXJgeEaPCLZhcJMFug8OeGVn/b/8k1DFnl2M72gjbTpv7jLyZAeP
         RpoTy2aro9V3ISk6DCEpHitqAjl6V31x/75HDhi5OI4jFLUQelcOaSZn0sQvyTQZuJMP
         sG+HSLlkuMHbseW4mr04XZrNS6OJPxEkNnicg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B9xkZB440QfOvvQC/6Szo5vK3L0uZanXQeARZG3ZA9DDzoITEFp0AmYTl52BDmGcGQ
         yfAUvjnlzrU0OoUyWbwCufl6tx1SveOPczJ194dUcXl7JvlNxeXYAiCxnLz1veBF9q/m
         lmc1ffPZn9BKSkSYfZBXj88gVARvDOttltGjU=
Received: by 10.150.2.5 with SMTP id 5mr12425985ybb.197.1266336595877;
        Tue, 16 Feb 2010 08:09:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 9sm2920401ywf.20.2010.02.16.08.09.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:13 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140126>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 8892d5a..ee596bb 100644
--- a/git.c
+++ b/git.c
@@ -408,7 +408,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
-		{ "verify-pack", cmd_verify_pack },
+		{ "verify-pack", cmd_verify_pack, RUN_SETUP_GENTLY },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	};
--=20
1.7.0.195.g637a2
