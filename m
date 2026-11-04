Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788016;
	b=eSyWvbvKTLSP+N3su4hsAQRlKvqtd9kQ3NQYxzK/DTKYJy+qK+pZCueCMhjdqUw9Wx+g
	 QWTpDvcIAjyGuHIJefpAXHH2Ktgft4Xn3wWNFlDAkrNWZBCIemd7QP2Gp6O2zUzNIuCFd
	 YAuHQszps4TJJJcBsQSKewUNmoD4bkBg0ITI8KVsvjW3swmMqqYtPbiCf23hcCv+mXWm6
	 Grvd6+eezc8bFllH9VGhhvxPv6cHJvzyh5f9ZACTXpE/om+86Z4hNjuXX4p7+6B1E2V2u
	 6IOPzWe9V1cqvhWSOdCuC7i2a1KmnYY5dDSsS8tJJEJySgEEVXYIn2Hqdj8sEEq6zOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=DwfQaC0Vs9ej4goDyAgE0uGdXBEPF/thUFb7tcd9UmM=;
	b=EQmp8LMFlBPUXEVqULDW3s8SY8VVdgVov6c3DgYdjF4t2n+SIQAeiA+ZftT+VJ3Mmzj8
	 pW8K639Pfe5yENf9l22LR1g9iJQdrmGWvDx+oU625VMjl3JRYLo6oFqmmNvSad5zAETyD
	 cP4lew/WhfLyStzcCmDOTl6GIhedZxeh7YDBTKLLdONzDjyH8wa/wDloAQUiciv2IAVdO
	 alt/RvZVuNdss/w1G3qpbSj+Fir+R7NO9zsflDLazwl76O4trVGaWjGot9XN2vc+YacWA
	 LtulmysVGIvp5J+cnTk3SUwKwoUtlcMvHqjjYW76SV0cf1RRpDE7X9CkYzOMX7WD4YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXyXra0b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B6606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 111B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXyXra0b
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7ce645a1c6aso273563137.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 02:26:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793788015; cv=none;
        d=google.com; s=arc-20260327;
        b=AVgKd5nyIoACXzmYtr6V34udB0IOrbW+z4/LphTcO9/S8pzoSXSax+lSJbMIdPsEdM
         MJB+r8F6opY05zaySCDn0zZB6w2xHQBZGPCnDxHOVIBNcxMwur8nEhvrjDShwUo60kdm
         arDiAu/uQszsvnBPDvYcNz5r1oVczPssIVw4tRoQAbW5NhzSU1UEKk+/w+Wy6JqXed8D
         GrasCY84OW3YtMb9EKRNFX314sPh7FkZvCqeBrVSb+1pDBitHjK6pXFtGSaphLdFhIou
         tIYEj6udjAz9Ab1fxKa56cjSz2X+4IqZ9sBNgmRFp+1I++Dp5MgncnmCmtTLodnkqHNI
         py/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=DwfQaC0Vs9ej4goDyAgE0uGdXBEPF/thUFb7tcd9UmM=;
        fh=wMAm3cqQhDHVCnV5Zc0/tMVL6LI7e5QwG6VSMBGS0J4=;
        b=no0Id5VG6EcsGCaIrBVTW+48r8mzK9m1ywI1O5Ic98c0rHelvEeTpW8VJlX1hAeDyV
         m8rPIhTSb9OEEwRpOznAfliOKuZPlg88d3FbaRg3thpR5wEBXmPsqRIob1vIEZsiHIC2
         nJGYZtA3R6eHGdXez85NorUpfYtggTMRQEfSxfYA5+boano3FJju7pzGbpZjnhKolWx8
         psg5ncvkCVSJ511ypV4BWc51jkqjUjWZOgbLqXH/pUamYssFLxlSEO7SXlU5BclXlvQf
         /8M9jTzyytICK/sRg7/0klmBNvCA7at0DyN/OjmTNPl2uGEgWgFRcAxXTvDtbsD5LTzn
         Ecpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793788015; x=1794392815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwfQaC0Vs9ej4goDyAgE0uGdXBEPF/thUFb7tcd9UmM=;
        b=CXyXra0bqSKNXhCb2WpheszNNJXx+iY0YSJqy2tjQ+hZ3pZpIlxwI9o0YLFhbBsKy0
         U7N0dlNCULOKbP+teFqEC6JI3FHCnjiN/Yghvx7tHQYXIdTOHrl2j8+x8N/Ezv1ieLHm
         MivNu4IRRPzxb7CLk3wDHl28Gb/DJnIIOrsRq+QjroyaUO0K6iq3baZiv6tXYxypYtj9
         xv/NyAdV2IeiPICR8olbL8iAti7hOzSYU55Wy54HDsT5mRO543gNKO/6kWgx11UFhbDr
         534/YKJCJIbOj7HFKR+lkl+1myU7ot+bbKBhoGrHAfbTKcOKuxiRIx+8HWDBQoKlNHS7
         ktFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788015; x=1794392815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DwfQaC0Vs9ej4goDyAgE0uGdXBEPF/thUFb7tcd9UmM=;
        b=0Zc4TEu3mWuAMb2OKBWIxDx7LJnoohgI9dHKOEr8ItYsHJN7S68oQSmJLaErbatG+I
         z2TG7rDpEUHjatPjgBy88QOmRDXv6vGF6A9taWdrIgzXOKlGLMXWwTI19KQdqZrTGtHc
         WxQoxYSh5uQUWcqf1Yp//mxE4UKczTnD8OAPG2FYwOCIgfnB4JA98Ap6aFgpBe86+Ull
         6YY7MjWJGofjODNA/XI5creL4wXRN5IEmCmx0Vq3gG+SggodhdNHzrRnVB+QL+7OlJrg
         zI3HbOjI+bypA5+s6PqsQfbG+QEoQxC52dFKTC82v6OJ/j9g6rRsSb/oaPwOEl1cqEpY
         3f1Q==
