Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2F346AF4
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211503; cv=none; b=YOgR+KPrYMPmPYlA1S1pxpNL8SZbvSzu03s4J3JlarcRQOyEx8ghDan8mxRYdQWn8wTSiafUOIAyDFnvWS6BqrxZlbRA1fcvz1P7jRfz0UrBaDI2fVql14FhSDz1N6FFhKY9G+waOHBdvdK/TYe8WNNdl3ejPqtkUqgpeAEBgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211503; c=relaxed/simple;
	bh=eDZd/uSo4VVHtMV8ZaoeZMnsw2y3ry1U83wC/O6KwqI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=prpVJpZJrMRJyjn8qL1h6RQU2oQEaMK1CldfRUTmlrDWmCGNLyPifAxwDKt//VAv2QOFgI3Vc60/geBEc55wR3QoZk4xRWitPSg122LdALzbJ22g+6LYL0U3dwxMeQv/hm/3x4J/nf6mGQkiiImtziTHr3goRefRSI8+qP/6mNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc2Puiqe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc2Puiqe"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70c1da52c4so119389a12.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772211501; x=1772816301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Elr7iTqJ+Ev+qtQNJHQonPOI4QwDDDHinkM15gc3mfE=;
        b=lc2PuiqeMmFSWgvyHtF7iX2yV/F8N97E/8E+8d/3ngqzDqOkzQTj3R9OE3yyeGG4hf
         E8ZGkA40ihRPp1VvRYJI+jg+ItgF1lGPLEEFLryYVJ1QkE1ksaRwgqZYaq4YPNiFNK7S
         LTXil6ZBO1EOyFwIxc5p8oJW5eF53Q8QTlxqAjfHKWRDzDfSwCopCQRO/hweXwq63zlW
         0TcQKXpdeeIbsKhGHGk4s1SH7+IHPTaROX8iODLA2dgqEb61lgQiufRBLsKQcaINs/KC
         gZF4fBKBfrnGxZgXpCrSLMNoSlmfX9y67gllLkYQEheECyLFDvExe+w8UI6OrCTBdfGN
         bUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211501; x=1772816301;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Elr7iTqJ+Ev+qtQNJHQonPOI4QwDDDHinkM15gc3mfE=;
        b=N1xOIAfwF8YEQp6etDsQZV+i1WUBxyIQX69Vy7GPMAJxb+QfwmbnqroR3K5sZRMgG/
         Ge1OL4rZ8C1AR7DuAAjIv2widp4YulR7ohMYosFDpDUFZ5LN3cYXjQYGsHrE1yz/KdW4
         BJwqg4vb7nCJhGJNjAyp30Q3QvUpzrBR5DQh87ijJSQCpf0WINIbXGTbqc3S5BomzXBa
         tr2sY/8AnxPOteWx64VbK/XKr4v5IjgH/j55lj2sLOcgFQyOsb6LqCCLLZutD4/sCzKA
         8gEi8dqWCAB3XzQLj1DrmeA+fbjHMdBv+Bl+SehQ00ra3FarLtBQtLXqoLDdv+cTDhpS
         a6Ug==
X-Gm-Message-State: AOJu0Yzadgdd3KaN9FZkEvqeFZIyoVRJZu344FLAEmEAPjmblctNeFDT
	gSyqMlCZGa/nnZWcjRgN+D56JYyrnHiho3arrS235UYZPPS/h9WawL+C7Lcfbg==
X-Gm-Gg: ATEYQzz8GwfyyLCRbYtWp6y6YCCx8qBOJWhTU5JHler0CNlUalSlsSAkiRsUajlR4xP
	BSKD4MTU2JuOpzu0PeTTet3kFlKMqWHfkOapG/WXRL/2JRKOby/0RkmQ6dApYL5rf48jn+k/AJx
	58IRNLbZa5xcnPGezM+56fHZDOGg5p5il5D6q1TmtzfXFdgu1TiWKmC2Y+DQuYu6dzzD1/wLbYV
	c070BPat3i9Nf959p2kvVrAgDkOKcSv1tie0Q8ur94Lpx+77CRsVTm3Sl1a2sXHsJjd9l+BtzvI
	NFbWdsJeYXV+oN4AZeHPi51t9tFfYc8RS5vSQ6vGXG+DKDeM59E35JKSmuh8epS47smRmhiI2xN
	na9WEI6SuLoEKT89vLgMb6rbYDOrFVmgq0DCbH6vqnaFTdKdQPNWBaIXVxcV+e0dbcEW4RTU90v
	9QcM8y63PXElpvgtKPUUvLsRlrZBo=
