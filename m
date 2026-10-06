Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514A4A5EA6
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315434; cv=none; b=cwhk+uPfFxJ25U56iB116hBi7lAH+LNhIIqik1//uy4KsoUYFoGg8JCoUrQB1XRNzDdEaNN/46ik92C2GUk+LAjGyoRk0YX9PAKBVPDoT3W6u+1oKlhydAoPVwKx9MZwh7oP/UNx+1U3df8olOUQfMbyxWGn0/1P3zL24rdefLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315434; c=relaxed/simple;
	bh=wVveqzP1SeY6X64TdcY3Pcc/0QrO84FPs8Td7ny1t+Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bM0hl27Y49DpOgyR1Yt/nbHQVlhgCtfO6hOE9NZQfHy4zcpyBkZZ7V6aIELLQQ89XchiIaljy/YfkBcCJHbccfg37OqCFUvcxTJSKOKgN3ySRGJr/QLXYZf91Val7T4UKgIhLz3qBJK/NbyqrO8ptYWzkIN97HWGBOvUV4xb0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHiBUB/u; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHiBUB/u"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91968804af0so9908896d6.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791315423; x=1791920223; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z8Ax5iOdo1lhgUOIDFtVYdojy3xO3augQ87Smo/kuAg=;
        b=QHiBUB/uAUrgNZlmtc8wnm6MbypTyDFrKsiuWSyzBz9MNnBtFdPZUdktvXNt0Pe/RF
         Vyizh/FeiEoNWyEoD3suoGuRBl2b7l6gFeWchcoHj4+V25Btk/E57000oIkFCR0IO3Ym
         X4351XdUYDJFHhHy1tLRbPtDVpRivWitbMyorfarVaC81K0CJG46GX0WcEH78ckzjJh5
         Q2t01jnVPwxjG583fiAfKxbGdkR7L5EB3kMRjQClHjPkTMUyWgSwW1YwMCyZUe8ByFIu
         9Z27QRyogrqRcody26T4dQy2ERJThCqe87TbdNVVNx4SbjwdIDKOaCbmuwaU8kwCj2P1
         gm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791315423; x=1791920223;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z8Ax5iOdo1lhgUOIDFtVYdojy3xO3augQ87Smo/kuAg=;
        b=TTkQXdEPhWKdfaqXYTISwpAbDfezQ7EITUEN7UFbYex7xTszxsS9WbiuBhplLWmghb
         73rnfIq13d3vJY1CQTTB5Xyoc89EdvcEGlpEBe/695pBFGzi4vdctghSkh5oE2cyzMOk
         3bpEQkwXotpiWM7OvXVKPqYSCbfCRweiOH1xtBKEPxkUHjUYIkopRkk02ABjbszqt+gA
         M/UEeFlsde9eYl/ClVf4U3k950cRoNFCeHkouJZOib2G8c3OXWNnTW6f7PKcySbdasNz
         UR3WnnjkRWdsfoWra4Y7fPjAmE4v1VkGeXPH80ZpdVLoykpZYm84zV+c/MZO5/1XoBda
         qnXA==
X-Gm-Message-State: AFuF++lUgh1FyLKHCZH9m3crGU31S+s4onUGbj6KkvnSiR1+M80m3zEy
	7cT0NpMpkVNWj6kUCR+b6URNhutJPNqYbYczpwaIIa3idM/AhDZ9hmIv8xAl0A==
X-Gm-Gg: AYBFou2iK0UMiSGJbbOTrgM40rMis+Vzs2TkXR9Q7Zh/XDgYLxrZP44tCumEachzTl9
	qT6yMuMV8IYSToMAqkbH/S8sgyxCN80fg0r10ui0U0nojknuZIT0np/m6TludYcXHf+eD6pdbTL
	EdZqdOso/PK+VXeZz7DUE8OBn2VDRBgp4u2rgJG6z+pgCaT9TNbhymm2jL0Plgc6B3/uKhoaamP
	02IdjTeMVDe6lpCWJ6J4apynKooLBCtYkCFzzlN64UtNk5oOUNPPr14G/CJ0llZ3z/ajr8Scez4
	sJT9k9foGRjFKn/fcGbdUju5p67PuXByEUPyzNL9AFTIJldY35/67GxJFdZ+iHRdMuo+AY2nnek
	tLyiabC9lkPJGbeaap1VeGlrmcVg6pTMriS73HcI8tHxO9Aq8UTPiz+/RvIsMqw380TVIfpqOc0
	LilOV+4NnnEiooMjWcoxy8Otq1503yYj7sn+/gDLX4f/TAPJ9zC6Vk5TQzmM9iaSWXRLL7629Pw
	RNHSKDbHyJY7w==
