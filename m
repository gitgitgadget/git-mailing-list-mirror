Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621430C366
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781233236; cv=none; b=A1rgx2HC8vlRFZED9YaPyKJ/wyg/wzuJTacYiyAV11HMKPb7eXyCUM4liVV+igyaMR1Lo1JB3aJkWXQWyI8mvMQswKj9rp3xnWYARY53twwhJ0SXgmcypQ0KuVcqgOPaycFG/zmxOeIEuE4ihjU0YplizRE4A1oNzq9GFnq8BVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781233236; c=relaxed/simple;
	bh=ROY8ddNfPvnm3KPkyg0haD0LjZYu8OoXNSkfTZyHA44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikAP+cKx7ZonAAU9/QjAtItu5AHuAS5VlwIjXd7RGdPUqhNUwPKsqJ4uPm5/aP5fVYRqxOKYVOByzShIzVf8xkzSoBd+P+dIdTAlO9lWXPOlp1BSFUVNe/8VfZ/hX4weKCCc7+JhVF9BsTbsLWR9914r1EjeDNmETy+/UZ1MSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJLKzXMV; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJLKzXMV"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso425572fac.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781233230; x=1781838030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL4HFL47NVTgGxT7H6Crt4kxYdqmBkHDKXGvyDURVhg=;
        b=ZJLKzXMVHYu4htlhAqEMAnN/mmguV+ntpBIgsBkG7CK7e1DCqyIbBVJfvz6LMug94p
         i74+++IJq9obveV96lgkscXPjPwQe340fRkCsMIzaOflMsNXpch6JUq/tnFwedrsPlJn
         P9afCoTpp3YYZAfjaUD3+UC4SCXFbGAnxoGfafQ4fv2BYOUBDZQuUdOHkHkctf94EwLJ
         XnmoxYFCOTocTRA8GGcnklr11j10VCCjTzAe3SJRhhBjZnbztGxmj3YCFuPBk1qo/7Zh
         blX5Bx/XB6qobhqPkdyOjahu7/Kvm/Ac0OUVo3xBwwFbgVnUERX/pBC7mNwK3SqQH2Ig
         fh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781233230; x=1781838030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vL4HFL47NVTgGxT7H6Crt4kxYdqmBkHDKXGvyDURVhg=;
        b=leyzYHhw0EQLw7zoQ4scDTod2UhWt7ZTkAfV7rHU6JUlWd0lC8NoONzh9lnBAmGjUJ
         euuRRlowij+1kG1/M6CIvu0FA8W7dl+YtYfokBOLJJPyz9Ig6nFIlExNDymBchhYWpdz
         0n8yJi3R2L10nw9HJM3oBMflJQktr7ybi/R+YCDRW+wFr8NnWOhnslOJbSulhkVRSffZ
         DAKuwtWYPflzB9Z9Yf1Ep1mshC18V8RA6oEpfERrgOJzGK/PymeLagucZWJu5ysadXtf
         cNtMFPozSbQuRhdX4kl/LTLx88DBqyLJymjML4BuIACLbkxbMttzycEl7Gc2Pt0EVpmV
         jISw==
X-Gm-Message-State: AOJu0YyIUTfOSqm5oj/DBjME5wnhjIzWOcZAYnFvYdOyvu307QdC60IQ
	9rG37kwgJpyVTY8Ja22b4ggZJMYoHSg1d9334zhUshNwESeFYbrnCKsL
X-Gm-Gg: Acq92OEeP05DNJ4GnzRlpC+4+DY3EAjY6XXlbEqHpX0O0zX6E/wOVBcTMb7XH/FBMUX
	1T1B2YW4ou6iF7rISpoEw73vCaSJSjRsT/77UxkNHb8u5Yp0lpmIkZlmXfe3hs7hfgM96y3Vcsn
	Pt7ABfxzYGn63dcjbMMaxSodu22juouhg0mNK0Zt4jichN8hdeG+GQugF5iIoVrM7l2p4zLoADL
	SbZFYS77ksJMcXO07kn3h/cTYCxwQNEgKzUsQ0PkNG8Fr8pdYJhY+0koy64gbxXO5oJXEsthUbS
	+CQ92jJH2ZcisZxKFdrT6f/Tqe5VIxNGPzLVV7zOWdq6NzIV/T4sIcBnQFUwpk4kzMgRgVxZfxj
	a+X543XS7VOETrL8YwHdEpuPywTF8gMtjGMCN/0p7hx/4ulxqYz5IBCdr8D86jZGCGXIcIF2eWJ
	SIM6Kjs2y9vum/nvnL/QSEAAaofrvEUQi4hpl4XEjCEEo6lEiS/2Jdkxnj9g98I3REaelAelCmR
	d1ob+8Xm2kUCaWQA9DVoMLBc13YULu9rk2veSFD4y+LmIQeaxAOqSzqUtQMuNHaHMHGjFQ5S+s9
	TuBvslFMJRrSiY22bIT7MMyno++2omvl9LWQE8tF2pyLfvLpXwwP
X-Received: by 2002:a05:6820:626:b0:69e:8bbb:78f8 with SMTP id 006d021491bc7-69edc5f9b80mr701956eaf.5.1781233230360;
        Thu, 11 Jun 2026 20:00:30 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.237.239.3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abe97c4sm702031fac.7.2026.06.11.20.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:00:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 20:00:15 -0700
Subject: [PATCH v3 3/3] commit-reach: die on contains walk errors
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ref-filter-memoized-contains-v3-3-b26af3dba285@gmail.com>
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
In-Reply-To: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781233218; l=2871;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ROY8ddNfPvnm3KPkyg0haD0LjZYu8OoXNSkfTZyHA44=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPfGDPxdaLbUQ3OBgsWjLrKsdGo3RwnrDCYHcjvkDkTzqGX4xfIZoH4YrwhtuPHARMGGZJAxg6I
 1K+nQYMxk8Qk=
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
Link: https://lore.kernel.org/r/20260611072942.GG2191159@coredump.intra.peff.net
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c                 |  8 +++++++-
 t/t6301-for-each-ref-errors.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index 572d2d47ff..af5563d70f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -820,10 +820,16 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
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

