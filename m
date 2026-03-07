Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8067081E
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879595; cv=pass; b=MXYeJglSvN+EgabLbNOSInpx3sH/AQaJKIEKJD9E+lqUrYRycXXZR1gQTdphpoLHfOGrfHaMBaBlw8xExt9cEpoc1CMjbprr9fv8lKRRsVr1QRXH7j9yjUGjBp+KRgf336jYAwPDK+aZsRiGpDPDQignQ32vsy5oz+k5gQ2V1yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879595; c=relaxed/simple;
	bh=OJl/uPYTeWlZIZG0wIi0WfVhVnoYaoYk/ldwEeHVrPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbcIbP1LdKpcyynB4XQ+ldZ7r4EvdZ7Dv18v9GvHXQo2ZLNmgZ7vxA/tdcc6ijOGCifyGrmtw9w9ikJIUYqR2D9pZuqX5UF3mwSnuIAWy6Y+XdP9R7k/oxXP+I22MGp4t54XZcJR49DCz021OzruMpcM8XIB+4v49clzUaIlD4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZPTGhM; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZPTGhM"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1274204434bso7224893c88.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 02:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772879593; cv=none;
        d=google.com; s=arc-20240605;
        b=JKEroxTCTdG1wMAzdOdzLwQSpt3TOlrAtav4gc6Lt1bdVzPHu8uHIi5AEEy8TtEW29
         +yavS67gLfo8JZn5Fb5Q8vQT2OcseBD2YBG1xXnoV09mRna3bSw5l8p+NZsSnP5qhfsn
         AI61P8pFz9dS7iXwLZrZTNrvIrA3XHCJBTK6aoDrZYNqXHIWx0vAaVdIB8wa1asm9Vsu
         rjXuclPFimnp+JPlc4l/CwQ5CW1SzwW5hIuFXrCRteTfmvumReJKg1XN9y/8xzfXGmRk
         3UU5JqBctRrm9fF4IVT9orkOCdLvoCzmI09/RlIJmmtz8fxNmCDe5e4tRyziL7Qh19nE
         WXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e4TeKGppokKAyGql3e5ntRALEawaTu6tISUkzSWfsIw=;
        fh=fGgCEE5tBeqgln+k45XSP6I/6lW8+BXSuYNSyQGl36w=;
        b=ig6SlFEIGJ+N62HjEXJAhdRiQG2Hi4X8i1f0E8Lt+WgxbNYVS9D2qR4IQEitDEF3hu
         oHTpx7D5ECG66tAzjqkxE6yIihN1iF1NhlEgzhm9vT3JcCqknUoz+4AnUmy23trB2X8G
         wB2ugWlNFedjRGIA8d9rA/ek7afEi8nK9C1gT7Y93yjIfDdiuIdjrOGc0oWAiyAwTYUt
         Da0gLeDb5kjX31Pk8Lsk5SVJt7JKpTK6jTw673FzuEqd4o1mj5kuHOX/JmZyDzIg3Dcg
         3T3GwWbnbu1dsbATzWOEPVKr2wczjafh2x3y/JI7/d7RWTal0FZCXDxhRFUI1HcVKiAV
         qezg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772879593; x=1773484393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4TeKGppokKAyGql3e5ntRALEawaTu6tISUkzSWfsIw=;
        b=bdZPTGhMoArrulDTpNMxxcQBMmCe9g/umyGs9zMHGcx+1P/REegQQz4AtF6HI/I6Zo
         Y3gFCYU5JhFTIY4ov1ld2GUzGR/8awBL0XnQm3Os++s/JKaChLDUYR0JFB60c8HRWY2n
         LxZcx6m664gi5dIaQl9juUe1PXJfUsFNbBlNYmc8DRvCZdYjUYsFAK2tmqDiEJaUVmIN
         6tQcV39rqD9t37gSMETr5LWjTIgRXC2M+IG1v1QZDyFV26EnBqIyr5bMbhIFZq2hwIbw
         D2Z+HyHtnFJdqAzm6WfVkc2Y+FFIV/mxA5x2Y6aofMtgyjQZqgUx+h8CR4vbo0vY2oK6
         2WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879593; x=1773484393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4TeKGppokKAyGql3e5ntRALEawaTu6tISUkzSWfsIw=;
        b=RuSkVRYWzFE0/0Zcqc1UrOZqVthub72Kgf7ROY/LdTF3tfB6ac28fNyLeblJTUh5XJ
         TMtAY6U18mLOWaXhKxqR+h7fzoTOPZLh6bpiH0BT17PN2A1xaJrTBOqkNNro07bZATh8
         BrR7fi7GAfviOG3gBEs73a9SBmKZ29uwAGNf895AMuS1kS3MNdjS6j2i66mvi13iMogb
         5Gc/L+LF1MokgBmonA26jeDhrifPxIOA6urkaUXY3GO4iX3T3yzulvczIza7h5ky0Txv
         DcgiR/IL0DtSmPcPGhU3Hp2LB1Nn1vbeUpJAi1bPelLfAea3NpvjUrK0RFJkJOrJ4Yt8
         jIWg==
