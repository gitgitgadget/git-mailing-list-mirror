Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567300;
	b=bUAGdlnswz9DxdVF3MYJvaFAnmW8wdT6doGTPwMcMUOPriJrdKfAX/6Zv224nnUcCo13
	 ImUPgItFgeI3rQAXOD5p92XfrstFgbqZk+qKEP7GqI2dvbp1hdfqpOnOEWmYPgoVwIqkr
	 GaPEhbU2bzdzA2N+SA3VM0HSf4d0EuFUt8cW4w2eLptpDoGDt5YnpbdqpMhN8oiHnvCOe
	 XfzAwMp3Qg+/ddSE7gcycfEdoTz7BbUiSz07j/xVrhq1hlM0RXk44jKBBzUXecXtAnKcv
	 PLU6adelq5H2dDJ9/9WOAJ2NCv4BqjDWBxR7aQWPo3G4b4qup2l45Eyy11w6Z9bqnMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LsPFDFjCgbHmtgd4ECN4kFqh3q72otrn1cL1kH0E34k=;
	b=g5XtaZvWP8Poo//+JO0OI0FU2R2eEInoGwoBRNTIwvRZWkgZD639RPLoJ44eRub/4C88
	 AwdUIY68mPx2zO18zvpPFuxFJmqPuciXMmUcp4HK4OlVQHpwWJvB25Qx6WNEvQDAz3fPA
	 JelR8QGrc9Job32h7Lauv84UejP2ma51Rbcbh1ZDeQfa0xTeAtAbSbO0+NMuTOI/vtOpC
	 gXUnw74fzFonDqtmHL6hLc21VuwnIwp7DJ6Y2x5uVGl+Lv5akAGbLROjQq6dsOBRRe7sd
	 8MbX75FrBA7YHrof9JILdyehFIZdm7/Q5j1RMAMagkCEvBnvnvelCYKbtyE2yIvm/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KxM2lb1B;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FB606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1FB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KxM2lb1B
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so1979625e9.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567298; x=1793172098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsPFDFjCgbHmtgd4ECN4kFqh3q72otrn1cL1kH0E34k=;
        b=KxM2lb1BZVsfTLee9ht9YIsSWn27QXS0kK6UztVEd7OmwWv+bUC7YSU9PdV4TB9RM1
         LFv2EUKIvpC2lR5gs9AIiMauFJZUesV3gRm1BsivJBChvw5NMYYKRG/LFuKxK9G+XcgI
         ZWCFoY0+96RxsDcP5k6ilfUQ5A/B8zAP6hD0F+jvEaWZsXdkqHWOBGzDlsoifmjx9cQb
         JfeT3V0ZrOlHihycKcPXFsjuTHduZ7YXLoHrQGbTdMOb+5Bm2uATKFBCJs+Ki8YIt2KY
         flHYzttF/JMCMm4QMlUl8q/vNCgeeG8ck6JJF4Y2DAtJstXgxqx7whFfPFhiu2ZQer0D
         rtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567298; x=1793172098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsPFDFjCgbHmtgd4ECN4kFqh3q72otrn1cL1kH0E34k=;
        b=hOuKq987Gyw98Q52OzvK0PKj4MCV8va19C+2NIr9XxH0zl1CtYctF3y8DMiBuWYogt
         Oa2gz1vgPSZQ7+8VU3BtaAF2+eUNeCU2mseVEFfoE36d9G88Ymk7oxKg4Vkipxt8QbOy
         GiX7Lst+B1JKyIvF+vjfGprDJoZdd5OKbLBi3DJNsEn625C98sjW1+rd0XK9S8Hdu5uE
         AoCCyp4fEjUkkfQF2M4NpJEmxWfczyKvLBpU7rYMKEyrfOhfSbjHj5TB/+Csg3F5w8j/
         JhftXhcSvg0eSbls/j9d3hRgpK/jBkGaqjiCkEq7H4VEHgRSnUgotBdzfvNB18bz7CIq
         NRtw==
X-Gm-Message-State: AFq9FYKpbgDpga6EY6Zfkd5n2LI9IAtHBpxwo3luxTGW8LYMwVWa+uuZ
	M7Fgu4ckrbxaMOOXwwerDqv3NHYnEKLrCpjn0JOVTX2Rq6MOg7Ojg0oOJ0+VPRdW
