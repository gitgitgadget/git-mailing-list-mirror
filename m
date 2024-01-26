Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03DAD53
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289185; cv=none; b=fo1QhLQ8r2hVJ/RyNe0qryNkIYQsLMCaunGgkXUHWv4EQAECt3H/rRM8JBtOJ1hzODGNfxYZT5xzkVUTc42rYKRVxKdn9JeIsjAVlDOmJM/a7UzrKSGmf7ftLRnBM3TKEEvT+1ijOJb/j1VN81Pvt33dClkQeNkfwX2kNluXtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289185; c=relaxed/simple;
	bh=lpG2zIJBuusQy5NMXFvAicgPp+q7LPCJpFR4lDkA3pM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GT7cFn09Juv5KkUp0nd/jp0DqToG53x8JZvIIyQ9fIE1gNtMuQBLHWyKZANczj6Zc/QVwB+daKZ+SKLvyCeFZgK0zO56vLT3Ma4FPm1D6mf79PXu9TRAPtnpEHhf/DvikJ9t7HcIM1DAJKr+A+nPuFHyRW/xSoGnq+dptr451Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4WC4eqO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4WC4eqO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso14184735e9.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289182; x=1706893982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/Bu+IylJ5Bq2bsVLtAv3PkC7hwy8dCixzGYnpgClIg=;
        b=R4WC4eqO/wb7QZ6WqLjv4VZS/zovNnZ/FPnHNMkHjSoZ6cdaUyCxL0skbOOc2rPukV
         e5lw8NEFzdNmxOqQJpANDw5N2357zJcu/PQvdp3Z9QvA3mDNYoy2OyIAqLfrrUfkKUmH
         mmG6MCc7DMRrtDx3zUcNGGZCxtYbnHs5Lk42uF4NTcMguhVLRzgA+xt8E4SBQ8DAUBiP
         L/2ZECutI8On7XV0aUpEynf7JG+CLmf1m52PGJv5qby6OZQCs30GLnvRsF2z0nhQPzLD
         dnjma5Ela4r8xbVUpyanRIzrvTzRj7bab8NiK+lKt5mq2WckvMuXkzTrw6A/qGJp6x4B
         LZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289182; x=1706893982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/Bu+IylJ5Bq2bsVLtAv3PkC7hwy8dCixzGYnpgClIg=;
        b=XpxO7SR14MG6rtbP8/rNTyIiZ7ncWPwTM/uPTXNOoF+iHSQAE8Z8lBI4uJjpLDSJmY
         AnQKx57EuyidWrGVWFMfMZmHTt4XTeXiyXFCwQfXRpdw2s+kA50Nho61Ka+gQuz9fxn0
         x1BfuqTQwVWzjkmGa/FYxadi0X0n34mcuhn9YV9RxXiFGGLPOvS3toU1aeYoQvXgOz/b
         yct6TWZRC/9FwEEf/vmMBhBKzROzK6Y1FRKf+/iKpnMxkhdEpMqmJ5HNCh0v6rlvbVgd
         zgEi+1oro7BEIU1gTT0A2XqQLkjPiGpaSLe9GPj29+d1y3bqu/Qfduz1ObVv889v9NxN
         PcNQ==
X-Gm-Message-State: AOJu0Yy6eXDbXi0TOQs0MAnJqndeVldJVXTNE/v68svn5ZI9FkRkFSfS
	knqMvrClPiOsZhF7yOVDVELAP/kAJJr0Ogf3oPlK5/m3eXQYJCvARiElYhuj
X-Google-Smtp-Source: AGHT+IECnXKShWDoaxx7d0KC1+7QUI135Wz9/CHmCrPqXoYp1ghqLyUC4DMwAyYKRfUjNfFqztagaw==
X-Received: by 2002:a5d:564a:0:b0:33a:9919:853a with SMTP id j10-20020a5d564a000000b0033a9919853amr1187634wrw.96.1706289181464;
        Fri, 26 Jan 2024 09:13:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6e87000000b0033addeabd6fsm964540wrz.18.2024.01.26.09.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:13:01 -0800 (PST)
Message-ID: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 17:12:58 +0000
Subject: [PATCH v2 0/2] index-pack: fsck honor checks
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
Cc: John Cai <johncai86@gmail.com>

git-index-pack has a --strict mode that can take an optional argument to
provide a list of fsck issues to change their severity. --fsck-objects does
not have such a utility, which would be useful if one would like to be more
lenient or strict on data integrity in a repository.

Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
change the severity.

Change since V1:

 * edited commit messages
 * clarified formatting in documentation for --strict= and --fsck-objects=