X-Received: by 2002:a05:6a00:1ad3:b0:81f:453d:1ab9 with SMTP id d2e1a72fcca58-8274da0d43dmr2350672b3a.3.1772211500869;
        Fri, 27 Feb 2026 08:58:20 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db4955sm5988793b3a.29.2026.02.27.08.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:58:20 -0800 (PST)
Message-ID: <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
Date: Sat, 28 Feb 2026 00:58:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v4] Refactoring in order to reduce Git's
 global state
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, phillip.wood@dunelm.org.uk
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
Content-Language: en-US
In-Reply-To: <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Here is the V5 patch.

Thanks Phillip Wood, for help and guidance.


Refactoring in order to reduce Git's global state
=================================================

PERSONAL INFORMATION
--------------------
Name: Tian Yuchen
E-mail: a3205153416@gmail.com
Phone number: +65 98740318
Time-zone: UTC + 08:00
Github: https://github.com/malon7782

Education: NTU, Singapore
Year: Year 1 semester 2
Degree: Electrical and Electronic Engineering (EEE)


PRE GSOC
--------
I have always held a deep passion for the open-source community. 
Although I wasn't a computer science major, I tinkered with open-source 
projects long before college. I have solid hands-on experience in C 
programming and system-level debugging.

I use Ubuntu 24.04 on a daily basis, so I am proficient in using the 
Linux command line and CLI tools.

I have contributed to the Git community by sending patches. Since my 
first commit (17/1/2026), I have maintained a nearly daily contribution. 
Here is the list of contributions I have made:

* [PATCH v1] t1005: modernize "! test -f" to "test_path_is_missing"

https://lore.kernel.org/git/20260117062515.319664-1-a3205153416@gmail.com/
   This patch is my microproject, the first contribution I made to the 
codebase.
   [Graduated to 'master']

* [PATCH v2] t2203: avoid masking exit codes in git status

https://lore.kernel.org/git/20260118043537.338769-1-a3205153416@gmail.com/#t

* [PATCH v2] symlinks: use unsigned int for flags

https://lore.kernel.org/git/20260120152219.398999-1-a3205153416@gmail.com/
   [Will merge to 'next']

* [PATCH v4] t/perf/p3400: speed up setup using fast-import

https://lore.kernel.org/git/20260130170123.642344-1-a3205153416@gmail.com/
   [Will merge to 'master']

* Re: [PATCH] [RFC] attr: use local repository state in read_attr

https://lore.kernel.org/git/cc2f400e-49c2-4de0-9c51-9a5c0294735e@gmail.com/
   Code review. To verify the performance loss, I wrote a test script to
   measure the time difference before and after the modification.

* Re: Bug: git add :!x . exits with error when x is in .gitignore

https://lore.kernel.org/git/1d560aa1-d452-47f5-aaf2-4cb1ccdab100@gmail.com/
   Code review. Pointed out logical error.

* [PATCH v10] setup: allow cwd/.git to be a symlink to a directory

https://lore.kernel.org/git/20260220164512.216901-1-a3205153416@gmail.com/
   [Under review]
   After over half a month of discussions, repeated refactoring, and code
   reviews, I delved deep into setup.c. I gained insights into Git's 
design philosophy, and learned the art of striking a balance in 
developer communication. It took me a large amount of time and effort to 
thoroughly understand every line of the code. I often found myself 
poring over the call chain of a single function well into the night.... 
But I persevered until the end, and I believe my patience will see me 
through even larger projects.


ABOUT THE PROJECT
-----------------

-- Synopsis

As far as I know, the Git community is actively working towards 
'libification' - making Git's internal machinery reusable as a C 
library. The extensive reliance on global state is a major roadblock to 
this goal.

Many core functions implicitly read environment variables and store them 
in global static variables. This can cause several issues:

   1. Global variables prevent Git's core functions from being executed 
safely in multi-threaded contexts. For example, When unexpected states 
(e.g., a permission denied error when probing a directory), they often 
rely on the global state to decide whether to call die(), which 
internally calls exit(). It’s fine for a standalone CLI tool, but for a 
linked C library used by a long-running multi-threaded server, a single 
die() call will kill the entire host process. Structured status, instead 
of fatal exits, should be returned.

   2. When Git is called multiple times within the same process, global 
states can lead to memory leaks or incorrect behaviors.

   3. Unit testing becomes difficult because the environment must be 
artificially manipulated before calling functions.

Take a look at this example from environment.c:

     206 const char *get_commit_output_encoding(void)
     207 {
     208     return git_commit_encoding ? git_commit_encoding : "UTF-8";
     209 }

