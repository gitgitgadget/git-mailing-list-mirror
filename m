Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA015699F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373318; cv=none; b=SpIHraCj0eBEifzl21I67zvLNdLjx/J38tY0RJBA7dxPXKo9mfeVK9pxzbmKChPX8dYnPqCckrhk0p5/YaiM1CDlwTSerqfU1JUs1NiWil/YPvkR911tJFKGX4c0KDac7kVD8ghXs4KKWW4rkGzat859QAE+TzLQw6ZLsEqGGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373318; c=relaxed/simple;
	bh=fRibx12tZS9Qek6YUYUtNWImhy1QLPrk/xkw+cJ/mVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNmNE8Q8BdRo0nvlxzo/+dMYzMukPQ/wSNfXmdR+IDyhvPmU+v0qyTEjW6KiXkxb7gIt6GeSqPHfWrJoqKE8rI85XBAJQIc6aTCRrBhPeQpGL5DdjCwPfiGZaBmhNXcyfpE+nei69gz/ZBRGYDEQlUJPq5If/8HSKn+w6W1eJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=HRidAdFg; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="HRidAdFg"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PDJIu8003603
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 14:19:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711372759; bh=fRibx12tZS9Qek6YUYUtNWImhy1QLPrk/xkw+cJ/mVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRidAdFgFRvYLUAz6sG35UTZNHsL1GSbNCkvV47JhaGtdK0F/7uONpXPiNE9kJdbI
	 R17HwoqS9jlfxVtWFKo64c1mDQgdXEKLjhrvqoOPFmgb9jS/ZVUlyy9RYQVEJil9vx
	 wfBNmlg5xu4ItMbvXxhcriZuB0FwVFMNz1s1n8z0=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v3 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Date: Mon, 25 Mar 2024 13:33:31 +0100
Message-ID: <cover.1711368498.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 3rd iteration for this series.

I tried to credit Kyle's suggestions for 4 and 5 with Helped-by tags and
hope it was adequate to do so.  Actually, at least #4 was a lot more
than a Helped-by, I would say...
---
Changes in v3:
* Reword the description in [4/5]
* Add a missing slash in [5/5]

Changes in v2:
* Added Emily to Cc in the hope for a review
* Remove superfluous tags from [1/5] and [3/5]
* Replace bashism `|&` by `2>&1 |` in [5/5]
---
Dirk Gouders (5):
  MyFirstObjectWalk: use additional arg in config_fn_t
  MyFirstObjectWalk: fix misspelled "builtins/"
  MyFirstObjectWalk: fix filtered object walk
  MyFirstObjectWalk: fix description for counting omitted objects
  MyFirstObjectWalk: add stderr to pipe processing

 Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 16 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  0eeb4b78ac MyFirstObjectWalk: use additional arg in config_fn_t
-:  ---------- > 2:  3122ae2472 MyFirstObjectWalk: fix misspelled "builtins/"
-:  ---------- > 3:  f21348ab80 MyFirstObjectWalk: fix filtered object walk
1:  4219237868 ! 4:  cfa4b9ce50 MyFirstObjectWalk: fix description for counting omitted objects
    @@ Commit message
         Fix the text to clarify that we now use another traversal function to
         be able to pass the pointer to the introduced oidset.
     
    +    Helped-by: Kyle Lippincott <spectral@google.com>
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## Documentation/MyFirstObjectWalk.txt ##
    @@ Documentation/MyFirstObjectWalk.txt: points to the same tree object as its grand
     -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
     -object walk does not perform any better than an unfiltered object walk; all
     -reachable objects are walked in order to populate the list.
    -+filter, like with `git log --filter=<spec> --filter-print-omitted`. We
    -+can ask `traverse_commit_list_filtered()` to populate the `omitted`
    -+list which means that our object walk does not perform any better than
    -+an unfiltered object walk; all reachable objects are walked in order
    -+to populate the list.
    ++filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
    ++change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
    ++able to populate an `omitted` list. Note that this means that our object walk
    ++will not perform any better than an unfiltered object walk; all reachable
    ++objects are walked in order to populate the list.
      
      First, add the `struct oidset` and related items we will use to iterate it:
      
    @@ Documentation/MyFirstObjectWalk.txt: static void walken_object_walk(
      
     -Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
     -object:
    -+You need to replace the call to `traverse_commit_list()` to
    -+`traverse_commit_list_filtered()` to be able to pass a pointer to the
    -+oidset defined and initialized above:
    ++Replace the call to `traverse_commit_list()` with
    ++`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
    ++defined and initialized above:
      
      ----
      	...
2:  9b0f0832b7 ! 5:  c571abb49d MyFirstObjectWalk: add stderr to pipe processing
    @@ Commit message
         Fix this by redirecting stderr to stdout prior to the pipe operator
         to additionally connect stderr to stdin of the latter command.
     
    +    Further, while reviewing the above fix, Kyle Lippincott noticed
    +    a second issue with the second of the examples: a missing slash in the
    +    executable path "./bin-wrappers git".
    +
    +    Add the missing slash.
    +
    +    Helped-by: Kyle Lippincott <spectral@google.com>
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## Documentation/MyFirstObjectWalk.txt ##
    @@ Documentation/MyFirstObjectWalk.txt: of the first handful:
      ----
      $ make
     -$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
    -+$ GIT_TRACE=1 ./bin-wrappers git walken 2>&1 | tail -n 10
    ++$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | tail -n 10
      ----
      
      The last commit object given should have the same OID as the one we saw at the
-- 
2.43.0