X-Gm-Message-State: APuU4Z9DTXDa/xxcgffeOljMBrVat49IUCYu28lD9yJYxwjgBYLfpApv
	kEuNfeYrir258PaRBlpkhsKrSHTforHCpkc3LuLmBriPK545smrTd4aTjKLO37K9UOvV12TNadY
	Y62tpMm4HvrYVl19HiftCpdK1L8pW6I+rx9x4
X-Gm-Gg: AYBFou3gCQmolPfcm/IX4s5x9JNMTkEL8PiXUTJnMS5mF4Kohd8c30s4wRUMeTGh26f
	hgSI5gR8MtA+UCyyq5aTgaL6ML+wrbakCfLJkPWspXBOIMN4yA+npiZkaKxyQ4Z39HawHRiWmCr
	Gh/2xS579b2bLXpGi1eIV8O2c0KhCUvHvRMM9S2xHMj14/70oTmDio9PtbikSyaAliT8lbf5koK
	nm106/vMfu5sMWiLnrWTsAJfV1/BKV/2QBuwXy73qXb3GbkHVu8+plJ/skKFD30xENyxvGc3p/Y
	QdZK2V0SCTlBmh3aYE3ez4GFl5S2kq8N4acKKOfqMkFATfwObbFj/SaUzg7/jDmOpDiHPoVbFcA
	/Z69LOPEAFP+JuNdP3oW8QcIhi7RIfYzD1n1XBrOCc3JDu96OJ4ZuIKsqhFD3Osa09PZqbyVaeY
	rlvJWYcUnWG66QL85HksoljVhOLUu4isW1MfwH8lq8z2p3XA==
X-Received: by 2002:a05:6102:a4e:b0:7cc:80ba:5e5c with SMTP id
 ada2fe7eead31-7d072bbdd54mr6977861137.6.1793788014847; Wed, 04 Nov 2026
 02:26:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Shashank S <shashu8660@gmail.com>
Date: Wed, 4 Nov 2026 15:56:43 +0530
X-Gm-Features: AclHuK8g1GX3iCgPQcEVnor22xXcF9mr-WQJxRsJjxt6HH7u3erKXT2fv7tOU4U
Message-ID: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
Subject: [Outreachy] Project Proposal : Implement promisor remote fetch ordering
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.co
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is my proposal for the project "Implement promisor remote fetch
ordering" for the December 2026 Outreachy internship.

