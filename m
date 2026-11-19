Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067851;
	b=dMyxMRbs71nS6mzWNxYBboID11va6QBNSPIo97qvSrQB0xzjb4LSJYr2mnDTUK9/ktNY
	 7JSb0pxCmPHbM9mp1rIGHxIN3eexw82Pac079z8w4NBLpnkCvZQK3Q+s6lYPL1nykINrz
	 ePHMRhLh9wQEn0YbP9bg4tvtx2uYC8Pak3+kVjDCT+PHGtQb+u3XB9y7MK8E/sbamPL27
	 vxq6RQdSneL6uhszXFjroLcEFGShltqkvAT8BA/PzoRl0B1aqDpxtzGTFKW4MzwqcFYfB
	 0kiEi7gbO6m17xC4GHdh2qEj54BMuFLXbrC9pnYZxEZxyqUgP4b6O53LiYXHBUAE8EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NeOpow2yvnl026VUgojHlEkl/Wmd5NaRMkZcG5VlA5o=;
	b=XgT+cxpMmjsapijLbu4Bq2c4SXcv7+f5KjeOtgOz9HmJJXeNKqtfSvUCRwH4GyaihhAv
	 cZ/uyA9xVueu8CSD7UD8CYeGaLaG3ODeaKwh3MFlcZNBlMJAlOIpHiRUiTZX05Li/NVjq
	 nQqJyCYzii+XUWeQAnbB0Ix8hZh5q7twijHXF7SHlgcQMA10J02hj5h0lmK3+l6LqkVOh
	 DgW+z2eZaJH32oYPF6LeTI2UME2UBSvCJLfswPw9cpUi5648IjYruuQywhlHHbhpyvmHC
	 +tDhzeSLNQnO5sNZSNLv9vwu+PIFDOZfll4kbhB+s34tlLscr7PeoOpCJe9ZCJ3kC5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEB0G5ow;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C3606A325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355C3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEB0G5ow
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1281293f8f.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067849; x=1795672649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NeOpow2yvnl026VUgojHlEkl/Wmd5NaRMkZcG5VlA5o=;
        b=oEB0G5ow6Q0EfRxt8yZHuzDXs4UK+6sLhQNIOBQPWXlCNPcJka7saqSm6rhkzkAyD1
         S7TtyBgO+7RqzlrFp9ihfA6CMVmAwbU6o7N/biUJrH/dTFFLfE3/TI9tE0+FBiS2nMiS
         x+cHnk+TJd9KXvOqs+Btch8Vn8TP2jxDEDm8OzM6r/tFPODb4hsvx40PXy3vZHJpRodc
         iLJUPUU/YnUmeawHYs77anp00htKUgNDOp1GbEFZxF2v3s+uuzAd571dlyOp8lj3GH3B
         38H55yOD1Dh0JOK4xD7uf2LHZiuCJ+iSHii23IUDGwDSEqAal5QvXARgnK+bHkzB42BI
         GdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067849; x=1795672649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NeOpow2yvnl026VUgojHlEkl/Wmd5NaRMkZcG5VlA5o=;
        b=ianPgORj6AhE8Ae/zd875Ljs3Sg3rtVl3dHIXZe74rH7660/QQVBO30oNp9w7Og65a
         jo539ryrgRrj1SINH7SOGTZbGdN+dzbog7Jb+XjPy1nPlmCn9UuYJa/i+l8Gmc/jHuak
         KCDYDbxrDGxY7V6O2kcCsoAvwlZXSMi3X+CFp/sbzWR857vsfC7M92SMlI0m6IUo4gpk
         2cWbdMHNcq+1t8qHBItv0dCLjM5DidFyzD0GNpwklYvmlyOqiz3cSm+N7yPtE08o1oqo
         m4S3DhcQHvMVkq1HDmrE9iHQVqwz08h0mELFjnVB0Iqs3aDc5+8e9nGsENFtiVLfdiwa
         22+g==
