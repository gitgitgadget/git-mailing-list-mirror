Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84451330664
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888297; cv=none; b=r25coVVY0xfNDIEZmdBKrAMYpwanAe805ELryEtcM4vbBiBoBU53Ira7tlFcj0w6Nc8tMTgx7uI5ZVRLJDxtb5N+3mhk2M2/7H6WG1VfVBosz5ZNEfgNstcvgxXK55+taY3AuDy3yG9GLx3FkvhX3F2egL88f7adgn7yNJRK/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888297; c=relaxed/simple;
	bh=YJvnzUNr3UNarzW4X6DemNtiCsAlbCbiOLIiyFVfBKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFFl9q3CUwzy7ldSr13GKqgkrPgLtvz2/PPUVGwJ7yE9ANmg7VdOeGApZ899a7MzjidevvoRpy3j/FaDLdbMMnO/ykUlZACm2woX5wY0iuS1ar/pKhK0MGqcWooUBJVC6GIriZHzZV4Q1kZgL7vFof6p7crRt0LWvf5MO476YRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNPHCs1j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNPHCs1j"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae5636ab04so66825345ad.3
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 04:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772888296; x=1773493096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQAEFsCohczFPeRJqPLPvl8I/aH7WgdolP5FWltE9U8=;
        b=NNPHCs1jx/KCWlzyAPc1ghRQwCm9EQnzc4u0ihlc+h127lzwg2VXWvfP6cMTghI1+x
         4OePB22sm9YRZueT/hchaSDG7Hl766Hv45MZx2oLoxXtAiwIiBJo30tKD9Fne04cfpK6
         sMEFzMoYhYZoTfVY7XCOERXYmAaz0I1fXcnSrCi+p6VyVfrD5N4mVHfXd1/EYqV4cG91
         4vr72fuUnnj25uGMdQZk1TIxamlFBCvHdV4a7At9U4pN6xhULzuKt0ydtxw7VnhnDqek
         eMRxhz85rPHlDbfmS9sz5kKUy6dUV5SXWe8NX+AU8epmatQvuRTvlTDQGw4ZxQRQQIBB
         Ne1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772888296; x=1773493096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQAEFsCohczFPeRJqPLPvl8I/aH7WgdolP5FWltE9U8=;
        b=VOSdxOzTPWwr/HxoTwRhzgqZUwK4shuhMUsB5xY8YHO1wPHlur/TPEpMM2EGYPM9aH
         4SwJFqrsZpSDdETFS7wkkIhPXXeGHSszbo4YxH82CiF1Uu9kBzgiA6S0XobLkqbEacuR
         yHASG4Fwqz9gf/MDt8c4e6uVaHfoaXmB4mI3ZyRpD2pCa6nggdkbWuaCFztWl3POaasr
         pL/mthn/ipAKs1GQxzGH5Lk9mya5UMJjSp+LZyy9GDbeRGQD1muHDFN+6ImzpcQmckvF
         0/hFuBrkG7mxaYG7Ehnhiuxh/D1ieWexurKn9kU/wtlkIT+c2QfpUTMxSSUXl1C16uOM
         WvTg==
X-Gm-Message-State: AOJu0YwJ++9UTQf0V3weWn/S2VfX0H3oIY7XkSTH8Wa2mv5YHo665tk8
	hScWSlRXgVugQ3DSqw2CM1GE0f/utt8c4JNgdXXIw3rRsFWZeaCxT1pFhIyzMg==
X-Gm-Gg: ATEYQzxbn8c31m7fid559cf3dr7qj07v/6KUbwiITdb7NaZL3wZfcDQYHQ3tEU+djEt
	H4q3GydazHB2QeWRbE7XTdXPc9FtTRlJHdMBYkpSSlQ2plkY9Lo7u7CG1Yc5ezwNLB2BREvjjyJ
	HB2BT1emJ/9wbls27+sMUkp426GhTABbwknyF8t/dYJTpAsKHTHsOo8ig5eX6KsAhTsFzM1SAgQ
	I0g67JnDTRXSHsa4EKXvHi0x8Ph5YpVarmbFEP0PH3FDV1nskCgSWx92H2QULaq4PUIUYUgiEel
	Jh+OrLuRMYfwz3c4H/85UE/11sSRf1fN1gjgtOeok5+jqQzJGARf4SX/fcv+epSA1CFGPptUMkH
	tfxsYJD/vCzIiCkD+Fft09CwQZ3DO/zka60sFdmfq+2BJx7YGZgmTD5Nq52sFciR9Oox+SJSTGQ
	erQgQl4VdBwOrz99D1ui0kb4fLKGugZdR/t7FkHJjmDBuXNjnLvtNadg==
