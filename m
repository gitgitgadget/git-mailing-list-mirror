Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D24374EF
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586461; cv=none; b=DhmgcTxslR+CLvZ7/ZJs9auQnGlPUeB9FB4DCPSBvZc0iow6nYVtdnXTLHNTMQz9iiqTWYerHXbyiqO4f04zjgH32gNIVpxVZ28R9p2MdI7qoK/MDuXjYnb0E3fwE7MWrNO0M8/4qo4Zev3VK244ddJf/gwL9g/wRPJRljh82X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586461; c=relaxed/simple;
	bh=De38W/cGvnoineRLkAJVxq5wvGHStrQ67epU/OHld8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UtTc58Ca0meE9XNDbg11O4fRcHn5U5Oc13NwOkWvGH7GZjUXPLPYPOmQ8bBvsS6YMh6h+OC7ZM0ThnNtAU7oPZajK6aBv1SmSKGBt099vqbQLLYvlfavyCmyCTtCkr2aAw+xEb1qWjidCwX2atd9hB0BK4dDq59XuRy6LAGZVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9lHy9d1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9lHy9d1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so1662996b3a.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 19:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706586459; x=1707191259; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPAJnq2Oy2ce8IkF4RMBwbPzjGdTqObVHli6GVkcgek=;
        b=i9lHy9d1I15w3sE+WPBEtb8X5vj72f80WmOrIjwFbTDZiu21adXBBCvJ4S7qOXPCnv
         B7++CrvErtgjD4gzSHMK37koGUyjfhdCOR60DBtdE4NyBopy/K2IMfOk8UqoCnko0qte
         as6kC57Y/TBIpstnWMblbedmrZIBleoaQJ1XwsPlolapjjIkZIXGb/WxfoUox6CE3xVf
         XPomk7+Y3/G2QrMnB7sNjNElMpjTXuAm6Sxz74c0HJNCOFsGXiDA8aa7aoz2LIrTL96A
         cqELQOp61U2aZUww3VgDUE6b29W/EumHIITnmgDOdbTjVSitlv/hpaJbkSW2EDSu9tp6
         pl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586459; x=1707191259;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPAJnq2Oy2ce8IkF4RMBwbPzjGdTqObVHli6GVkcgek=;
        b=a6zGi42na/Nqc5K/FDGGrZAEJ++CwP9I3+q4camDmGSGq8t6H/QzvpZFC7j+gW0R0Y
         ISaDjg7JArp/PI+iENGUbbJu3FTOFVLMFTmVxDJtQlRrh2AiMOur03kllUenvPNh52yO
         4cJlRtngR0fwtRurecRzpMStfuCI4gl7NwvtE0c0yVO3rtuvYGVnXfoJjR4W3scmTAe1
         Kp5c/jFkE+C0a6BaycsFbc4g1NomKwEhZ7bwj+/OTN/J1gmvBl11qmEFA83dyJknap72
         rNDpe7aankegxRpTibAEiBDpHl+EIQzoJMq/u86yWgtzY1XXKgLIIoqbasXjODv6TFdd
         wrIw==
X-Gm-Message-State: AOJu0YyvLuuJgEDHcu/EYTVV+VwwVfHdjSDfLHoRrQburcP7nb7Q7LTt
	isBRRwdzDWI0K36/HeBrHUmrFnWxLxW6jxytX3bJG4bCNCRc1RyZudXkopE+DO5ddppTFC/0x34
	5rgRqumfSjaJWVyri0E6fXFsmys7KhIGw5gg=
X-Google-Smtp-Source: AGHT+IHumygVeWnZycwQ3JMQZ5vNLF5JWsrE/WHC9xTRRYVHimcG2giiaPcASxMSAVr5y7Tqf5HvB49vHYFuvmCC1OY=
X-Received: by 2002:a05:6a00:138f:b0:6dd:dbb2:8ee9 with SMTP id
 t15-20020a056a00138f00b006dddbb28ee9mr6084152pfg.6.1706586459106; Mon, 29 Jan
 2024 19:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jacek Lipiec <jacek.lipiec.bc@gmail.com>
Date: Tue, 30 Jan 2024 04:47:27 +0100
Message-ID: <CAPGWkwcqbkanFP4h1P0umJAFzmiQYTvSm1KeD0=yY0n2K=KS7g@mail.gmail.com>
Subject: Multiple indices / staging areas
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I am thinking about extending the current index mechanism, and I wish
to ask for feedback if this would be something that you would be
interested in. Please note, I have no prior git development
experience.

