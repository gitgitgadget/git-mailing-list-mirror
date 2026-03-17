Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F06371CE9
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740270; cv=pass; b=LWgb95W+T6BnosSsZs1FV/zl2tLhLbnpTJgN91+FstDxvD1RCejQPXdLXbfUSDlRHHvweIXWAw+jv9nV6NQ/Kim7nqNbFaxobTKIVM26rG2BRArpTNxwBYij/KFlcXpHYaKiKWlsr+w6dEIKCPshsvqVrwRfW+JZmHM9AHm3TgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740270; c=relaxed/simple;
	bh=bUDHEOkhwMwlP4fEQnkmhHqrnhWaMtZnXr4689w8rE8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7dGMWuKYFRnM/OFxj+iJJuPqg66w0oiteEAjq7YoW3i/oJ87YtOQCA//QSnuKXlBBJXKVopKMLlC7eoUO0wqLH9Fq4fRQj63RAYlbSpugUI1Oi7beQUqwTyfWXEQOx9lBR7NLCg0AGvEEaOAzt3iLSf1iUeOla9KA5PtiXD7Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+OWMHxc; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+OWMHxc"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-950cc286d86so608492241.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773740268; cv=none;
        d=google.com; s=arc-20240605;
        b=gYvL76HlpooZgSnggTIau11u2OolRILmLPPDpUyj94LW+KMmC8ex+GrsvG9r6bziaB
         mTeIPaWP6eihn00CPEHJOtfgYfzh2CATI2OPfzOPjAjNobYhnrEHRVK0a0LAHNseawMd
         UZhc3aYvBvZilaq/2v1XW2w7BWu0L8zLXB+BBlM0FdozGlNQ9+BON+dxyawO6LkdkD89
         T2f7HYErtVffZRQ2rmBvgV78pzPEyfB0a1A/iD0EQRQjt5ySJPJ8DCzmcku8lIjWY17Y
         NJb5kLjob34BB5IDbirvtgvaQT7EDnRswdngebIENN38ep0Mwbf0RF1EempJrV7x9rjn
         qMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bqHd2mrKQEn1V0vvfTvBGfg2ickvcrXqfl43HHG3PdE=;
        fh=SggmJGi7xfwemMK2IZypC8qiJJsZYxORGHGgcnZhWyw=;
        b=jZQfmKljQa9TEPD0ZpN50fjV9G9aOEk1OIeT7Nm0w7Eiy07krcCqqRtprPNraGhP6Y
         5IrMMhRAZ6PDmph5Adey1JxLZ+H1oEK+Lfn4tQCTp0bMpG80ZejrsLBLpsMaNt36egtm
         9ErbDQh5uLpv7Kp52NntX0kmZIjvnlAindaBv7yHUaKK+vS16TAeyk5QEXS3KZuJedDk
         2/9rMk2o/OCi6l5mn8naEpepG/SCZ5tD71QZaOuD92gCnYf+prKUMWxvBAgXJAweOYku
         qPgxvhAvMyQhAm1IwsDdmwDxbtnMZKdAmneSSmCMm/owfuxYbz3+1V42Ap05eoLurqHL
         YMFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740268; x=1774345068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqHd2mrKQEn1V0vvfTvBGfg2ickvcrXqfl43HHG3PdE=;
        b=O+OWMHxcnOwnzF2JaBKZhtREXSCcTi4BZcQHuWH7OIharEyXVNWgiMCAxlgb/8zY87
         zDhro6wHae3raGLKb7BRZwDZ0F1YBgipxvF9Q7TNKBwrqwRz+Ujpa8155GIi5YbqpF9f
         kMmHA1BVUGWgb1P1vDoepc5ymM44AjOmF/vFHlCKav5K8FBgiVIRYtJrBj4AT1gPly/b
         HGVjkzXDENUFkh+bNrtKkuBfgpOFcaJbSqMWzbq9ornMtRzyb0H1zlsIzLwOy6CM5TyE
         qrpQ0KEi1Ug9Xad4KGLUuIo/5fCiuprgjIW9klhxZXrJNVSQHpAP/PKDlzQBZRN9XxOt
         rXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740268; x=1774345068;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqHd2mrKQEn1V0vvfTvBGfg2ickvcrXqfl43HHG3PdE=;
        b=Mq/2UpS8mPRe01IgeyG8k0qZ4FuLa80sAxfYDFB/YMR5zYIFVpLSMsAvPZkkgO3gtF
         aBUp+5fSbknpuY52oTYCQI1q3pVQu7fMR2kd2FdcvxVBi8pOz6E/0bxL9/AHuYwYmzMF
         u5cJTNJaywy0jmY5FvvzX18lcKeVUDPlgWoAz+wB7R39aPfMNs1kdaYXopDZ1CxoSv3K
         SHn1aYsRcsUyWu/+ym0w8O3zUylEfpYBRnxuv7/B1I4t5KJlDC51AY75CoXfvwFHhbiX
         FPg0chJjaKVm6sOVnT8TORnDhw7OQs+4CWe23vNTIX2AWHs0pn446YX7IxMbxP2TwVfZ
         FDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQMiBFPARM9gsaOXkK5uJbu2coowv0Hzs6Yfq7o7UUeXWHUw6OA1iYdMPuy/GhhA6JgCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbM96o3hT9lqhaIhCVkdgft8SCGsqNeN395OWU+dq9cWP+yW4
	fj4aYgCYmGjQ+dDoVibR49T1DqWPSEcqpCDSbM7DGtTFpUMabdi0Ha/fmohtOaHuCZDbhZIBtvl
	P80zp9AXYZmQwEKj7oofGrWpPrOe3bKM=