I would appreciate any feedback from the community.

Personal Information
----------------------------

Full Name: Shashank S Mogaveera
Email Address : shashu8660@gmail.com
Github : https://github.com/shashu8660
Location : Kundapur, Karnataka, India (IST, UTC+5:30)

About me
-------------

I am Shashank, a software engineer with a strong passion for C
programming, system architecture, and network protocols. My journey
into open-source development began with a desire to understand how
massive, distributed systems operate under the hood.

During this Outreachy contribution phase, I initially focused on Git's
core libification and option-parsing APIs, which allowed me to get
comfortable modifying Git's C structs and internal memory management.
However, my true interest lies in network optimization. Diving into
Git's GIT_TRACE2 engine to map out how partial clones communicate with
promisor remotes convinced me that the "Implement promisor remote
fetch ordering" project is exactly where I want to focus my 13-week
internship.

Past experience with git
--------------------------------

I have been using Git extensively for version control in my personal
projects. This contribution period was my first time engaging directly
with a mailing list-based open-source community.

Learning to use git send-email and GitGitGadget to format patches,
manage versioned rerolls (v1, v2), and incorporate maintainer feedback
has been a massive learning curve, but a highly rewarding one. I
learned the importance of atomic commits, clean commit messages, and
the strict rules around not ignoring Git's exit codes in shell
scripts.


Contribution to the git community
--------------------------------------------

Microprojects:

1.  t0081: modernize the code testing whether a file exists
     Link: https://lore.kernel.org/git/pull.2254.git.1791962806807.gitgitga=
dget@gmail.com/
     This patch series was integrated into master via
githttps://github.com/git/git/commit/e1bb515788e48d500c9d4e36f13c66c4daddd3=
d4

2.  t2403: modernize test for directory existence
      Link: https://lore.kernel.org/git/pull.2259.git.1792125111461.gitgitg=
adget@gmail.com/
      This patch series was integrated into seen via
https://github.com/git/git/commit/c645a5db002ded161115dc8f6c15a40acfdde2b2

3. prune-packed: remove use_the_repository_variable
    Link :https://lore.kernel.org/git/pull.2266.git.1792341073005.gitgitgad=
get@gmail.com/
    This patch series was integrated into next via
https://github.com/git/git/commit/936609cfa0a57e1b047c345a91fec79ab255897c

4. test-chmtime: use parse_options() to parse command-line flags
    Link: https://lore.kernel.org/git/pull.2280.git.1793099688076.gitgitgad=
get@gmail.com/
    This patch series was integrated into seen via
https://github.com/git/git/commit/c6a318cc4b8c6f6ce1a403e497816cd195c57cf7

Project Overview: Promisor Remote Fetch Ordering
----------------------------------------------------------------------
When a Git repository is configured as a partial clone with multiple
promisor remotes, there is currently no defined mechanism to specify
the order in which these remotes should be queried for missing
objects.

Different remotes have vastly different performance characteristics
and bandwidth costs. Currently, Git relies on a hardcoded fallback
system rather than deterministic priority. This project aims to
implement a flexible fetch ordering mechanism by introducing a
client-side configuration list (promisor.fetchOrder) and a server-side
advertisement extension via Git Protocol v2, allowing servers to
broadcast their preferred fetch order.

Phase 0: Baseline & Trace2 Playground Verification
----------------------------------------------------------------------
Before designing the protocol enhancements, I established a verifiable
baseline by building a local partial clone playground with multiple
dummy promisor remotes (server-A and server-B).

To prove the telemetry, I forced a lazy fetch by requesting a missing
object (file2.txt) and captured the transaction using
GIT_TRACE2_EVENT.

- Verification: I successfully extracted the
{"key":"fetch_count","value":"1"} data event and the specific
child_start subprocess (["git","fetch","origin"...]) proving which
remote Git communicated with first.

The Current Baseline (Ordering Rules): Git currently lacks a
deterministic, user-configurable fetch order for multiple promisor
remotes. Based on my trace testing and codebase review, the baseline
behavior is:

- By default, Git iterates through configured remotes in the order
they are stored/parsed when attempting to fetch missing objects.

