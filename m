From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/15] gettextize: git-revert messages using the "me" variable
Date: Mon,  6 Sep 2010 12:21:42 +0000
Message-ID: <1283775704-29440-14-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaix-0000aR-N9
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0IFMWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab0IFMWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:43 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so6463612wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZMS1e9gIfn7t3yIwPHw+JDT55bn0F1gFGRoT2+ZO3Uo=;
        b=XFL68eM2IwhXtMaB4xFEtXQvfEXpEtqWOsJPecHkqeoNZjjEd5mq/6YcSIp68RmDrM
         JHvUYalE0p7/8MXHyLVaRqM1auHnLPBpMz3fCWHy2F0lNc9T3JTSeWH8eXJcSWU2yD8D
         CWiBBAipN7LxDMS7o61zgt9pbI/X5Oz8SVrPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N4nymKC9HP20/OLHX5oPu68gqw+6Pa7kmB1R8RAIjdjEgWGieTh7SPSzidM4vrhKEq
         C7ANSbnnl0swzVKFopGfd38g4iGRoB8kLdzs1o71ldH7R6nIHxtppZRoA1V+76PFBocR
         AAbRe7BECpB1v0i5xGEsfPX3zsm33iT4nSf7k=
Received: by 10.227.157.13 with SMTP id z13mr217926wbw.184.1283775762769;
        Mon, 06 Sep 2010 05:22:42 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155562>

Mark messages that used the "me" variable for translation. The
potential values of the variable had already been marked using N_(),
so we can use _(me) here.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c              |   14 +++++++-------
 t/t3501-revert-cherry-pick.sh |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2f319f8..8dff244 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -286,10 +286,10 @@ static NORETURN void die_dirty_index(const char *=
me)
 		die_resolve_conflict(me);
 	} else {
 		if (advice_commit_before_merge)
-			die("Your local changes would be overwritten by %s.\n"
-			    "Please, commit your changes or stash them to proceed.", me);
+			die(_("Your local changes would be overwritten by %s.\n"
+			    "Please, commit your changes or stash them to proceed."), _(me)=
);
 		else
-			die("Your local changes would be overwritten by %s.\n", me);
+			die(_("Your local changes would be overwritten by %s.\n"), _(me));
 	}
 }
=20
@@ -339,7 +339,7 @@ static int do_recursive_merge(struct commit *base, =
struct commit *next,
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
-		die("%s: Unable to write new index file", me);
+		die(_("%s: Unable to write new index file"), _(me));
 	rollback_lock_file(&index_lock);
=20
 	if (!clean) {
@@ -446,8 +446,8 @@ static int do_pick_commit(void)
 		return fast_forward_to(commit->object.sha1, head);
=20
 	if (parent && parse_commit(parent) < 0)
-		die("%s: cannot parse parent commit %s",
-		    me, sha1_to_hex(parent->object.sha1));
+		die(_("%s: cannot parse parent commit %s"),
+		    _(me), sha1_to_hex(parent->object.sha1));
=20
 	if (get_message(commit->buffer, &msg) !=3D 0)
 		die(_("Cannot get commit message for %s"),
@@ -570,7 +570,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	}
=20
 	if (read_cache() < 0)
-		die("git %s: failed to read the index", me);
+		die(_("git %s: failed to read the index"), _(me));
=20
 	prepare_revs(&revs);
=20
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index bc7aedd..b12b1b4 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -81,7 +81,7 @@ test_expect_success 'revert after renaming branch' '
=20
 '
=20
-test_expect_success 'revert forbidden on dirty working tree' '
+test_expect_success NO_GETTEXT_POISON 'revert forbidden on dirty worki=
ng tree' '
=20
 	echo content >extra_file &&
 	git add extra_file &&
--=20
1.7.2.3.313.gcd15