X-Gm-Message-State: AOJu0YyvOAY+GovuRShTMLrcLTFc/9Yy+rxV+ol0HqMmdIdE4qks8zDG
	DRT5sEf4YZnqKziSH5e+7hc2N73QyU2j1iPZUg6PQTfhNMLGegZXJKLN49i5Voj7NdRIBcwenHn
	j9Fnl3j5YMMVYiYhFFlODwYXXLIIQ8U4=
X-Gm-Gg: ATEYQzwkmQ7fXJzx9P4/+ep/W2qhO2l8WUyteVC538tIhzxDeVJpPk8Oq9Vuz0zwUah
	oQneXUlWX46Ka2cKFPt5s3VSxG7XgUuHdG3IaZRW3UeJBVJUdVqHbYbSRP8PWLIxY7Lsqnxvt5S
	qom7dgolu37P4B5QWT4CKgGYIbapDAmjHNHxaxNfQoHopyU7h4c/V+KC624E9VPNOBZjPP7lDDL
	f+VsVKhhL5iyBhDvQRY4KBftSgYZ1esDobbSwjYMswoCdQwpsx6qv2MxZy80Koq2bOYOtvxNM7+
	USOEzS+9oJlX4Pc1BHTkF29OR+8OkJMyWvmeked9cmUd49vcvMk2SUB3PNUn0vIgFSAJvmCmSog
	+qEY=
X-Received: by 2002:a05:7022:e13:b0:127:fa:7758 with SMTP id
 a92af1059eb24-128bbf83c4amr3704507c88.9.1772879593261; Sat, 07 Mar 2026
 02:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306151605.29330-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260306151605.29330-1-shreyanshpaliwalcmsmn@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 7 Mar 2026 11:33:02 +0100
X-Gm-Features: AaiRm53gzmz5lAis1AQ8gbzS2RoXF1Ziyb7XSoUQwAc0EvMT_KOla_XEaRIK72Y
Message-ID: <CAP8UFD2cchYrwbhym1m9Kif7hBu3BXaK2YvOexwZT+Lcfi30LQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D=5BPROPOSAL=5D=3A_Refactoring_in_order_to_reduce?=
	=?UTF-8?Q?_Git=E2=80=99s_global_state?=
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shreyansh,

On Fri, Mar 6, 2026 at 4:16=E2=80=AFPM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:
>
> Hello all,
>
> This is my first draft of GSoC 2026 proposal for the project
> 'Refactoring in order to reduce Git=E2=80=99s global state'.

Thanks for your interest in Git.

> I am Shreyansh Paliwal, a pre-final year undergraduate student at Guru
> Gobind Singh Indraprastha University, New Delhi, India. I am a technology
> enthusiast, who began programming in 2018 with Java as my first language
> and later transitioned to C/C++ in 2023 as my primary focus. I enjoy
> exploring new technologies and programming languages, and I have develope=
d
> solid experience building applications using TypeScript, React.js, Node.j=
s,
> and AWS. I actively participate in technical events and have organized
> multiple hackathons, tech-fests, and related activities at my college as
> the SIG-Head of IOSD, a tech-focused student community.

Interesting. Do you have links about these?

> Pre-GSOC:
> ---------

> During this process, I attempted to remove the usage of the_repository fr=
om
> a file. However, after discussion on the mailing list, Phillip pointed ou=
t
> that the change was not particularly useful in that context and could
> introduce segfaults that would not justify the effort for builtin code.
> Based on this feedback, I dropped that attempt and instead focused on
> understanding the broader global state refactoring effort. To better
> understand the project area, I studied previous patches and blog posts by
> Ayush Chandekar and Olamide Bello, followed discussions on the mailing
> list, and explored parts of the codebase such as the wt-status and worktr=
ee
> subsystems. This helped me understand the ongoing effort to reduce Git=E2=
=80=99s
> reliance on global state and motivated me to work further in this area.
>
> The following is a list of my contributions, ordered from earliest to mos=
t
> recent:
>
> Patches for Git:
> ----------------
>
> * test-lib-functions.sh: fix test_grep fail message wording
>         Status: Merged into master

