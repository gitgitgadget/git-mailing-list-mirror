Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9F2253EB
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637888; cv=none; b=ofp1OCOdDClP3rFTQEiI+J3ZtUC3wjd1VBcr+6LI21cTQ7hrvcC4Nc4ut3RX5PLWQ8rGr+q9WCvc9QDWKuQR+nosh2yQbqP1XGH90zPCjtT4/CmSEwsDn78qqAuu0LThFtYxOQXwIq20FZJilq3PGw1zu0gj8LAPJ3hURvEWAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637888; c=relaxed/simple;
	bh=eCa8OR7jJHTX6m9+TMgAMiSnzxnq9NQfgxn99PMYlF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBWyVI3m/gatCsMlw3w0s5TFi7tSK/OYVmXujjioMrNWu0NFy6qHl3FVJqss0AvSyUjmmBLVHdolL+DtXCyjKxAc4gXLgppEKcvtxYbm0SgiQTECBwfY4/4KFK515r2w6hfC6YIEp2EsEHQL1pYB9phuwhRGnbvIt4+yiZbh9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYx1eIkY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYx1eIkY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24286ed452fso2551935ad.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637885; x=1755242685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3csa9H+Ah/LSr0jg/EGL014a8zJtNCHtcGbuJg0U5E=;
        b=bYx1eIkYjCMKOewM1mnYAwKUMTp7JkJx2XRQ5yF0F8pNQSzALXe42nDK3zxS45wLh8
         LUtPIqUUR2wxna4zYLWvNnc0Ol3vdL5CrPyN/5/3RF1aPInW14b1T5hC/2Ml3/jU2qpF
         TtQuDsLn0qeAiLBQpD3MqVPvSpMvzluYUS4JDsX9c6hlnbUEYeFYBXA0jR6oBRo35zSn
         nN+juEpteGVXlqo9U+6kG9jzxaFaC5y4OY1oQDZ/QL91+bJ3kVSkxdqwSuyp+TAJunQ2
         bBV76Wu9JbR46t7ONhGmL/uGXWOYmxctkXIlVYn45Gr/s5FovTiei2wsNZKisONCD3em
         QF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637885; x=1755242685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3csa9H+Ah/LSr0jg/EGL014a8zJtNCHtcGbuJg0U5E=;
        b=frcZecUhcrO51YZY6rb5XX48sUEBm70OwqruL1itIPCxZKxbODZxNKSaXU1IHOf0Pf
         YWT9wuCNzgEQAfi/gtSwD56/innN7h0/Eg7pWwzC0NCdr5GO+QfeD2WuW9BMOdm7kxKr
         MysByt1KhmquGqOWYIqiCR5tmEZxGHFTNpIRfsjG1AcRwWbUma9hLPxdA9uW/9kyjW+l
         M0cJcoMGzm9aBaj6PmoSm7eMg0A/TzfhX1j0nTdcwTBmPPDMURDhVVUkGhYUDXKMHj/I
         kK10d9CdLQnh5bzf5V5YAxZ1CGOrOpEj7EDRv4FobMvlATwYGQEX8QU/UB2mNVYu7efc
         4bww==
X-Gm-Message-State: AOJu0YwBVehQJGz/H5/qagJ5Sa05Zvobsoqqq6G5eJ4YAcAaC9NjjQSP
	wo6xVWgBEqLDbAtx3ma5heuolWWr9WpGo7JE/3Jqb5xZ9mJCynvRF5KbC/dDAQ==
X-Gm-Gg: ASbGncvZYnhwMGHGy1t1HcAo/jxQejgdStVok4xmDOAGsDy/njRIQnOYLvlrBpQoAWe
	kPhQLZz9XKgZ6NWzUTBJOlr7YWuok5BMajc+O+Wch3HHrESQtAODefbKrm5ini/EHHODa3jlOXr
	VM1x5Rb2owte0HT7PCrEAEzvR7edKwDtkafIGxnSS+OEKeCjU+E6iqILzIMvKxKHsOx84XG7Y2n
	fKestkSAomWXvCAIvoPMBvmq9Zexnq8v1nwL8BCR4cUzyyQynnHAuCrp3wvdzvw0TmzKix9/qt9
	/5r2GiQYoC65aC0U9vnzDprSVBV7Wcuf3boimMApVJkFqKPhKXIc0r+qnpYnATXlvywJiEuzpGx
	W3U30uubDLMFRBnCzo0/M1HY7wHwyVw==