X-Received: by 2002:a17:903:1a26:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2ae82368445mr57369085ad.2.1772888295660;
        Sat, 07 Mar 2026 04:58:15 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:da5c:db1d:7b7b:dc47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eafc64sm70104105ad.40.2026.03.07.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 04:58:15 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com
Subject: =?UTF-8?q?Re=3A=20=5BGSOC=5D=5BPROPOSAL=5D=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Sat,  7 Mar 2026 18:16:49 +0530
Message-ID: <20260307125740.95052-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAP8UFD2cchYrwbhym1m9Kif7hBu3BXaK2YvOexwZT+Lcfi30LQ@mail.gmail.com>
References: <CAP8UFD2cchYrwbhym1m9Kif7hBu3BXaK2YvOexwZT+Lcfi30LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Hi Shreyansh,
>
> On Fri, Mar 6, 2026 at 4:16 PM Shreyansh Paliwal
> <shreyanshpaliwalcmsmn@gmail.com> wrote:
> >
> > Hello all,
> >
> > This is my first draft of GSoC 2026 proposal for the project
> > 'Refactoring in order to reduce Git’s global state'.
>
> Thanks for your interest in Git.
>
> > I am Shreyansh Paliwal, a pre-final year undergraduate student at Guru
> > Gobind Singh Indraprastha University, New Delhi, India. I am a technology
> > enthusiast, who began programming in 2018 with Java as my first language
> > and later transitioned to C/C++ in 2023 as my primary focus. I enjoy
> > exploring new technologies and programming languages, and I have developed
> > solid experience building applications using TypeScript, React.js, Node.js,
> > and AWS. I actively participate in technical events and have organized
> > multiple hackathons, tech-fests, and related activities at my college as
> > the SIG-Head of IOSD, a tech-focused student community.
>
> Interesting. Do you have links about these?

Yup, I can gather some related links for these, will add them.

>
> > Pre-GSOC:
> > ---------
>
> > During this process, I attempted to remove the usage of the_repository from
> > a file. However, after discussion on the mailing list, Phillip pointed out
> > that the change was not particularly useful in that context and could
> > introduce segfaults that would not justify the effort for builtin code.
> > Based on this feedback, I dropped that attempt and instead focused on
> > understanding the broader global state refactoring effort. To better
> > understand the project area, I studied previous patches and blog posts by
> > Ayush Chandekar and Olamide Bello, followed discussions on the mailing
> > list, and explored parts of the codebase such as the wt-status and worktree
> > subsystems. This helped me understand the ongoing effort to reduce Git’s
> > reliance on global state and motivated me to work further in this area.
> >
> > The following is a list of my contributions, ordered from earliest to most
> > recent:
> >
> > Patches for Git:
> > ----------------
> >
> > * test-lib-functions.sh: fix test_grep fail message wording
> >         Status: Merged into master
>
> The status should be "Released as part of v2.43.1" or something like
> that as far as I can see.

Right, got it.

> >         Mailing List: https://lore.kernel.org/git/20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com/
> >         Merge Commit: 37e8d795bed7b93d3f12bcdd3fbb86dfe57921e6
>
> If you say "Merge Commit" we expect the commit that merged your work.
> It looks like this commit contains your work, so I think it's better
> to just say "Commit" instead.
>

Understood. I will change "Merge Commit" to "Commit" for all the patches.

> >         Log: This was my first patch to Git in 2023. While browsing the
> >                  source code and past issues, I noticed that even after
> >                  the test_i18ngrep function was deprecated, an error message
> >                  referring to test_grep was left behind. I updated the
> >                  wording to correctly reference test_i18ngrep.
>
> I think it should be something like:
>
> ... even after the test_i18ngrep function was deprecated, an error
> message referring to test_i18ngrep was left behind. I updated the
> wording to correctly reference test_grep.
>

Oops, I'll fix the wording.

