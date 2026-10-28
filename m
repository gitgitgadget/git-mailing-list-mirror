Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200707;
	b=roPFXeCOWhjDd15xk+MYo+3jeFpijdQaBSg185Io4QmS4Gf0xO9QG4yCzG7zZj0q4QPd
	 Y/KA+HOikx4gf7jYf4kh2LYtbALrfl1OBD/0Fhx2lOF0DiC6feyoLqQmSMV8IelrnmdBH
	 BzLjZ0nKTSla8/UwSeFwBM8uG3M1+D1bASJqsKcJrH5MFWux3LjZsnURfNzwjRXSx8rFZ
	 KnqDY/V04blQyRd/AbukpTpa/nbOlEQ3DqRcjbualoDK9BDSj0pLYG2PabeGvHe8jhYdf
	 LormNjR1mNk3lU+CMzCwfSRuObQveN/xrjDLHpEK2oOXpSiIzjk84uPOK8fd4kw+Y4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=KyBVUGmKn+/jKmSpvfuobtldnRwO8dQ1i1wb1HzpLbE=;
	b=e91/kaVD1K7U2PCZVI7zTXdTRRK66BLOeHqUrbPminpGl1LPOSUKCW3kD4YrjmOLOAfp
	 pJi049At9krXCjXMjkS5wncRNz+FPFoh+7JmTt4wbJXxKgxi66eIACDz/hcA/Om3CtRkW
	 bLNkMtaXbkPmFPETsg+QMrMbsMQ2QE9peLljqFOUR7G+J2pO/oDmePJnfiA4Y5TPNXTOI
	 x1v9DvMF32vuQnKy7ZCNcZMG5nzKoHZWnhstFziSVcSmxsyrbjvP/QazIovgp4pe472tY
	 g51eIXXOD+qQFcBp+B9rXc1Hv30X8oDArWzN4HMGoPPdH5b0idsPc1JLWZzM4QUJeJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTxsljFi;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34096606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34096606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTxsljFi
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5364648ae07so14750821cf.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793200706; x=1793805506; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KyBVUGmKn+/jKmSpvfuobtldnRwO8dQ1i1wb1HzpLbE=;
        b=FTxsljFiSMGIOhvl+aTcSgHTGU+iZKwEReagpU1kpNQhKxgLCKU8yZfRiG4AqvsNse
         3NU82ti3F88KuZx/y4YBBchtraiMe3G2KafBB7wRVqeWfZXbDFg9eil/Q2Tbr7tpVds/
         riyNMAsMOmkXk5G3TNd0sFmXB45CZnzfC12Cp91YdAdwRZwZDe7GQK1Xw7afWO2KpDe6
         jEcAFt2TvH1PkR/LSo6fys8lNPr4ddfJLhqmjX+3Hwr7qBnHlEuKOEP2qhOBxiz7wbJn
         7lpjJs+//EvHSHD5Q+9UrO9J61qkfwN4KCjW6XugLIhs9NhTwXqibxuFVO/fN24MtSVt
         a+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200706; x=1793805506;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KyBVUGmKn+/jKmSpvfuobtldnRwO8dQ1i1wb1HzpLbE=;
        b=xlIk84zkXalRJ6RWvz4QEyilGq83SXrbOcvmYmfTNWP9MmWWRgLAXfToQYA7F3sN3n
         pZvqumEdp747rcYP68AIIe8l4O+VxAvhInCeinC6JXrN2GLZmO0V4rZv9MLbg0qUe0GR
         gVxSVPsmeb9GFJIK2bkYPUlMPxEfa1P+G+z0BisCinq/YRg0xvWpte+/ReMdhD1w+COu
         r0TIIwI3m0YySWOVfPf3+eEpghgiGoOtoiKX07ZGLAbEb76ZXmyOQOp4WCPLC+PQXIt8
         bAmR5pfVB1jdJJDW3Lz9ph86PlV3xiGy2alk/fsBH/SeRqIP0Jd7bpGKbaddvDfqoFHN
         WR4A==
X-Gm-Message-State: AFq9FYLlERp8E1vOJdcyeTVDc3yGWo+AxyGadBKDGh/8nB9sPaGPJDSJ
	LRNhmAJGzEubKUm2TPpMBX565dRdypQQrfyZJ+rt2UhS6dl2NFA9WdZT3S8CDVzj
