Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E3443A81
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385489; cv=none; b=rPAYhKhZjPWVSUc120tJBvIhS8eeNFEr0WFsoQUhT3j0kGfJKwKsheHzc4LSVNapQrrJfrXsphskjlJY8pPzgYq9e81qm+qaFYIfIldTWlckzP7r6gfLnB+m9zLT27wvAu07Q4FrKqMILgsALwBTftMTyvqhB9VgZKxKw8DwyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385489; c=relaxed/simple;
	bh=sttCLbjb/wEiNVZQFNac2ymoerqTwp7Zmm/SrpKXyew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KJQXlJtQkTf9QgNSuBucB0NVDBAKke6/f5epixGtmo2Eb0scDkNuMgbK5Ax+CT2n9cfMP+PANrS1JRSq6p7IU9Nzoq52R68dK9S5g/uW5UOSHW6guK5Q5HQIHAxn51rKLLxRD2wyTJEH1oVuJzXzlkyOjjn8VUagbl8dB3bb04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pU83r6+N; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU83r6+N"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so18679035ad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385487; x=1789990287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e/ZQ+39pj/JR1447+kEqiotTW6ixt7z5+q+Eg/HI/IQ=;
        b=pU83r6+Ne5MjLelhuF0eXVRl05CT7kuZGRAhvW/tP4l5KIMOkgXcAoyVVLpYpjgO1z
         KoQbVkUDokvkT1F5zbP07q0K5vwBV6ff7Z+jcooOsTxLQmx81OqIHuYclf8fE9sel1sm
         P4zx2V6ceiGUEvK6K9NpCNx0WEU5+I7cpIv7Nh0PLDKwyCTSt147Zq++lRuVVOFPDKFS
         iCsFD35BFTvEVBY7nqRjr5dOjTLrXV6xptyFvbTGSKpkkA6/ROGyzIF/L07MoLi8K00r
         8ak3x48iTzvsGdLNdZBNff1bbyNFBDGnTZheBntfJucO3YoJDCV/Hwm/2WFOc73ExDQb
         K7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385487; x=1789990287;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/ZQ+39pj/JR1447+kEqiotTW6ixt7z5+q+Eg/HI/IQ=;
        b=Wlw/UoD8Fgo/yQecl0or61geqf5Jw8EkoQexUO5ZZ7RVQK9WlOI5Y6IyKL7ljYk1sC
         DCFvVeY1j0D1+95FNP/w0OSF8LXR6FHyHtk2ZBZqvKNFIcB9mQ2+BvvzLPkTyhHHDPBC
         fSna37tZ/ED4faRpv8V5mqT49Z3azeDZsOPB6xDQpulAX8bQ7l11Q/muBl9NVgrM0mFM
         OxjfprwZgqHjzWktPNJoF9UfiWx7VHUIYgNqyhM2ALXYBzh7ivMrjf9JLlhI0hsldtze
         G3DuRiyvZhytcfxEO4OMjVjpzbix2lfB9zgYsjSvVZiplyofJlN93KPIcL8gH0TbBy6k
         9m0A==
X-Gm-Message-State: AFuF++mmXpgGRbtDcZlci1vPue0x/QXU3Y1ytGcwJiA+re3d2uaCluPx
	mECobK8j6F45e7JACk/deDQ5GNp7ayC/sU8XHQGN472Ofs4YTI5JqE0+W14sRQ==
