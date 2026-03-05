Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EF34752D
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743712; cv=none; b=N/3SDWtAj9SuQ6H4T4C6WqAMEeI1ueXCrRNJWBqE7mKFsD7trkTZlTeBGo0Yx1ZMjegeeCQHNh5eiDKkuTnhJpfUGhabTSp1zmlP+WHANVQANNd0/NeQd0IEWr0NVM26dyeIDsDFSmlgOh+j50lHMAdWL/vkS5k6/hhnHkXfcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743712; c=relaxed/simple;
	bh=g2c8TpMRK5AwfzzQARJ+fiPIQJYlyfyKF/8GjPBiSzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QviIeetwj6JpbFKq3vNJaRO9N3srd8L3BhPQtWsw1ZcPNQGmIF9aunnsudD5k5bcq3Shv+h2iMPw5ITBXFFrrvXa1F+eR8jR0jh6pLE1isfegUvUcYO+BN+8wT+bYSZVhRubjiCdRyLqyNggaMa3B20xLehqZPFmqOhsN6bRJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiiK6lJQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiiK6lJQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae56f8776dso32940495ad.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772743710; x=1773348510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kn6CP/dHNmTSwFvoG0Phw5XN5kAWgh6M1xfloQ5WBFY=;
        b=IiiK6lJQjV+C0nlWLSSKY3t9A3xsoANTTj2gW9tIDSVI48kQdKZ19IhqSHR0miJy3P
         K60WBmOXXV0FK+3UxWtMfHfUTB14c2KmG21TwA4d2vSnKKeFOdyErcVyG+wcQtUlAc6B
         1e19cnzTbIXOjwV4zxHhyO8jChDZhG4XFufHxcCoTV3u8jofpQ+lMMsBu2Xhleg0nJSO
         dzFlzLzVC9XGqEqMNLI1jiBP/HavV4u5i6ejgPofxPH0zG0SmGqONEgQbM+zEipR/d95
         phco6sjIN6l294S5JeUcaIgm7e/nDY2aKqK2/fX+rZAU0LlIA0miWVlj7kDP9xZOm4fP
         cfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743710; x=1773348510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn6CP/dHNmTSwFvoG0Phw5XN5kAWgh6M1xfloQ5WBFY=;
        b=SnN3L4GOU29ytpsNSJ7GHC1QOh8D5M/yqlPLi7poCJvrAST0PhIBSKbuoAgHdAcWym
         ye1U2QA75oJze6pZySQA1tRyWJ1rIuncqeGbmDKUurv8855NtUlQ3elgeKd1tfyCKRZa
         csP0RyACmhhw1uatpPBehli43ns9rbm/Mh8KhuxJASWHQiyMC/O9sEzSAYoA7aqKcg83
         ezgKfvAy9NFi5TEsZGYgZzhri0B/gvGVwa2C3GuapnRhDqQvqlOfiizcMlgXddYHebar
         WG2ifNkptG7HJRvzXqKYBBSYhCk3uYOSGo4WqOT44dM8q1XJ1pULGdKCaM3c/OLkswMF
         rrGg==
X-Gm-Message-State: AOJu0Yx4b3+hi0dHhqWBWABbmJGwcOKhdQUlvqgKP4kBwdm/UuopIbHh
	f+ikjXvsDVew0JiN8hp4Pe4HbRdElNtWmaMKDknXYvxkRz41RQv0srDfRPd/THkB
X-Gm-Gg: ATEYQzyNYQnQHPA2Qo9+3gAbwV5pXa5PoyGq21my9TrL8DovTVS2WPBNdoEPP70bnbq
	FgzEURzmX+P9A3MOXaufRD9nVZcDYgUe3MctOu2HPA2QFloXKMOsbTcZReZh4eohv4i53xjy91e
	uknCMLJBT6YOxg3RQxSM9U+t3i0wyVGTWv8Gp84ZNxdd6CjVxD4wgWt4FKCu2xVxbQN58xiVHeo
	LE2wnSlCxhvTWjO/ChaBbCGXLCohw8M3Du8j2HNIMFgGyuuZlxxQiKKAqhqmlalCpew9WBRXeEn
	PrWt72qWity8NBpaT/45S9Buxt+LIaEPJRSzEZV/rf9IYlCG8KkFSJt3PFE0nrKbX6UzVejgmGH
	6qEFspeYUGkBWUvd0QjLBxRAYpZkbvpVe5nieagVDhefu4zln2fAHmOYLyf5AxdIf9ZmzGvQCUF
	e7GdjR1ImsZ8jfK5Sa/tZI42qdpkSn5vL8l2JfSaiu9NTmgBquE6vPe/1FAH10miJ72jGNxvBvV
	vwmPlhj99V9EGPFA8aSsa36Vmk+tvyVw8OQ5GbfzR2XDS1gF/cfKXJZp0pXoaH46asSlp2Ixu9Q
	nXOuMw083g==
X-Received: by 2002:a17:903:283:b0:2ae:606b:bd98 with SMTP id d9443c01a7336-2ae6aab2a33mr68911845ad.26.1772743709845;
        Thu, 05 Mar 2026 12:48:29 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:1019:11ad:a5d4:131f:3bb3:e156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4dcf80f2sm128167875ad.90.2026.03.05.12.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Mar 2026 12:48:29 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com
Subject: [GSOC Proposal] Complete and extend the remote-object-info command for git cat-file
Date: Fri,  6 Mar 2026 02:18:09 +0530
Message-ID: <20260305204809.54927-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi!

This is my project proposal for GSOC 2026