X-Gm-Gg: ATEYQzwNH+AWU1O//1ctvU9I55zf8VKEHEj2exZQ6U++trqWtz/fT0e/1YHZZj4t4LJ
	g3nqUQTJfRqQmHnlFSuc592ZjWQffeQdnCyWMxDJtkPinRhPHBNX7pZMPesWz5YynfnS9+XfjCX
	Bmn/LkHwmjYft5swly2waGWO3tfnL0rPmI/b9pgtZEI+QATDdEfVTce/61E6IbCRgq81KCmU208
	ArIvQe8aKJsC5ZPN7L4Yxp7WH9OJ5370Tcs7Y36LEiVRBL2d9dZzhkWPWppLLnjmylnnDwGTRWR
	i+Rxn118HIkCmXuNoGGYOLnro/zfBrQxGRNDsbhKVQ==
X-Received: by 2002:a05:6102:94c:b0:5ff:be25:8933 with SMTP id
 ada2fe7eead31-6020e1aa705mr6028647137.4.1773740268182; Tue, 17 Mar 2026
 02:37:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 02:37:45 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 02:37:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apERc0KU_95tQ@mail.gmail.com>
References: <CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apERc0KU_95tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 02:37:45 -0700
X-Gm-Features: AaiRm50DaJIDmtK3GmWKyxLjWdB45Pmtx7QqUpWxh9TbSE_twO34Fg5jUviyAzo
Message-ID: <CAOLa=ZTtNSZ904v0-SN16jAis7gK4=MVj1g_5CGdbmaBopeZkg@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL] Improve the new git repo command
To: Mansi Singh <mansimaanu8627@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, lucasseikioshiro@gmail.com
Content-Type: multipart/mixed; boundary="0000000000009bfd32064d3516f4"

--0000000000009bfd32064d3516f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mansi Singh <mansimaanu8627@gmail.com> writes:

