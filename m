Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD851C84B1
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743849694; cv=none; b=my72wuA/Ar4zCrBsdcVDLYFpA1BLCJrUt6PU7IZQOgHI7a4xsvHmL7kBc/hg7PK7w+q/fwMxRtc82D08qzHCPRiqHwC8jDxTuFt/HHlV+wb4JThQ9wJiwSMH+S74pE77tMUobAel/HsuxC+amodJ0INDDrIEi94SJw0axvW+5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743849694; c=relaxed/simple;
	bh=oSofq8qZxQpxsDyfGt7jhr82ir6y46p0rIW9nST8THM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j9dYCgyTxxM/14A6QgnOuIoNp/Qggxp75X6DTXx4wcylfndzu/1YCE9bCpXIbTUI4A0RakcGnZEHGhKjGxPMfGre+zn/v45YVsV8x6zzzYzL1r56lWUOyICedezwxTB9Aq2qOeXaUImz+OUQdS5zCMSTn8fCuCSjRdi0G2iJTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqqEQho9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqqEQho9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso169553466b.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743849691; x=1744454491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZQ9UbRgFM7r0+JGOc/mBr2uddAcJ2mb+3adIxkzGFo=;
        b=IqqEQho9qHqSm64arIfeTeAvoAE+kUanU4g81yITqmfBbkBVAlKBrW+8DQMoMA3qub
         PwBbWxEINJLni0hDNvDlJsQCr9XtxPV7YkQz6gu3XBsOb+EsvXeEiRgpp4GsUDl5DcvY
         6sTYdNeY8zqjdCUdP57VSh0ksbnOq6AiJZXoyZHya7BfuCeOYwHJ5lVgxdYbXAQrHqvn
         zmqcJKwJCADWqYvPwtdlxLjROVV2Sb7kj/l6e2rmHLKi05xhBPvwNIMQ2dhqZzT6FAmp
         2t3MgmpJ48fLEhLxwXjXNvYqok/o8JSaJ3usXLbpynf7N5z+GMar5B7ip3saicGv7M0N
         iyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743849691; x=1744454491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZQ9UbRgFM7r0+JGOc/mBr2uddAcJ2mb+3adIxkzGFo=;
        b=hh+kDzKU32je2vRylcYdUcfrPeGQqVYaitBxBmwJXlO8N7Fvp8EX/V0gdaFo42JBb5
         I8VTuw4I7H3gE08RpLFgwDRP0smMkH4+892vxpUworK8ieggkSb8zGbhhbZnNwchAq6u
         fP3mgcdS79oIR1uJAV6NaBxFV+9VtKqC2K7365biouxj5QeNCOXaqhCg2YPVKDFsLFhn
         d5fYMjXRFaw/7dqbPDyeMZZ8ayOxoN2AcMEBbzyveIEXlEjLQadyOA9Rc2dg1pbS+pMC
         mePVacIzNiqxQ8/A95W8x61cvUaS4mQ8vSDvm+I9ZkiZhzIHjlpJ+joDuXshiKueDsA/
         eUtg==
X-Gm-Message-State: AOJu0Ywt08eU6QJfQ7YX3Ses5+/CyUzHDLoOm28HkLwzr8XKuAYZGCgj
	RE5/wlLwTxUIWuKSW23Xdty+2BfM4fvEpHLx2I/y1PCrtPIYQvopVuSJLOWNtA==
X-Gm-Gg: ASbGncv7b9gU1aG16++j/+GE4Me5tTkaSNBvoq3c0oBKqypJzfeGgXfzuQJb5gWnJN1
	L8h0GqOg6Mi3VaIi1ZR2ku3hpQdxW63Pekz5uO5XQEsle39Ws8grkrYhL8ypWhueE2T53wrEt1s
	G25VupScwoKFHFbC7Ve6gz+wXPZk0zm0ZZu2k7fGMzzpvLSozq7h1JwUtBGPjhApzFOXwiBGiGi
	8hmuUObCZprOvoBYP/crd4itaqaoHWHVGIXDBmt8oUgzT69UYNaJk1/TsjfQ3Q7cVPmczMG0M6d
	mSorEg9mW4RFjYM+bqwAQ9AXVMIqD9Hf8ay1nawUQdF+1VFPVNcgVEz9B/DNjocnD2dKyXDN/H+
	j3FKMJcEmBd9WWaXmY9so3lfFj+KetekNPKENA55vvq6xwIpyKqs73JrMBDTdqmdsL48d83gPUD
	2m22QSrfwHzXjYnz4p3vvpZc29q/qf5Nh5XA==
X-Google-Smtp-Source: AGHT+IGvlToFObxuOQ0cNOgQjxBKKSds1uOGWZ7xG3LF72ZUr5XRDwX/UrN5hql+xm6gd18ZWz6SLw==
X-Received: by 2002:a17:907:96a0:b0:ac7:b48d:7c29 with SMTP id a640c23a62f3a-ac7d18bc100mr445955666b.26.1743849690366;
        Sat, 05 Apr 2025 03:41:30 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c5e9sm398505966b.5.2025.04.05.03.41.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Apr 2025 03:41:29 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [RFC] Project Proposal: Refactoring in order to reduce Git's global state
Date: Sat,  5 Apr 2025 12:41:24 +0200
Message-Id: <20250405104124.25272-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is the first version of my proposal. I would love to 
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
- Developed a text editor in C: https://github.com/wang-anthony03/Quill

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

### Expected Project Size: 90 Hours

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
an incredibly large amount of time, thus I have chosen my expected 
project size to be 90 hours. I will be fully available outside of 
working hours to this task, and will set up a compatible schedule 
with my mentor(s) in order to ensure that an effective line of 
communication is established.

I appreciate your time in reviewing this proposal and look forward to 
your feedback!
Thank you, 

Anthony Wang
(He/him/his)