John Cai (2):
  index-pack: test and document --strict=<msg>
  index-pack: --fsck-objects to take an optional argument for fsck msgs

 Documentation/git-index-pack.txt | 19 +++++++++++----
 builtin/index-pack.c             |  5 ++--
 t/t5300-pack-object.sh           | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1658%2Fjohn-cai%2Fjc%2Findex-pack-fsck-honor-checks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1658/john-cai/jc/index-pack-fsck-honor-checks-v2
Pull-Request: https://github.com/git/git/pull/1658

Range-diff vs v1:

 1:  9b353aff73d ! 1:  b3b3e8bd0bf index-pack: test and document --strict=<msg>
     @@ Commit message
          5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
          2015-06-22) allowed a list of fsck msg to downgrade to be passed to
          --strict. However this is a hidden argument that was not documented nor
     -    tested. Though true that most users would not call this option
     -    direction, (nor use index-pack for that matter) it is still useful to
     +    tested. Though it is true that most users would not call this option
     +    directly, (nor use index-pack for that matter) it is still useful to
          document and test this feature.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ Documentation/git-index-pack.txt: OPTIONS
       
      ---strict::
      -	Die, if the pack contains broken objects or links.
     -+--strict[=<msg-ids>]::
     ++--strict[=<msg-id>=<severity>...]::
      +	Die, if the pack contains broken objects or links. If `<msg-ids>` is passed,
      +	it should be a comma-separated list of `<msg-id>=<severity>` elements where
      +	`<msg-id>` and `<severity>` are used to change the severity of some possible
     -+	issues, eg: `--strict="missingEmail=ignore,badTagName=error"`. See the entry
     ++	issues, e.g., `--strict="missingEmail=ignore,badTagName=error"`. See the entry
      +	for the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
      +	more information on the possible values of `<msg-id>` and `<severity>`.
       
     @@ t/t5300-pack-object.sh: test_expect_success 'index-pack with --strict' '
      +		author A U Thor
      +		committer A U Thor
      +
     -+		commit: this is a commit wit bad emails
     ++		commit: this is a commit with bad emails
      +
      +		EOF
      +		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
 2:  074e0c7ab92 ! 2:  cce63c6465f index-pack: --fsck-objects to take an optional argument for fsck msgs
     @@ Metadata
       ## Commit message ##
          index-pack: --fsck-objects to take an optional argument for fsck msgs
      
     -    git-index-pack has a --strict mode that can take an optional argument to
     -    provide a list of fsck issues to change their severity. --fsck-objects
     -    does not have such a utility, which would be useful if one would like to
     -    be more lenient or strict on data integrity in a repository.
     +    git-index-pack has a --strict option that can take an optional argument
     +    to provide a list of fsck issues to change their severity.
     +    --fsck-objects does not have such a utility, which would be useful if
     +    one would like to be more lenient or strict on data integrity in a
     +    repository.
      
     -    Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
     +    Like --strict, allow --fsck-objects to also take a list of fsck msgs to
          change the severity.
      
     -    This commit also removes the "For internal use only" note for
     -    --fsck-objects, and documents the option. This won't often be used by
     -    the normal end user, but it turns out it is useful for Git forges like
     -    GitLab.
     +    Remove the "For internal use only" note for --fsck-objects, and document
     +    the option. This won't often be used by the normal end user, but it
     +    turns out it is useful for Git forges like GitLab.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     @@ Documentation/git-index-pack.txt: default and "Indexing objects" when `--stdin`
       
      ---fsck-objects::
      -	For internal use only.
     -+--fsck-objects[=<msg-ids>]::
     -+	Instructs index-pack to check for broken objects instead of broken
     -+	links. If `<msg-ids>` is passed, it should be  a comma-separated list of
     -+	`<msg-id>=<severity>` where `<msg-id>` and `<severity>` are used to
     -+	change the severity of `fsck` errors, eg: `--strict="missingEmail=ignore,badTagName=ignore"`.
     -+	See the entry for the `fsck.<msg-id>` configuration options in
     -+	`linkgit:git-fsck[1] for more information on the possible values of
     -+	`<msg-id>` and `<severity>`.
     ++--fsck-objects[=<msg-ids>=<severity>...]::
     ++	Instructs index-pack to check for broken objects, but unlike `--strict`,
     ++	does not choke on broken links. If `<msg-ids>` is passed, it should be
     ++	a comma-separated list of `<msg-id>=<severity>` where `<msg-id>` and
     ++	`<severity>` are used to change the severity of `fsck` errors e.g.,
     ++	`--strict="missingEmail=ignore,badTagName=ignore"`. See the entry for
     ++	the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
     ++	more information on the possible values of `<msg-id>` and `<severity>`.
       +
       Die if the pack contains broken objects. If the pack contains a tree
       pointing to a .gitmodules blob that does not exist, prints the hash of

-- 
gitgitgadget
