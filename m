Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567B215059
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045833; cv=none; b=g6bmux8fUzr5DqVsC4DFfDaCjLP9TpGBqU5GpbTZ1iziRwMh9Kv2nZbv9kkfsqQfq8HwqjeGsUJGWITyPHqqVNz/idxthAEAMelF5Hp/wAXW7AOn1j4D1OrFUOtD8ML1MeI7qSXWUr9jiQkFTdt3ShBfZARFe9pm2Wt1thvIblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045833; c=relaxed/simple;
	bh=TO9i087ju5BuOWfqgH3t7rm/RDYESMP/L7urgqu0UXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOr9KgkR+FpmnlOfDfZa9Q15cnvn1a2xlHCca757iPy5PRjwmam9Ru4KLNyy3+Nv2deqD3sWAC2xkmrhdUfSXE2Y6o38XTviMX05s4lUSqg8uQ7lHRaiNqbwOw6l+umEfdvtfZ6glIW1Mno6D3FOQsKyrTWPpklqIWha/VXoUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/qK0Y+J; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/qK0Y+J"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so720766166b.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744045829; x=1744650629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G5lxL593EfcX0etHZA1Q0vuZJLrwVN+Qctvl6v+uvU=;
        b=j/qK0Y+JsRqmsNMNDJXmSISwUPjBOmSOk/yP3F+yobVAHCcgLRrfjzGmjGPPHKmTMC
         AoWhgwxrqWA65awzJ1PbngDxGwfMwyP3wpwPCxWkgUfmTk9UsXIhu85n6BqOu7h4UdJc
         Tc5ygS1zZvQQU2m2kymqrRHV+2UuhZE+VpGm7FjCHyCvSNalTIhfmxQqdcKImrDtkO6N
         js6I0b33JHAyOHxnz5F0oNINcuoxBwtHvzQ0MiqxgjzyU8tcJillwTrsJyXHU7zpNxGH
         8megYai9bjGHN81Rahj4dtKz3cLcgA6i6Didy7zefZww+oaiT4Pi59sEnuECWOdMpHxO
         +ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744045829; x=1744650629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G5lxL593EfcX0etHZA1Q0vuZJLrwVN+Qctvl6v+uvU=;
        b=KYhXxEbP/g/SUdc69KJVuIq0FLuGYEjttFN8tqSOTTuCmuKT3CBhBfmgEmStlag8ui
         cR0Bx6g8KbVotdtWeUUaf0W2Yc3mOKJMsk8MTuCp62nVmZgyPPSunv/pX6lpL5Wae8LL
         FlNmEum4QYmaaaWXoki5f+qz3F7rIymJTLHykH+mv93NVSMJXa2MR2YGS60faOLPDAxA
         5zWeadYuXuEvuu5WItfEj+H/ZUa7Lxb1q8wb9hM/S3IdWchA4+g44N821IFFOIHvX2ey
         PPcHhGOE56CusrEjv4SiOdCoU5kVD/flwOR9ytyjvbjIafBesLhNlcB9749EnBD6z2WR
         FwNw==
X-Gm-Message-State: AOJu0YwcL2z6u2TX1NONy0dVO7V4dBYP61plv+acSytdzcwHvgk8Bulj
	aPcWj3On33ec0C92UhegodWLs6B4c0lkd+h9xbOVXwzfPRcK0omF9Zo3N1Zvhg==
X-Gm-Gg: ASbGnct8JupTAR4p+eEspG9YCuXs1e7t0Y32yFmj7XEinGnKaE48ICbQjYAknixXVCu
	KReyfB9pz03clHXiJv1JMun8Q+WuYwV2SG7HPqZ+EhcWDhh36tOppMjf5nODYXGQSha625U1qAN
	6zf333Hvfq87FS5VViDKWUheKRBwIuMkBiP4U6ScUrk6fhR4uOqFDWQJ4RYmeNK5jc/tPUf9x6c
	v6hyeGLI7C1+Q1X4nQ8v9opV7GCK0BjeRLJ2N3MSiCirXAEQf9GTHo2EkVCRr+t4ivFiQxJmqzf
	S1JfOn7dD2hp/mugA+yGjBYX/t21zvgV1KneWnNexOBHJDj8eeQtrkg4/DJj/Fv0ZELboU8zFHc
	RflfABxA8AhNX