X-Google-Smtp-Source: AGHT+IE7HNqAgcs+jUDBJL1FHGiLTstRAWAJex+j6O5E+RT+bHCSLO9QzSsqeHLQoUpnejR2Db4kCg==
X-Received: by 2002:a17:903:120f:b0:240:725d:dd66 with SMTP id d9443c01a7336-242c23549f3mr15407755ad.11.1754637884992;
        Fri, 08 Aug 2025 00:24:44 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f53sm204107445ad.113.2025.08.08.00.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:24:44 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:24:42 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/3] t5516: remove surrounding empty lines in test bodies
Message-ID: <d31f320fdbb375cda9365df501e9b684ee84360c.1754637850.git.liu.denton@gmail.com>
References: <cover.1754627874.git.liu.denton@gmail.com>
 <cover.1754637849.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754637849.git.liu.denton@gmail.com>

This style with the empty lines in test bodies was from when the test
suite was being developed. Remove the empty lines to match the modern
test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5516-fetch-push.sh | 51 -------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4e9c27b0f2..8eddf3e40d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -105,7 +105,6 @@ check_push_result () {
 }
 
 test_expect_success setup '
-
 	>path1 &&
 	git add path1 &&
 	test_tick &&
@@ -117,7 +116,6 @@ test_expect_success setup '
 	test_tick &&
 	git commit -a -m second &&
 	the_commit=$(git show-ref -s --verify refs/heads/main)
-
 '
 
 for cmd in push fetch
@@ -322,104 +320,82 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 '
 
 test_expect_success 'push with matching heads' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	check_push_result testrepo $the_commit heads/main
-
 '
 
 test_expect_success 'push with matching heads on the command line' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	check_push_result testrepo $the_commit heads/main
-
 '
 
 test_expect_success 'failed (non-fast-forward) push with matching heads' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	test_must_fail git push testrepo &&
 	check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
-
 '
 
 test_expect_success 'push --force with matching heads' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push --force testrepo : &&
 	! check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
-
 '
 
 test_expect_success 'push with matching heads and forced update' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push testrepo +: &&
 	! check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
-
 '
 
 test_expect_success 'push with no ambiguity (1)' '
-
 	mk_test testrepo heads/main &&
 	git push testrepo main:main &&
 	check_push_result testrepo $the_commit heads/main
-
 '
 
 test_expect_success 'push with no ambiguity (2)' '
-
 	mk_test testrepo remotes/origin/main &&
 	git push testrepo main:origin/main &&
 	check_push_result testrepo $the_commit remotes/origin/main
-
 '
 
 test_expect_success 'push with colon-less refspec, no ambiguity' '
-
 	mk_test testrepo heads/main heads/t/main &&
 	git branch -f t/main main &&
 	git push testrepo main &&
 	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit heads/t/main
-
 '
 
 test_expect_success 'push with weak ambiguity (1)' '
-
 	mk_test testrepo heads/main remotes/origin/main &&
 	git push testrepo main:main &&
 	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit remotes/origin/main
-
 '
 
 test_expect_success 'push with weak ambiguity (2)' '
-
 	mk_test testrepo heads/main remotes/origin/main remotes/another/main &&
 	git push testrepo main:main &&
 	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit remotes/origin/main remotes/another/main
-
 '
 
 test_expect_success 'push with ambiguity' '
-
 	mk_test testrepo heads/frotz tags/frotz &&
 	test_must_fail git push testrepo main:frotz &&
 	check_push_result testrepo $the_first_commit heads/frotz tags/frotz
-
 '
 
 test_expect_success 'push with onelevel ref' '