X-Gm-Gg: AYBFou1lqLmym6RCFce+kG0bf1yxAl23J4j9B7yguZ4VFRtvQPyV8+nvw7COuqCmnqm
	JstLTcY6PmfsHb+8TGBWRNYpFl8DPMosq43pAIYIM0GwpJJWJFUGOpewGYqzW9QemOxtbrutQZB
	tuelRXsaLCtACq3r6TN0S731CVQY3P7TCFprVk3wSPSyLzplrPr4AXB8oM23Xp/uCYyv2EWqPwx
	grmpz6mSwG9hQ8F6ohHrGvkjj0TE8x+XSwGOtkSDsgu8fyNTdeoCFRF4lL7M8ogJGOzR+WQ0Q1p
	et5YIzfEX3xegjXUgoei7rdvQmyWFAG5Vm26f1Gzz0JSXiNU5VXQPCoGnQNAud5yMgJAQpk6MVV
	h5tzCB7/fh3PvwpD0NqJ2kk3Oyqpv62M9SBfeUwa6RNfKhEpoktLKz5maIvwwr5P3/BQTy3dYJb
	PtOac083+zksCJTH/oNN468QuaSvSR8dehRNA5DcL69V8SscOGDxZWsjVe9bnYKwv/7Mt8SOMdp
	TtHHcCtzBdNRwOwCTMsAmA3thSyGtyA+xZ/+jvb8khuqHExZ5zgMRsYpZFgpNwNTwoL++NQJ0hW
	TVtJmjQyiEc=
X-Received: by 2002:a05:600c:c116:b0:4a1:7659:9b94 with SMTP id 5b1f17b1804b1-4a1fdd15d29mr18295115e9.13.1792567298183;
        Wed, 21 Oct 2026 00:21:38 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a200c1cc03sm1985775e9.0.2026.10.21.00.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:21:37 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	haraldnordgren@gmail.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2] status: reword message for a missing upstream branch
Date: Wed, 21 Oct 2026 09:21:37 +0200
Message-ID: <20261021072137.258934-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019175722.5223-1-gitter.spiros@gmail.com>
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
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
Changes since v1:

 - push_creates() suggests "git push" when the push remote has a push
   refspec or is a mirror, even with push.default=matching, checking
   things in the same order as branch_get_push_1(); add tests for
   both cases.

 - Correct the log message about the "[gone]" label: it is translated
   in "git status -sb" and "git branch -vv", and untranslated only in
   "git status --porcelain" and "git for-each-ref".

 remote.c                 |  45 +++++++++++--
 t/t6040-tracking-info.sh | 135 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 172 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 49ee2ea318..5f703b40a9 100644
--- a/remote.c
+++ b/remote.c
@@ -2449,6 +2449,39 @@ static void format_branch_comparison(struct strbuf *sb,
 	}
 }
 
+/*
+ * Would a plain "git push" create the remote-tracking ref "upstream"?
+ * Not with "matching", which only updates branches that already exist
+ * on the remote, unless push refspecs or mirroring override it, as in
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
+static void format_missing_upstream(struct strbuf *sb, const char *name,
+				    bool suggest_push)
+{
+	strbuf_addf(sb, _("Your branch is set up to track '%s', "
+			  "which does not exist.\n"), name);
+	if (!advice_enabled(ADVICE_STATUS_HINTS))
+		return;
+	if (suggest_push)
+		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
+	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
+			    "to stop tracking it)\n"));
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2510,12 +2543,12 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 		if (cmp < 0) {
 			if (is_upstream) {
-				strbuf_addf(sb,
-					_("Your branch is based on '%s', but the upstream is gone.\n"),
-					short_ref);
-				if (advice_enabled(ADVICE_STATUS_HINTS))
-					strbuf_addstr(sb,
-						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+				bool suggest_push = push_creates(branch,
+								 push_ref,
+								 full_ref);
+
+				format_missing_upstream(sb, short_ref,
+							suggest_push);
 				reported = 1;
 			}
 			free(full_ref);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..7804c84aaf 100755
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
@@ -123,7 +123,138 @@ test_expect_success 'status (upstream is gone)' '
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
-- 
2.53.0