The status should be "Released as part of v2.43.1" or something like
that as far as I can see.

>         Mailing List: https://lore.kernel.org/git/20231203171956.771-1-sh=
reyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: 37e8d795bed7b93d3f12bcdd3fbb86dfe57921e6

If you say "Merge Commit" we expect the commit that merged your work.
It looks like this commit contains your work, so I think it's better
to just say "Commit" instead.

>         Log: This was my first patch to Git in 2023. While browsing the
>                  source code and past issues, I noticed that even after
>                  the test_i18ngrep function was deprecated, an error mess=
age
>                  referring to test_grep was left behind. I updated the
>                  wording to correctly reference test_i18ngrep.

I think it should be something like:

... even after the test_i18ngrep function was deprecated, an error
message referring to test_i18ngrep was left behind. I updated the
wording to correctly reference test_grep.

> * doc: MyFirstContribution: fix missing dependencies and clarify build st=
eps
>         Status: Merged into master
>         Mailing List: https://lore.kernel.org/git/20260112195625.391821-1=
-shreyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: 81021871eaa8b16a892b9c8791a0c905ab26e342

Same thing about "Merge Commit" vs "Commit". Below too.

>         Log: While getting familiar with the codebase, I followed the
>                  MyFirstContribution documentation and encountered a few
>                  issues. Some include headers were missing, the synopsis
>                  format was incorrect, and the explanation for -j$(nproc)
>                  was absent. I submitted fixes to improve the clarity and
>                  correctness of the documentation.
>
> * t5500: simplify test implementation and fix git exit code suppression (=
Microproject)
>         Status: Merged into master
>         Mailing List: https://lore.kernel.org/git/20260121130012.888299-1=
-shreyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: a824421d3644f39bfa8dfc75876db8ed1c7bcdbf
>         Log: This was completed as a microproject for GSoC. Instead of
>                 constructing the pack protocol using a complex combinatio=
n
>                 of here-docs and echo commands, the patch captures comman=
d
>                 outputs beforehand and uses the test-tool pkt-line pack
>                 helper to construct the protocol input in a temporary fil=
e
>                 before feeding it to git upload-pack.
>
> * show-index: add warning and wrap error messages with gettext
>         Status: Merged into master
>         Mailing List: https://lore.kernel.org/git/20260130153603.290196-1=
-shreyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: ea39808a22714b8f61b9472de7ef467ced15efea,
>                 227e2cc4e1415c4aeadceef527dd33e478ad5ec3
>         Log: While exploring the code, I noticed a TODO comment suggestin=
g
>                 automatic hash detection. After discussion on the mailing
>                 list, it was concluded that there was no future-proof
>                 approach to implement this until a new index file format
>                 came into use. Instead, an explicit warning was added rat=
her
>                 than silently falling back to SHA-1. Additionally, severa=
l
>                 error messages were missing gettext wrapping, which was a=
lso
>                 fixed.
>
> * wt-status: reduce reliance on global state
>         Status: Merged into seen

When a patch series isn't yet merged into next, it's better to tell
what's its status in Junio's latest "What's cooking in git.git ..."
email. For this one, it looks like it is "Will merge to 'next'.".

>         Mailing List: https://lore.kernel.org/git/20260218175654.66004-1-=
shreyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: a7cd24de0b3b679c16ae3ee8215af06aeea1e6a3,
>                 9d0d2ba217f3ceefb0315b556f012edb598b9724,
>                 4631e22f925fa2af8d8548af97ee2215be101409
>         Log: This has been the most significant patch series in my journe=
y
>                 so far. It began with a suggestion from Phillip to clean =
up
>                 some the_repository usages in wt-status.c. I extended the
>                 effort to remove all usages of the_repository and
>                 the_hash_algo from the file. During review discussions, i=
t
>                 was suggested that some worktree API cleanup should happe=
n
>                 first, particularly regarding the representation of workt=
rees
>                 as NULL. Some related changes were later moved to a separ=
ate
>                 series, after which this refactoring proceeded.
>
> * worktree: change representation and usage of primary worktree
>         Status: Continued by Phillip Wood [1]

Here you can also say that they have been merged into master. Maybe:
"Status: Merged into master after being continued by Phillip Wood"

>         Mailing List: https://lore.kernel.org/git/20260213120529.15475-1-=
shreyanshpaliwalcmsmn@gmail.com/
>         Log: This worktree API cleanup series started while I was working
>                 on wt-status. The intention was to modify the representat=
ion
>                 of the current worktree so that struct worktree would not=
 be
