Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761983769FB
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781300966; cv=none; b=ZAAajjflf+1VkdqAybd27XzzNp9Tc3sxCyg0rVOypFfmrSS1eJkgu4I3qpZej7u8Ub8iFgCB3DC+yelNInIlLe2RhCOI3C+jozIh8B0h+zWoid0QQsR5eHTWsR0l8m6ZvaCbogzBVRhyB34+Wu5Uf++MoICL7zYPFg3tOhk9sSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781300966; c=relaxed/simple;
	bh=8vgd1f3gP2qoZMIBEy9sFLyHwPQmKCNNXnor81sNcFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwEn/0LTjWyOSYKn3HMWnxo29a7fYQ+UX9e/RYHb0RCrwSDtjuadRfDkqyD0TcVhljKQgB2g6IzJQXuWWWhhzP4hKKlz8QtKZSropdm+BTkKnJzerNv3LK7Q0fA/eCGKI8B6V3xb+4lzDQ/RsQ0fH0FrRJsZ/jkXJbFOXtpJAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekhk4pqS; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekhk4pqS"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ce9df31840so12349606d6.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781300964; x=1781905764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeR6/nR2RXsGYfxr3yfNj529hTJRV/AKvHPgfkDhyQw=;
        b=Ekhk4pqSFJfoEfHxoK7k/yzfEeqNsysej6LcvTZsrcrEzl3NahSWhp6jyxAqID4hpw
         ZRBl2ZGEYxiiHHf6bfpdCSQUzO9JPWi7PrE9rPSbJgltN9rNiaNy2EwgXgoKhiDIs/qt
         w2fMcbsP0EeLw8gd1wZ5dSVE+h7cE6qcBQqLjIsT1P0P3JOOx6ErVdBhmhMuDt8GAP/j
         8rwqMRAzkYAgUiPE9vjyOzRhfl8BQXI7wCs9pVrDbkt7aWWmruMC+fs9igF4+lo/VjdG
         tESYRNEyaL4D0wIOJHzBlwFK+9s7NeLtYme/V4w91V+XwTGUuF0nDqfVC9gNJWRATAwK
         TaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300964; x=1781905764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oeR6/nR2RXsGYfxr3yfNj529hTJRV/AKvHPgfkDhyQw=;
        b=W2ZEsS0NFkF5d/c11mLKSmWyeNbakCqbZUF5yYwEnW5ce1s//08t0yNMENIdSubTiK
         jx2oCHssHHHNlQ9wj4xeIvRUVnU6TlpuikR+UgGtEl49gK8wWqyx73EeD9VLlnb5SDpl
         NK1E4BPq7FA+3klbG2zzJlOsTVNSocrzbZaOdbFGZE35/KULa7q9hIZGSw+Ki5i7+y0E
         A7Wx1ETVNts8tJ+qTpPWMo9+TRIDcingi+mBWU5tAH8lT7iBRzvpB/Tw2GHccV789PsB
         XGkXYmFIwEhnkJsNdOvQ+EqnyehS1mhvOMqesPqJcvsGAz3bW+hlcrxxFIn/3ua/grc3
         KTgA==
X-Gm-Message-State: AOJu0Yy6Bv7RL7h/R84On8CigFpfrnHEyjpjwWGn3tCM58x2idF6aoeS
	8Eq4WUPJVxfKtU3x7/zfh+FX9Y2sgY2glxgAZdaMh2fCZMZR6o66y9353lbA2CDw
