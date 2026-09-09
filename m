Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899238F249
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932953; cv=none; b=VIYMa6PM6xKl66kK56/prKr3KHJ3FiOLEq2XNHYrGZXnwPSt/nWdrdN5QTXrI5dCX99LsA4ynXo4HexNFX+P78hMoDLFks3Bl/JBAVByrQXsygajkJ1KW7d7hOGrQ/zZz/XJzPJzHgzzCatoDXlgNZ63YO6bgq+Nx9tCytQkMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932953; c=relaxed/simple;
	bh=PknHVwuthzv2k8s3GG3AWbh4iOfC6DOxpqwyshiX4OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1u33zd3TpiTlo9gu0aTPr71SQNIzrsgTAQKpwFo6hz8NlBoK+bKrH90vYWqubVT15BiUteTQvCZT3COly/mPh78Gg5wmtsOF+FwepX7vLj1Kers+FyrX9deMBEdG9laQskp3mfkSSvtJjae11jKfnB59xy99v+o00EgNpZqF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CTyh7QJb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYj3vEGT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CTyh7QJb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYj3vEGT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C8311D00103;
	Wed,  9 Sep 2026 01:49:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 01:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932951;
	 x=1789019351; bh=T5C2h67conYoqixBwbyEOwGOM8fhFwbEJi5SuDdZOx0=; b=
	CTyh7QJbYJdFkj/jTfRclGCk+Bpmyxfkzp72Ibmz8+9OreH+dGs29+o8kTgwRzIq
	4ReYkFlKlVY9I5VT5Y8wthq6s7azE+4OcOB5y7Wy1Iu5MkIt1FMI0jpS2aIGjOVE
	tV1h2DrJoNC50dDQsrXjj7/ULHfB3QMT8YHbXkzpb/rkRerHV1gPA9xjJZdf0czQ
	E2kiZoNx7pqNfqwmIBXGrfdOjjb8XEl7EJ6Ivsuqna4cpdvC8CECXqoN33T1v3le
	6l3Dd4KTitOMLkPQwsfSU6LrFo7edEj4nhaGPJk8uaRB55GqYb0UW/U62431tvBM
	ALffGHiDnlIoETdhxmeXPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932951; x=
	1789019351; bh=T5C2h67conYoqixBwbyEOwGOM8fhFwbEJi5SuDdZOx0=; b=e
	Yj3vEGTlzc1en5kuOsZHnUedsefRipHt2/55PRiTzaAhwwJ7dysVnWiScoM5DTAx
	YfjpE0d8jAwE5Y2jGnHQzUsGftzMuG16mdMIEB9bxsm2unFVP0VGsu89Eepy99l7
	pXj9F/hmEdHZYvfjVtjDnak9CxCugzYfE090koKnH1ZIiSYQEKXTmdylxqBg4ysv
	7BMo7hkz3k1rRXH70WKuC4In6Fec+FCwYciXbCFs7Moqsz+cf7IxT345CJ/Ye/gM
	XXavgpOs29ZRe6zeFkfqfDpgyLDBU1LzCB5RD48f9TVjZgKqkjGDih7zqqJz0s4T
	Ouk0ICI5mo0Cdwi3rMXww==
X-ME-Sender: <xms:V_OgajX2dgJfIc8FHMIp3Vay7JWdRPzY9zW2HoNOcjl2NsTPOpHDdg>
    <xme:V_Ogaikz5T8NjwtKOdkjkI8-7w1PASnrJUHwjxsW55_s-nUJGSY4OdZodGVh23HCR
    7Gdv0XSJfBxejkZHGjaSYLZMQGaM9ZrLVARqeeTY0YuqjJhaw8NfXM>
X-ME-Received: <xmr:V_OgakasQ0aQ3Ojlkwm0eGYDL4GCW_FCR0_iC8r87ho_Y7Z1Go1fYXjZuT-OvQciH-_MVg>
X-ME-Proxy-Cause: dmFkZTFztZ3LmJ2CDKdQ3eOewzOTN4qTHVlOlcKj2crN7ZPW5XSk289zNEdXp8IN/wn8Kt
    gQozyHBaMY0iqrRcz2BSUYxVPjan2N36Mt6cCGoXsh6dgAjtATSHyXr7RqAfbN4XxwUOho
    4JvUL7anTGg1/U850GToH17pM59gicFtL69uwHp+SJBgc/kej5HczZvfcS++AFPKoCBHwT
    Ku+WfNIzi8kjkLjvGc6Zo3RaMFyKVkiavb0tMXBXJbDJM+Hcr6g/PH5YL9Yx45CfNRPDVo
    ag2wnSV53Jj7RP6okr/raNatAQ/+Y2eyP9ZDMzd6J9Qdlk/MdQJWn1jMzhQWvQsEN0jcXk
    PPwfj612cyGKIKEugqJnbdO19cKm4V7b6D/Y1MTjxpVycwmEznboBYo4ZuANvniNpfYJrt
    RGr40Q2D8Jl25XrMtpFwcLXex4aduT8DvmImD8CXwBVyY4fiY4NdzQJMK5xN4X2dbOERcS
    G3DrUf052Bo5GhC8XeTfTgRJ3kv/MFPuTmIAcdD18uxNuN4gBQH2JHxqarM/HOAwYIRYql
    TIkm+/GybTQxJG5o6V0mtyVQGeI0u0tCq2QWBqmACumsnOG6rbh/bssmPTTMO6sEBvYVbi
    7liy4FfgtfQeRxWB//75ieusReTzLQZVEGWiB46qcC3DZduCshrR4TzFrQvQ
