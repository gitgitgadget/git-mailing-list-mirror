Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6561DFFD
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167194; cv=none; b=stq2koIF8JADSDNRD995Ej66wQhhqiDF+yNla2y4Zzr7kYm9sGPxjv/geZVs7bDqcSA7v8Hv75T0UEcW/G0aublC8MR6WfkhnikvFu7uHVYa0B99zQKXeOlmrpYjPu5y8SRxm63p8ScsrFgQDhX6Cdw9k8rotHg6WkZSx5fYHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167194; c=relaxed/simple;
	bh=Jct/VNVfOoR/PuEPlK/vmdvD+uBM3Cysjs8Vwd3ocO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTw6jLvNiPvLkWRNdVK1rqpclJDE14ShmQ+I5tBvUSKeYZBAmAAZQDsitkco24utyjcLrMoWqb4/MgrGmIzFysijkwwfH4FrYQUqad+7A9B/sNEq1Ui/HvoFq5qjrskQteUDxSpukXMwX4kfhtKzuQ8vF+sYfrVs1OfKB15Yj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXTNmiA2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXTNmiA2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224019ad9edso2133435ad.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743167192; x=1743771992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vWxIwGo7boxu1UhD4K13PuKRg2m6teFR+MteuaVBwaI=;
        b=dXTNmiA2vx5lUdQSRZEXToDPZZn8vSbeiLQhVmFC8mfQ+JK1d0twxrOtZnP0ho1/oc
         K1BY1CrbLXkQeE0sAGksUVIpw3wKHlW95eSZnkEYw7rMsFn5GIti2qFUveIfsnqNO1lr
         uKq2WA37e6bcJjeS4+Dqnz6HXZrZGtLnN9KKkGKq+6IHxr8Ko7+stXu1BRf5uF5T+40r
         nPMMy4RguA5f/oe1kNnbUgy0VL51t8EcYpZiEXiU8+Az1YZ/0vmY+oVbA/ujz+LFiTEp
         chS7lJUNJCRZXL5H2d97DIgcNLnD4c/zhHCrPgGe+7b3wHX1xE1n0RpillSIwhdg6NHM
         MBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743167192; x=1743771992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWxIwGo7boxu1UhD4K13PuKRg2m6teFR+MteuaVBwaI=;
        b=nrgybry0ZFa2ntRzQ9AjsbZRGhJQP0xY562M23U6S+fkI5A3TcboTADxPcLtGqub5n
         lTN1nQYT6Or+B5K3Wqm/lLOVU1clNdH0Kj04H+ld+fkUfOIftmKtTa50ghn5MneMNdeB
         LoMMr7W3s76hzpElhYT/MMqn6DPvtgaZLxSZZVIH967jMpnCJmtgMlOmteF0uP8Gyeup
         8nOJT0RAqfVWFWY8vXB5N3duCXTKTdGXNSO1V0Gv3zASbFkxXJk7vDzKTDD5/UOxkOZT
         67wRB6EGG+9SnL7WBvTWlVjywvy1WbzSdVuX+DZF0mEegVfVnV2bWHmlErzUJNA9wZ2c
         PC/g==
X-Gm-Message-State: AOJu0Yyqj/8q9KwWrkW217m8fSyRd/w/dwHq1R5oVA/Nh4ANeZsSACeV
	WCNKMNW0Di17wej3H7nY0wSxuNzR/kegyyslq//Ks1pu5jyLWOgC/0OrtOIm
X-Gm-Gg: ASbGnctbCrOjPzNUTSSD5Br15+X5xMM11MfvP3RoV1HBD9o2u3wT4ohR6Azb4SRZdSm
	DO9lolBabOBvyyuj5Yo6iuY5rwrqLNmkFVA0m59F4UiGzimoJCOgBt4mBcvjSwehIwx5Dzw4hn2
	jJpuGop7epVCoIbad0BI0sHRrDwznH5nxAxrbW/VoYkkYhRY7nJfbHxSz0zwy9ehDH8P7h8YrYB
	1xmabDxrvHTQRiQrnFNg5OI38GGgVgHj/sF0A+kP+vxA1j1OeDaPF6gtehwxsXU2NGMu0PyHR/K
	+bszOf+iSqHomlV4eFTMVtLCuYVjs/yZNUlo7TLi
X-Google-Smtp-Source: AGHT+IGWnsprGsmonuwoL+ggXl1K8+5R77Su0m/cziGt6C1aQmeT3H0o3cvG3qoqWDl6XVnsxHgUsg==
X-Received: by 2002:a05:6a00:22d2:b0:736:6268:9ec9 with SMTP id d2e1a72fcca58-739610a4f08mr11552137b3a.16.1743167191115;
        Fri, 28 Mar 2025 06:06:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73971092197sm1681431b3a.134.2025.03.28.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:06:30 -0700 (PDT)