X-Received: by 2002:a05:6214:4612:b0:919:546a:43c9 with SMTP id 6a1803df08f44-9198b790bdbmr51799106d6.14.1791315423284;
        Tue, 06 Oct 2026 12:37:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.206.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996cb5bd3sm1452616d6.11.2026.10.06.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 12:37:02 -0700 (PDT)
Message-Id: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 19:37:00 +0000
Subject: [PATCH 0/2] WIP: doc: add new git tutorial
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
Cc: Julia Evans <julia@jvns.ca>

This is the first draft of a tutorial which introduces Git in two parts:

Part 1: Create an empty repo & make 2 commits (git init, git add, git
commit, git status, git diff) Part 2: Push the repo to a remote host like
GitHub or GitLab (git remote add, git push)

So far we've gotten 112 comments from 22 beta testers who have tried to
learn Git for the first using this tutorial. Most of them were able to
finish it successfully. I'd like to avoid getting into the details of every
single thing in the tutorial at this stage (we're still planning to do a
second round of feedback with the beta testers, and the beginning especially
will likely change)

There are 2 questions I'd like feedback on since they both could affect the
structure of the tutorial. I don't think either of these is a dealbreaker,
since folks generally were able to finish the tutorial despite all these
issues and said that they enjoyed it and learned a lot. But it would be
great if there were an easy way to make the process less messy.


question 1: create the repo on the command line, or in the forge?
=================================================================

One issue that came up a lot in our testing is that the tutorials explains
how to run git init in a repo to create it locally and then later choose a
forge to host that repo (GitLab, GitHub, etc) and push to the remote on that
forge.

Several users ran into the issue that GitLab by default creates a README.md,
which means that when you run your first git push, the push fails since
there's already a commit.

A few options I see:

a. Suggest that they instead create the repo on the forge and then clone it.
I think this is easier and usually I support suggesting things that are
easier, but in this case I think it's our role (as the official Git
documentation) to make it clear that you do not need a forge to use Git. IMO
this approach really confuses that issues and makes it seem like the forge
is more important than it is. b. Suggest git push --force. This is an easy
fix but I don't like suggesting that people use --force so early since it's
so dangerous. c. Just try to get users to try to figure the right way in the
GitLab/GitHub/etc UI to actually create an empty repository that it's
possible to just push to. This is really hard because the UIs constantly
change.


current solution 1
==================

Right now we're working on Option C since it seems least bad


question 2: How to handle authentication
========================================

 * How should the tutorial tell users to authenticate? I know there are
   commands like gh auth login for GitHub and IIRC GitLab and it seems like
   there are some advantages to using those, but also AFAIK they're all
   pretty specific to the individual Git forge and I don't see how it's
   possible to discuss them in a generic tutorial.
 * Whether to explain the process of creating an SSH key etc. Arguably this
   is the job of the SSH documentation, but since https://www.openssh.org/
   doesn't have such a guide, it feels bad to tell users "you should go read
   a guide on how to use SSH to do this but by the way that guide does not
   exist so good luck I guess".
 * A lot of testers found it hard to find the SSH URL on GitLab/GitHub


current solution 2
==================

Right now we're solving these by:

 1. Using SSH
 2. Explaining how to set up SSH in the easiest way possible (with
    disclaimers to check your security team's policy if applicable since the
    "easiest way" may not be the best)
 3. Giving some instructions for how to translate an HTTPS URL to an SSH URL

Julia Evans (2):
  doc: remove gittutorial
  doc: add new Git tutorial for beginners

 Documentation/gittutorial.adoc | 854 +++++++++++++++------------------
 1 file changed, 397 insertions(+), 457 deletions(-)


base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2248%2Fjvns%2Fgit-tutorial-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/jvns/git-tutorial-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2248
-- 
gitgitgadget