@@ -428,17 +404,14 @@ test_expect_success 'push with onelevel ref' '
 '
 
 test_expect_success 'push with colon-less refspec (1)' '
-
 	mk_test testrepo heads/frotz tags/frotz &&
 	git branch -f frotz main &&
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit heads/frotz &&
 	check_push_result testrepo $the_first_commit tags/frotz
-
 '
 
 test_expect_success 'push with colon-less refspec (2)' '
-
 	mk_test testrepo heads/frotz tags/frotz &&
 	if git show-ref --verify -q refs/heads/frotz
 	then
@@ -448,7 +421,6 @@ test_expect_success 'push with colon-less refspec (2)' '
 	git push -f testrepo frotz &&
 	check_push_result testrepo $the_commit tags/frotz &&
 	check_push_result testrepo $the_first_commit heads/frotz
-
 '
 
 test_expect_success 'push with colon-less refspec (3)' '
@@ -465,7 +437,6 @@ test_expect_success 'push with colon-less refspec (3)' '
 '
 
 test_expect_success 'push with colon-less refspec (4)' '
-
 	mk_test testrepo &&
 	if git show-ref --verify -q refs/heads/frotz
 	then
@@ -475,38 +446,29 @@ test_expect_success 'push with colon-less refspec (4)' '
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit tags/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
-
 '
 
 test_expect_success 'push head with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	git push testrepo main:branch &&
 	check_push_result testrepo $the_commit heads/branch
-
 '
 
 test_expect_success 'push tag with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	git tag -f v1.0 &&
 	git push testrepo v1.0:tag &&
 	check_push_result testrepo $the_commit tags/tag
-
 '
 
 test_expect_success 'push oid with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	test_must_fail git push testrepo $(git rev-parse main):foo
-
 '
 
 test_expect_success 'push ref expression with non-existent, incomplete dest' '
-
 	mk_test testrepo &&
 	test_must_fail git push testrepo main^:branch
-
 '
 
 for head in HEAD @
@@ -550,7 +512,6 @@ do
 		git checkout main &&
 		git push testrepo $head:branch &&
 		check_push_result testrepo $the_commit heads/branch
-
 	'
 
 	test_expect_success "push with config remote.*.push = $head" '
@@ -596,7 +557,6 @@ test_expect_success 'push with remote.pushdefault' '
 '
 
 test_expect_success 'push with config remote.*.pushurl' '
-
 	mk_test testrepo heads/main &&
 	git checkout main &&
 	test_config remote.there.url test2repo &&
@@ -655,7 +615,6 @@ test_expect_success 'push ignores "branch." config without subsection' '
 '
 
 test_expect_success 'push with dry-run' '
-
 	mk_test testrepo heads/main &&
 	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/main) &&
 	git push --dry-run testrepo : &&
@@ -663,7 +622,6 @@ test_expect_success 'push with dry-run' '
 '
 
 test_expect_success 'push updates local refs' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	(
@@ -673,11 +631,9 @@ test_expect_success 'push updates local refs' '
 		test $(git rev-parse main) = \
 			$(git rev-parse remotes/origin/main)
 	)
-
 '
 
 test_expect_success 'push updates up-to-date local refs' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
@@ -689,11 +645,9 @@ test_expect_success 'push updates up-to-date local refs' '
 		test $(git rev-parse main) = \
 			$(git rev-parse remotes/origin/main)
 	)
-
 '
 
 test_expect_success 'push preserves up-to-date packed refs' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	(
@@ -701,11 +655,9 @@ test_expect_success 'push preserves up-to-date packed refs' '
 		git push &&
 		! test -f .git/refs/remotes/origin/main
 	)
-
 '
 
 test_expect_success 'push does not update local refs on failure' '
-
 	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
@@ -717,16 +669,13 @@ test_expect_success 'push does not update local refs on failure' '
 		test $(git rev-parse main) != \
 			$(git rev-parse remotes/origin/main)
 	)
-
 '
 
 test_expect_success 'allow deleting an invalid remote ref' '
-
 	mk_test testrepo heads/branch &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/branch &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/branch)
-
 '
 
 test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
-- 
2.50.1