X-Gm-Gg: AYBFou3PVL0fOdi+QzgbgcUwbsIPnrTB+QX1oJ7f61xMNBp/mDAqQsHb9qp2vzqgGXo
	Kox6udVfB5gWqeMElFV+SQLWTokUwhcu/K7YhvwY2Go6/CPbFE8Q221BmJ1GLQ0f5UE95VQHHEG
	+qSpyWIn5SWd+Ydy/KyldERBgdHDSZYTD33RxJQw0rWsMtHGgyRkk9wW3FSk1V2M5F6dAOLgWkA
	CeVmNvMosP3MqgphF7vjPivcfrgEZaWYqgbSvW8oqHJtEDZ6OP3N48QH3eT1X4EO3aeczcEs3Rc
	C2GLApCxkX3qUS383z6RxeuBZP+W14/imM8u6splOlAGF4/vc/1G+GTWgh8H0txXuN0ShTf1h+P
	y2sEfE82t715dAPqP7yRxv//aaYlOwdWmNPdydtQ/QHs/iL7oQ6AGxonHsAar6HMEnWp1JkM16E
	o5MAstiIz+rTJ1OX9IVOEonIfXUyNnlKm/BgdszmeKBacFh87fIoptmL1E/txAGuCmGiX6fyDzD
	mkaZcv3oWxq6SDrLtyQOFoUoe6aUJ5bew9uj87J6L1Oq54P56v4HRUPskRpqv8WE9muWw9ryktj
	k+7QiHwbUTI/0VB4muqlp2Sm58TEFUSzvw==
X-Received: by 2002:a05:622a:528f:b0:535:11bb:c2a3 with SMTP id d75a77b69052e-53fcc6cbc72mr43906631cf.53.1793200705943;
        Wed, 28 Oct 2026 08:18:25 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.83.105])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6bc95b66sm64701066d6.43.2026.10.28.08.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:18:25 -0700 (PDT)
Message-Id: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Oct 2026 15:18:24 +0000
Subject: [PATCH] odb: do not list our own refs as alternate refs in the
 quarantine
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Since 722ff7f876 (receive-pack: quarantine objects until pre-receive
accepts, 2016-10-03), receive-pack writes incoming objects to a
temporary object directory. Child processes see it as their primary
object directory, and tmp-objdir passes the repository's own object
directory to them via GIT_ALTERNATE_OBJECT_DIRECTORIES.

The connectivity check passes --alternate-refs to rev-list since
39b44ba771 (check_everything_connected: assume alternate ref tips are
valid, 2019-07-01). Inside the quarantine, the repository's own object
directory is one of the alternates, so --alternate-refs runs
for-each-ref on the repository itself and lists all of its refs.

That includes hidden refs. bcec6780b2 (receive-pack: only use visible
refs for connectivity check, 2022-11-17) added --exclude-hidden=receive
to the check so that repositories with many hidden refs do not have to
load all of them on each push. The hidden refs are excluded from --all,
but they all come back through --alternate-refs.

Skip an alternate whose repository is our own when listing alternate
refs. This is done by comparing paths, which is a hack: it is mainly
here to measure the cost of the bug, and a proper fix would have the
quarantine tell its children which directory is ours. It is safe,
though: alternate refs only serve as negative tips that are assumed to
be complete, so dropping some can only make the traversal walk further,
never make it accept a missing object.

Add a test that our own refs are no longer listed, a test that the refs
of a real alternate still are, and a perf test pushing a single commit
into a repository with a visible branch and about 200,000 refs hidden
by receive.hideRefs, and into a copy of it that hides nothing:

    Test                           HEAD~1            HEAD
    -----------------------------------------------------------------------
    5552.2: push, hidden refs      0.31(0.32+0.08)   0.10(0.06+0.03) -67.7%
    5552.3: push, no hidden refs   1.25(1.08+0.68)   1.03(0.84+0.62) -17.6%

With hidden refs, most of the time went to the for-each-ref child that
listed the alternate refs. Without hidden refs, every ref was listed
twice, once for --all and once for --alternate-refs.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    receive-pack: connectivity check does not exclude hidden refs in the
    quarantine
    
    This is mainly a bug report, in patch form so that it comes with a test
    and numbers. I don't expect it to be merged, at least not in this form.
    
    When a repository hides refs with receive.hideRefs, every push still
    loads all of the hidden refs in the connectivity check, even though
    bcec6780b2 (receive-pack: only use visible refs for connectivity check,
    2022-11-17) excludes them from it. With many hidden refs, that is most
    of the time spent on a small push.
    
    I stumbled across this while working on the boundary walk of the
    connectivity check (the follow-up to kk/connectivity-check-incremental),
    when the walk loaded every ref during a push even though it should only
    have looked at a few of them.
    
    The cause is that receive-pack runs the check inside the object
    quarantine, and there the repository's own object directory is passed to
    rev-list as an alternate. --alternate-refs then lists all of the
    repository's own refs, hidden ones included. Without hidden refs, every
    ref is listed twice instead. Setting core.alternateRefsPrefixes to the
    visible namespaces works around it, though that also limits which refs
    of real alternates are used.
    
    The patch includes a small fix by comparing paths, mostly so that the
    perf test can show the difference (about 0.31s -> 0.10s for a push with
    200,000 hidden refs). I am not really happy with it as a proper fix
    though.
    
    I also tried resolving the object directories that --alternate-refs uses
    before the quarantine is created. That got a bit messy: it needed a new
    internal rev-list option, and receive-pack had to carry the list of
    directories through to each of its connectivity checks. And it only
    fixes the check itself; other processes running inside the quarantine,
    like pre-receive hooks, would still see the repository as its own
    alternate.
    
    So the question is really where this should be fixed: is there a better
    way for processes running inside the quarantine to tell the repository's
    own object directory apart from real alternates?
    
    I am likely not the best person to answer that. Patrick, maybe you could
    take a look, since you have recently reworked tmp-objdir and the odb
    sources?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2285%2Fspkrka%2Fquarantine-altrefs-bugreport-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2285/spkrka/quarantine-altrefs-bugreport-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2285

 odb.c                            | 16 ++++++++++++++
 t/perf/p5552-push-hidden-refs.sh | 37 ++++++++++++++++++++++++++++++++
 t/t5547-push-quarantine.sh       | 25 +++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 t/perf/p5552-push-hidden-refs.sh

