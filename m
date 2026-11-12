Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504859;
	b=uiOs56etv3d/wjikfMfvAE/IGAapE7zJwSfa36bkPPsj98SEdg1DUHxEvKi75nTiPX2j
	 7Z/wT3Ib/0XQc/jzxE4NRLbbHPEfKxQyhi7/cOm7wu8qBkDfhQcnDs7AgiLojn4Njr6lO
	 O9ChZ7itkASiaf5pdi6jyh9eXrJj9zE8Z0bKNPRh9Y94PKJmnJIEzNFRaxnb1wTff9fGB
	 TQRZXTz1v7Jt41XBwdVi2Kpi/YFBDMPh8Y1Uq/gW1cCBWlreP2VtKBq+4VqiKfPn2I3h6
	 IlY6qmoNMp3CKT5H5Gir/XLved4DTr6HudctqN79+SID2v6BKL79X/Fhn5zpmI3Hxeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=0rliJOGCUENz4dPBpArsqtyqUTdbSsc3lu7IEZMmRwE=;
	b=FVkT9pZQu2G9ebcmEr3UT7MFIrR+trF9vkeSSWOIRXhLk45UGwlXDPnoR7dmN9bAlWzT
	 XcPgrcQ/eRYk6irKYl/PTlTF7OsjfwgznEP0HV6vY5X3OCfiOIVYuW9j32pM6MI5VfYfp
	 onk4MhZEPPE7wc9vgABdxLUWGR+onFWlNwKYqhTS3Zl+xbb0rMjeiJm6Brpe0YgK8nmx4
	 ISUzBh5pE2H4kZxgPosrhUGdsXHe35JvqVgTW4eSmKidakmgxL/JJjEojJWgbyFcUzZrZ
	 jcfociZ58wxz1reHzBYcTd3emZqnNMVwC5w5VsbIzFQ+AhnzMCYHeRuZPHOU05h0RSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbAPLam0;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBC606A20C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8FBC606A20C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbAPLam0
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4922dbcee23so17533f8f.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504857; x=1795109657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rliJOGCUENz4dPBpArsqtyqUTdbSsc3lu7IEZMmRwE=;
        b=jbAPLam00yuJISBdJUiH93VZaTJsa0Mv97Z33UieLNZ5p3oLBvQshF0jrs677u9Rjf
         Xa7nlWK2SE6DfVIsCMnb19VNYg1bf4Li7zZtW3oFOvXBCFobarHxB9vJ9laogbqCoE7P
         3PAZ8EQdqXEYwxFdwyRmKmxGlfVgRPFbMyoPHzL9mNvZsWPMR8qDEI0Q51YS2HxxFPLn
         M/FvmVC3TVAm3KbBOnW9jAoL3CfffK8fbLGDuaLW8TBBbBdrVR8SQJoO/j5/h3DDPAXc
         6If/r4t03hE3cBVPtEQ50OaG6lzsNUN7wWo/9lk5EcMP5c/CKkEcuphjJzhzcTwnt2wL
         13IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504857; x=1795109657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rliJOGCUENz4dPBpArsqtyqUTdbSsc3lu7IEZMmRwE=;
        b=b/Ly9InWxoXFJz+P1M+p9IvW8FBeRGbceEz8rNSIyu70jAugWOgDS/2hbAnsNGim2x
         qJzVioTpsdd2LfS44pufOyzMPCigm+AKKAgZrbmfpNH8duguPPt8ayIj+JDJohVRwQO8
         9+5iU/ZQdAMdoTE/+Fl8EzYWzaegg4SRGlysO4oKN4BQuTpEPwG56r7u5+pVfg3QXiHW
         n3qY9WAGkQZGxxHejs1+rO7ygqLEBukm/74Cw1CXo0FHOFSpynGb+BetPzD1HoNdzh/K
         g7WwB47QkL2AQlxfB7gUBtyyQ9O93EyeWQ7D7TvkX91EVxRnoc5A7NDkMw3U9fHOGjQ+
         s1Vw==