- The remote configured via core.partialClone (usually origin) is
treated strictly as a fallback and is checked last.

- If a remote fails, Git moves to the next available promisor remote
until the missing object is found or all remotes are exhausted.

Internship Plan and 13-Week Timeline
---------------------------------------------------

Pre-Internship (Now =E2=80=93 Dec 6)
-----------------------------------------
Finish resolving feedback on my test-chmtime.c (v2) and prune-packed.c
patches.Study the promisor-remote.c sorting algorithms and Git
Protocol v2 documentation.

Weeks 1=E2=80=932 (Dec 7 =E2=80=93 Dec 20): Phase 1 - Visibility and Baseli=
ne
---------------------------------------------------------------------------=
----------
Goal: Document and lock in Git's current behavior to act as a safety net.

Tasks: Submit a docs-only upstream patch defining the current fallback
rules (accepted before configured, partialClone last, fallback on
failure). Develop automated tests utilizing GIT_TRACE2 to definitively
lock in and prove the current sequential fetch order.

Weeks 3=E2=80=935 (Dec 21 =E2=80=93 Jan 10): Phase 2 - Client-Side Ordering
---------------------------------------------------------------------------=
---------
Goal: Implement local configuration for promisor remote priorities.

Tasks: Introduce the promisor.fetchOrder configuration list. A list is
preferred over per-remote integers as it composes cleanly across
config files. Refactor internal sorting logic in promisor-remote.c to
reorder remotes based on this list before initiating lazy fetches.
Implement edge-case handling for unlisted remotes and preserve the
partialClone-last fallback rule.

Weeks 6=E2=80=939 (Jan 11 =E2=80=93 Feb 7): Phase 3 - Server-Advertised Ord=
er
---------------------------------------------------------------------------=
-----------
Goal: Extend Protocol v2 to allow servers to broadcast their preferred prio=
rity.

Tasks: Draft an RFC proposing the protocol v2 explicit priority=3D<n>
fields. Implement server-side advertisement gated by a new
promisor.sendFields configuration. Implement the client-side parser,
strictly adhering to the "ignore unknown fields" rule to maintain
backward compatibility.

Weeks 10=E2=80=9312 (Feb 8 =E2=80=93 Feb 28): Phase 4 - Upstreaming & Prece=
dence
---------------------------------------------------------------------------=
--------------------
Goal: Secure mailing list approval and resolve precedence rules.

Tasks: Settle precedence conflicts (Recommendation: local client
config maintains absolute authority, while the server's advertised
order sorts unranked remotes). Split Phase 2 and Phase 3 into a clean,
reviewable patch series. Route through at least two rounds of mailing
list review.

Week 13 (Mar 1 =E2=80=93 Mar 8): Polish & Stretch Goals
-------------------------------------------------------------------
Goal: Finalize documentation and explore dynamic caching.

Tasks: Write final release notes and user-facing documentation.
Stretch Goal: Implement runtime memory of failed remotes within a
single process to skip them on subsequent lazy fetches to reduce
latency. Submit final Outreachy report.

Availability
------------------
I can commit 40 hours a week to the project during the internship. I
am based in India (IST, UTC+5:30) and can adjust my hours for
synchronous calls, pair programming, and mailing list reviews to
overlap with my mentors' timezones.

Blogging
-------------
I will document my technical journey, posting weekly updates on the
C-level challenges I face, how I navigate network tracing, and the
feedback I receive from the Git community. I will share each post on
the mailing list.

After the Internship
---------------------------
After the internship, I intend to remain an active contributor to the
Git core project. Having touched the libification, option parsing, and
network protocol subsystems during my application, I want to continue
bridging these areas=E2=80=94specifically helping remove the remaining
USE_THE_REPOSITORY_VARIABLE macros from network-facing C files like
promisor-remote.c.

Appreciation
-------------------
I want to express my gratitude to Usman Akinyemi, Junio C Hamano,
Kaartic Sivaraam, Patrick Steinhardt and Cynthia Uche. Your patience
in reviewing my early patches and helping me understand the git
send-email workflow has been incredible. Thank you for making this
community so welcoming.

Thank you .
