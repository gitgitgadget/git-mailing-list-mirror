Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2E54FAB
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847454; cv=none; b=Gw7kQJrgiIzdONLHRUTH5+Q6NmPb+J+MPb6NIxXIwrEU5WG0G6VovZ5PFd/uNsCGH3oj/ohj1Y8thU+kUdjtdGst1IcjNP+e4WZdFkAx9fP1/kVOHHfGwmCa8FKHlYxO1qV5GIvEPyo12zsKvItAfBoZfz+awclSIuKQESl2Jcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847454; c=relaxed/simple;
	bh=PtTVjdORV58aghawW1LwdVfSF26JJsC05la/bU1QIeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WehapQMMQAQEfjSsSlMiX7jzwRrN2eXvKf2/J5P1OtOUIX4TmGTLlNZ9Njhxs78Mi4XDMJUb0Ty+Csq+6M0v+KN9RtJA++QCqSV3mUsk8yRe9avtxJe4LOREqBsnXUkyDjnIlk5PUqmCrBovkBRwbzQDQ6SbG4O8ixAO9f+NLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=OE0YL8fm; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="OE0YL8fm"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JBNuCR017008
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 12:23:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710847437; bh=PtTVjdORV58aghawW1LwdVfSF26JJsC05la/bU1QIeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OE0YL8fmGgrLw4moxMVh88gxbNerajiEK3rQVMcW23vRIOsXsIhkZ3aNi3hahtbxF
	 MIr28p5phvVDW4DQrthuPqslmpXjvVrQmFPr+A1YSa7HAl5D0FajgmhaCFqgU86qJ0
	 I6c7VFKCXuXFVsf2kaCOLvStQ4IdJxSJ0lGA7yGE=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Date: Tue, 19 Mar 2024 12:23:10 +0100
Message-ID: <cover.1710840596.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710192973.git.dirk@gouders.net>
References: <cover.1710192973.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second spin for this series.
---
Changes since v1:
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

Range-diff against v1:
1:  15b74566e0 ! 1:  babf04295e MyFirstObjectWalk: use additional arg in config_fn_t
    @@ Commit message
         Fix those calls and the example git_walken_config() to use
         that additional argument.
     
    -    Fixes: a4e7e317 (config: add ctx arg to config_fn_t)
    -    Cc: Glen Choo <glencbz@gmail.com>
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## Documentation/MyFirstObjectWalk.txt ##
2:  c1ac705840 = 2:  ab0b820df7 MyFirstObjectWalk: fix misspelled "builtins/"
3:  0f67a161ef ! 3:  fac6886af3 MyFirstObjectWalk: fix filtered object walk
    @@ Commit message
         rev->filter to parse_list_objects_filter() in accordance to
         such a call in revisions.c, for example.
     
    -    Fixes: f0d2f849 (MyFirstObjectWalk: update recommended usage)
    -    Cc: Derrick Stolee <stolee@gmail.com>
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## Documentation/MyFirstObjectWalk.txt ##
4:  637070dd48 = 4:  33a1845889 MyFirstObjectWalk: fix description for counting omitted objects
5:  a2d30eff21 ! 5:  64c36dbf16 MyFirstObjectWalk: add stderr to pipe processing
    @@ Commit message
         trace messages are sent to stderr if GIT_TRACE is set to '1', so those
         commands do not produce the described results.
     
    -    Fix this by using the operator '|&' to additionally connect stderr to
    -    stdin of the latter command.
    +    Fix this by redirecting stderr to stdout prior to the pipe operator
    +    to additionally connect stderr to stdin of the latter command.
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
    @@ Documentation/MyFirstObjectWalk.txt: those lines without having to recompile.
      
      ----
     -$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
    -+$ GIT_TRACE=1 ./bin-wrappers/git walken |& head -n 10
    ++$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | head -n 10
      ----
      
      Take a look at the top commit with `git show` and the object ID you printed; it
    @@ Documentation/MyFirstObjectWalk.txt: of the first handful:
      ----
      $ make
     -$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
    -+$ GIT_TRACE=1 ./bin-wrappers git walken |& tail -n 10
    ++$ GIT_TRACE=1 ./bin-wrappers git walken 2>&1 | tail -n 10
      ----
      
      The last commit object given should have the same OID as the one we saw at the
-- 
2.43.0

