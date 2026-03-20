Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14633AE6F4
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012350; cv=none; b=hM9SNvyZPQGNJYizw9bDMB3tCUfctWhuH6B4e0sGIFyf+QgFf+XO4rIkjk6nQ5giohLjzN2hz6qgVBLdOdQwwxaAoKG6OAmoXmgugIp8wiIKFPrPnTK0ZaNKNS5Subn479oMLGGwRKQNlEkgOroJoXmcEQRbkiES7DuBPhlo2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012350; c=relaxed/simple;
	bh=PCpO/BaYYHbt2gWxrs7hbikDU34Cj4Xlw2Jpr+mwjcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX8ZCelM3ls8L+s//WLUvyH4lG6QP0ZmTmHShU3OMYwMKIj1alBkKSg3bAML4lffDxRzLFbiYlyrSpIRiXCa4eIgATAEcI8otrSwluewtcgSi0MLjw9FqEQYNMvAPA+3ozwDMWO6GRWi9gqhBZCir9VEUdwAuWyZaYsvyx0K/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgP+AiqD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgP+AiqD"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so1391743a91.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774012348; x=1774617148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA/emWIm3CbMl57BThIvkqVT/Hc3rNblclz5PQ7J1xM=;
        b=YgP+AiqDSr0S/OeZhjxy9mYiO0c8q4dNEDkwShwIdnF66El7HzqTMBIYKYF7fjJUqx
         2N0AzWFZZAsVQwPCRnO0UESd+HbzAk+I7hVsxYrqVDvD/T02XHhOW4uH3gC92Y0zZpOZ
         TQ3oaza/77oi9tNu5xCaMx3AH6UbbEyAut832f7FTeArkX9NL4Wo//CLXt8hp7ERANvu
         45xx5ftJiJwldjmAQwLpeKUC1RhvGCJvtQvQMq+kMNIaiIM3mUawqYaWIJvC0TdGfH+I
         D8120kuhfLZSSxToCNt3tnbwjw0QYInfKqdkvM0fcLNsqtlReu5OLVZjnmzlQkhrL847
         SxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774012348; x=1774617148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BA/emWIm3CbMl57BThIvkqVT/Hc3rNblclz5PQ7J1xM=;
        b=meZOfXzWTuhfhVFrmqR/vWz5ByDMmT8kD17tdOuHF0lMVTa+mf45jRjJKAV4URihlr
         IRstJPOQEo/t5wSCw9oUMlsa5ZU3o8i594albTYenH9EzFFNtkad7urs60aNL6H5XVR3
         aI6Gic+lGGL7WD56FzWIxJktzdYJ52Y2x5Mm32ZB1rQ4V9OFxO+BiZTIgU51kEqz33dN
         rp2w/fIIzZ1yIiiQslh/0ivB9s3HrkKq3zK2wSfmNNwjUyGw/1sexxx1tuPVfXpoPO7N
         +Z22f2gJQTFCtaFrJYjSEOx1Gafo0kChcrXXU5p7o4vmAkQdY7nuQogsLF5T+LuOjkHb
         M5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWVPEaUu3X0MKDqAFSHcldbzjOE25+1qxV7RfjKdOZrX2TWSiCuGH/PTMAAtiw/dYHo0ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6v4GVR2VJWGFxhmZtzMwE71286fy95mj7cpTwPIwjDc2HCG7t
	c4E5a2LCnpfg1D0FBM0A3DywjzVMtONXF6IOpnKa+L5tHkXw2frzpnjS
