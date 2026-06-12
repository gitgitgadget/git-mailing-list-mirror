Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBB38D3EC
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299676; cv=none; b=iJNCNCYKljGufu2AGN3kMqlIxRlMT1+qhd1sHZafj/EmZ2spCXbJLMsdRzfSyu0XLWOhK1Bg/L1Az4mFoUIKM8Wx75LgnlQ4C+trXwqzP2syZ+7sAQpbgbeIFnl9GiD8sWQ8azX8UHxz+tiuQdF5BJeypz15e45rUpLOeq0FfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299676; c=relaxed/simple;
	bh=A82zUKjzMbe0XPnzvN0cxzZUMxhc7aGZT0XRQu6Ca/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=upxrLIxucTzJsZXmG0ACEsPvrdCvgApaYXrZkYTbwgLotW0uIRZjjuVRAE/XoPHDFKDV/t8zBIzNJQJ4czdsfHo4HXuHKt7I63nH0dMaCu8XnzQsCXZZ9asLYd7vAL7jCqg3leDaRbiy8nQv71XO+l7I66Q+TTfXPW6k3bcgOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNQ9kp97; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNQ9kp97"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9159da9bba5so109594885a.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781299674; x=1781904474; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kta0PzVJgRTKfdXw+8YJ8cLU1zNocETw+5KXVqbukvc=;
        b=RNQ9kp97aw8SOaTk635E5J0avrQEN4OEZbJa4q5CSWQjHHmFpaM1zv7Qcx8ZZkH7vB
         pAMKln/vjbQxlMHzjRFEu5fV4QgSj8sV7kx0tKdsGuZWiP0QoKp82i2nGEpztCzCpmmU
         Vq5y/xG9kcqgxcjXnt9y4mb2WHZbA/39Kx2phi1IPJUsctp3mp6Mr1SRBmGl0GVCdfdv
         r2ed5gQ6Q1dpGibEnvYmkcf4zIfT9H9qTrSZC4PISHm9a+GKTVrwmypDsn4NNkZIXhdA
         7ysuR2VDEJUfriYG0HCSa22Bvd8Fmb8FDFsKb0nD9lVqWmqxMMzNBHwgFAhqWfKhpdvj
         M85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299674; x=1781904474;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kta0PzVJgRTKfdXw+8YJ8cLU1zNocETw+5KXVqbukvc=;
        b=i1jlQhkJM+yC4KwddFVOVvZpzV2ol6QDP5abIkWGdSvb2yTMHiviME+hVqPABnz5uY
         G4SYbYStol5ShKMCBl8dbZ1637Kcg9d6x6E9t6uTQhHKb8fZUzd9Z4jQMaFfCmSgetUB
         5993mbHdLREPWZpB/UDSXr0T9beFaVGv3flT20mmfvyaNiAoNffY2RJuv5EX2y3GuzFJ
         YufuNy8cLKnReQIMdPlkjh/fNZZolAO6IiVpt7edbDYEjzVcGDb/T00IDo5eRK5Dj3Vg
         nSKY5H6VE5rMoJFyTmtD6A5fjz3frRuKPfjKHYs39wGIDgEe8PBADGPFi4Q6t9eAZCZh
         Ld1Q==
X-Gm-Message-State: AOJu0YwLw0Ov3dVyEpiG0UfwoRGR2m303AXXNzMqEr3Z6sBmPZR0iMVC
	8K0pz69iJB0O+pIuYqVzosK3wZgNMUFMipY6MuQUAqQuwxYJ+vSeA4w/
