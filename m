Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A317A2E1
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783236; cv=none; b=JJMQhgCjwZ9qOACiOaz/I/fIDHvNF8SlDw25SyUGYy0nlSmA2bzc6dtiLIMOYg+Ly0RNWUSclBaawRqqr3LBuTXp8dHWQJ74qPcA7hjRMhUbX+DmcBe3tnSczGrK0NQwOhKxFn/FSvvO4gpIE257jopHLFxa04UPQfgoZ5GxuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783236; c=relaxed/simple;
	bh=HlaU4BvHQ8wVTDIraedjY5GpRrvrTY+fJKyW/ieZMLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bNmYSBcNcymuJYx9Gf+weoxJ6bFFT8NeD8dmjC1RZiCqMyhltpBpzF9LUGRUhus9E/xJqLFFgpe1G+XAY+NcYbNZZqJyjT7dxJlV2IBayHrhUHYGxnUJogPSwFj2beFEaltZaWwZU8Z7Z4KNGUF2UzEcKWOAAbN79G+ZMuOFCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiE0i+h8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiE0i+h8"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so4347421a12.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743783232; x=1744388032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/BzO7tHowG/eX2EMPveBzpIYDP7QTljBWEQwv+0Cns=;
        b=AiE0i+h8AwNQ78KUTrzq7CPa4fFznoDD36XZiG6xDYueN//oW6Ye5hZM0zQhiy6kRh
         bmL1AYVshYB31AGw3KZGJpNz3213YeAkf+eqwFpE8d87lypqMk41oqF18InyIEfr/qLd
         3baSzihL0R4MTVEzoKRoO2QmRcDg28h9CdnNxxbmNa2y4MIdnVBEda8IJn6WB6KgfyhN
         jyrtRzdFyFGWVrhgw5/l3W04lJCdTjV0Ov3fEIC2n2NKPkh/hleFeU1aqP0LN/X5Rvla
         tTbdvCrzBjUoFOqoSs09rQDUbNpp91sgTl6GBryf/aDEzKmFiHcyenozMjgxQK2vAjbR
         AatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743783232; x=1744388032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/BzO7tHowG/eX2EMPveBzpIYDP7QTljBWEQwv+0Cns=;
        b=YwxkEjHbCf8t0yNNQ4pasvxr9Uez0zBdN9SxC3YRRQmXgtP57F0WuszOBqw7t25fo2
         eWMwfAuJgloAMZbndvf5adZj8PbBmb8IFJE+Vp9sulVJm5lIZU09dMbL92NFLRpmUcLF
         oAX0MQ4d628WNNBOIxaM7vQGKuTaM94vWW01mgTO+HRpWVffbyFpJmZZezxDgf8eGrML
         j4EO5Pu/C2N6IAXD0ChRe8PIHyphxzJawyx1cxBR3hLoiP+Cfgf0Oep1rd23Z/D6DF+2
         5BiNC5Ggm+LTw5rBBFdy1KyzGqG3AO4WVpqQYW/zs/PGY/i9Gh2H3PSuZch+KEcAs0JP
         sfKg==
X-Gm-Message-State: AOJu0YxIrB7oMa2H3STliDQPJ6VPbXYYXI1O8IoKeXtOZUdC8tcUjseo
	vuDAf/xm1h7aE5LtDiyxxwWP5ZLMJiLa11WWtzflqr1VgTDiQSXnPujDyPCGrA==
X-Gm-Gg: ASbGncvbWn5g709mWC7AtNkPaEInk4qmqpUedWAx3krWlOGTUmlAsOCBGy0EMHqYt8V
	axqlezHedCZ+v/mKrn1wvBtg8ixuc+9oGnjuX6JzBfug/wdFebHCsyKaCvWTeVBeVadGdQonXwR
	Kc4ZUFa7OxScgtbt8opIPe1w2q3bTKHbdJWoSlzGaIqj7K3wgNZYXAqU9AVFNa23ItztGmKirN8
	1v/15yQM7t8SRn1FbXPi6yhosBCEzc8v/BPoA84P0plei4sOUi/dgE2QXZqb8aJL2v6K7oqY2jX
	Pi/5bk28fgZgUb5MWGghJugU2FTIk5LXrgV34HO7xjjr6w8vGArmChicdsb7KYPxoXSEsC9xpr1
	yet2t+tvyXNLBNOTOPza1WfWKCNqNckZU8GlNO8nIiMrcqaoU1CvW+nGzLsCqwXMykZ6GKggQax
	bNZMkj5B7WcNzaXCLu1crmCsv3jnM3jGA8Yg==
X-Google-Smtp-Source: AGHT+IHSJliqdZN9TaphancewohRzePYDad2Q86rX/sYAZsH7ooik71wdfMB4vgly7VdroascmeFJA==
X-Received: by 2002:a05:6402:5483:b0:5e8:bf2a:7e8c with SMTP id 4fb4d7f45d1cf-5f0b3b9999fmr2793365a12.11.1743783231534;
        Fri, 04 Apr 2025 09:13:51 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880a45d3sm2598537a12.70.2025.04.04.09.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Apr 2025 09:13:51 -0700 (PDT)
From: wang-anthony03 <anthonywang513@gmail.com>
X-Google-Original-From: wang-anthony03 <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [RFC] Project Proposal: Refactoring in order to reduce Git's global state
Date: Fri,  4 Apr 2025 18:13:43 +0200
Message-Id: <20250404161343.12635-1-anthonywang03@icloud.com>
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

Note - I am still waiting for feedback on my Microproject, and would 
love to discuss how my patch contents or formatting could be improved!
Patch: https://public-inbox.org/git/20250402081545.94784-1-anthonywang03@icloud.com/

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

I appreciate your time in reviewing this proposal and look forward to your feedback!
Thank you, 

Anthony Wang
(He/him/his)



