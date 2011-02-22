From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 37/73] gettextize: git-grep "--open-files-in-pager" message
Date: Tue, 22 Feb 2011 23:41:56 +0000
Message-ID: <1298418152-27789-38-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1ws-0001H8-97
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab1BVXqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:23 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab1BVXoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:08 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FTSbYZXISGF+GiNa4oQjv/9C8t0CmEphLe0L+vw/5sI=;
        b=hfjWlqoqQpwUu9jVRz38w1YKnQghQPUstpyiLgsIecRumkeunNTpNHW1vEvDIAPOc1
         Wr+kY9/BIRqMDtr5ooQWwUSO5FlPxr4xxqyOBD6W8dqN8gNP+fz77iTNxVrPY+a1P6Ab
         VYatM9UbIruYCVa/JU8W71a36rY+5UuW7uReg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HsNrl6s8VNRui8eO4F4MmUJr58qwnTr7tYDCGR1ryXDwSy0qIbjkPEwkCXfXJiQGnB
         poOcPAGl1+dWg3DlX6I/BYGPewVVgNAEEFVd5rw2Cf+j7+7JWIxF4Fk3/fsUBJZ3MmW0
         BbNrmLTiap3c9W7ox3WpI5fdhUbtq5/f0qJog=
Received: by 10.204.135.217 with SMTP id o25mr3120565bkt.15.1298418247942;
        Tue, 22 Feb 2011 15:44:07 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.07
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:07 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167647>

Gettextize the "--open-files-in-pager only works on the worktree"
message. A test in t7811-grep-open.sh explicitly checked for this
message. Change it to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/grep.c       |    2 +-
 t/t7811-grep-open.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d35b76c..dfc32fb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1061,7 +1061,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (show_in_pager && (cached || list.nr))
-		die("--open-files-in-pager only works on the worktree");
+		die(_("--open-files-in-pager only works on the worktree"));
=20
 	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
 		const char *pager =3D path_list.items[0].string;
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 568a6f2..aedf484 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -61,7 +61,7 @@ test_expect_success SIMPLEPAGER 'git grep -O' '
 	test_cmp empty out
 '
=20
-test_expect_success 'git grep -O --cached' '
+test_expect_success C_LOCALE_OUTPUT 'git grep -O --cached' '
 	test_must_fail git grep --cached -O GREP_PATTERN >out 2>msg &&
 	grep open-files-in-pager msg
 '
--=20
1.7.2.3