Date: Fri, 28 Mar 2025 21:06:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com,
	christian.couder@gmail.com, shyamthakkar001@gmail.com
Subject: Re: [GSOC] [PROPOSAL V1]: =?utf-8?Q?Refact?=
 =?utf-8?Q?oring_in_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <Z-ae2l6fkurPNuPe@ArchLinux>
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326052602.265989-1-ayu.chandekar@gmail.com>

On Wed, Mar 26, 2025 at 10:56:00AM +0530, Ayush Chandekar wrote:
> Hello,
> This is my GSoC 2025 proposal for the project "Refactoring in order to reduce Git’s global state".
> You can view docs version here: 
> https://docs.google.com/document/d/1tJrtWxo1UGKChB3hu5eZ-ljm0FtU_fsv0TnIRwu3EKY/edit?usp=sharing
> 
> ---------
> 
> Refactoring in order to reduce git’s state
> 
> My Information:
> ---------------
> 
> Name: Ayush Chandekar
> Email: ayu.chandekar@gmail.com
> Mobile No: (+91) 9372496874
> Education: UG Sophomore, IIT Roorkee
> Github: https://github.com/ayu-ch
> Blog: https://ayu-ch.github.io
> 
> 
> About me:
> ---------
> 
> I'm Ayush Chandekar, a UG Sophomore studying at Indian Institute of
> Technology, Roorkee. I like participating in various software development
> and tech-development endeavors, usually hackathons, CTFs, and projects at
> SDSLabs. SDSLabs is a student-run technical group that includes passionate
> developers and designers interested in various fields and involved in multiple
> software development projects that aim to foster a software development
> culture on campus. Being a part of this group has exposed me to different
> software development methodologies, tools and frameworks and helped me become
> comfortable contributing to an open-source project with multiple contributors.
> Some open-source contributions I made here are: [1], [2] & [3]
> 
> I see this project as a meaningful opportunity to deepen my involvement in
> the Git community and to build a foundation for continued contributions to
> open source development in the future.
> 
> 
> Overview:
> ---------
> 
> Git currently uses a global object called `the_repository`, which refers to a
> single instance of `struct repository`. Many internal functions rely on this
> global object rather than accepting a `struct repository` as an explicit
> parameter. This design inherently assumes a single active repository,
> making it difficult to support multi-repository use cases and obstructing
> the long-term goal of libification of Git.
> 
> A key architectural limitation is that while `struct repository` encapsulates
> some repository-specific information, many important environment variables
> and configuration settings that logically belong to a repository are still
> stored as global variables, primarily in `environment.c`, not within the
> `repository` struct. As a result, even if multiple repositories were to
> exist concurrently, they would still share this global state, leading to
> incorrect behavior, race conditions, or subtle bugs.
> 
> This project aims to refactor Git’s environment handling by relocating
> these global variables into appropriate local contexts primarily into
> `struct repository` and `struct repo_settings`. This change will not

I think we could just improve this statement better. Some global
variables may only apply to one subsystem or two subsystems. In such
situations, we may just put the global variable into their own context
but not the "struct repository" or "struct repo_settings".