I am interested in the project idea : "Complete and extend the 
remote-object-info command for git cat-file"


# Complete and extend the remote-object-info command for git cat-file

## Contact

- Name: Soutrik Das
- E-mail: valusoutrik@gmail.com
- Github: https://github.com/SoutrikDas
- LinkedIn: https://www.linkedin.com/in/soutrik-das/

## About Me

My name is Soutrik Das, I am a developer and CS bachelor from Indian 
Institute of Technology, Dhanbad. Currently I am pursuing a master's
degree in AI from Indian Institute of Technology, Bhubaneswar.

I dont really have much experience in contributing to something as 
large as git, but I would love to learn anything and everything I can
gain from this experience. I have experience in C/C++ from my
Btech coursework and participating in codeforces contests.


## Pre GSOC

I started exploring Git's codebase around February 2026 and sent my first patch
as a docfix, followed by a microproject of modernizing tests 

- [PATCH] doc: fix repo_config documentation reference [1]
    status: merged to master 
    Merge Commit: 94336d77bcbf4360b67a9454d8bf2e84b3d88ae7
    Description: Replace the path for the repo_config() documentation 
    from 'Documentation/technical/api-config.h' to 'config.h'.

- [GSOC PATCH] t7003: modernize path existence checks using test helpers [2]
    status: merged to master 
    Merge Commit: 11294bb0fa540d214d071b32cf74b1ed37b3bbbd
    Description: Replace direct uses of 'test -f' and 'test -d' with
    git's helper functions 'test_path_is_file' ,'test_path_is_missing'
     and 'test_path_is_dir'


I have read through most of Eric Ju's [4] work and some of Calvin Wan's [5]
work. I am still finding more things to understand from each thread, but 
I feel I have grasped the basics.

My work in this project would be focused on implementing the changes
suggested at the end of Eric Ju's [Patch v11].

I wouldn't say I understand every bit of discussion from that thread,
but in general my understanding is :

Calvin Wan and Eric Ju has already implemented a client side command
called get_remote_info but its designed for being batched to reduce
multiple network trips to get a single object's data. 

I have added Eric Ju's patch series to an old master commit (2d2a71ce85)
since I could not find a base commit for Eric's patch series. The patch
was properly applied and I also played around and added a very rough
but workin "%(objecttype)" code , ie now it prints like this : 

29658341f39210201ff7f72a4be83937cf2288c5 14 blob


## Project : Complete and extend the remote-object-info command for git cat-file

Currently in the case of a partial clone, the user cannot retrieve all 
object data without fetching the object beforehand. To solve this problem
Calvin Wan and Eric Ju had designed a patch sreies that can solve that,
by utilising protocolv2 servers capabilities.

This was done in the form of "remote-object-info".

But only the %(objectsize) was implemented, and that patch was not merged. 
This project has two goals 

1: To Rebase and finalize Calvin Wan and Eric Ju's Work by addressing
    the feedback on Eric Ju's Patch v11 

2: To add support for objecttype in remote-object-info

3: To discuss other information type like objectsize:disk and deltabase.

Project Duration : 12 week approx

## Timeline 

Mar 6-31 : Refine Proposal

    If possible I would like to submit small patches... but first I will
    have to rebase Eric Ju's Patches ... I am not sure if I can do this
    before GSOC...

    If not, I plan to contribute to git in other areas.

May 1-24 : Community Bonding 
    1-7  : Understand relevant underlying/ helper functions
    8-24 : Ask about any design related problems/decisions

May 25 - Jun 14 : Start a Patch Series to rebase Calvin Wan and Eric Ju's work
    and keep refining

Jun 15 - Aug 15 : Start and keep refining Patch Series to add support for
    object type information

Aug 16 - Aug 24 : Discuss and Implement other object information if possible
    Concurrently I shall make a report for all the work done.

## Availability

My current semester is ending in the first week of April, so I will be
able to contribute 7-8 hours per day, totalling around 35-40 hrs a week
on the project.

Total weeks = 12 , total hours = 35*12 = 420 
It leaves with a lot more room to accomodate any unforeseen circumstances
that may arise during the project.

## RFC 

I have a few ideas but do not know if they are worth pursuing, so I will
leave them here in the first draft 

- Addition of a remote-object-info outside of batchmode :
    Yes it should be optimally used in batch mode .. but if user wants
    only one objects size or type then should they be able to just 
    `git cat-file -r origin <oid>` 
    and get the size and type ? or something similar , I am not sure if
    the way I have depicted it conforms to git's design.

- Addition of commands for common user behaviour :
    I dont know if its going to be a common user behaviour but what about
    `git cat-file -r --all-absent` 
    Or inside "git cat-file --batch-command="<format> remote-object-info 
    --all-absent --type=tree <remote>"
    which would basically fill in remote-object-info with all the blobs
    that are currently absent from the worktree ?
    No need to fill them if its for a common enough use case.

- Sort according to size :
    Maybe a user would want to check whats the largest file they dont
    have yet.

- Get total missing blob size :
    Use case would be when someone wants to know how much exactly there
    is to download, before starting the download.
    
Thank you for your time in revewing my proposal as well as considering
my application. I am excited to learn everything I can from git.

Thanks and Regards,
Soutrik


[1] : pull.2187.git.git.1770293021383.gitgitgadget@gmail.com
[2] : 20260209172445.39536-1-valusoutrik@gmail.com
[3] : 20260225190306.39358-1-valusoutrik@gmail.com
[4] : 20240628190503.67389-1-eric.peijian@gmail.com
[5] : 20220728230210.2952731-1-calvinwan@google.com