If Git is invoked as a C library by a multi-threaded server:
- Thread A formats a commit for Repo A (using GBK);
- Thread B concurrently formats a commit for Repo B (using UTF-8);

Then they will race to read and overwrite the exact same global
`git_commit_encoding` pointer, which is not what we expect. Therefore,
we have to refactor these environment variables by moving them from
global scope into a well-defined and encapsulated context.


-- Approach

The task at hand goes beyond simply repackaging the global variables 
into the struct repository structure. Based on my recent experience 
refactoring setup.c, I realized that libification requires careful 
management of variable lifecycles and api boundaries:

     [ Current ]
     Core functions --------reads-------> Global variables (via getenv)
                                          [Thread unsafe]

     [ Target ]
     Core functions ----passes context--> struct repository
                                                 | owns
                                                 v
                                          struct repo_settings

                    	                 other domain-specific structs

Although the principle is simple, the scope of changes is extensive. The 
following insights can serve as a guiding principle for it:

   1. Identify isolated environment variables currently residing in the
      global scope. Conduct a case-by-case analysis to map each variable
      to its most appropriate existing home based on their lifecycles:

	Variables that are only parsed when needed will be safely mapped
	to struct repo_settings.

	Variables parsed at startup (e.g., editor_program)
	must not be moved to lazily parsed structs to ensure that
	invalid configurations can trigger early failures before
	execution proceeds too far, which is also for the sake of user
         experience.

   2. Instead of blindly passing struct repository *repo down into every
      single low-level library function, bubbling the dependency up is
      the true goal. External callers of the functions must be carefully
      audited to prevent regressions.

   3. Safely remove the old global variables and macro definitions. Make
      full use of Git's existing GitLab/GitHub CI and utilize local
      Meson builds with AddressSanitizer enabled to ensure that the new
      lifecycle introduces zero memory leaks.


Additionally, given the anticipated high volume of commits, we must 
ensure each patch is independent and atomic, preventing any 
user-untraceable or unexplainable bugs from occurring in the codebase at 
any state.


AVAILABILITY
------------
Fortunately, my summer vacation coincides with the GSoC work period.
I will treat this project as my primary focus, dedicating a minimum of
35 hours per week. If needed, I can work a 9-to-5 schedule.

I will have a significant head start to draft RFC patches before the
official coding period even begins. Having this buffer period allows me
to go through the rigorous code review process within the Git community
with greater ease.


TIMELINE & MILESTONES
---------------------
Considering the differences between this project and other projects on 
the idea list, rather than hoarding massive changes, I will submit 
3-to-5-patch series frequently to respect reviewers' time and maintain a 
steady velocity.

Below is the tentative schedule I have prepared for myself:

* Community Bonding (May 1 - May 25): Planning & RFC
   - May 1 - May 7: Wrap up university finals. Discuss and finalize the
     prioritized list of subsystems with my mentor.
   - May 8 - May 25: Categorize the targeted global variables and map out
     their intended destinations (e.g., repo_settings). Draft and submit
     the initial RFC patch series.

* Phase 1 (May 26 - July 10): Foundation
   - Weeks 1-2: Plumb the context pointer ('struct repository *repo') 
through call chains for simple variables (e.g., boolean flags or integer 
configs).
   - Weeks 3-4: Audit and update external callers to use the new API.
   - Weeks 5-6: Submit the first major refactoring patch series. Address
     mailing list feedback and resolve merge conflicts. (Midterm Evaluation)

* Phase 2 (July 11 - August 18): Complex Migration & Cleanup
   - Weeks 7-8: Refactor higher-complexity variables (e.g., path-related 
globals).
   - Weeks 9-10: Compile the codebase with AddressSanitizer and run the 
full test suite to execute strict memory leak checks.
   - Weeks 11-12: Remove unused global macro definitions and static 
variables. Update internal documentation and write the final GSoC report.

(The above is for reference only. Personally, I always finish tasks 
faster than planned 😉)


~$ git checkout HEAD@{postGSoC}
-------------------------------
This past month since joining the Git community has been the most 
enjoyable month of my programming journey. To quote a close friend of 
mine (who is applying for the Neovim GSoC project):

   "Only fools chase trends; open source is the game for the brave."

The words may be blunt, but the logic holds true. This statement surely
resonates with me (and maybe many other GSoC contributors): our passion
for code and open-source drives us forward.

Even if I didn't make the cut, so what? ~$ git reset --hard...
Just kidding. The Git codebase is far too interesting to abandon now.

-------------------------------------------------------------------------
Changes since V4:

  - “Treating variables or functions differently based on their 
lifecycle” has been added to the Approach section.

  - Fixed a typo below the diagram.

Regards,

Yuchen