> only make the environment state repository-specific, but also improve the
> modularity and maintainability of the codebase. The work involves identifying
> environment-related global variables, designing a suitable structure to
> house them within the repository context, and updating all affected code
> paths accordingly.
> 
> The difficulty of this project is medium, and it is estimated to take 
> 175 to 350 hours.
> 
> 
> Pre-GSOC:
> ---------
> 
> I started exploring Git’s codebase and documentation around the end of
> January, familiarizing myself with its structure and development practices. I
> submitted a microproject, which helped me navigate the code and contribution
> workflow.
> 
> After selecting the project on refactoring Git’s state, I studied the
> surrounding code and reviewed past patches ([4], [5], [6], [7], [8] & [9])
> to understand the reasoning behind previous changes. To better prepare
> for the GSoC timeline, I also submitted a patch related to the project,
> gaining hands-on experience with both the implementation details and the
> submission process.
> 
> 
> Patches:
> --------
> 
> + (Microproject) t6423: fix suppression of Git’s exit code in tests
> 	Thread:
> 	https://public-inbox.org/git/20250202120926.322417-1-ayu.chandekar@gmail.com/
> 	Status: Merged into master 
> 	Commit Hash: 7c1d34fe5d1229362f2c3ecf2d493167a1f555a2 
> 	Description: Instead of executing a Git command as the upstream component of
> 				 a pipe, which can result in the exit status being lost, redirect
> 				 its output to a file and then process that file in two steps to
> 				 ensure the exit status is properly preserved.
> 
> + midx: implement progress reporting for QSORT operation
> 	Thread:
> 	https://public-inbox.org/git/20250210074623.136599-1-ayu.chandekar@gmail.com/
> 	Status: Dropped 
> 	Description: Add progress reporting during the QSORT operation in 
> 				 multi-pack-index verification. While going through the code, 
> 				 I found this TODO, which I thought was interesting however my 
> 				 approach assumed that the qsort() operation processes elements
> 				 in a structured order, which isn't guaranteed.
> 
> + Stop depending on `the_repository` for core.attributesfile
> 	Thread:
> 	https://public-inbox.org/git/20250310151048.69825-1-ayu.chandekar@gmail.com/
> 	Status: WIP, needs more discussion.  
> 	Description: This patch refactors access to the `core.attributesfiles` 
> 				 configuration by moving it into the `repo_settings` struct.
> 				 It eliminates the global variable `git_attributes_file` and 
> 				 updates relevant code paths to pass the `struct repository`
> 				 as a parameter.
> 
> 
> Proposed Plan:
> --------------
> 
> I have been reviewing global variables across the codebase to understand their
> dependencies and impact. To do this, I examined `config.c` and cross-referenced
> it with `environment.c` to see how these variables are currently managed. The
> goal of this project is to eliminate global variables by moving their
> configurations into repository-specific settings. This involves:
> 
> -   Identifying all occurrences of these global variables.
> 
> -   Removing dependencies on `the_repository`.
> 
> -   Updating function signatures to pass `struct repository` explicitly.
> 

When reading this, I feel a little wired because I think in [1], you
have already realized that we should move some global variables to some
specific subsystems.

[1] https://public-inbox.org/git/20250310151048.69825-1-ayu.chandekar@gmail.com/ 

> -   Replacing global variable references with repository-scoped configurations.
> 
> Instead of adding all variables directly into `repo_settings`, we can group
> related variables into specialized structs (e.g., `performance_config`,
> `behaviour_config`, `whitespace_config`) and embed these within `repo_settings`.
> This approach ensures a more modular and maintainable design while keeping 
> `repo_settings` manageable.
> 
> I have also created a diagram explaining this structure in [10].
> 
> With this approach, I can structure the patch series by grouping the refactoring 
> of related variables within specific structs. This will help maintain a clean and
> organized codebase while also making the development and review process more 
> systematic and efficient.
> 

Yes, it's a good idea to use sub-structure to make the code be cleaner.
However, from my own experience when being a GSoC student, we should not
consider about this due to that we will over-engineer this.

You need a lot of time and effort to convince the community why the
design is good and why we should put this variable into this
sub-structure.

Instead, you'd better focus on which variables you want to remove
firstly. And how do you try to remove them with some simple steps. This
would make you more concentrate on the jobs you need to do and reduce
the risk.

> One key challenge is determining which variables should be part of
> `repo_settings` and which should remain separate. While working on the patch to
> refactor access to `core.attributesfile`, I received feedback from Junio that not
> all global variables should be blindly moved into the `repo_settings` struct.
> This reinforced the need to carefully assess which variables belong in `repo_settings`
> and which should be handled differently.
> 

Yes, this is correct. I somehow think whether we should put this
paragraph into Pre-GSoC part? I think that you have found this when
adding a patch to remove one global variable. And thus by communicating
with the community, you have further understood that the requirement and
the detail of this project.

And in your plan, you should just say that we need to do this. Would
this be better?

> This plan is flexible and may be refined through multiple iterations as I receive
> feedback from the community and reviewers.
> 
> Timeline:
> ---------
> 
> Pre-GSOC: 
> (Until 8 May) 
> -	Explore the codebase more, focusing on environment-related code paths.
> -	Document how each global variable is used and how it can be moved to 
> 	repository settings.  
> -	Study Git’s Coding Guidelines and the Pro Git Book to align with best practices.
> 
> ----------
> 
> Community Bonding: 
> (May 8 - June 1) 
> -	Engage with mentors to discuss different environment variables, their 
> 	dependencies, and the best approach for refactoring.
> -	Finalize an implementation plan based on discussions.
> -	Since I will be on summer vacation, I can start coding early and make progress 
> 	on the project.
> 
> ----------
> 
> Coding Period: 
> (June 2 - August 25) 
> -	Refactor global variables, replacing them with repository-scoped 
> 	configurations.  
> -	Modify function signatures to pass `struct repository` explicitly instead
> 	of relying on `the_repository`.
> -	Categorize variables into specialized structs to improve modularity and
> 	maintainability.  