X-ME-Proxy: <xmx:V_OgatNLPxW_r7cqey9RGf3TskyFo4gwbZEkIyBW8EX0U-4rKS6L8Q>
    <xmx:V_OgapYQ2HdxRtWbyjI3JZwkY2yl2uPr08v-fNsodyNriSER7wTQSQ>
    <xmx:V_Ogar0hxNKOOdKHymzyNFfDVFX9vZp7ddZ7zixd3y0XX-P9McmEaQ>
    <xmx:V_Ogavc--XvAu6kTfxLnL47u-e1Cc7JbMni5U4WKSEY1Gnwn4oh67Q>
    <xmx:V_Ogaqb79dAchnHOG1JyP77Hs_LNES6MfndyqMJj-zdM3_bB_QBiHA8D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54dfbd66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:48 +0200
Subject: [PATCH v4 6/9] builtin/clone: move setup of alternates for
 non-shared local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-6-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Similar as in the preceding commit, move the setup of alternates for
local clones with "--no-shared" into `collect_alternates()`. With this
step, the complete setup of alternates is now handled by that function.

Note that besides moving stuff around, it also fixes a bug: previously,
we did not know to resolve the referenced repository's common directory.
Consequently, when referencing a worktree we failed to resolve
alternates. But as `collect_alternates()` already knows to resolve the
commondir for "--local" we can simply reuse this resolved path for our
purpose.

Add two tests, the first one of which exercises this bug to avoid future
regressions. The second test ensures that we properly handle relative
alternates for a referenced worktree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 34 +++++++++++++++++++++++-----------
 t/t5604-clone-reference.sh | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 011fc867c8..84c1317867 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -181,7 +181,7 @@ static int add_one_alternate(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void copy_alternates(struct strbuf *src, const char *src_repo)
+static void read_alternates(struct strvec *alternates, const char *src_repo)
 {
 	/*
 	 * Read from the source objects/info/alternates file
@@ -195,29 +195,41 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	 * to turn entries with paths relative to the original
 	 * absolute, so that they can be used in the new repository.
 	 */
-	FILE *in = xfopen(src->buf, "r");
+	FILE *in;
+	struct strbuf path = STRBUF_INIT;
 	struct strbuf line = STRBUF_INIT;
 
+	strbuf_addf(&path, "%s/objects/info/alternates", src_repo);
+
+	in = fopen(path.buf, "r");
+	if (!in) {
+		if (errno == ENOENT)
+			goto out;
+		die_errno("could not read alternates file '%s'", path.buf);
+	}
+
 	while (strbuf_getline(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
-			odb_add_to_alternates_file(the_repository->objects,
-						   line.buf);
+			strvec_push(alternates, line.buf);
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
 		if (!normalize_path_copy(abs_path, abs_path))
-			odb_add_to_alternates_file(the_repository->objects,
-						   abs_path);
+			strvec_push(alternates, abs_path);
 		else
 			warning("skipping invalid relative alternate: %s/%s",
 				src_repo, line.buf);
 		free(abs_path);
 	}
+
+out:
+	strbuf_release(&path);
 	strbuf_release(&line);
-	fclose(in);
+	if (in)
+		fclose(in);
 }
 
 static void collect_alternates(struct strvec *alternates,
@@ -242,6 +254,8 @@ static void collect_alternates(struct strvec *alternates,
 		get_common_dir(&commondir, src_repo);
 		if (option_shared)
 			strvec_pushf(alternates, "%s/objects", commondir.buf);
+		else
+			read_alternates(alternates, commondir.buf);
 
 		strbuf_release(&commondir);
 	}
@@ -320,11 +334,9 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 
-		/* Files that cannot be copied bit-for-bit... */
-		if (!fspathcmp(iter->relative_path, "info/alternates")) {
-			copy_alternates(src, src_repo);
+		/* Alternates were already handled earlier. */
+		if (!fspathcmp(iter->relative_path, "info/alternates"))
 			continue;
-		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 39a0c318df..9e4b98fdb8 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -383,4 +383,29 @@ test_expect_success 'dissociate from repo with commit graph' '
 	git clone --no-local --reference graph.git --dissociate orig clone
 '
 
+test_expect_success 'local clone from linked worktree carries over alternates' '
+	rm -fr base derived derived-wt dst expect &&
+	git init base &&
+	test_commit -C base one &&
+	git clone --shared base derived &&
+	git -C derived worktree add ../derived-wt &&
+	git clone derived-wt dst &&
+	echo "$(pwd)/base/.git/objects" >expect &&
+	test_cmp expect dst/.git/objects/info/alternates &&
+	git -C dst fsck
+'
+
+test_expect_success 'local clone from linked worktree resolves relative alternates' '
+	rm -fr base derived derived-wt dst expect &&
+	git init base &&
+	test_commit -C base one &&
+	git clone --shared base derived &&
+	echo "../../../base/.git/objects" >derived/.git/objects/info/alternates &&
+	git -C derived worktree add ../derived-wt &&
+	git clone derived-wt dst &&
+	echo "$(pwd)/base/.git/objects" >expect &&
+	test_cmp expect dst/.git/objects/info/alternates &&
+	git -C dst fsck
+'
+
 test_done

-- 
2.55.0.1074.ge7621b4bad.dirty