>                 NULL. During discussion, Phillip clarified that NULL actu=
ally
>                 represents the current worktree rather than the primary
>                 worktree. Since Phillip already had a patch based on the =
right
>                 logic, he continued the series and it was eventually merg=
ed
>                 into master.
>
> * tree-diff: remove the usage of the_hash_algo global
>         Status: Merged into master
>         Mailing List: https://lore.kernel.org/git/20260220175331.1250726-=
1-shreyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: 1e50d839f8592daf364778298a61670c4b998654
>         Log: This was a straightforward patch that removed the remaining
>                 usages of the global the_hash_algo in tree-diff.c by usin=
g the
>                 repository=E2=80=99s local instance instead.
>
> * send-email: UTF-8 encoding in subject line
>         Status: Merged into seen
>         Mailing List: https://lore.kernel.org/git/20260228112210.270273-1=
-shreyanshpaliwalcmsmn@gmail.com/
>         Merge Commit: c52f085a477c8eece87821c5bbc035e5a900eb12
>         Log: This patch was motivated by an issue I personally encountere=
d
>                 while sending a GSoC discussion email [2]. Initially the
>                 change only modified the wording of the prompt, but after
>                 discussion on the mailing list it was extended to include
>                 proper validation to prevent invalid charset encodings fr=
om
>                 being used in git send-email and to reduce confusion.
>
> * Remove global state from editor.c
>         Status: Waiting for further feedback
>         Mailing List: https://lore.kernel.org/git/20260301105228.1738388-=
1-shreyanshpaliwalcmsmn@gmail.com/
>         Log: This was based on my doubt on localizing editor_program in
>                 editor.c [2]. The patch received mixed feedback from
>                 contributors and is currently awaiting additional guidanc=
e
>                 from mentor and/or maintainer regarding the appropriate
>                 direction.
>
> Patches for git.github.io:
> --------------------------
>
> * SoC-2026-ideas: Remove an extra backtick
>         Status: merged into master
>         PR Link: https://github.com/git/git.github.io/pull/831
>         Merge Commit: c1e4aa87a54430953eaa7355061139fdf1ff6796
>         Log: Minor Typo fix.
>
> * rn-132: fixed 2 typos
>         Status: merged into master
>         PR Link: https://github.com/git/git.github.io/pull/832
>         Merge Commit: 92876114d855d472ce2e0e5337e72a4b97b81681
>         Log: Fixed typos in Git Rev News Edition 132.
>
> I have also been involved in additional discussions on the Git mailing
> list [3][4][5][6].

[...]

> Project Timeline:
> ----------------
>
> * Community Bonding (Until May 24):
>         - Discuss the project direction and design approaches with mentor=
s.
>         - Identify and prioritize two main areas of work:
>                 + files that rely on the_repository.
>                 + global variables defined in environment.c.
>         - Study the previous patches by Olamide Bello and Ayush in depth =
and
>                  also discuss with them about their approaches and challe=
nges.
>         - Interact with all the people involved in this work to better
>                  understand design decisions and potential pitfalls.
>         - Experiment with small RFC patches, if needed to validate approa=
ches.
>
> * Coding period (May 25 - August 16):
>         - Review the work done by Olamide Bello on moving values parsed b=
y
>                  git_default_config() into the repo_config_values structu=
re and
>                  identify any remaining tasks.

I think this should be part of the Community Bonding period.

>         - Complete remaining cleanup or refactoring related to the worktr=
ee API,
>                  if left any [19].
>         - Identify straightforward refactors to remove usages of the_repo=
sitory
>                  in files such as xdiff-interface.c, archive*.c, fsmonito=
r*.c etc.
>         - Work file by file with the goal of eliminating
>                  #define USE_THE_REPOSITORY_VARIABLE by replacing global =
usages
>                  with explicit repository instances.
>         - Concurrently maintain at least two parallel patch series:
>                 + Small / straightforward refactors and replacements like
>                          the_hash_algo or the_repostitory.
>                 + Larger structural refactors involving globals such as
>                          DEFAULT_ABBREV, comment_line_str etc.
>         - Publish weekly or biweekly blog updates documenting progress an=
d design
>                  decisions.
>
> * Final week (august 17 - august 24):
>         - Address any remaining tasks or pending patches.
>         - Recieve final feedback from mentors and reviewers.

s/Recieve/Receive/

>         - Prepare a detailed report summarizing the work completed during=
 the project.


Thanks for your proposal!