As I have said, this is a high-risk task. Categorization needs many
iterations. And we may do this after GSoC.

> -	Continuously submit patches for review and incorporate feedback from mentors
> 	and the community.  
> -	I plan to write weekly blogs which will document what I did in the whole 
> 	week.
> 
> ----------
> 
> Final Week: 
> (August 25 - September 1) 
> -	Write a detailed report on the entire project.  
> -	Fix bugs if any.  
> -	Reflect on the project, noting challenges faced and lessons learned.
> 
> 
> Blogging:
> ---------
> 
> I have also set up a blogging page at [11]. While reading blogs from previous
> GSoC contributors, I found them useful in understanding the challenges
> they faced and how they approached their projects. Their experiences gave
> me a better idea of what to expect and how to navigate the development
> process. Inspired by this, I decided to start my own blog to document my
> journey throughout GSoC. This will not only help me track my own progress but
> also serve as a resource for future contributors who might work on similar
> projects. I plan to share updates on my work, challenges encountered and
> insights gained from discussions with mentors and the community.
> 
> Additionally, I hope my blog encourages more people to contribute to open
> source by providing a transparent look into the development process. Writing
> about my experience will also help me reflect on my work and improve my
> ability to communicate technical ideas effectively.
> 
> I liked the format and structure of Chandra's blog, so I decided to use the
> same template for my own blogging page.
> 
> 
> Availability:
> -------------
> 
> As a college student, I intend to utilise my summer breaks from May to July
> to work on the project. After completing my University exams in April, I can
> start working in May. I can dedicate 40 hours a week from May to July, while
> in August after the classes commence, I can dedicate about 25 hours a week.
> 
> There are no exams or planned vacations throughout the coding period. Besides
> this project, I have no commitments/vacations planned for the summer. I shall
> keep my status posted to all the community members and maintain transparency
> in the project.
> 
> 
> Post-GSOC:
> ----------
> 
> Beyond contributing code, I strongly believe in giving back to the community
> and helping others grow. Open source thrives on mentorship, knowledge sharing,
> and long-term involvement, and I would love to continue contributing even
> after GSoC ends.
> 
> I have always valued mentorship, both as a mentee and as someone who enjoys
> guiding others. If given the opportunity, I would be more than happy to
> mentor/co-mentor future GSoC contributors. By staying involved in the
> community, whether through contributing, reviewing patches, or mentoring,
> I hope to help sustain and expand the project’s reach. I look at GSoC as not 
> just as a one-time contribution but as a step toward a longer-term relationship
> with open source.
> 
> I will continue to be involved with Git even after GSoC by contributing patches,
> reviewing code, and participating in discussions. My work on refactoring Git’s 
> state aligns with long-term improvements to the codebase, and I plan to keep 
> refining it beyond the program. I see GSoC as just the beginning of my journey
> with Git.
> 
> Appreciation:
> -------------
> 
> I appreciate the Git community for its excellent documentation, which made it 
> much easier for me to understand Git in depth. The well-structured resources 
> helped me navigate the codebase and gain a deeper understanding of how Git 
> works internally.
> 
> Beyond the documentation, I am also grateful for how welcoming and supportive 
> the community has been. Whether through discussions on the mailing list or 
> feedback on my patches, the information and guidance I received made my 
> experience even better.
> 
> Additionally, I read the blogs and proposals of Chandra, Jialuo, and Ghanashyam, 
> which provided valuable insights into their journeys and helped me shape my 
> own approach to contributing.

I'm happy that my blogs help you.

> 
> Thanks for reviewing this proposal.
> 

Thanks for your proposal!

> References:
> -----------
> 
> [1] https://github.com/sdslabs/beast/pull/374
> 
> [2] https://github.com/sdslabs/beast/tree/add-teams-with-hint
> 
> [3] https://github.com/sdslabs/playCTF/pull/177
> 
> [4] https://public-inbox.org/git/pull.1826.git.git.1730926082.gitgitgadget@gmail.com/
> 
> [5] https://public-inbox.org/git/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im/
> 
> [6] https://public-inbox.org/git/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im/
> 
> [7] https://public-inbox.org/git/pull.1829.git.1731653548549.gitgitgadget@gmail.com/#t
> 
> [8] https://public-inbox.org/git/cover.1733236936.git.karthik.188@gmail.com/
> 
> [9] https://public-inbox.org/git/cover.1724923648.git.ps@pks.im/
> 
> [10] https://www.mermaidchart.com/raw/327324ea-af1d-4a98-8bff-254479b3a79c?theme=light&version=v0.1&format=svg
> 
> [11] https://ayu-ch.github.io

Jialuo