X-Gm-Gg: AYBFou2+hMfwu7JMMHMKD5iXxwXtwSWUcXi1/lB/sDiiszbX5FKQF5HI2bYxvdjxqLx
	epGPfSGse97KRePKcHIikeW3LuTuOYWTFLME4JHDaqfAMl3zMEDio9sNdXGMKcrcQ+s0Qg2p1YY
	M62k0q2XftBr7FnYx9CyuRCu+yO+6Jnxd6tpoAG571Y10xCIr4Z8Dh+IQTJXFaxwcBK0I49MwST
	eiAPlcrPRfZNE5+SR47qhLRafOxl4CPxnXQDgQ2R5pGMiKBdFOpuVliG2RKwl07C6xLRaVmdhL5
	0ac+EgGhd9E7X81hhh4swMlTIRbSjrfQoRnXjloDrSqP0ZyJJEu7ITx4YbyOubg8g7dOgmqcVIC
	D818/GoekmkQqFzYq/ngfEDtVV0pU2w4JkogwL2K6ulHvHqebsk9LKygcwntefwzfBZMm6/xB+S
	DMUsvI4UpSSK3OBVE+4jv1UHTmy2cic2aRuVYvN7HlYNxQWQvLWXOuvSryifpKfNqtog0ayuEFB
	CNn
X-Received: by 2002:a17:90b:39cc:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39debf547abmr5074038a91.5.1789385487078;
        Mon, 14 Sep 2026 04:31:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d58adb5sm6399000a91.3.2026.09.14.04.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:31:26 -0700 (PDT)
Message-Id: <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 11:31:18 +0000
Subject: [PATCH 1/6] odb: don't remove a ".keep" we never installed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

receive-pack runs index-pack with "--keep" over the quarantine, which
writes a "pack-XXX.keep" there. The path we register as a tempfile is
a different one: where that ".keep" will land once the quarantine is
migrated into the main object database.

Nothing of ours is at that path yet, and something else may be. Two
pushes of identical content produce identical thin packs, index-pack
names a pack after its contents, and so both want the same ".keep" in
the main object database. If the other push still holds it, that file
is what keeps its pack from being repacked away, and we remove it at
exit regardless -- even when pre-receive rejected our push and nothing
was migrated at all.

Register the path right before the migration instead, and once the
migration has returned, read the files back. index-pack wrote the
message we handed it; a file that says something else was not written
for us, so let go of it without removing it. tempfile gains
unregister_tempfile() for that.

Registering only after the migration would leave a window: the ".keep"
is the first thing migrated, and for a push that duplicates a large
pack the migration then spends a while comparing the two packfiles. A
signal in between would leave our ".keep" behind, with our message in
it, and every later push of the same content would fail to migrate
over it. Registering first keeps that window closed, as it is today.

Reading the files back also covers a migration that fails partway
through with our ".keep" already in place: we go by what is there, not
by whether the migration succeeded, and still remove it.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 object-file.c              | 95 +++++++++++++++++++++++++++++---------
 t/t5547-push-quarantine.sh | 52 +++++++++++++++++++++
 tempfile.c                 | 12 +++++
 tempfile.h                 |  9 ++++
 4 files changed, 147 insertions(+), 21 deletions(-)

diff --git a/object-file.c b/object-file.c
index a4cbf8b081..21513ee535 100644
--- a/object-file.c
+++ b/object-file.c
@@ -29,6 +29,7 @@
 #include "read-cache-ll.h"
 #include "run-command.h"
 #include "setup.h"
+#include "string-list.h"
 #include "strvec.h"
 #include "tempfile.h"
 #include "tmp-objdir.h"
@@ -492,9 +493,13 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 	const char *prefix;
 
-	struct tempfile **pack_lockfiles;
-	size_t pack_lockfiles_nr;
-	size_t pack_lockfiles_alloc;
+	/*
+	 * The message index-pack writes into its ".keep" files, and where
+	 * those files end up once the quarantine is migrated. Each "util"
+	 * holds a tempfile for as long as we consider that file ours.
+	 */
+	char *keep_msg;
+	struct string_list pack_lockfiles;
 };
 
 int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -1256,6 +1261,45 @@ out:
 	return ret;
 }
 