X-Gm-Gg: ATEYQzyYf1AvNyqUcpCCLM/GHODqbgFyn7EQ+wuSGhE6TsSGC05aThbfqObPRt3WpO1
	woT9riVTWz4XymrIrmDjswvC3hlEXU2grdU2AM2yvdKzttBC/tnaAV8c+F0D5BjzYyFHUr6Q9Kq
	bEi4+2YXs6WazzOzUpeDQ8Xi0RhTAo+n9jGr+of+lB4nsOv+OjTa/6Ln7NzUkauJQt04V6PR549
	QoUdkzST8u3yyEG5CNj/W61MkQCHNN/MM+Z2dWgDrKxYY3T0NH+vHyz1YmlMkHm8dPPkpZsmzAB
	7lITD4+28w4AE70aOjOVmZwMXyrZm+FDwasbrVH7/NfolsLB01xeoV+euyqdtrqCrx4GUW5jwZG
	gOeJQsQrc+jSqTOXXeSbalMnY087UvHpetEi/vTeUxYltBe8OLuhOhfDdzvN8wXaxBFspeIkOTJ
	nQfqMomFkVlJtnCyZY7YKr/fk2984hE/z86DpVJ86vsroqwhiUyPU+1K6TnulT286el3VLyw5xi
	ijoWOoPvEP9uUtu9vJ9FDfiriYxfp0gUot4Y0WZEzq/RTA1Pase2R632YkqahccZCNGu6WoL3PE
	bVs=
X-Received: by 2002:a17:90b:510a:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35bd2bd5ceamr2423863a91.1.1774012348008;
        Fri, 20 Mar 2026 06:12:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:102b:250:2142:4e75:ddcb:9d3d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb46b2sm2197908a91.2.2026.03.20.06.12.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 06:12:27 -0700 (PDT)
From: SoutrikDas <valusoutrik@gmail.com>
To: valusoutrik@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com
Subject: [GSoC Proposal v2] Complete and extend the remote-object-info command for git cat-file
Date: Fri, 20 Mar 2026 18:42:00 +0530
Message-ID: <20260320131200.3615-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305204809.54927-1-valusoutrik@gmail.com>
References: <20260305204809.54927-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi everyone,
Thank you for the feedback Christian and Karthik.
I have not made a doc version of this yet. I will link it from v3

I understand that in this proposal I have not explained my own plans that
thoroughly, I am working on this in v3.

Changes from v1 : 
- Correct spelling mistakes
- Address how much work is remaining after Eric Ju's Patch v11
- Increase Time in Timeline for Reviews
- Add a section for rebasing problems

---

This is the second version of my project proposal for GSoC 2026

I am interested in the project idea : "Complete and extend the 
remote-object-info command for git cat-file"


# Complete and extend the remote-object-info command for git cat-file

## Contact

- Name: Soutrik Das
- E-mail: valusoutrik@gmail.com
- Github: https://github.com/SoutrikDas
- LinkedIn: https://www.linkedin.com/in/soutrik-das/

## About Me

My name is Soutrik Das, I am a developer. I did my B.Tech in CS from 
IIT Dhanbad. Currently I am pursuing a M.Tech degree in AI from IIT 
Bhubaneswar.

I don't really have much experience in contributing to something as 
large as git, but I would like to learn as much as possible from this 
experience. I have experience in C/C++ from my Btech coursework and 
participating in codeforces contests.


## Pre GSoC

I started exploring Git's codebase around February 2026 and sent my first patch
as a docfix, followed by a microproject of modernizing tests 

- [PATCH] doc: fix repo_config documentation reference [1]
    status: merged to master 
    Merge Commit: 94336d77bcbf4360b67a9454d8bf2e84b3d88ae7
    Merge Date : 13 Feb 2026
    Description: Replace the path for the repo_config() documentation 
    from 'Documentation/technical/api-config.h' to 'config.h'.

- [GSoC PATCH] t7003: modernize path existence checks using test helpers [2]
    status: merged to master 
    Merge Commit: 11294bb0fa540d214d071b32cf74b1ed37b3bbbd
    Merge Date : 17 Feb 2026
    Description: Replace direct uses of 'test -f' and 'test -d' with
    git's helper functions 'test_path_is_file' ,'test_path_is_missing'
     and 'test_path_is_dir'


## Eric Ju and Calvin Wan's work