The main idea is to mirror the "changelist" functionality found in
IntelliJ IDE's (https://www.jetbrains.com/help/idea/managing-changelists.html).
Namely, at each given moment you can create a "changelist"/separate
index to which you can move hunks to. Such changelists are named, and
optionally have a (default) commit message.
This allows for an easy way to split current changes into separate
commits, to have clean and atomic work units committed; while seeing
the combined changes in the worktree; as well as having a
conceptual/logical separation for changes

Scenario: I am introducing a new functionality. Changes are
conceptually separate, but work together. i.e. new version of package
& using the new functionality from the package.
Scenario 2: I am not yet sure about what needs to be done, so I am
sketching in code. Some changes will be of linting nature, some will
introduce code, some will be an "ad-hoc fix".

What we can do with the current flow:
* Commit/amend/fixup. This works best when one has prior knowledge of
what needs to be done, i.e. bumping versions then using the
functionality. Problems arise when the code is "living", as such you
need to fixup commits in the local branch, which can lead to
conflicts. Another issue is that if you wish to commit small change
(i.e. a fix for a linter) you need to juggle the staging area. (This
is my current flow in the vanilla git. It can become clunky if you,
like me, sketch the solution in the code)
* git worktree. While this functionality is the closest to what I am
proposing, it does not allow for easy transfer of hunks, nor it allows
for working with all the changes in the same worktree at the same
time.
* branches. This again does not allow us to see all the changes at the
same time.

The idea for the implementation would be as follows, and should
hopefully introduce no change to the existing flow.

1) Design

1.1) New indices file
We add a new file in the $GIT_DIR, called `indices`. This is a map
file that will MUST have at least one entry. Index entry MUST have a
name. Index entries COULD have default commit message
Example:
```.git/indices
selected=1 # maps to .git/index.1
#  translates to .git/index.0
index[0].name=Default
#  translates to .git/index.1
index[1].name=Add named index
#  translates to .git/index.2
index[2].name=Wip
index[2].message=Add named index\n\nThis is a longer description
```
The "selected" index is in two places - one is `index` and the other
is based on the selected entry; so following example, `index.1`. The
best way to keep them synced would be to symlink them, though this
would introduce FS dependency. Synchronized copy would work as well.
Renames could work, but there would be IMO high risk of losing changes
from the index due to a mistake.

This way, the existing index file format remains unchanged; and all
new functionality can be handled via the new `indices` file; due to
that all existing code should work without an issue.
I see a potential problem of two indices overlapping (i.e. index
changed via older git, or other tool) - in this case I would
transparently correct other indices, treating selected index as the
source of truth. This would imply that software not aware of the
indices would see the changes in the not-selected index as unstaged.
The second issue is the split index, as I know nothing about it, yet
it might require changes.

1.2) Commands
A git index create <name> [-m|--message <message>]
A git index delete <name>
A git index switch <name>
A git index update <name> [-m|--message <message>] [-n|--name <new name>]
M git add [-I|--index <index name>]
M git diff [-I|--index <index name>]

2) Example workflows
2.1) Working with indices/non interactive add
git index create "wip" --message="This is a default commit message" #
We have a new index, but the default one is selected
touch {example|example2|example3}
git add example # Added to the "current"/"default" index, by default 0
git index switch "wip"
git add example2 # Added to the "wip"/ index, with id of 1
git add example3 --index=default # Added to the "current"/"default" index,
git commit # commit message="This is a default commit message"
# At this point, index.1 (wip) is empty, but selected. We can commit
another index
git commit --index=default -m "This is a commit message for the default index"

2.2) Status
> git status
On branch main
Selected index: wip
Changes to be committed (wip):
  (use "git restore --staged <file>..." to unstage)
        modified:   example

Changes staged for commit (default)
  (use "git restore --index=default --staged <file>..." to unstage)
        modified:   example

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   example

2.3) Git add (interactive)
> git add --interactive # details omitted for brevity
-Example change
+Example change 2
(1/1) Stage this hunk to wip [y,n,q,a,d,e,i,?]?
> ?
i - change the current index

2.4) Remove index
> git index remove # removes current, all staged goes to the "default" branch/index 0
> git index remove wip # removes wip, all staged goes to the default branch/index 0
> git index switch default
> git index remove # Does nothing...
> git index rename default "WIP" # index[0].name=WIP
> git index remove # renames default -> index[0].name=Default
...

I am open for the feedback/questions, or early go/nogo.

Jacek Lipiec