X-Gm-Gg: Acq92OElOUA3mcoOyfyOQQNC9oGnSGxCXw8kfzhdvRFp84DPdH0IayK51i5/wrZ5Hb2
	Hmn3hY9UW/buXIRBkwJtReYwwNKWkBdTWJT5/EdNWSVq0NDBqb65Ihljv+neZEr708CnrthjuvP
	kcbKfMBE+7fNsqWggu8OXopU+iGoVZV70JCJmXO7i4crTZnYXAegwWReKNgy3G8ofa1sqmEj7u8
	pbpJyNY6TiVc0ftx3I/fX0gsI3Wjg1TShpVYDtOM3w+qncENs9wex/N0UUMBcU6JLCbwG+VnRuj
	v9Z+GERxq1Fd5RQk2saDZ/QR/8FFwLgEX3JQsoB3RXpGN2rsmq0qYn3vz0EseNUnkxtaqyveR2e
	df45H4NUS3pm+un3/mwYeG8dLfLRc03zzTQK8YQXTC34paAsofx9Arp8HaAaEG6Zr3b/ATkO57O
	wxKk+p3/JInnYyQsNbetS+EVQtaop9B5Fn8oVrIYtc2AXQMxlpSMKpk04arexrBfsuDVRzYaSpr
	FhcXjPMG0wOjgXpAEW5xGTXZKiR5wQSrGZUWXBar1pkLSm3vDIxCsGexEtflGkdlFK5jCu6HpXQ
	Goo2O8iG44D+tyCAYX2cB6+mf6MUzzBny7RJ9S8ptfNjjaAdLS1PQTEKfqx+GZk9
X-Received: by 2002:a05:6214:4a86:b0:8ce:d68f:6723 with SMTP id 6a1803df08f44-8d32d8565d4mr87016186d6.28.1781300964264;
        Fri, 12 Jun 2026 14:49:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:980:d7de:1287:a424])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302114676sm36593136d6.20.2026.06.12.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:49:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 12 Jun 2026 17:49:14 -0400
Subject: [PATCH v4 3/3] commit-reach: die on contains walk errors
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ref-filter-memoized-contains-v4-3-5ed39fd001dd@gmail.com>
References: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
In-Reply-To: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781300957; l=2789;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=8vgd1f3gP2qoZMIBEy9sFLyHwPQmKCNNXnor81sNcFA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOQEv511c3dcXlbDxzc41aKv366NQy6RW9YLklPql5lr4yt4zcEjW6oxaGdIf2QQk0/0w2gYPds
 I/peCZqBb4wU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Without generation numbers, repo_is_descendant_of() can return -1 when
it cannot read commit ancestry. commit_contains() exposes that result
through a Boolean interface, so ref-filter treats it as true. This can
include a ref for --contains or exclude it for --no-contains without
failing the command.

Die when repo_is_descendant_of() reports an error. The memoized walk
already dies when it cannot parse a commit, so callers of the
non-memoized path no longer turn a failed walk into a match.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c                 |  8 +++++++-
 t/t6301-for-each-ref-errors.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index 18fcd69113..37b66b6b21 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -805,10 +805,16 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache)
 {
+	int result;
+
 	if (filter->with_commit_tag_algo ||
 	    generation_numbers_enabled(the_repository))
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
-	return repo_is_descendant_of(the_repository, commit, list);
+
+	result = repo_is_descendant_of(the_repository, commit, list);
+	if (result < 0)
+		die(_("failed to check reachability"));
+	return result;
 }
 
 int can_all_from_reach_with_flag(struct object_array *from,
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index e06feb06e9..72b27c8be3 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -52,6 +52,28 @@ test_expect_success 'Missing objects are reported correctly' '
 	test_must_be_empty brief-err
 '
 
+test_expect_success 'missing ancestors are reported by contains filters' '
+	test_when_finished "git update-ref -d refs/heads/missing-parent" &&
+	{
+		echo "tree $(git rev-parse HEAD^{tree})" &&
+		echo "parent $MISSING" &&
+		git cat-file commit HEAD |
+			sed -n -e "/^author /p" -e "/^committer /p" &&
+		echo &&
+		echo "missing parent"
+	} >commit &&
+	broken=$(git hash-object -t commit -w commit) &&
+	git update-ref refs/heads/missing-parent "$broken" &&
+	for option in --contains --no-contains
+	do
+		test_must_fail git for-each-ref "$option=HEAD" \
+			refs/heads/missing-parent >out 2>err &&
+		test_must_be_empty out &&
+		test_grep "parse commit $MISSING" err ||
+		return 1
+	done
+'
+
 test_expect_success 'ahead-behind requires an argument' '
 	test_must_fail git for-each-ref \
 		--format="%(ahead-behind)" 2>err &&

-- 
2.54.0.548.gbe7bb2469c