> Hi everyone,
>
> I am Mansi Singh, an M.S. student at Northeastern University Seattle.
> I would like to share my proposal for the "Improve the new git repo
> command" project under GSoC 2026. I would appreciate any feedback.
>
> ---
>
> GSoC 2026 Proposal: Improve the new git repo command
> Mansi Singh <mansimaanu8627@gmail.com>
>
> =3D=3D 1. PERSONAL INFORMATION
>
> * Name: Mansi Singh
> * Email: mansimaanu8627@gmail.com
> * GitHub: https://github.com/MansiSingh17
> * Education: M.S. Information Systems, Northeastern University Seattle,
>   GPA 4.0, Expected May 2027
> * Timezone: PST (UTC-8)
> * Availability: 40 hours/week, May through August 2026
>
> =3D=3D 2. ABOUT ME
>
> I have 3+ years of professional software development experience, most
> recently at Nokia Solutions and Networks where I built AI-powered
> monitoring tools for engineering teams. Before that, at Grant Thornton,
> I built distributed audit automation platforms processing data across
> thousands of projects. This background in building analytics and
> diagnostics tools gives me direct context for why repository health
> metrics matter to developers at scale.
>
> =3D=3D 3. CONTRIBUTIONS TO GIT
>
> =3D=3D=3D 3.1 Microproject: t7605 - Replace test -f with test_path_is_fil=
e
>
> Replaced old-style path checks with modern test helpers in
> t/t7605-merge-resolve.sh. Went through 3 review iterations responding
> to feedback from Lucas Seiki Oshiro and name consistency feedback from
> Junio C Hamano. The patch was integrated into seen.
>
>   PR: https://github.com/gitgitgadget/git/pull/2050
>
> =3D=3D=3D 3.2 repo: Remove redundant variable shadow in
>         stats_table_print_structure
>
> In stats_table_print_structure() inside builtin/repo.c, the variable
> 'entry' was declared at the top of the loop body and then redeclared
> identically inside an if block. Removed the inner redeclaration.
>
>   PR: https://github.com/gitgitgadget/git/pull/2062
>
> =3D=3D=3D 3.3 t1900: Add tests for git repo structure subcommand
>
> The t1900 test file had no tests for git repo structure at all. Added
> 4 tests covering the default, keyvalue, and nul output formats, plus
> rejection of an unknown format.
>
>   PR: https://github.com/gitgitgadget/git/pull/2064
>
> =3D=3D 4. PROJECT DESCRIPTION
>
> =3D=3D=3D 4.1 Scope Decision
>
> After reading Kaartic Sivaraam's reply on March 10 advising applicants
> that the repo info scope was under discussion and suggesting looking at
> other areas, I examined the full project landscape carefully.
>
> The path-related git repo info work is already well underway =E2=80=94 es=
lam
> reda's patch series is at v6 and actively being reviewed. At the same
> time, the ideas page explicitly lists git repo structure enhancements
> ("functionality from git-sizer could be added to provide more detailed
> repository analysis") but nobody has started implementing them. That
> is the gap I am proposing to fill.
>

I would contest this a bit. There was overlapping work between what
Lucas was doing [1] and eslam was [2]. Neither of them have been picked
up by the maintainer.

I still think this needs to be done. But before approaching the problem
with a solution, we need to see some discussion around relative vs
absolute paths and how to go about it. Brian shed some light on it [3],
but there was no concrete solution as such.

This is not to say your proposal doesn't make sense. It is totally valid
to make a proposal to fill in the gap between `git repo structure` and
`git sizer` as you have.

> =3D=3D=3D 4.2 The Gap: git repo structure vs git-sizer
>
> git repo structure currently reports reference counts, object counts
> by type, and inflated/disk sizes. Comparing against git-sizer reveals
> three entire sections that are missing:
>
> Missing: Biggest objects
>   - objects.commits.max-size
>   - objects.commits.max-parents
>   - objects.trees.max-entries
>   - objects.blobs.max-size
>
> Missing: History structure
>   - history.max-depth
>   - history.max-tag-depth
>
> Missing: Biggest checkout metrics
>   - checkout.max-directories
>   - checkout.max-path-depth
>   - checkout.max-path-length
>   - checkout.max-files
>   - checkout.symlinks
>

There was also discussion about adding buckets to the metrics and
providing Histograms [4].

> =3D=3D 5. TECHNICAL PLAN
>
> =3D=3D=3D 5.1 Phase 1: Biggest Objects Metrics
>
> Extend the count_objects() callback in builtin/repo.c to track maximum
> values in addition to totals. Add corresponding fields to struct
> object_stats and struct object_values. Extend both table and keyvalue
> output formatters.
>
> =3D=3D=3D 5.2 Phase 2: History Structure Metrics
>
> Implement maximum history depth using topological traversal with
> memoization. Discuss performance trade-offs on the mailing list before
> implementing. For repositories like linux.git these traversals can be
> expensive, so I will place them behind --expensive if needed.
>
> =3D=3D=3D 5.3 Phase 3: Biggest Checkout Metrics
>
> Use the existing path-walk API (walk_objects_by_path) already called
> in cmd_repo_structure(). Extend the path_fn callback to track tree
> entry counts and path lengths during traversal.
>
> =3D=3D=3D 5.4 Phase 4: Removing Global State (Stretch Goal)
>
> builtin/repo.c uses USE_THE_REPOSITORY_VARIABLE. The most visible
> instance is get_layout_bare() which marks its repo argument as UNUSED
> and calls the global is_bare_repository() instead. I will implement
> this as a stretch goal, coordinating with the ongoing libification
> work in the community to avoid duplicating effort.
>
> =3D=3D 6. TIMELINE
>
> Community Bonding (May 1 - May 26):
>   - Establish sync schedule with mentors
>   - Initiate mailing list discussion on metric naming and priority
>   - Study git-sizer implementation for algorithmic approaches
>   - Finalize struct extensions needed
>
> Phase 1: Biggest Objects (Weeks 1-4, May 27 - Jun 22):
>   - Weeks 1-2: Extend structs, update count_objects() callback
>   - Week 3: Extend formatters, write tests in t1900-repo-structure.sh
>   - Week 4: Address review feedback
>
> Phase 2: History Structure (Weeks 5-7, Jun 23 - Jul 12):
>   - Week 5: Implement commit graph traversal for max-depth
>   - Week 6: Implement max-tag-depth, add output and tests
>   - Week 7: Midterm buffer, address feedback
>
> Midterm goal: Phase 1 merged or in next. Phase 2 under review.
>
> Phase 3: Biggest Checkouts (Weeks 8-10, Jul 15 - Aug 2):
>   - Weeks 8-9: Extend path-walk callback
>   - Week 10: Output formatters, tests, documentation
>
> Weeks 11-12: Buffer and Finalization (Aug 3 - Aug 17):
>   - Address remaining review feedback
>   - Begin Phase 4 if time permits
>   - Final documentation and GSoC report
>
> =3D=3D 7. RISKS AND MITIGATIONS
>
> Review cycles: Structured so Phase 1 completes early, giving maximum
> time for iterations before midterm.
>
> Performance: Will benchmark history traversal against linux.git and
> use --expensive flag if needed.
>
> Design disagreements: Will initiate naming and format discussions
> during bonding period before writing any code.
>
> =3D=3D 8. WHY I AM THE RIGHT PERSON
>
> The git repo structure enhancements I am proposing are fundamentally
> a repository analytics problem. At Nokia I built monitoring tools that
> aggregate diagnostic metrics for engineering teams. At Grant Thornton
> I built systems analyzing data across thousands of projects.
>
> I have already studied builtin/repo.c, run both subcommands, identified
> the gaps by comparing against git-sizer, and made three contributions
> touching the repo codebase directly =E2=80=94 including tests specificall=
y for
> git repo structure, which is the subcommand I am proposing to enhance.
>
> My microproject went through 3 review iterations in under 2 weeks and
> was integrated into seen.
>
> =3D=3D 9. REFERENCES
>
> * GSoC 2026 ideas page: https://git.github.io/SoC-2026-Ideas/
> * git-sizer: https://github.com/github/git-sizer
> * Original git repo introduction:
>   https://lore.kernel.org/git/20250610152117.14826-1-lucasseikioshiro@gma=
il.com/
> * Microproject PR: https://github.com/gitgitgadget/git/pull/2050
> * Variable shadow fix: https://github.com/gitgitgadget/git/pull/2062
> * Structure tests: https://github.com/gitgitgadget/git/pull/2064
>
> Regards,
> Mansi

The rest looks good to me :)