In this section I want to talk about the work already done and what 
feedback the community had on the last sent patch , ie v11 

This is my understanding of the patch series: 

Patch 1/8 : git-compat-util: add strtoul_ul()
    Helper function addition

Patch 2/8 : cat-file: add declaration of variable i inside for loop
    Small refactoring

Patch 3/8 : t1006: split test utility functions into new "lib-cat-file.sh"
    Moving the `echo_without_newline`,`echo_without_newline_nul` and 
    `strlen` function from `t1006-cat-file.sh` to `lib-cat-file.sh` to
    reuse them in future. 
    When I rebased the patch series against a recent master (March 5)
    795c338de725e13bd361214c6b768019fc45a2c1, there is only one other
    file ( t1007-hash-object.sh ) that has a duplicate definition. 

Patch 4/8 : fetch-pack: refactor packet writing
    Generalized write_command_and_capabilities so that it now takes in
    a command instead of hardcoding "fetch". It was also moved from 
    `fetch-pack.c` to `connect.c`

Patch 5/8 : fetch-pack: move fetch initialization
    Before this patch, the state machine of do_fetch_pack_v2() used to
    assume that starting state is FETCH_CHECK_LOCAL so it would initialize
    certain variables like `use_sideband=2` inside the FETCH_CHECK_LOCAL
    case. But now for remote-object-info we do not want to go through
    the extra steps, we are directly entering the state machine at
    FETCH_SEND_REQUEST. We don't need to figure out what to fetch,
    the user/machine is explicitly giving it.

Patch 6/8 : serve: advertise object-info feature
    Makes the server adertise that it supports the "size" feature of
    object-info command.

Patch 7/8 : transport: add client support for object-info
    Adds `fetch_object_info` which checks if protocol is v2 
    and then sends the object info request. After getting the result
    its parsing the output. 

    Also sets `state=FFETCH_SEND_REQUEST` when object-info is used.

Not related to above patch , but on the server side this request is
caught by serve.c and then handled by cap_object_info in protocol-caps.c

Patch 8/8 : cat-file: add remote-object-info to batch-command
    Adds the subcommands and relevant tests.

To summarize, this patch series has added the subcommand, and all of
the needed functions to make one object info field work. But a few problems
were left to be addressed. Once those are addressed, adding new object
info fields will be much easier. 

## Problems faced during rebasing

I applied the patches onto an old master (2d2a71ce85)  and then rebased
to a recent master (795c338de7) 

Patch 1/8: Auto / No Merge Conflict

Patch 2/8: Auto / No Merge Conflict

Patch 3/8: add/add conflict

Patch 4/8: Confirming movement of function `write_command_and_capabilities`

Patch 5/8: Auto / No Merge Conflict

Patch 6/8: Auto / No Merge Conflict

Patch 7/8: Makefile merge conflict but when opened in vscode it shows
0 conflict.

Patch 8/8: add/add conflict for object-store.c and modify/delete 
conflict for object-store-ll.h
According to 68cd492a3e 

> object-store: merge "object-store-ll.h" and "object-store.h"

And according to 8f49151763

> object-store: rename files to "odb.{c,h}"

Therefore I have added the function signature that was supposed to go to
object-store-ll.h to odb.h


## Work remaining to get v11 patch accepted

Almost all of it is focused on patch 8 

- Fix multi-line comment formatting - closing */ on own line
- Add blank lines between macro definitions
- Split overly-long MAX_REMOTE_OBJ_INFO_LINE definition across lines
- Change loop variable from size_t i to int i (since argc is int)
- Rearrange if/else to put smaller body first: if (!gtransport->smart_options)
    before else

- Fix the logic of maximum line size for the remote-object-info.
- Adding an allow list of object info fields 
- Handling what happens if an unsupported object info field is given in
    format string. 
    In this case we send the request as if such a object info field is
    not even there, and when printing the result we simply print an empty
    string on the client side. No extra payload on the network. 
 
