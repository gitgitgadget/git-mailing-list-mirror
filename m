Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E082367C9
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744423092; cv=none; b=KLYaYb2+yzwVPDtqmolYF7dquQ6U/b9J+hrDJgt2u5m08LBpOYcxdMocMezoiFBJQoNxRRHHNhTRjyFUJ6a+H101UYzG/VDMREVx7JYB3ytv+hZXchRl/CfDMhwp1XCUJb+bMtGsThOOfb1MPPwb9K94txuDtcPAybKkxqit1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744423092; c=relaxed/simple;
	bh=Qtvg8gAtt/uLoCpdS6g/+/FDjA0Rae6te4NHcLbvyhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiIffP2DcfPC9G1TUL2oTSzciM6lrXXfyzpLE8wZYZEh7kVYCJilOQPFKFcRY71iOeFSk2S+76w76dYaOWmOd1k8BydarDCHkVreQhxDDGhXunAsYuRENGhunBEcX78BAkX0jyMkYO3Ah7YnncXEXVb3tKwyq+lU9ewWqpcPRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3+CdmUA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3+CdmUA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227b650504fso26218045ad.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744423090; x=1745027890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPZQXzSbNZOZDHjQK/UQq7JTldP4rP8JD6B058dS6l4=;
        b=V3+CdmUAjhLuEdRCMQKsdIVzsLpFKm/FkM+8QclmZO3TSuUYENJTsSSafNveIQgCyQ
         5u5n6T3O2M8HK8VOZFzjmRla0gT0Wk0hY5h4lnbMydY3mZv4wXpABhp8EBThAAO5o4iu
         HqIVGXYdBwdr5nqe58PwbsX6PFdvHENipMlZaue/NyhbqCLY5oLbt3CwKc33r6C0bFKo
         5U75IaLI3qYaSIu8UnHHNZb560lh9/221nsD3gj+JhkCPE5LapSYwLQvyMTPHizvVIAi
         uJTKNAdwYvZ2nIwj/wJVHtGkisvfP5J4s8h/YnCPaJ5QNqUITy+Etxni4F2n8pzcAmzV
         bq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744423090; x=1745027890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPZQXzSbNZOZDHjQK/UQq7JTldP4rP8JD6B058dS6l4=;
        b=Wf/syzXn2QqaGtROI1VwStklshOprrdIY3XV0S8e8NFXXjjwBe91loJAatBpZhMOUN
         QNxHpD6kz+T4HbrHc8YppYhJX2VE4HBpg3Q7VyApA5wGmtCLrAqFhhyOCnkFg8GZQXwd
         jSuhCbVz/qY5PA/EjDaNtgEHvlolt9Q8nJzurQCedqpmRnfoYGT2VGtXODTgPAPn+iGc
         S2893agz4lQa607AXZt/eytWbK5LJp3PxDwzELnXIizyegRZ5iXOao96HOdFXbxmKM8T
         WnqJoZdtwv3m32AV3QqtECxNORRbM2+F7asWMi6G6yPtILyg6UsJEkoWTOmF97LEZXku
         q1rA==
X-Gm-Message-State: AOJu0YwhtbOkXadNQENWBhZNBYo2rmd9HubKXwLDZQpj5c7NoU8i4fjA
	JBZscTOyafliqLbn8pIF9y1Tp/FMiLgYpTlu9HWfd1lqHh9T/ej8yphRvQ==
X-Gm-Gg: ASbGnctYIEKV6r0KPrRCx50b0uhfLRv0ayv40ciFK4NnWrAKQS0WX/iyen+iBrC1qkf
	ZVvmw66e2+67dyluXbUGeb2DoZzQl39fX7ZXj2UxMe1mMcwkfNL/WhcaaMMk9pG8U+uQJQi2Xg6
	Iy5kcthuS8HXI/YLKlD4G97qCEfEIWNelTGShbWyga/zHFWFaU8dKdJAOzJOCmcEL06W4IZpAUv
	9ZX4VrCFBFmqV7XVHUjq7GQTxPJh1C6QGxJLrvij1bRXQIq0jfTrNnBfTSQcR94SSDz1nECPEaj
	TbusLbibcljfe584Rc18KEq+3BXMiEiFuVS9KkozBcEoX7+2wJXp6dHajbcwN3SgOdgzTERu9Wo
	=
X-Google-Smtp-Source: AGHT+IH9oNKgAMEf08PCZgmmVFfAbwQAIf5kL3FMo+LdXqN6g20KgZqnF8TM9Anf5we0wHG45FfddQ==
X-Received: by 2002:a17:902:f650:b0:223:37ec:63d3 with SMTP id d9443c01a7336-22bea4adeecmr67992395ad.18.1744423089608;
        Fri, 11 Apr 2025 18:58:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd219be37sm2474151b3a.19.2025.04.11.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:58:09 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: piotrsiupa@gmail.com