+/*
+ * Track the ".keep" files before the migration moves them into place, so
+ * that a signal in the middle of it removes ours.
+ */
+static void register_pack_lockfiles(struct odb_transaction_files *transaction)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &transaction->pack_lockfiles)
+		item->util = register_tempfile(item->string);
+}
+
+/*
+ * The migration stops at the first file that differs from what is already
+ * at its destination, and a ".keep" left by somebody else's push is one
+ * such file. Rather than work out what got installed, read the files
+ * back: one that does not carry our message is not ours to remove.
+ */
+static void disown_foreign_pack_lockfiles(struct odb_transaction_files *transaction)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &transaction->pack_lockfiles) {
+		struct tempfile *lockfile = item->util;
+
+		strbuf_reset(&buf);
+		if (strbuf_read_file(&buf, item->string, 0) >= 0) {
+			strbuf_trim_trailing_newline(&buf);
+			if (!strcmp(buf.buf, transaction->keep_msg))
+				continue;
+		}
+		unregister_tempfile(&lockfile);
+		item->util = NULL;
+	}
+
+	strbuf_release(&buf);
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1264,6 +1308,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	if (transaction->objdir) {
 		struct strbuf temp_path = STRBUF_INIT;
 		struct tempfile *temp;
+		int ret;
 
 		/*
 		 * Issue a full hardware flush against a temporary file to ensure
@@ -1285,7 +1330,10 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		 * Make the object files visible in the primary ODB after their data is
 		 * fully durable.
 		 */
-		if (tmp_objdir_migrate(transaction->objdir))
+		register_pack_lockfiles(transaction);
+		ret = tmp_objdir_migrate(transaction->objdir);
+		disown_foreign_pack_lockfiles(transaction);
+		if (ret)
 			return error(_("unable to migrate temporary objects"));
 
 		transaction->objdir = NULL;
@@ -1393,10 +1441,10 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 
 		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
-		strvec_pushf(&child.args,
-			     "--keep=receive-pack %"PRIuMAX" on %s",
-			     (uintmax_t)getpid(),
-			     hostname);
+		free(transaction->keep_msg);
+		transaction->keep_msg = xstrfmt("receive-pack %"PRIuMAX" on %s",
+						(uintmax_t)getpid(), hostname);
+		strvec_pushf(&child.args, "--keep=%s", transaction->keep_msg);
 
 		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
@@ -1423,18 +1471,13 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		/*
 		 * The lockfile filepath is expected to be the final location of
 		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
+		 * We start tracking it right before that migration; see
+		 * odb_transaction_files_commit().
 		 */
 		lockfile = index_pack_lockfile(base->source, child.out, NULL);
-		if (lockfile) {
-			ALLOC_GROW(transaction->pack_lockfiles,
-				   transaction->pack_lockfiles_nr + 1,
-				   transaction->pack_lockfiles_alloc);
-			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
-				register_tempfile(lockfile);
-			free(lockfile);
-		}
+		if (lockfile)
+			string_list_append_nodup(&transaction->pack_lockfiles,
+						 lockfile);
 		close(child.out);
 
 		status = finish_command(&child);
@@ -1454,12 +1497,21 @@ static int odb_transaction_files_finalize(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
+	struct string_list_item *item;
 	int ret = 0;
 
-	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
-		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
+	/*
+	 * Only the ".keep" files that turned out to be ours still have a
+	 * tempfile attached; delete_tempfile() does nothing for the rest.
+	 */
+	for_each_string_list_item(item, &transaction->pack_lockfiles) {
+		struct tempfile *lockfile = item->util;
+
+		ret |= delete_tempfile(&lockfile);
+	}
 
-	free(transaction->pack_lockfiles);
+	string_list_clear(&transaction->pack_lockfiles, 0);
+	FREE_AND_NULL(transaction->keep_msg);
 
 	return ret;
 }
@@ -1492,6 +1544,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.write_pack = odb_transaction_files_write_pack;
 	transaction->base.env = odb_transaction_files_env;
 	transaction->flags = flags;
+	string_list_init_dup(&transaction->pack_lockfiles);
 
 	transaction->prefix = "bulk-fsync";
 	if (flags & ODB_TRANSACTION_RECEIVE) {
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 1b7097179e..8623d2d6c1 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -101,4 +101,56 @@ test_expect_success '.keep file is removed after push' '
 	test_path_is_missing "$keep"
 '
 
+test_expect_success 'a rejected push does not remove a foreign ".keep"' '
+	test_when_finished rm -rf foreign.git &&
+	git init --bare foreign.git &&
+	git -C foreign.git config set receive.unpackLimit 0 &&
+
+	# Get a packfile into the main object database without updating any
+	# ref, so that pushing the same objects again reuses its name.
+	test_hook -C foreign.git update <<-\EOF &&
+	exit 1
+	EOF
+	test_commit foreign &&
+	test_must_fail git push foreign.git HEAD:refs/heads/one &&
+
+	pack="$(ls foreign.git/objects/pack/pack-*.pack)" &&
+	keep="${pack%.pack}.keep" &&
+
+	# Pretend somebody else holds the lock on that packfile, and let the
+	# next push be rejected before its objects are ever migrated.
+	>"$keep" &&
+	test_hook -C foreign.git pre-receive <<-\EOF &&
+	exit 1
+	EOF
+	test_must_fail git push foreign.git HEAD:refs/heads/two &&
+	test_path_is_file "$keep"
+'
+
+test_expect_success 'a ".keep" installed by a failed migration is removed' '
+	test_when_finished rm -rf partial.git &&
+	git init --bare partial.git &&
+	git -C partial.git config set receive.unpackLimit 0 &&
+	git -C partial.git config set pack.indexVersion 1 &&
+
+	# Leave the objects in the main object database without a ref, so
+	# that pushing them again produces a pack with the same name.
+	test_hook -C partial.git update <<-\EOF &&
+	exit 1
+	EOF
+	test_commit partial &&
+	test_must_fail git push partial.git HEAD:refs/heads/one &&
+
+	# The same pack now arrives with a differently formatted index. The
+	# ".keep" is migrated first and goes in fine; the index then collides
+	# with the one already there, and the migration fails with our
+	# ".keep" already installed.
+	git -C partial.git config set pack.indexVersion 2 &&
+	test_must_fail git push partial.git HEAD:refs/heads/two 2>err &&
+	test_grep "unable to migrate" err &&
+
+	pack="$(ls partial.git/objects/pack/pack-*.pack)" &&
+	test_path_is_missing "${pack%.pack}.keep"
+'
+
 test_done
diff --git a/tempfile.c b/tempfile.c
index dc9ca4e645..10db4fbc7f 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -373,6 +373,18 @@ int delete_tempfile(struct tempfile **tempfile_p)
 	return err ? -1 : 0;
 }
 
+void unregister_tempfile(struct tempfile **tempfile_p)
+{
+	struct tempfile *tempfile = *tempfile_p;
+
+	if (!is_tempfile_active(tempfile))
+		return;
+
+	close_tempfile_gently(tempfile);
+	deactivate_tempfile(tempfile);
+	*tempfile_p = NULL;
+}
+
 void reassign_tempfile_ownership(pid_t from, pid_t to)
 {
 	volatile struct volatile_list_head *pos;
diff --git a/tempfile.h b/tempfile.h
index f571f3c609..b439066a30 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -275,6 +275,15 @@ int reopen_tempfile(struct tempfile *tempfile);
  */
 int delete_tempfile(struct tempfile **tempfile_p);
 
+/*
+ * Stop tracking `tempfile` without removing the file: close the file
+ * descriptor and/or file pointer if they are still open, and leave the
+ * file where it is, no longer to be removed at exit or on a signal. It
+ * is a NOOP to call `unregister_tempfile()` for a `tempfile` object
+ * that is not currently active.
+ */
+void unregister_tempfile(struct tempfile **tempfile_p);
+
 /*
  * Close the file descriptor and/or file pointer if they are still
  * open, and atomically rename the temporary file to `path`. `path`
-- 
gitgitgadget

