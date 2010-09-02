From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/25] gettextize: git-merge "Merge made by %s." message
Date: Thu,  2 Sep 2010 19:40:33 +0000
Message-ID: <1283456446-22577-13-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFfb-00061i-4P
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab0IBTlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab0IBTlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:50 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zzRGAVnhwDnHesAb/E2RqVHpqfu/3/qOn3r327pGkqQ=;
        b=ZPuTkG+AKXw1uiWY/Kv9vVRFLg6+ZLxoeXFxI+0shVp+IKe0ecmlH345oieh5Np4MI
         ZpNLgyQPtu8/WMkIs8mFPMIpZ35AitDbc/GrU6s+nIdAw1GTMSrvT2u2ATE4es1Xx/UE
         KT0zUxbsICzrCdum/wUFkKEve92OMLbHtYlKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GGc4H3onSubUZVqnG7sPPrvB01SChwLhhKgFQkNRg69PYFAyTHTP/AJF1oGDKt2hJ9
         s+GwOZRI/WxtkfSFcQcfqyweIDPpnR6Svw46G01/WeQ13BRNr8OU10FhbSOvnJpkCYnr
         CeYiX7dManhlNMvWDT9PsHbjKoRn5x56B3ZgM=
Received: by 10.227.142.84 with SMTP id p20mr222911wbu.182.1283456509409;
        Thu, 02 Sep 2010 12:41:49 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155174>

Like the "In-index merge" message "Merge made by %s." emits to stdout
via finish(), so translating it should be fine.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 956ce14..9121c7b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -820,7 +820,7 @@ static int finish_automerge(struct commit_list *com=
mon,
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
-	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
+	strbuf_addf(&buf, _("Merge made by %s."), wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
 	drop_save();
--=20
1.7.2.2.614.g1dc9