diff --git a/odb.c b/odb.c
index 2c93a9490c..0cda333c4e 100644
--- a/odb.c
+++ b/odb.c
@@ -183,6 +183,7 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf self = STRBUF_INIT;
 	size_t base_len;
 	struct alternate_refs_data *cb = payload;
 
@@ -190,6 +191,20 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 		goto out;
 	if (!strbuf_strip_suffix(&path, "/objects"))
 		goto out;
+
+	/*
+	 * NEEDSWORK: this is a hack, mainly here to measure the cost of
+	 * the bug. Inside an object quarantine, tmp-objdir passes our own
+	 * object directory to child processes as an alternate, so we would
+	 * list our own refs as alternate refs, including the hidden refs
+	 * that the connectivity check of receive-pack deliberately skips.
+	 * Comparing paths papers over that; the quarantine should rather
+	 * tell its children which directory is ours.
+	 */
+	if (cb->repo->commondir &&
+	    strbuf_realpath(&self, cb->repo->commondir, 0) &&
+	    !strcmp(path.buf, self.buf))
+		goto out;
 	base_len = path.len;
 
 	/* Is this a git repository with refs? */
@@ -202,6 +217,7 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 
 out:
 	strbuf_release(&path);
+	strbuf_release(&self);
 	return 0;
 }
 
diff --git a/t/perf/p5552-push-hidden-refs.sh b/t/perf/p5552-push-hidden-refs.sh
new file mode 100755
index 0000000000..e9aa206298
--- /dev/null
+++ b/t/perf/p5552-push-hidden-refs.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='speed of push into a repository with many hidden refs'
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+test_expect_success 'set up repository with many hidden refs' '
+	git init --bare dst.git &&
+	test_commit_bulk --ref=refs/hidden/base --id=hidden 1000 &&
+	git rev-list refs/hidden/base >commits &&
+	for i in $(test_seq 200)
+	do
+		sed "s|^\(.*\)$|create refs/hidden/$i/\1 \1|" commits || return 1
+	done >input &&
+	git push dst.git refs/hidden/base &&
+	git -C dst.git update-ref --stdin <input &&
+	git -C dst.git pack-refs --all &&
+	cp -R dst.git dst-visible.git &&
+	git -C dst.git config receive.hideRefs refs/hidden &&
+	git symbolic-ref HEAD refs/heads/main &&
+	test_commit_bulk --id=visible 1 &&
+	git push dst.git main &&
+	git push dst-visible.git main
+'
+
+test_perf 'push, hidden refs' '
+	git commit --allow-empty -m new &&
+	git push -f dst.git HEAD:refs/heads/new
+'
+
+test_perf 'push, no hidden refs' '
+	git commit --allow-empty -m new &&
+	git push -f dst-visible.git HEAD:refs/heads/new
+'
+
+test_done
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 1b7097179e..855a1d2c0a 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -101,4 +101,29 @@ test_expect_success '.keep file is removed after push' '
 	test_path_is_missing "$keep"
 '
 
+test_expect_success 'quarantine does not list own refs as alternate refs' '
+	git init --bare hidden.git &&
+	git push hidden.git HEAD:refs/heads/main HEAD:refs/hidden/one &&
+	git -C hidden.git config receive.hideRefs refs/hidden &&
+	write_script hidden.git/alternate-refs <<-EOF &&
+	echo "\$1" >>"$(pwd)/alternate-refs.log"
+	EOF
+	git -C hidden.git config core.alternateRefsCommand ./alternate-refs &&
+	test_commit hidden-push &&
+	git push hidden.git HEAD:refs/heads/new &&
+	test_path_is_missing alternate-refs.log
+'
+
+test_expect_success 'quarantine lists refs of other alternates' '
+	test_when_finished "rm -f alternate-refs.log" &&
+	git init --bare other.git &&
+	git push other.git HEAD:refs/heads/other &&
+	echo "$(pwd)/other.git/objects" >hidden.git/objects/info/alternates &&
+	test_commit hidden-push-2 &&
+	git push hidden.git HEAD:refs/heads/new2 &&
+	(cd other.git && pwd -P) >expect &&
+	sort -u alternate-refs.log >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
gitgitgadget
