Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A703FE7
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754746664; cv=none; b=LbxO+53WkIX6zFXc+ITIst4Q6gOe91u7n0sG86j0XFSSwP9IPe2gB55IaW0K2zK28E9rlSZ4WoLveZvctvJkou0SXXLycXRrcfF6zoKOMKm/zlDoBsBZVkb3+zVEhggZIbqAYnZvUmwTaBpxjULdu2TrrLiY/DYEckURvE6402Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754746664; c=relaxed/simple;
	bh=/s+pG4NwsQy9FobMQ8OZ6qXK7kPAFzzUZXHpspFpYeg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Bj5PuMSFhUwzlhEQW6wbBZXdvIITcPmKvBJnAR2SOzGe1nFOAFTPcKHjoq3OpbdacQBFNR6Oe3MW6Xh/xJs+ZH1qWYlhlFP953g56ztDPL9pEJlqxFzBaZCFqM6jtUTw9417b59cfkM4sGWAWWWaFYQUE8v5MGof3PhG1HBOvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=c0R6/yBb; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="c0R6/yBb"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id kjiPuwpw17HMwkjiRuuZdP; Sat, 09 Aug 2025 14:34:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1754746471; bh=EXFWERwNNxJBoEmqOe3lM0WC43Avk1yjDSGe/DOK35Q=;
	h=Date:To:Cc:From:Subject;
	b=c0R6/yBbY16eFUn1t725boMB2haahEcSwgatvFJ5IJjCd2t+QW+iJqh4sBNkkDNnC
	 dgjjJOM6k0GFM7+fO8i68yC5E0TyGsUAsDhMMpHHc1uyYhVcvL7Sbh293zJAaEm7Mu
	 d4qkD0l9oO8wyisrPoCdnFm4CaMDXOl+cgkjcvEPc4veBAN4j0Gra6c+k9kvTNN5q1
	 uZC0vQub0ES7vfDkVY0Ya0ECjfidZb/UOm5wt+zzv/vpBALCG3hQwH0uRoadYJCAp/
	 XwcNNGGMl4rp9WhC2DHJlzlrSgwrDKoYlwPliADt45PQxWkJFuuctTdRMkAM+ZgPlt
	 ZvUXPq3+RmS6A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=68974e67
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=qFU3D5xzw5W5iwC5dtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <92c8c9eb-91de-48c6-88ac-7d5583cc766a@ramsayjones.plus.com>
Date: Sat, 9 Aug 2025 14:34:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: 'seen' branch fails to build
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFDzYGheoAnLgFt8zZJ+75b6D08f1az6uHESIJJbpOTTF1FMFRNbiAz3lu7vNwlKgmWShL+LPVZfMTdBbg3lbQHjpv40/NIByxdaqkEEiezS4xePZVaS
 n02+fMglPHQfdYyEvzPKxmSLiWh0MPk+ew0wPisD6yersYAY0rOPAIu/T6D8831mXJlZ914DKR7E/L46xpLViOHKY2x2ZXYaWgY=

Hi Junio,

You have probably already fixed this but, just in case you are unaware, the
current 'seen' branch @9faf989da6 ("Merge branch 'gh/git-jump-pathname-with-sp'
into seen", 2025-08-08) fails to build for me with DEVELOPER=1:

      CC builtin/diff.o
  builtin/diff.c: In function ‘cmd_diff’:
  builtin/diff.c:500:17: error: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
    500 |                 chdir(prefix);
        |                 ^~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2818: builtin/diff.o] Error 1

See commit 456a265746 ("diff: --no-index should ignore the worktree",
2025-08-07) in the 'jc/diff-no-index-in-subdir' branch.

In order to get it to build, I just did:

  $ git diff
  diff --git a/builtin/diff.c b/builtin/diff.c
  index 3eb4cbb057..ff16d7be99 100644
  --- a/builtin/diff.c
  +++ b/builtin/diff.c
  @@ -497,7 +497,8 @@ int cmd_diff(int argc,
           * prefix.
           */
          if (no_index && prefix) {
  -               chdir(prefix);
  +               if (chdir(prefix) < 0)
  +                       die_errno(_("cannot chdir to %s"), prefix);
                  prefix = NULL;
          }
   
  $ 

[I don't know if that is the best solution; it was just the quickest! :) ]

ATB,
Ramsay Jones

 