X-Google-Smtp-Source: AGHT+IGWQvYy2ZBGs8FGnGIoFYQgGGyu7DC5fbo9fAKESZuuvBwvFsTxwEkqyX7APDF5dOI8CtJKTg==
X-Received: by 2002:a17:907:7f9f:b0:ac6:ecd8:a235 with SMTP id a640c23a62f3a-ac7d6d62dffmr1269962666b.28.1744045829026;
        Mon, 07 Apr 2025 10:10:29 -0700 (PDT)
Received: from localhost.localdomain (generic-nat.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe67e17sm778591066b.34.2025.04.07.10.10.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 10:10:28 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org,
	kaartic.sivaraam@gmail.com
Cc: ps@pks.im,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [RFC] Project Proposal v2: Refactoring in order to reduce Git's global state
Date: Mon,  7 Apr 2025 19:10:25 +0200
Message-Id: <20250407171026.49901-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250405104124.25272-1-anthonywang03@icloud.com>
References: <20250405104124.25272-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anthony Wang <anthonywang513@gmail.com>

Hi all,

I'm interested in working with Git over the summer to "Refactor in Order 
to Reduce Git's Global State." My main motivation for choosing this idea 
is that improving Git's environment handling will enhance long-term 
maintainability and scalability, and allow for multiple-repository 
interactions. 

This is the second version of my proposal. I would love to 
receive feedback on the content or structure, especially on the points 
pertaining to the actual implementation of the project and planned work. 
I will also discuss my past experience, and speak on why I believe I 
will be able to effectively contribute in a sustainable way to this 
large undertaking.
Thanks!

-------------------------------------

# Refactoring in Order to Reduce Git’s Global State

### Personal Info
Name: Anthony Wang
Timezone: Eastern Time (ET)/UTC -5
GitHub: https://github.com/wang-anthony03
LinkedIn: https://www.linkedin.com/in/anthonywang03/

## About Me

My name is Anthony Wang, and I am a 3rd year Computer Science student 
at the University of Virginia. I have experience in software engineering 
and development, particularly in C, Python, and shell scripting. This is 
my first time working with open source software, and I am incredibly 
excited to contribute to Git, as I have always wanted to work on 
developing the tools that I use everyday.

My background includes building scalable automation tools and 
contributing to infrastructure projects at Verizon. I was able to work 
with large codebases, and I learned the importance of clean, 
well-documented code, as well as the challenges of tech-debt leading to 
difficulties in maintaining code.

## Previous Experience

- Experience using Git extensively in academic and personal projects.
- Experience working with C as the main language for multiple Computer 
Systems courses.
- Developed a text editor in C. [1]

## Microproject
- t8911: avoid using pipes and improve code clarity
Thread: https://public-inbox.org/git/20250405103718.25160-1-anthonywang03@icloud.com/
Status: undergoing discussion  
Description: In order to expose more testing outputs, we remove the 
piping of `git tag` outputs in order to expose the exit codes. In 
addition, we remove `-q` tags on instances of `grep` to ensure clarity. 
We also replace `grep` with `test_grep` to provide helpful debug output 
in case of test failure.


## Project Proposal

### Objective
This project aims to modernize Git's environment handling by refactoring 
the environment.c code to reduce the reliance on global state. The goal 
is to move environment variables and configuration settings from the 
global scope into appropriate local contexts, primarily within struct 
repository and struct repository_settings. This architectural 
improvement will:

- Enhance code maintainability by making dependencies explicit.
- Reduce the risk of unintended side effects from global state 
modifications.
- Improve Git's ability to handle multiple repositories within the same 
process.

### Expected Project Size: 90 or 175 Hours

## Key Tasks

1. Identifying Global State Variables
- Analyze environment.c and related files to locate global variables.
- Identify the functions and modules that rely on these global 
variables, and list all files using each variable.
- Categorize these variables based on their use cases and potential 
migration targets.
- Write Documentation listing all desired variable migration, allowing 
for community contribution.
- Discuss prioritization with the community and designate priority of 
tasks.

2. Refactoring Process
- Move identified global variables into struct repository or struct 
repository_settings.
- Ensure proper initialization and access mechanisms to maintain 
current behavior.
- Updating Affected Code Paths
- Modify functions and modules that rely on the old global state.
- Ensure all relevant operations correctly pass repository-specific 
context.

3. Testing and Validation
- Run Git's extensive test suite to verify functionality remains intact.
- Update or create new tests as needed to cover refactored components.

4. Documentation
— Document changes in Git's developer notes.
— Provide clear explanations for new structures and access patterns.

5. Challenges and Considerations
- Ensuring backward compatibility and avoiding regressions.
- Handling dependencies between different parts of the codebase that 
rely on global state.
- Keeping performance overhead minimal while introducing structured 
state management.

## Planned Implementation
I have been examining the codebase to search for global variables 
and have found two major groups:

The first group is just one variable - `the_repository`. In order 
to refactor the code to remove dependencies on `the_repository`, 
we would need to adapt the code in various manners. The first would 
be to start at the lowest level, and modify the code so that it would 
take in the needed parameters from `the_repository`, removing the 
internal dependency on `the_repository`. Alternatively, if the 
dependency can simply be resolved by using information from a 
different source, such as a `struct repository`, or other context 
dependent information, such as in [2] or [3],adapt the code to take 
in the information from the alternate source and remove the 
dependency entirely. Following that, move up another level and repeat 
the process.

The second group is config variables. Because these are global 
variables used by multiple subsystems, refactoring is a bit more 
complicated. For areas with access to the repository, relocate the 
config variable to the according struct that stores that information. 
For areas without guaranteed access, move the variable into local 
context appropriate structure and its constructor, guaranteeing 
access to the variable. This workflow heavily draws from [4].


## Schedule
1. **Now -- May 5th**: Exploration of codebase
- Research and familiarize with environment.c and related code. 
- Identify global variables to refactor.
- Engage with the Git community for feedback.

2. **May 6th -- June 1st**: Community bonding
- Get in touch with the mentors;
- Present to the community a first list of variable migrations;
- Receive feedback from the community and modify project plans;
- Present potential changes to ensure they align with community goals;

3. **June 2nd -- July 7th**: First coding period
- Eliminate dependencies on “the_repository” following priority;
- Identify possible patterns in refactoring and document for future 
contributors;

4. **July 8th -- August 10th**: Second coding period
- Move other global variables into local repository contexts;
- Identify possible patterns in refactoring and document for future 
contributors;

5. **August 11 -- August 25th**: Documentation period
- Finalize and refine changes;
- Document changes, the process, and outline future work regarding 
reducing the global namespace;

## Availability
I will be working over the summer, but regularly code and study outside 
of work/school hours. I will be dedicating all of this extra time 
towards this project, but I acknowledge that I will not be able to spend 
an incredibly large amount of time,  thus I have chosen my expected 
project size to be up to 175 hours if given an extended timeline, and 
90 hours if not. I will be fully available outside of working hours to 
this task, and will set up a compatible schedule with my mentor(s) in
order to ensure that an effective line of communication is established.

I appreciate your time in reviewing this proposal and look forward to 
your feedback!
Thank you, 

Anthony Wang
(He/him/his)

References:
-----------

[1] https://github.com/wang-anthony03/Quill

[2] https://lore.kernel.org/git/20250310-b4-pks-objects-without-the-repository-v4-6-f201b8ec57ba@pks.im/

[3] https://lore.kernel.org/git/20250310-b4-pks-objects-without-the-repository-v4-1-f201b8ec57ba@pks.im/

[4] https://public-inbox.org/git/342a26572d6372d40ba563d73242e0d18a481d2a.1733236936.git.karthik.188@gmail.com/