> > * doc: MyFirstContribution: fix missing dependencies and clarify build steps
> >         Status: Merged into master
> >         Mailing List: https://lore.kernel.org/git/20260112195625.391821-1-shreyanshpaliwalcmsmn@gmail.com/
> >         Merge Commit: 81021871eaa8b16a892b9c8791a0c905ab26e342
>
> Same thing about "Merge Commit" vs "Commit". Below too.
>
> >         Log: While getting familiar with the codebase, I followed the
> >                  MyFirstContribution documentation and encountered a few
> >                  issues. Some include headers were missing, the synopsis
> >                  format was incorrect, and the explanation for -j$(nproc)
> >                  was absent. I submitted fixes to improve the clarity and
> >                  correctness of the documentation.
> >
> > * t5500: simplify test implementation and fix git exit code suppression (Microproject)
> >         Status: Merged into master
> >         Mailing List: https://lore.kernel.org/git/20260121130012.888299-1-shreyanshpaliwalcmsmn@gmail.com/
> >         Merge Commit: a824421d3644f39bfa8dfc75876db8ed1c7bcdbf
> >         Log: This was completed as a microproject for GSoC. Instead of
> >                 constructing the pack protocol using a complex combination
> >                 of here-docs and echo commands, the patch captures command
> >                 outputs beforehand and uses the test-tool pkt-line pack
> >                 helper to construct the protocol input in a temporary file
> >                 before feeding it to git upload-pack.
> >
> > * show-index: add warning and wrap error messages with gettext
> >         Status: Merged into master
> >         Mailing List: https://lore.kernel.org/git/20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com/
> >         Merge Commit: ea39808a22714b8f61b9472de7ef467ced15efea,
> >                 227e2cc4e1415c4aeadceef527dd33e478ad5ec3
> >         Log: While exploring the code, I noticed a TODO comment suggesting
> >                 automatic hash detection. After discussion on the mailing
> >                 list, it was concluded that there was no future-proof
> >                 approach to implement this until a new index file format
> >                 came into use. Instead, an explicit warning was added rather
> >                 than silently falling back to SHA-1. Additionally, several
> >                 error messages were missing gettext wrapping, which was also
> >                 fixed.
> >
> > * wt-status: reduce reliance on global state
> >         Status: Merged into seen
>
> When a patch series isn't yet merged into next, it's better to tell
> what's its status in Junio's latest "What's cooking in git.git ..."
> email. For this one, it looks like it is "Will merge to 'next'.".
>

Yes, merging to next was just confirmed in the latest Mar 2026 #03,
before this it was still with a question mark and pending for any comments.
I will update the status, including for the send-email patch.

> >         Mailing List: https://lore.kernel.org/git/20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com/
> >         Merge Commit: a7cd24de0b3b679c16ae3ee8215af06aeea1e6a3,
> >                 9d0d2ba217f3ceefb0315b556f012edb598b9724,
> >                 4631e22f925fa2af8d8548af97ee2215be101409
> >         Log: This has been the most significant patch series in my journey
> >                 so far. It began with a suggestion from Phillip to clean up
> >                 some the_repository usages in wt-status.c. I extended the
> >                 effort to remove all usages of the_repository and
> >                 the_hash_algo from the file. During review discussions, it
> >                 was suggested that some worktree API cleanup should happen
> >                 first, particularly regarding the representation of worktrees
> >                 as NULL. Some related changes were later moved to a separate
> >                 series, after which this refactoring proceeded.
> >
> > * worktree: change representation and usage of primary worktree
> >         Status: Continued by Phillip Wood [1]
>
> Here you can also say that they have been merged into master. Maybe:
> "Status: Merged into master after being continued by Phillip Wood"
>

Makes sense. I'll update this.

> >         Mailing List: https://lore.kernel.org/git/20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com/
> >         Log: This worktree API cleanup series started while I was working
> >                 on wt-status. The intention was to modify the representation
> >                 of the current worktree so that struct worktree would not be
> >                 NULL. During discussion, Phillip clarified that NULL actually
> >                 represents the current worktree rather than the primary
> >                 worktree. Since Phillip already had a patch based on the right
> >                 logic, he continued the series and it was eventually merged
> >                 into master.

[...]

> >
> > * Coding period (May 25 - August 16):
> >         - Review the work done by Olamide Bello on moving values parsed by
> >                  git_default_config() into the repo_config_values structure and
> >                  identify any remaining tasks.
>
> I think this should be part of the Community Bonding period.
>
> >         - Complete remaining cleanup or refactoring related to the worktree API,
> >                  if left any [19].
> >         - Identify straightforward refactors to remove usages of the_repository
> >                  in files such as xdiff-interface.c, archive*.c, fsmonitor*.c etc.
> >         - Work file by file with the goal of eliminating
> >                  #define USE_THE_REPOSITORY_VARIABLE by replacing global usages
> >                  with explicit repository instances.
> >         - Concurrently maintain at least two parallel patch series:
> >                 + Small / straightforward refactors and replacements like
> >                          the_hash_algo or the_repostitory.
> >                 + Larger structural refactors involving globals such as
> >                          DEFAULT_ABBREV, comment_line_str etc.
> >         - Publish weekly or biweekly blog updates documenting progress and design
> >                  decisions.
> >
> > * Final week (august 17 - august 24):
> >         - Address any remaining tasks or pending patches.
> >         - Recieve final feedback from mentors and reviewers.
>
> s/Recieve/Receive/
>
> >         - Prepare a detailed report summarizing the work completed during the project.
>
>
> Thanks for your proposal!

Thanks Christian, for reading and for the suggestions, I'll revise
and send an updated version on this.
