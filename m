From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 18/73] gettextize: git-branch "git branch -v" messages
Date: Tue, 22 Feb 2011 23:41:37 +0000
Message-ID: <1298418152-27789-19-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1ww-0001H8-Bx
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab1BVXrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:47:03 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab1BVXnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:49 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=A707ZqIVC7OqytMgriqsVt+qCgr4ZTi3aDPLwkmB6O0=;
        b=OX8q0orbNHEjk4ZBjRF3fnb/uX7IZaWTkQgBusGG+QvLEtojtolXLUELqAfAlLVYXk
         2tLmuApv1DsREZYK8sTBTilOqLCrwnGnvJlxFWZmqwYfQh5mRRKHlMD61hcQrSpc1ChV
         23m3+k3qsJVFf0NsoxqXz0aRxbzB4bAE7KdIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TI+BcdMbnINKNGAF46sF6oFHLW29dklQMK2kk15oMyfoYgkoQL/Eq1CkeQPYiblurM
         tgeHxFnwKvZCITRPON+1AgXhY+QKyUzAzldmynXeUEKhE2g/WTIqxK7wLqjdCd387tpv
         B9O+W3DplIld5VyeV/Ef5UAFtRl1JSF/yNXkQ=
Received: by 10.204.101.83 with SMTP id b19mr3055551bko.199.1298418228752;
        Tue, 22 Feb 2011 15:43:48 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.47
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:48 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167654>

Make the "git branch -v" messages translatable, e.g.:

    5054b57 [ahead 8] branch error fixup

This is possibly a plumbing message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c         |    6 +++---
 t/t6040-tracking-info.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d276681..4c1a256 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -373,11 +373,11 @@ static void fill_tracking_info(struct strbuf *sta=
t, const char *branch_name,
 		strbuf_addf(stat, "%s: ",
 			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
 	if (!ours)
-		strbuf_addf(stat, "behind %d] ", theirs);
+		strbuf_addf(stat, _("behind %d] "), theirs);
 	else if (!theirs)
-		strbuf_addf(stat, "ahead %d] ", ours);
+		strbuf_addf(stat, _("ahead %d] "), ours);
 	else
-		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
+		strbuf_addf(stat, _("ahead %d, behind %d] "), ours, theirs);
 }
=20
 static int matches_merge_filter(struct commit *commit)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1e0447f..6cad643 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -42,7 +42,7 @@ b3 behind 1
 b4 ahead 2
 EOF
=20
-test_expect_success 'branch -v' '
+test_expect_success C_LOCALE_OUTPUT 'branch -v' '
 	(
 		cd test &&
 		git branch -v
--=20
1.7.2.3
