Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDB1DE8AD
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865820; cv=none; b=fHdEtRvY2sHbZ4njv84vBoRECFhKEGSjzIQjWaXQXZxsElvLMMJ08DnPVl1HzXZwmN4juxHoBW6aIPdD/BEpTwGnAfCZ6JLJIBLMLABqZyo48RhfOUvoHsDWqQ16a6l5JN7EDRMQamnhzxI6ywWIxJJPfA5mh9kM9RtEha/eeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865820; c=relaxed/simple;
	bh=51CG+xoriPW2aODibvIHCW0x72P7ADIzkFMwiwTYxM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YbL1ASQUY/ExEWrwie8/sr1uH2NDH0P9M+1cYio3/XLBkYm07GbWK0//d0jdmt+7QO0TQDjilXn5bmmDX/urZ/EX1oKEr1mYJkNP5Qve/PkgeUd+cGzyBx+CsGCz+WFPCOojvmc9J4D8DaESDS7wwxZT2fxfvLJ5TgnVt8K2T/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLZO46Jc; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLZO46Jc"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30759632453so4755689eec.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780865818; x=1781470618; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0rvZ2A+IaQcsVUwJBREeJE5iAGPe68oCSWjnY5m06U=;
        b=fLZO46JcsIaSeJQMeoSx46KEo/3H227d2wzYE1CluXR47T1fWprGudVofsJmBJltOk
         puB3tGm4B+eMVK5nFlPAVk0uR/HIdG304wh6DlzCvpsX0dGl4EjGnX09fQKd0GtdO+QU
         LgQzJpBdgSJ0bv64Dwh9XuUIk6NplqQE0ipowbaKqyYpTMXQrcxjYOtTgk74SzeC76ts
         RPGJCqC8hYi7uj+SGwofgdfR2z3BSFyTMlzLwwS8S+IgoRQlAXB3ZWLetnv/ZgoBwqgU
         a0Zi/STy2plBAXkGpcJ+aX+ZTvTtzGORiMdJRs29/vRObT0KTIwxylx6MtgsrIk8ArYa
         1xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865818; x=1781470618;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0rvZ2A+IaQcsVUwJBREeJE5iAGPe68oCSWjnY5m06U=;
        b=kdEkCMsP/OjOkmfdPEIpwTjQCacEgazNvoZNui0jGKwdkumfwF+m68MkHFBWqd+RlS
         OUVDrgbXvIB1xs4uEZP5fFbUKeZVqJtM+ZdLPbJlRxp2UsKdxh0FvGcMLT08Lo26UtiB
         n9e8P+J8zcTa3lGedA2B0IItriLxdvXJ55mZd2+Uekm/JTY0OaX4qqIsI5OwvTU68CWR
         cQ83UrY4Hr4j9BD2/XqtDl5GI5RJB1/YWYQ8+q6lfBjcA02D/mSQLopxcY5xGzHljkk+
         qmVkqSCG/m5eqw9erC+q/nkuOtWFDXYZkgQ+Z0zGk5hR6uHDJwMLeBcmr7FtcDK5GULZ
         hMRQ==
X-Gm-Message-State: AOJu0YzM3Ge7bn0UcQyoJ+UzFrxAXMJoC1GApFlQ6gQ18+3yfOvauQOy
	3vLT7TqCiOl++GMzEgKlSZGWeqtQkx+7WyhByuLWFx4UM8Q+ccbZjv2d
X-Gm-Gg: Acq92OGBTyGzIjA0UK/Is7x7z8frhmcuwVxwzRW3zBS5Hvfb108ZOPtKoDZBN2jF0hd
	+e7JQzJbNb2Wb/skxwvFaf5TANzXvrfXIlufyN6RyUU+4r2QAXkMIcKbWXCFiJjSz9BHI33WGCA
	sLKxYMctagikgUaOyiHK6uVhC49nd/LtiGxPrZdqARlJsOzf6aRRlwl5gydRgexDFNJjUAGjTVS
	EFXn7WK2b1eu1PltnVGdJobVZIhPkKejmj2RgvroR52PCEVDiskd6G1G+OUeoAf+XqGNbcp+foS
	/BuA+0adXsksMhC82KbV5rqrR//jSt2tkMhfsbf4C/0mV+W6VEGtC+C9ydyBVQWSs0lvExlOxjA
	dB+sFXMTOz/KWOZNm2GFWm/H0PYKo0SqtTtL11E/pt38tFizISYv/nBSnUnvWwoqYp4RYfCe4eH
	cCliiDwSYlXFziac/djve6iwjzCKpZg7mW5TfYnZfE4uLsIVzq9xNodN0CeokLko4PA6effIzTQ
	QQM//30tdIYqSszMoLFur59sW47dVKlZdhA/HN4Uu7UuqRqYlnBpXunNeLOURqip3F0i9A+FhQX
	PVx9e3NZVr/1R31mb+ip3Nj7Ru45XA==