Cc: git@vger.kernel.org
Subject: Re: Bug: Git sometimes disregards wildcards in pathspecs if a file name matches exactly
Date: Sat, 12 Apr 2025 07:27:48 +0530
Message-ID: <20250412015748.7177-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAPM0=yBnaXojeC9WkHg08deR-VpjaVQwyrqt8mk+54qLXqSaAQ@mail.gmail.com>
References: <CAPM0=yBnaXojeC9WkHg08deR-VpjaVQwyrqt8mk+54qLXqSaAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Piotr, Hello everyone,

Thanks for the clear bug report, Piotr. I can reproduce the behavior
you described in 2.49:

On Fri, Apr 11, 2025 at 9:08 PM Piotr Siupa <piotrsiupa@gmail.com> wrote:
>
> Hi! I think I've found a bug in the command "git add".
> It can be reproduced in a fresh repository by running:
>
> git init
> touch 'foo' 'f*'
> git add 'f*'
>
> The last command should add both files "f*" and "foo" to the index but
> it adds only "f*".
> Running it the second time works as expected. (It adds "foo" on the
> second attempt.)

Following the code path down from 'cmd_add' (in 'builtin/add.c'),
the issue appears to stem from how pathspecs are matched against
directory entries. This happens specifically within the 'prune_directory'
function which uses 'do_match_pathspec' internally (likely called via
'dir_path_match' -> 'match_pathspec' -> 'match_pathspec_with_flags').

Here's a breakdown of what seems to be happening during that first
'git add ''f*''' call:

First, 'cmd_add' sees it needs to add new files. Then, 'fill_directory'
finds both untracked files: 'foo' and the literal 'f*'.

Next, 'prune_directory' is called to filter these using the pathspec ''f*''.
Inside 'prune_directory', the 'do_match_pathspec' function is called for
each file ('foo', then 'f*', or vice-versa) against the pathspec list
(which just contains ''f*''). These calls share a common marker array
(often called 'seen') to track which pathspecs have found a match so far.

When 'do_match_pathspec' processes the literal file 'f*' against the
pathspec item ''f*'', it calls 'match_pathspec_item'. This helper function
likely returns a code like 'MATCHED_EXACTLY' because the pattern ''f*''
happens to exactly match the filename '"f*"'. Consequently,
'do_match_pathspec' updates the 'seen' array for the ''f*'' pathspec to
mark it as exactly matched. Since a match was found, 'prune_directory'
decides to keep the 'f*' entry.

The problem arises when 'do_match_pathspec' processes the other file, 'foo',
against the same pathspec item ''f*''. Before doing the actual comparison,
it checks the 'seen' array and finds that the ''f*'' pathspec was already
marked 'MATCHED_EXACTLY' (from processing the literal 'f*' file).
An optimization check like 'if (seen && seen[i] == MATCHED_EXACTLY)'
then evaluates to true. This causes the loop to 'continue', skipping the
call to 'match_pathspec_item' entirely for the 'foo' file against the ''f*''
pattern. Because no match was found *in this specific call*, 'do_match_pathspec'
returns 0, and 'prune_directory' discards the 'foo' entry.

Finally, 'prune_directory' returns the filtered list, now containing only 'f*',
and 'add_files' adds only that file to the index.

On the *second* 'git add ''f*''' call, 'fill_directory' only finds the
untracked 'foo'. 'do_match_pathspec' runs with a fresh 'seen' array,
so the 'MATCHED_EXACTLY' check is initially false. 'match_pathspec_item'
is called for 'foo', returns 'MATCHED_FNMATCH' (a glob match), and 'foo'
is correctly added.

> I'm using Git 2.43.2. The current "next" (2.49.0.805.g082f7c87e0)
> seems to have the same behavior if I'm testing it correctly.

Yes, the relevant code structures in 'do_match_pathspec' appear similar
in recent versions, suggesting the behavior is likely consistent.

Conclusion:

The core issue seems to be that optimization check within 'do_match_pathspec':

  // inside do_match_pathspec loop:
  if (seen && seen[i] == MATCHED_EXACTLY)
          continue;

This optimization assumes that once a pathspec item has achieved an
"exact" match against *some* file, it doesn't need to be checked
against *any other* files during the same directory scan operation.

However, when a pathspec contains glob characters (like ''f*'') but
happens to *also* exactly match a literal filename ('f*'),
'match_pathspec_item' appears to return 'MATCHED_EXACTLY'. This triggers
the optimization, incorrectly preventing the *same* pathspec pattern ''f*''
from matching *other* files (like 'foo') via its intended glob behavior
during that initial scan.

A potential fix might involve adjusting the logic in 'match_pathspec_item'
to perhaps not return 'MATCHED_EXACTLY' if the match involved globbing,
or modifying the 'seen' check in 'do_match_pathspec' to account for
this ambiguity.

Thanks again for spotting this subtle behavior!

-Jayatheerth