X-Gm-Gg: Acq92OHYVAgD73KzMmUHazxpy4X83MolwnwUom8K2PQhhhJQVOFKNKfTgUgHw8iPC67
	It499nf021PyTeGoC+gfQ7dH3x9dCfAOYvytP9zGdys2cdEKFPyev+DvpPFvrYKgT9GxTIffuxr
	+oYFMCe5DySI6YrPEjxgyOHM15kf+xgHvAs82cKJEbbcuIOK3vAuGU09V5yCt938tInYJ5j99D2
	fdeTAdn3PGk1haWSvTCVpwcwPrMaS12+tAbHoDZHNc1n7oSCuw+gxPOHUhUeyjNeFRigSyRzWMQ
	DDpAXRQdjvVtYgZJX80ycTKOlDN2FZejBRGaD1GRmtM2J+M/wLM7MI1XCtxfj3PmtTav5Fo3T7P
	tHQGsAY0uu5G90ym15BCRYkHzb7sUL3+puYujKa0Haqi8O34V7s/RZHySBiTpaaoB62yAoiflZX
	2DHEptgXsLkk/lQDGwwUQkwD4PrQufvjRs5wf1UEnUin0DnQQy+6+9es6hqVFrJ5Wh3qmWDyUhM
	1g1or0tc8j+bhiMZhoiQdSqgcl5PSlpFwlpjBTWqP9x7hcYJyt5uun5gSbbkDIcEWdgfd2EI2T7
	V4BIiQPzQ8eQpcGH6//9ZR9X2bfaw84rILc99MRuNOVPWIbRAnpz7pg4JGEZH3ySDRh5/50TOs8
	=
X-Received: by 2002:a05:620a:f0e:b0:915:d322:c465 with SMTP id af79cd13be357-9161bac73dbmr726737385a.6.1781299673905;
        Fri, 12 Jun 2026 14:27:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:980:d7de:1287:a424])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7fb5sm324305685a.6.2026.06.12.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:27:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 12 Jun 2026 17:27:44 -0400
Subject: [PATCH v4] ref-filter: restore prefix-scoped iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-fix-git-branch-regression-v4-1-f150038c02f4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBQE0KuYrq35/RQorryHcVHpL9QomBaJh
 nB3W90QF8TlJDNvJhbIOwpsv5mYp9EF13cxyO2G1a3uGuLOxMwQsIACcm7dkzdu4Gevu7rlnhp
 PIa14RRKzwgoFlWBxf/cUyx/7ePrm8DhfqB4SmBqtC0PvX5/zUaTePz+j4IIDWgnaSKiwOjQ37
 a67ur+x9DPiUlJrEkbJGoVQ5lrlCL9StpAErElZlAprpLLalDrPltI8z2/4lhNYaAEAAA==
X-Change-ID: 20260605-fix-git-branch-regression-9e4236f18091
In-Reply-To: <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com>
References: <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 ZheNing Hu <adlternative@gmail.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781299666; l=5221;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=A82zUKjzMbe0XPnzvN0cxzZUMxhc7aGZT0XRQu6Ca/g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHpGx64YcmDjyKyruIaATN0JcJUh9u+3XWGxZfFh8D4bkcPDPLuDPaUtPAMZaCngsuDTdCjPy5+
 mTsK6s2gqyAI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

dabecb9db2 (for-each-ref: introduce a '--start-after' option,
2025-07-15) changed branch, remote-tracking branch, and tag enumeration
from constructing an iterator with the namespace prefix to constructing
an unscoped iterator and seeking to the prefix.

Review of --start-after noted that the construction prefix and seek
position represent different state and are easy to conflate [1]. It also
noted that future branch or tag support would need to retain the
namespace prefix while moving the cursor [2].

The files backend constructs its loose-ref iterator with cache priming
enabled. cache_ref_iterator_begin() immediately applies the construction
prefix through cache_ref_iterator_set_prefix(), reading loose refs
beneath it before packed refs are opened. An empty prefix therefore
reads every loose ref, and a later seek cannot undo that I/O.

For the current single-kind filters, construct the iterator with the
namespace prefix when start_after is not set. Leave the existing
start_after path unchanged; no current command combines it with these
filters, and future support must carry the prefix separately from the
cursor.