- Add tests.
- Update Documentation 
    


## Project : Complete and extend the remote-object-info command for git cat-file

Currently in the case of a partial clone, the user cannot retrieve all 
object data without fetching the object beforehand. To solve this problem
Calvin Wan and Eric Ju had designed a patch series that can solve that,
by utilising protocolv2 servers capabilities.

This was done in the form of "remote-object-info".

But only the %(objectsize) was implemented, and that patch was not merged. 
This project has two goals 

1: To Rebase and finalize Calvin Wan and Eric Ju's Work by addressing
    the feedback on Eric Ju's Patch v11. Work for this part is discussed
    above in above section.

2: To discuss with the community and add support for other relevant 
    object info fields `remote-object-info` like `objecttype`, 
    `objectsize:disk` and `deltabase`

Project Duration : 13 week approx

## Timeline 


### Phase 1 : 

May 1-24 : Community Bonding + Start Design discussions on 
            Logic of allow list implementation
            Logic of maximum size of the remote-object-info command
            Which object info fields should be supported

Week 1 (May 25 - 31) : 
    Open Patch Series 1 for Eric Jus patch, after 
    solving all remaining problems. Use the discussed idea/solution from 
    above. Both client and server side work would be in the same patch 
    series. This is just rebasing previous work so I have to address 
    the changes suggested after v11.

Week 2 (June 1 - 7) : Continue discussion, review feedback and refine.

Week 3 (June 8 - 14) : Review feedback and refine

Week 4 (June 15 - 21) : Review feedback and refine + Update Documentation
    and Tests

Week 5 (June 22 - 28) : By now all tasks regarding Merging Eric Ju's 
    patch should be finished. But since it may take more time for 
    reviewing I am adding a buffer weeks.

Week 6 (June 29 - July 5) : Polish everything + Midterm report

Week 7 (July 6 - 12) : Midterm evaluation ( July 7-11)

Week 8 (July 13 - 19) : Start Patch Series 2 for adding other object info
    fields as per the discussion started in Week 1.

Week 9 (July 20 - 26) : Review feedback and refine.

Week 10 (July 27 - August 2) : Review feedback and refine. 

Week 11 (August 3 - 9) : Finalize all tests and Doc changes.

Week 12 (August 10 - 16) : Prepare Final report.

Week 13 (August 17 - 23) : Final Evaluation ( Aug 18-24 )



## Availability

My current semester is ending in the first week of May, so I will be
able to contribute 7-8 hours per day, totalling around 35-40 hrs a week
on the project.

Total weeks = 13 , total hours = 35*13 = 455
It leaves with a lot more room to accommodate any unforeseen circumstances
that may arise during the project.

## RFC 


Hi Christian and Karthik !

I still feel like the single object get remote info might be useful
and I think this might be where I can add this functionality :

When someone does `GIT_NO_LAZY_FETCH=0 git cat-file -s <oid>` 
And the oid is of a blob that is not on local, then git simply fetches
the blob and reruns git cat-file -s. 

But if someone does `GIT_NO_LAZY_FETCH=1 git cat-file -s <oid>` 
And the blob is not on local then it exits with the following error

>	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
>		static int warning_shown;
>		if (!warning_shown) {
>			warning_shown = 1;
>			warning(_("lazy fetching disabled; some objects may not be available"));
>		}
>		return -1;
>	}

Would it be useful behaviour if instead of exiting with an error it sent
a remote-object-info request for that single file ? 


Thank you for your time in reviewing my proposal as well as considering
my application. I am excited to learn everything I can from git.


Thanks and Regards,
Soutrik

[1] : pull.2187.git.git.1770293021383.gitgitgadget@gmail.com
[2] : 20260209172445.39536-1-valusoutrik@gmail.com
[3] : 20260225190306.39358-1-valusoutrik@gmail.com
[4] : 20240628190503.67389-1-eric.peijian@gmail.com
[5] : 20220728230210.2952731-1-calvinwan@google.com