X-Gm-Message-State: APuU4Z8IYc1hqI6VCymd5G7WAG+r31R3a44auManHRfA8M44DUlmhvyn
	qCN/ThcnLB1s1zQNWRR9aEBS5HpaJSOMGUPMf/IoDNGJGHRut/TBYzrpR6lmaA==
X-Gm-Gg: AYBFou2s5oYR84SkVoaFcHHfwyXeDj4DD/uqVpHuFNCqqAehygUolDVwpX775fbPk04
	xDtbBuPs0IYnE2pBvsGmUZf/yYoABuPR3uOJFMXtWDNyiQWsRUcYH4614aYKTyYpVrHUhy9vbQ0
	WmBLNM/r3lp9GSzJGyURpB/dYgOTCCDPX54yJuXMSyIYjojhGDF9xTIjaGWcpZphxZsZZRVHgmZ
	nTpnavVh0KqUms0yN+jL4Np4CwcWQBsOLbAXQqqSfzh6WLHfzGj/8g29Yb486Rqs2tG6AF/pHsh
	WheqiOt/uQ+auxOYPSTRw9W0uDQ8AafMdy8hZhZb3lBcwnvMxxceX7ab5H6BjlAUB11ev1ituyB
	QH1rHuCDcKG2ZQFs/5a6p0wtYxifRcuWO6HuzhgJOdUkNdMOV2pXRkDsjz89BeWvoVnln74Bz0E
	7VnKewxvFt5tpKzmim1S0K5GgijjBqRqt3iJmskbk2xSGiIedOnkUIL+D5yczlg34josAT1Tz07
	x0/OpBzX5wig7bk09lKXLPndKzKDjFZIfKnQQtUPwA7skD9pCkDg54EKYXDInL2fnH35hbTGQzv
	gCmJFjcceUYNRQa6yUk9JickR4MJytR46f0MmqLEzC1iyvy3kbdSSxw/CoOLWqq5AV7gGDl0nmw
	3I0DZiwm0IyU/wA==
X-Received: by 2002:adf:e008:0:20b0:48e:6f76:de98 with SMTP id ffacd0b85a97d-49c71e3e1c0mr118432f8f.9.1794504857324;
        Thu, 12 Nov 2026 09:34:17 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:16 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:05 +0100
Subject: [PATCH v2 05/20] t9300: make the series V tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-5-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5633; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=W75jBO1XOo/hTN3SyXzM2hg0L4LkpLv6ykUFBhaqaT0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JEWDsWoQejPszNxE07uSHU/2nBH63EA9
 YbT3dGAUmJybokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiRAAoJED7VnySO
 Rox/g84L/RDrGCZ3ywhGUeAhqUpDWNZxE5qp2uWFc4e9DQwpMobX3RkenusY1cjlpnyHTf0JRde
 NBrODroiBEMzH3vQTrLxbcTaVWgsOrxY0e9s56w91EUyW+1n8e7zyfhdsl9PmhBaeO6E9vwqCd0
 foD/+Jf30rp1mUrqY7+JnhKDaVlfbvpUDkyRVPsL/hMcX+WE4dlFpDUm5ivIlJTh6DBYEVYHfW/
 FlSV9eoeHTm5Zm8ip6ThRNZ+s87HV8UiVGsxxeZ+NCGh5I7HVf4S2sxutdNTbdmGB/k8TcEkO5I
 AjNfIh3ieTQ9RgHV6HSMG291gstAEfZ4Jcqu6YmeJ40uQxwUglATAZGFMeP3qrS/p6cDKdreidc
 WQ6m8djsn4HimEbSbwraq1HN3XLaXDE7r+N1CO7T7bh90pafSqHXe2AnowtmZ/r50PCY7zRAD8Z
 6xdUlJLZ2Xmg9xe9GNMklnRykFYvnKZzUjk2SU921Nd5RVo9SYeURWvA/mJQZxPDjR0+oDx5RT6
 NI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series V' to make
them independent of state from previous tests.

Move the setup to a 'setup_checkpoint_repo()' function, so each test can
invoke it. The tests used to build on the 'U' branch from series U, so
let the function create a 'base' commit instead. For the same reason,
the tag test now tags 'base' and not 'V'.