X-Received: by 2002:a05:7300:4347:b0:2ed:7e1:975 with SMTP id 5a478bee46e88-3077ae6fe7cmr7178873eec.1.1780865817846;
        Sun, 07 Jun 2026 13:56:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([99.196.128.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm21796310eec.21.2026.06.07.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:56:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 07 Jun 2026 16:51:53 -0400
Subject: [PATCH] describe: limit default ref iteration to tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQBBE0atIr21oJWrwKuJinKmYzkJlWkNAv
 HtGXT6K+jsZosKozXaK+KrpPCUUeUb+7aYRrCGZSilrqaXhAPNRB/DqRo54sfl5ATdBxKF4iKu
 elM5LmvR3hbv+tm3DB349a3Qcf0Cea/96AAAA
X-Change-ID: 20260607-describe-tag-ref-scope-7d00ae140a58
To: git@vger.kernel.org
Cc: "Shawn O. Pearce" <spearce@spearce.org>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780865530; l=3164;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=51CG+xoriPW2aODibvIHCW0x72P7ADIzkFMwiwTYxM8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG0JKdk/FSfjwaE/IQAuRCYjpsCS78mKQfrU6A0PzY+Lh+d7lWuq+VAkZzASdu+tkczipkm8/jR
 12/VhpF8hTgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Unless --all is given, get_name() rejects every ref outside refs/tags/.
The rejection happens only after the ref backend has enumerated the ref,
so repositories with many other refs spend most of a simple describe
invocation visiting refs which cannot affect its result.

Commit 8a5a1884e9 (Avoid accessing non-tag refs in git-describe unless
--all is requested, 2008-02-24) moved this rejection before object
lookup, but left iteration unscoped. Pass the existing refs/tags/
restriction to the iterator unless --all is given so the backend can
avoid unrelated refs.

On a checkout with 124,357 refs, of which 330 were tags, I ran the
following command with the parent and patched binaries:

    hyperfine --warmup 3 --runs 15 \
        'git describe --always --long --abbrev=40 HEAD'

The results were:

             parent       this commit
  elapsed    196.2 ms      63.3 ms
  user        69.5 ms      48.0 ms
  system     123.0 ms      12.0 ms

The wall-time standard deviations were 13.2 ms and 2.6 ms, respectively,
for a 3.10x speedup.

Both revisions were built with -O3, -mcpu=native, and ThinLTO using
Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
(Mac16,6) with a 16-core Apple M4 Max (12 performance and four
efficiency cores) and 128 GB RAM.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 builtin/describe.c       |  3 +++
 t/perf/p6100-describe.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7..3532c8ff22 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -740,6 +740,9 @@ int cmd_describe(int argc,
 		return ret;
 	}
 
+	if (!all)
+		for_each_ref_opts.prefix = "refs/tags/";
+
 	hashmap_init(&names, commit_name_neq, NULL, 0);
 	refs_for_each_ref_ext(get_main_ref_store(the_repository),
 			      get_name, NULL, &for_each_ref_opts);
diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
index 069f91ce49..dfcaf59e90 100755
--- a/t/perf/p6100-describe.sh
+++ b/t/perf/p6100-describe.sh
@@ -5,6 +5,12 @@ test_description='performance of git-describe'
 
 test_perf_default_repo
 
+test_lazy_prereq PERF_REFFILES '
+	test "$(git rev-parse --show-ref-format)" = files
+'
+
+ref_count=10000
+
 # clear out old tags and give us a known state
 test_expect_success 'set up tags' '
 	git for-each-ref --format="delete %(refname)" refs/tags >to-delete &&
@@ -27,4 +33,18 @@ test_perf 'describe HEAD with one tag' '
 	git describe --match=new HEAD
 '
 
+test_expect_success PERF_REFFILES 'set up many unrelated refs' '
+	git tag -m tip tip HEAD &&
+	for i in $(test_seq $ref_count)
+	do
+		printf "create refs/heads/describe-perf/%05d HEAD\n" $i ||
+		return 1
+	done >instructions &&
+	git update-ref --stdin <instructions
+'
+
+test_perf 'describe exact tag with many loose refs' --prereq PERF_REFFILES '
+	git describe --exact-match HEAD
+'
+
 test_done

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-describe-tag-ref-scope-7d00ae140a58

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

