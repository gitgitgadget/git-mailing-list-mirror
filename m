Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B814C58C
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550234; cv=none; b=Drcrf/NSRI/y9OxIhCZ07rJJqXw9uLbdog0LPRmac9mabTboHbILLMK0gvjCJOLqeqeJI/Ag9WO8/OSiM4qm+Bw+NhbqgGj/k9eFN4D6VVEylunyOxGLl39UxvlMVZ+URKq4z+EByGnwoDpKXjbFUPOGozmxxqPbXtRRQo8A7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550234; c=relaxed/simple;
	bh=jgBi6oNQL+qdRE7utMh8FfsQo+FyxbRlKAjlGaLSrHE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TQzU+W2IZ7R4YBhytdhXuG40AtiiSxM7TZ9SKtUccpUPrbktJwAnvlm0ZS0OUjNGDBmC2+l00eAxQgsJhZAB3UvW6z7WLsNOVFeyt30Q7v3hTMJ2u1/PU38pDIuvCau+BunUT8FBVHWVZ/QQu3je9omVcNhmQPo8hy+NzbGwhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYTpTX05; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYTpTX05"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367990aaef3so3902722f8f.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722550231; x=1723155031; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56hSNiOlt1LylH+n3beA4JrC5B+sMVlxoMQsGPznpV4=;
        b=aYTpTX05GQuNu/+GeO2Y5UFgdUwSVab1GncHRGO2Wk5uvy5u+FdWJh/kOu5j6cmRp3
         hipDRqr6CSQK1eK+sL0Yz62CsBSFelK2YUrxINyxsnD5zJFW6rfsBv4dEBBL7eXHI43o
         CWn0pCzfdfyyAQUYHEaqUhQnYfwhhxSHt0zDaMsUxZmLUY+sQfZ2B806y6H6DLwEUZDV
         zyFwMcJlZetLrFu47xQGIzYkjNA+PdMNxtDg+0DCqfe27VKbMWbe/Us2mRsNPX0nKFyD
         UnC9E0b5KDyLkmU6t1LGoySCoQ6FgBm12cH+Rptwb9eYIxFl2/ztW8VYKwR4VUpBxKBG
         iibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722550231; x=1723155031;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56hSNiOlt1LylH+n3beA4JrC5B+sMVlxoMQsGPznpV4=;
        b=Ityl50P6EOv4gW/AsV/e9GYiNhro18NSHsae/W1SCRneTy80HEopJyhVgtwOtGipjq
         OjWb0lsJultUiH99o2wmCzBW20FiabwZCe1ZUOlJ51P5PO5Ygwzh5FHGINxkd1Gtkci6
         35WisAr+DklBPXbEE7dSoa3ZakGzj4LFRDpYgF5tM8uJW13gZ7NKtEYunbbvVq1WIhar
         hgL4mYKXlNB/byaizG8zNGMJMvutCCzL55DqocOC0bxYlAv9xAhS///sH4zJnFWx2gDw
         wFbKv9CgO3Ed8zE/O2of4gZdXAviYWkayAG9eNj8SDCW86QXCYm9ImTe1ZWT9RYi13pZ
         EVoA==
X-Gm-Message-State: AOJu0YzDWBP6g1sezVvXP0AXSNx4N596N9vN4NDY1XuMMGilIgl71C5f
	Ef9xfTn+I7ezb0QVfjwiuJDYxapwTJQnOLd8m2qopjbgLQvlDfwgfeneQQ==
X-Google-Smtp-Source: AGHT+IGY5TGGKVbCVuoEWk9uPPobRgEDFBMij2FHZ/PSBEud5Q1EBeHFBzFw8lX8X/TeNLUYWce/OQ==
X-Received: by 2002:a05:6000:2c6:b0:368:4da3:a3ac with SMTP id ffacd0b85a97d-36bbc16313bmr771078f8f.40.1722550230542;
        Thu, 01 Aug 2024 15:10:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd02a451sm500302f8f.63.2024.08.01.15.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:10:29 -0700 (PDT)
Message-Id: <db87434e146df2228529dc967bdd2e8f34c59f72.1722550226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 22:10:26 +0000
Subject: [PATCH 3/3] p1500: add is-base performance tests
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous two changes introduced a commit walking heuristic for finding
the most likely base branch for a given source. This algorithm walks
first-parent histories until reaching a collision.

This walk _should_ be very fast. Exceptions include cases where a
commit-graph file does not exist, leading to a full walk of all reachable
commits to compute generation numbers, or a case where no collision in the
first-parent history exists, leading to a walk of all first-parent history
to the root commits.

The p1500 test script guarantees a complete commit-graph file during its
setup, so we will not test that scenario. Do create a new root commit in an
effort to test the scenario of parallel first-parent histories.

Even with the extra root commit, these tests take no longer than 0.02
seconds on my machine for the Git repository. However, the results are
slightly more interesting in a copy of the Linux kernel repository:

Test
---------------------------------------------------------------
1500.2: ahead-behind counts: git for-each-ref              0.12
1500.3: ahead-behind counts: git branch                    0.12
1500.4: ahead-behind counts: git tag                       0.12
1500.5: contains: git for-each-ref --merged                0.04
1500.6: contains: git branch --merged                      0.04
1500.7: contains: git tag --merged                         0.04
1500.8: is-base check: test-tool reach (refs)              0.03
1500.9: is-base check: test-tool reach (tags)              0.03
1500.10: is-base check: git for-each-ref                   0.03
1500.11: is-base check: git for-each-ref (disjoint-base)   0.07

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p1500-graph-walks.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index e14e7620cce..5b23ce5db93 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -20,6 +20,21 @@ test_expect_success 'setup' '
 		echo tag-$ref ||
 		return 1
 	done >tags &&
+
+	echo "A:HEAD" >test-tool-refs &&
+	for line in $(cat refs)
+	do
+		echo "X:$line" >>test-tool-refs || return 1
+	done &&
+	echo "A:HEAD" >test-tool-tags &&
+	for line in $(cat tags)
+	do
+		echo "X:$line" >>test-tool-tags || return 1
+	done &&
+
+	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
+	git update-ref refs/heads/disjoint-base $commit &&
+
 	git commit-graph write --reachable
 '
 
@@ -47,4 +62,20 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'is-base check: test-tool reach (refs)' '
+	test-tool reach get_branch_base_for_tip <test-tool-refs
+'
+
+test_perf 'is-base check: test-tool reach (tags)' '
+	test-tool reach get_branch_base_for_tip <test-tool-tags
+'
+
+test_perf 'is-base check: git for-each-ref' '
+	git for-each-ref --format="%(is-base:HEAD)" --stdin <refs
+'
+
+test_perf 'is-base check: git for-each-ref (disjoint-base)' '
+	git for-each-ref --format="%(is-base:refs/heads/disjoint-base)" --stdin <refs
+'
+
 test_done
-- 
gitgitgadget