X-Gm-Message-State: APuU4Z9FAdYojf43z+VeDZ5wnHlg1lWbOiti0DpTNhhbqOiD+6Bl/8Hz
	fHnqNLBjMZalVKFs+EaFtBMROcjY4UzXexple6CE3rjGlICNNCyW5vKJrJq7EA==
X-Gm-Gg: AYBFou0UoFg4VlVZUO6tnImVOv4OtTYa4hvS1k+YW5hBRj6hfn8yZIQWpmauhMh/UQK
	906UiQ/7oiEr4iHquu46Vljfx7JDZ8fbX5F7z+cw4CX8PItraPW63Gz4i9JdXz3b/KVn3gwVYzt
	0Q83XE4XfR9ye0MgzKqEGUzSXhVbRFSJI83+LdcB+92OVzCydlwaDZL936VszLGm/m0XEv/+v/x
	3DqSLX1sa36+gQgszcvK3BbpV0Wr0fLwINjp+Nj4btvIlA3Jvc/a1Oj8Kil8iAKcRgmFwo/iKy6
	aIG5lcnlnHLpkmEbVgoS3QGORXqNTeu5hgnWvpUyK02etLHN/SbOTO0iB6JpYh5Si/iyyZtiP3X
	A+VAwwfE8/Z4JxDxlmQxoNkmUz8ITRKxZkKvqLr3BlDpi9kLX61bfz3wdWGuPx+vONSb9NX8DHC
	EvwFnuynClh1e4vfXqBDemg59KltJT6692+SGHYLajy9SMOQk4omqHCZfU2g16nDMk/uHdT2Zur
	mQqmjLr8AV2HNoILckeSqFQTTs8wRXASgyvaYZvbBiAYKNoxxyKHVhzAHvV9Hrzvbjsg1xeUFDl
	tDvcGmr9ehy6IVcjIRg2WQhOZoOLATB4VIoXY22DNrp4WjeCxCyLjhEBr/whFjA=
X-Received: by 2002:a05:600c:45d4:b0:4bb:5f45:c97f with SMTP id 5b1f17b1804b1-4bb7da29ad4mr87157155e9.27.1795067849350;
        Wed, 18 Nov 2026 21:57:29 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm12598945e9.6.2026.11.18.21.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:57:28 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v3] status: reword message for a missing upstream branch
Date: Thu, 19 Nov 2026 06:57:26 +0100
Message-ID: <20261119055726.774485-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021072137.258934-1-gitter.spiros@gmail.com>
References: <20261021072137.258934-1-gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clone an empty repository, make a commit and run "git status":

    $ git init --bare empty.git
    $ git clone empty.git work && cd work
    $ git commit --allow-empty -m initial
    $ git status
    On branch master
    Your branch is based on 'origin/master', but the upstream is gone.
      (use "git branch --unset-upstream" to fixup)

The upstream is not gone, it was never there: the remote is empty,
so origin/master has not been created yet. The advice is also not
what the user needs; "git push" creates origin/master and the
message goes away.

The message was added in f2e087395b (branch: report invalid tracking
branch as gone, 2013-08-26), assuming that a configured upstream that
cannot be resolved must have been deleted. But "git clone" of an empty
repository configures the upstream anyway, and Git has no way to tell
"deleted" from "not created yet".

Since we cannot tell the two cases apart, change the message for both,
including the "deleted" case that has been reported as "gone" since
2013, so that it is correct either way:

    Your branch is set up to track 'origin/master', which does not exist.
      (use "git push" to create it)
      (use "git branch --unset-upstream" to stop tracking it)

Only suggest "git push" when it would actually create the upstream,
that is when the push destination of the branch (what "@{push}"
resolves to) is the upstream itself. This is not the case, for
example, with push.default set to "nothing", or when pushing to a
different remote (branch.<name>.pushRemote or remote.pushDefault).
It is also not the case with push.default set to "matching": it
only pushes branches that already exist on the remote, so it would
not create the missing upstream. In all these cases only suggest
"git branch --unset-upstream".