'background_import_then_checkpoint()' registers a cleanup with
'test_when_finished', which is not allowed in a subshell, so call it
from the main shell.

The 'no new objects' test needs the 'V' commit in a pack, because
fast-import only detects duplicates against packs and not against loose
objects. It used to rely on the 'fastimport.unpackLimit' set by an
earlier test, so create the commit in the test with
'fastimport.unpackLimit' set to 0.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 80 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f9359bbaf3..809a5a59c5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3854,7 +3854,7 @@ background_import_then_checkpoint () {
 	rm V.output
 
 	(
-		git fast-import $options <&8 >&9 &
+		git -C repo fast-import $options <&8 >&9 &
 		echo $! >&9
 		wait $!
 		echo >&2 "background fast-import terminated too early with exit code $?"
@@ -3906,80 +3906,110 @@ background_import_still_running () {
 	fi
 }
 
+setup_checkpoint_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_tick &&
+	git -C repo fast-import <<-INPUT_END
+	commit refs/heads/base
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	base commit
+	COMMIT
+	INPUT_END
+}
+
 test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra output' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-INPUT_END &&
 	progress foo
 	progress bar
 
 	INPUT_END
 
-	background_import_then_checkpoint "" input &&
+	background_import_then_checkpoint "" repo/input &&
 	background_import_still_running
 '
 
 test_expect_success PIPE 'V: checkpoint updates refs after reset' '
-	cat >input <<-\INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-\INPUT_END &&
 	reset refs/heads/V
-	from refs/heads/U
+	from refs/heads/base
 
 	INPUT_END
 
-	background_import_then_checkpoint "" input &&
-	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
+	background_import_then_checkpoint "" repo/input &&
+	test "$(git -C repo rev-parse --verify V)" = "$(git -C repo rev-parse --verify base)" &&
 	background_import_still_running
 '
 
 test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-INPUT_END &&
 	commit refs/heads/V
 	mark :1
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 0
-	from refs/heads/U
+	from refs/heads/base
 
 	INPUT_END
 
-	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+	background_import_then_checkpoint "--export-marks=marks.actual" repo/input &&
+	(
+		cd repo &&
+		echo ":1 $(git rev-parse --verify V)" >marks.expected &&
 
-	echo ":1 $(git rev-parse --verify V)" >marks.expected &&
-
-	test "$(git rev-parse --verify V^)" = "$(git rev-parse --verify U)" &&
-	test_cmp marks.expected marks.actual &&
+		test "$(git rev-parse --verify V^)" = "$(git rev-parse --verify base)" &&
+		test_cmp marks.expected marks.actual
+	) &&
 	background_import_still_running
 '
 
 # Re-create the exact same commit, but on a different branch: no new object is
 # created in the database, but the refs and marks still need to be updated.
 test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no new objects)' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	git -C repo -c fastimport.unpackLimit=0 fast-import <<-INPUT_END &&
+	commit refs/heads/V
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/base
+
+	INPUT_END
+
+	cat >repo/input <<-INPUT_END &&
 	commit refs/heads/V2
 	mark :2
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 0
-	from refs/heads/U
+	from refs/heads/base
 
 	INPUT_END
 
-	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+	background_import_then_checkpoint "--export-marks=marks.actual" repo/input &&
+	(
+		cd repo &&
+		echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
 
-	echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
-
-	test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
-	test_cmp marks.expected marks.actual &&
+		test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
+		test_cmp marks.expected marks.actual
+	) &&
 	background_import_still_running
 '
 
 test_expect_success PIPE 'V: checkpoint updates tags after tag' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-INPUT_END &&
 	tag Vtag
-	from refs/heads/V
+	from refs/heads/base
 	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 0
 
 	INPUT_END
 
-	background_import_then_checkpoint "" input &&
-	git show-ref -d Vtag &&
+	background_import_then_checkpoint "" repo/input &&
+	git -C repo show-ref -d Vtag &&
 	background_import_still_running
 '
 

-- 
2.56.GIT