With 10,000 unrelated loose refs in the files backend, the p6300 tests
improve as follows:

                         before   after
  branch                  2.74 s   0.11 s
  branch --remotes        2.81 s   0.12 s
  tag                     3.01 s   0.11 s

[1] https://lore.kernel.org/r/aGZidwwlToWThkn8@pks.im/
[2] https://lore.kernel.org/r/xmqqikjq7s16.fsf@gitster.g/

Fixes: dabecb9db2b2 ("for-each-ref: introduce a '--start-after' option")
Suggested-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
The series is based on a89346e34a (maint) because the regression has
been present in released versions since Git 2.51.0.
---
Changes in v4:
- Explain the historical references in the commit message.
- Run the new performance cases with both ref backends.
- Drop the Assisted-by trailer.
- Link to v3: https://patch.msgid.link/20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com

Changes in v3:
- Construct the iterator directly with the namespace prefix.
- Explain when the files backend primes its loose-ref cache.
- Condense the commit message and performance results.
- Link to v2: https://patch.msgid.link/20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com

Changes in v2:
- Extract local variable `store`.
- Link to v1: https://patch.msgid.link/20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com
---
 ref-filter.c                 | 13 ++++++-------
 t/perf/p6300-for-each-ref.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..9b04e3af85 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3316,15 +3316,14 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
 
 	if (prefix) {
 		struct ref_iterator *iter;
+		struct ref_store *store = get_main_ref_store(the_repository);
 
-		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
-					       "", NULL, 0, 0);
-
-		if (filter->start_after)
+		if (filter->start_after) {
+			iter = refs_ref_iterator_begin(store, "", NULL, 0, 0);
 			ret = start_ref_iterator_after(iter, filter->start_after);
-		else
-			ret = ref_iterator_seek(iter, prefix,
-						REF_ITERATOR_SEEK_SET_PREFIX);
+		} else {
+			iter = refs_ref_iterator_begin(store, prefix, NULL, 0, 0);
+		}
 
 		if (!ret)
 			ret = do_for_each_ref_iterator(iter, fn, cb_data);
diff --git a/t/perf/p6300-for-each-ref.sh b/t/perf/p6300-for-each-ref.sh
index fa7289c752..25ffa5e84c 100755
--- a/t/perf/p6300-for-each-ref.sh
+++ b/t/perf/p6300-for-each-ref.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='performance of for-each-ref'
+test_description='performance of ref-filter users'
 . ./perf-lib.sh
 
 test_perf_fresh_repo
@@ -84,4 +84,41 @@ test_expect_success 'pack refs' '
 '
 run_tests "packed"
 
+test_expect_success 'setup many unrelated refs' '
+	git init scoped &&
+	test_commit -C scoped --no-tag base &&
+	test_seq $ref_count_per_type |
+		sed "s,.*,update refs/custom/unrelated_& HEAD," |
+		git -C scoped update-ref --stdin &&
+	git -C scoped update-ref refs/remotes/origin/main HEAD &&
+	git -C scoped update-ref refs/tags/only HEAD
+'
+
+test_perf "branch (many unrelated refs)" "
+	(
+		cd scoped &&
+		for i in \$(test_seq $test_iteration_count); do
+			git branch --format='%(refname)' >/dev/null
+		done
+	)
+"
+
+test_perf "branch --remotes (many unrelated refs)" "
+	(
+		cd scoped &&
+		for i in \$(test_seq $test_iteration_count); do
+			git branch --remotes --format='%(refname)' >/dev/null
+		done
+	)
+"
+
+test_perf "tag (many unrelated refs)" "
+	(
+		cd scoped &&
+		for i in \$(test_seq $test_iteration_count); do
+			git tag --format='%(refname)' >/dev/null
+		done
+	)
+"
+
 test_done

---
base-commit: a89346e34a937f001e5d397ee62224e3e9852040
change-id: 20260605-fix-git-branch-regression-9e4236f18091

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