push.default is not used when the remote has its own push refspec or
is a mirror, though, and then "git push" does create the upstream, so
suggest it even with push.default set to "matching".

"git checkout" prints the same message, so it changes too.

Leave the short "[gone]" label alone. It is untranslated in
"git status --porcelain" and in "%(upstream:track)" of
"git for-each-ref", where it is documented and scripts may parse
it. It is translated in "git status -sb" and "git branch -vv", but
under the C locale it still reads "gone", and recipes like
"git branch -vv | grep ': gone]'" are common. Rewording it can be
done separately.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Changes since v2:

 - push_creates() is now called from format_missing_upstream(), only
   when advice.statusHints is enabled.

 - The comment above push_creates() explains why requiring @{push} to
   be the upstream already rules out push.default=nothing, push
   refspecs that do not cover the branch, and a mirror remote when the
   branch tracks a branch of a different name.

 - Two new tests in t6040 for the last two cases.

 remote.c                 |  49 +++++++++++--
 t/t6040-tracking-info.sh | 150 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 49ee2ea318..7e26088f65 100644
--- a/remote.c
+++ b/remote.c
@@ -2449,6 +2449,47 @@ static void format_branch_comparison(struct strbuf *sb,
 	}
 }
 
+/*
+ * Would a plain "git push" create the remote-tracking ref "upstream"?
+ *
+ * Only if "push_ref", what @{push} resolves to, is the upstream. That
+ * rules out push.default=nothing, push refspecs that do not include
+ * the branch, and pushes that go elsewhere, e.g. a mirror remote when
+ * the branch tracks a branch of a different name: @{push} does not
+ * resolve or names another ref.
+ *
+ * Even then, "matching" only updates branches that already exist on
+ * the remote, unless push refspecs or mirroring override it, as in
+ * branch_get_push_1().
+ */
+static bool push_creates(struct branch *branch, const char *push_ref,
+			 const char *upstream)
+{
+	struct remote *remote;
+
+	if (!push_ref || strcmp(push_ref, upstream))
+		return false;
+	remote = pushremote_get(pushremote_for_branch(branch, NULL));
+	if (remote && (remote->push.nr || remote->mirror))
+		return true;
+	return repo_config_values(the_repository)->push_default !=
+	       PUSH_DEFAULT_MATCHING;
+}
+
+static void format_missing_upstream(struct strbuf *sb, struct branch *branch,
+				    const char *name, const char *push_ref,
+				    const char *upstream)
+{
+	strbuf_addf(sb, _("Your branch is set up to track '%s', "
+			  "which does not exist.\n"), name);
+	if (!advice_enabled(ADVICE_STATUS_HINTS))
+		return;
+	if (push_creates(branch, push_ref, upstream))
+		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
+	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
+			    "to stop tracking it)\n"));
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2510,12 +2551,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 		if (cmp < 0) {
 			if (is_upstream) {
-				strbuf_addf(sb,
-					_("Your branch is based on '%s', but the upstream is gone.\n"),
-					short_ref);
-				if (advice_enabled(ADVICE_STATUS_HINTS))
-					strbuf_addstr(sb,
-						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+				format_missing_upstream(sb, branch, short_ref,
+							push_ref, full_ref);
 				reported = 1;
 			}
 			free(full_ref);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..1f0583b391 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -96,7 +96,7 @@ test_expect_success 'checkout (upstream is gone)' '
 		cd test &&
 		git checkout b5
 	) >actual &&
-	test_grep "is based on .*, but the upstream is gone." actual
+	test_grep "set up to track .*, which does not exist." actual
 '
 
 test_expect_success 'checkout (up-to-date with upstream)' '
@@ -123,7 +123,153 @@ test_expect_success 'status (upstream is gone)' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_grep "is based on .*, but the upstream is gone." actual
+	test_grep "set up to track .*, which does not exist." actual
+'
+
+test_expect_success 'setup clone of an empty repository' '
+	git init --bare empty.git &&
+	git clone empty.git empty-clone &&
+	git -C empty-clone commit --allow-empty -m initial
+'
+
+test_expect_success 'status (upstream not yet pushed after empty clone)' '
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+	git -C empty-clone status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout (upstream not yet pushed after empty clone)' '
+	test_when_finished "git -C empty-clone branch -D tmp" &&
+	cat >expect <<-EOF &&
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+	EOF
+	git -C empty-clone checkout -b tmp &&
+	git -C empty-clone checkout main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'status -s -b (upstream not yet pushed after empty clone)' '
+	echo "## main...origin/main [gone]" >expect &&
+	git -C empty-clone status -s -b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup expected output without "git push" advice' '
+	cat >expect-no-push <<-EOF
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'status (missing upstream, push.default=nothing)' '
+	git -C empty-clone -c push.default=nothing status >actual &&
+	test_cmp expect-no-push actual
+'
+
+# "matching" only updates branches that already exist on the remote
+test_expect_success 'status (missing upstream, push.default=matching)' '
+	git -C empty-clone -c push.default=matching status >actual &&
+	test_cmp expect-no-push actual
+'
+
+# but push.default is not used with a push refspec or a mirror
+test_expect_success 'status (missing upstream, matching with push refspec)' '
+	git -C empty-clone -c push.default=matching \
+		-c remote.origin.push=refs/heads/main:refs/heads/main \
+		status >actual &&
+	test_grep "use \"git push\" to create it" actual
+'
+
+test_expect_success 'status (missing upstream, matching with mirror remote)' '
+	git -C empty-clone -c push.default=matching \
+		-c remote.origin.mirror=true \
+		status >actual &&
+	test_grep "use \"git push\" to create it" actual
+'
+
+test_expect_success 'status (missing upstream, mirror pushes to another name)' '
+	test_when_finished "git -C empty-clone config branch.main.merge refs/heads/main" &&
+	git -C empty-clone config branch.main.merge refs/heads/other &&
+	git -C empty-clone -c remote.origin.mirror=true status >actual &&
+	test_grep "track ${SQ}origin/other${SQ}, which does not exist" actual &&
+	test_grep ! "git push" actual
+'
+
+test_expect_success 'status (missing upstream, push refspecs without the branch)' '
+	git -C empty-clone -c remote.origin.push=refs/heads/next \
+		-c remote.origin.push=refs/heads/seen \
+		status >actual &&
+	test_cmp expect-no-push actual
+'
+
+test_expect_success 'status (missing upstream, pushRemote is another remote)' '
+	git init --bare fork.git &&
+	git -C empty-clone remote add fork ../fork.git &&
+	git -C empty-clone -c branch.main.pushRemote=fork status >actual &&
+	test_cmp expect-no-push actual
+'
+
+test_expect_success 'status (missing upstream, advice.statusHints=false)' '
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+
+	nothing to commit, working tree clean
+	EOF
+	git -C empty-clone -c advice.statusHints=false status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream deleted on the remote and pruned' '
+	git init --bare pruned.git &&
+	git clone pruned.git pruned-clone &&
+	(
+		cd pruned-clone &&
+		git commit --allow-empty -m initial &&
+		git push origin main &&
+		git checkout -b topic &&
+		git push -u origin topic
+	) &&
+	git -C pruned.git branch -D topic &&
+	git -C pruned-clone fetch --prune
+'
+
+test_expect_success 'status (upstream deleted on the remote and pruned)' '
+	cat >expect <<-EOF &&
+	On branch topic
+	Your branch is set up to track ${SQ}origin/topic${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+	git -C pruned-clone status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'short formats still show "gone" for a deleted upstream' '
+	echo "## topic...origin/topic [gone]" >expect &&
+	git -C pruned-clone status -s -b >actual &&
+	test_cmp expect actual &&
+	git -C pruned-clone branch -vv >actual &&
+	test_grep "^\* topic .* \[origin/topic: gone\] initial$" actual &&
+	echo "topic [gone]" >expect &&
+	git -C pruned-clone for-each-ref \
+		--format="%(refname:short) %(upstream:track)" \
+		refs/heads/topic >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'status (up-to-date with upstream)' '

Range-diff against v2:
1:  e5920906ed ! 1:  0d4dfd06ab status: reword message for a missing upstream branch
    @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
      
     +/*
     + * Would a plain "git push" create the remote-tracking ref "upstream"?
    -+ * Not with "matching", which only updates branches that already exist
    -+ * on the remote, unless push refspecs or mirroring override it, as in
    ++ *
    ++ * Only if "push_ref", what @{push} resolves to, is the upstream. That
    ++ * rules out push.default=nothing, push refspecs that do not include
    ++ * the branch, and pushes that go elsewhere, e.g. a mirror remote when
    ++ * the branch tracks a branch of a different name: @{push} does not
    ++ * resolve or names another ref.
    ++ *
    ++ * Even then, "matching" only updates branches that already exist on
    ++ * the remote, unless push refspecs or mirroring override it, as in
     + * branch_get_push_1().
     + */
     +static bool push_creates(struct branch *branch, const char *push_ref,
    @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     +	       PUSH_DEFAULT_MATCHING;
     +}
     +
    -+static void format_missing_upstream(struct strbuf *sb, const char *name,
    -+				    bool suggest_push)
    ++static void format_missing_upstream(struct strbuf *sb, struct branch *branch,
    ++				    const char *name, const char *push_ref,
    ++				    const char *upstream)
     +{
     +	strbuf_addf(sb, _("Your branch is set up to track '%s', "
     +			  "which does not exist.\n"), name);
     +	if (!advice_enabled(ADVICE_STATUS_HINTS))
     +		return;
    -+	if (suggest_push)
    ++	if (push_creates(branch, push_ref, upstream))
     +		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
     +	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
     +			    "to stop tracking it)\n"));
    @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     -				if (advice_enabled(ADVICE_STATUS_HINTS))
     -					strbuf_addstr(sb,
     -						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
    -+				bool suggest_push = push_creates(branch,
    -+								 push_ref,
    -+								 full_ref);
    -+
    -+				format_missing_upstream(sb, short_ref,
    -+							suggest_push);
    ++				format_missing_upstream(sb, branch, short_ref,
    ++							push_ref, full_ref);
      				reported = 1;
      			}
      			free(full_ref);
    @@ t/t6040-tracking-info.sh: test_expect_success 'status (upstream is gone)' '
     +	test_grep "use \"git push\" to create it" actual
     +'
     +
    ++test_expect_success 'status (missing upstream, mirror pushes to another name)' '
    ++	test_when_finished "git -C empty-clone config branch.main.merge refs/heads/main" &&
    ++	git -C empty-clone config branch.main.merge refs/heads/other &&
    ++	git -C empty-clone -c remote.origin.mirror=true status >actual &&
    ++	test_grep "track ${SQ}origin/other${SQ}, which does not exist" actual &&
    ++	test_grep ! "git push" actual
    ++'
    ++
    ++test_expect_success 'status (missing upstream, push refspecs without the branch)' '
    ++	git -C empty-clone -c remote.origin.push=refs/heads/next \
    ++		-c remote.origin.push=refs/heads/seen \
    ++		status >actual &&
    ++	test_cmp expect-no-push actual
    ++'
    ++
     +test_expect_success 'status (missing upstream, pushRemote is another remote)' '
     +	git init --bare fork.git &&
     +	git -C empty-clone remote add fork ../fork.git &&

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.53.0

