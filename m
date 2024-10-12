Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF22C95
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707872; cv=none; b=aDQWJrNO3PTTvUvfnpJarvZp6PHKmoUKYphZXfbqxIly/hRn1MgHFYl4MoZAsVBspV8NJujxn15YsSTDIfJkNlCD2NsM1fBC3UQmQjx9T/UL+SoNLSoif37LFK/9ZNUi/a8tkSO8untRNLJsZUXE/bZVClKOZA/1ZzQLjV3Azzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707872; c=relaxed/simple;
	bh=BHSrh4xO84Zf1xL6N8m5BfXQk9qHlhDXDCSaWgljpjw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=e7n4tL1P2BBbSc/l5xEHkfpWL1RwAYFJ6139TKZTw2n3AwQg04mvkxIYPQGK47AL6G18yKwY73Rpyz3MJrMowslQALNjaYc8zQXfxx6YbYzDjHddU5hhcosX6qFJmAeX7MAM5djeYU1zdJf3HERlDPDzeqC5LGWwOI1Uo8hMc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPXp0w6B; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPXp0w6B"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9963e47b69so396642266b.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707869; x=1729312669; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FDB28SLDgh/cqxvGZMX1tcSQvBdAIQRzUbqihsfsWQ=;
        b=OPXp0w6BVKwhZ0c5n+2KCrX63pQYgZ+Kf0O/zcmvTpRpvNqjhdzdQ54cXOXW1L+QUb
         XJ0KDtlxzsoocN4auZidq0lGsuxhlYc4MXJltx1qyYBVSP6+9UktN/DXlz8yNAkdfJRx
         Ap1CNFkk6rSsl8lFCiO0aDwHqgSUz5yAnxWXGhMxh6LkulQZjPnar2Ik060fzLJCusgS
         Q5Pi8RlazxVvjn3QLBy9rXv7V2KWRss3f8QUFCBNX74fm2xhYUVksj9BEn8P/Sy/rq8E
         bHS84Ba+Y4pP0wr5panuZD0d25HtoYx9JHrh5HhGsO1jnEgKQtgRzECTZGy5vR3YMHCB
         R+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707869; x=1729312669;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FDB28SLDgh/cqxvGZMX1tcSQvBdAIQRzUbqihsfsWQ=;
        b=jHS/ada835MKotieT8MtDyI62YE9T/OWGrtRsWePzDT1d1XEFoP3nGVKOVVaI2wAhG
         4LIS1gNkfVUb9bZstsNCaCfTscYW9yWzs0gjb2lOrxisjvh6l+AEY12eIhwpmcFk5/U3
         ut7uE+3EB4UJLUyL9pI7/wVsKAddxbNgew/jsYmGKayrde1rqDnxelHXiXO5iJuiLtZM
         ObD+tXAtgBAe2vg3OfYWJgu+cAm+02fEI6H5X++VPOJ9TTq+VRMXc1Tm+rANuUB6gypI
         kxV8raZ9COmkvmE8raF2QWoaNghER1o1jIZdLRGrignlTGXvcY1zSQyFGfHr/7qli0/O
         zzQw==
X-Gm-Message-State: AOJu0YzQ2t0VvSiMWGrL22Q/vx0lCgoWPXf9jNNcbodoqBQo633yjvVm
	Rcxp6duRnCf2E8jG+1R+SC45yBjSIJ20jSVlIHr6mD6+uoahZtYj+v1Lww==
X-Google-Smtp-Source: AGHT+IHUeY3E/bddRR2Gd71dOrjHDGj6CTF5BmpsKA2CGPtwCXEutHaPRICIo5estZ8OGNDzPCLHBQ==
X-Received: by 2002:a17:906:dc92:b0:a99:4f5f:c9aa with SMTP id a640c23a62f3a-a99b95bade3mr288839066b.50.1728707868797;
        Fri, 11 Oct 2024 21:37:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dd875sm283318366b.178.2024.10.11.21.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:37:48 -0700 (PDT)
Message-Id: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
In-Reply-To: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
From: "Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 04:37:45 +0000
Subject: [PATCH v2 0/2] blame: respect .git-blame-ignore-revs automatically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>


Summary
=======

This patch introduces the ability for git blame to automatically respect the
.git-blame-ignore-revs file, which can help users streamline their workflows
by ignoring revisions for non-functional changes.

The feature is inspired by similar practices in other projects like
Chromium, and it aligns with needs expressed by users in discussions around
revision-ignoring mechanisms for git blame.

I have incorporated suggestions provided during the review of patch v1,
including improvements to the commit message and addressing how to override
ignore revisions using a new option.


Patch Updates and Improvements
==============================


Changes since v1
================

 * Updated the commit message for the first patch. I incorporated
   Kristoffer’s suggestions by directly using the example he provided,
   ensuring the commit message aligns with the project's standards.
 * Attempted to use --no-ignore-revs-file to bypass the
   .git-blame-ignore-revs file, but observed that it did not ignore the
   specified revisions.
 * Introduced the --override-ignore-revs option (short form: -O) as a
   straightforward method to override any configured revision ignores,
   providing users with more control.
 * For the second commit, I applied Kristoffer’s feedback in writing the
   commit message to ensure consistency and clarity.

Abhijeetsingh Meena (2):
  blame: respect .git-blame-ignore-revs automatically
  blame: introduce --override-ignore-revs to bypass ignore revisions
    list

 builtin/blame.c                       | 16 +++++++++++++++-
 t/t8015-blame-default-ignore-revs.sh  | 26 ++++++++++++++++++++++++++
 t/t8016-blame-override-ignore-revs.sh | 25 +++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100755 t/t8015-blame-default-ignore-revs.sh
 create mode 100755 t/t8016-blame-override-ignore-revs.sh


base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1809%2FEthan0456%2Fblame-auto-ignore-revs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1809/Ethan0456/blame-auto-ignore-revs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1809

Range-diff vs v1:

 1:  666404681d9 ! 1:  4ed930cab1b blame: respect .git-blame-ignore-revs automatically
     @@ Metadata
       ## Commit message ##
          blame: respect .git-blame-ignore-revs automatically
      
     -    Modify `git blame` to automatically respect a `.git-blame-ignore-revs`
     -    file if it exists in the repository. This file is used by many projects
     -    to ignore non-functional changes, such as reformatting or large-scale
     -    refactoring, when generating blame information.
     +    git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
     +    This is useful for marking uninteresting commits like formatting
     +    changes, refactors and whatever else should not be “blamed”.  Some
     +    projects even version control this file so that all contributors can
     +    use it; the conventional name is `.git-blame-ignore-revs`.
      
     -    Before this change, users had to manually specify the file with the
     -    `--ignore-revs-file` option. This update streamlines the process by
     -    automatically detecting the `.git-blame-ignore-revs` file, reducing
     -    manual effort.
     -
     -    This change aligns with the standardized practice in many repositories
     -    and simplifies the workflow for users.
     +    But each user still has to opt-in to the standard ignore list,
     +    either with this option or with the config `blame.ignoreRevsFile`.
     +    Let’s teach git-blame(1) to respect this conventional file in order
     +    to streamline the process.
      
          Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
      
     @@ t/t8015-blame-default-ignore-revs.sh (new)
      +'
      +
      +test_done
     - \ No newline at end of file
 -:  ----------- > 2:  8d2fa3af796 blame: introduce --override-ignore-revs to bypass ignore revisions list

-- 
gitgitgadget