Regards,
Karthik

[1]: 20260228224252.72788-1-lucasseikioshiro@gmail.com
[2]: pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com
[3]: aaSusXil9nDHYGMR@fruit.crustytoothpaste.net
[4]: CA+rGoLd0_gc36EBv_DieVqtjLn1FL39vtT5ib1fEbk-+OvPP6A@mail.gmail.com

--0000000000009bfd32064d3516f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee0d944891a49951_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNUlPY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meC9aREFDWkt0STdRazVEcUZDQWZYNnhUZ2YwNlRwWgp1OWE3VUlDSUZt
bUl2Q2E5Q240VW81KzRtRFNLMm1PM0JIMXR1T1VmSWFTOHRHMVQzcytiNU1mTitkZW9LL1phClB2
WUtNZWFwcGx3aUFqMU5TTnZWcXZRRm1wY2hYcVJZS1puOXF3cnp6eDBBdmtIQ2s4R0NQcThCQ2to
RzVSdmsKQ2Y3U2t1L3l6aXJnN0hOaEE3R21rdXFYRis1V1gzK21vWmQyY1R5L2djWDZjSmdLS3pl
emlhTWRuSnA3WW9mbQo3N0crdXNWQzVkT0NiZ1JoVVdKZ21nb1VxTDNYajFiOXVpYUhFclFFeGFO
UzUybENWcVNKZFdzNHhOY3N3Nkc5CmtJRlNmMHlYZndDMiswd0tBc3BwQWhwckx6WWlubFZkOTJO
aHg4MENPTlBPN3NHUHhTZmVqRytrdGw2STZPejMKNFhJWEZIN0FEK285ek96eS9TT0JPWFVEd1Q5
OTlDOXprdmFVTk9MNlZKcmpLeFNOS3VnamhmTEd0dDlNOFY1awp4VEpjU1VmdUxXa1dmU2wvdWkw
T1pHMW1aWVBBTmxGR0ludUtBcVdlajFPdzc1S1NqbU5yOXN6b1NPU1I0TkIrCkNsUzMwaDYwcGJp
eFdBd29WM09RSmhOSnNxOTVRU1RPdHVKUWtOUT0KPUU5aWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009bfd32064d3516f4--
