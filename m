Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793795276;
	b=UdFEbnctEp4IgrmLMme5sojoxctnwcb9wOSV6eAzeZK7zH9XzTYmQC3iTvmsmbsXIeau
	 zOPSrnox0dNNeHEojcr6pOH7R7vAnnojlWmI4tZa1x60zC3gHnu+VrfZe1osDGxTjdXRr
	 8xR6kIiNDrtp/+C5f4B69G9rjCyO+fX6SMpm8EZruz6cwadOaaU1M5MILu5seuRFrS2i8
	 Hh2OfPlOFY5ewsYBYczRSMTpmRhNgKDKEz+UPXnhAkjykkAk9DwaXOR7Nue+yw3clsj53
	 Zlqf8Z/WKpXUh/99mQ8FfxxUVPp0dPfvczWdmcj9iYZm6TNJrDiEcpE0vTf+l1M7pjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UZ4OVZ+jewSNs3hMlEEXDyZTzR/1omsXhaYPAot8mck=;
	b=p6Y+Lv381JGFTBb4Q/50IfYnjgp7a6n0uDCdBko/Opzuf7L2CctCtCv3xxF0yDn4dT0G
	 9OKf01zRksBlaRuw4D2ktAdsmLylJlpWRf4Z4QhuTPTek4apV6pbhF0ULL9T04/8+fX74
	 ddrZco/kQMIHHfS4b3agsDm6CaKTCVQ8K8J12aQKdOTdWn2reHCerfvs2HhOE7hhT14Al
	 cl/bIY2XfG7OUvrZVmstYesC7bpCeWJC8AJOE4SxSG2pAbuPOajKFpg7AngN0jgtZYeo5
	 9brl4AAXoTEhP3VDirQY8bTg3pDsXZYUAJ/9wzoZ5z385NoWsnPKbsZNpEmWD/dSBng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CAImsSRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FF606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15FF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CAImsSRi
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so188948241.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 04:27:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793795275; cv=none;
        d=google.com; s=arc-20260327;
        b=FR/RxR2/wkxGbWe8PfFm/vbVPFGD9OGjYJrGJWXLlPWZcQ1DGFdVek4hUe6Q4/9ej5
         p0oekHmDWeXvbuVFmxzhFEBh4ZmEXJPYrCKc7ip9DlLbX6QkwaP2NF1F4AQrf74I+DJZ
         ozPWsw9aGKlcHvR+1TlLtzbM+ia+oiZVKQw1E0ehrMbi3z71gMrz738rFmQcDCZu6Jgr
         Haare5zJTeTZBb4cDIO73f7YycZB3VZZEMeVs5Gq6TdA2afZsNlyynG21SjKrlHaHfHX
         2eEYz/HEPkPswE2oOBpCcZvRZ1LeOLbdqlckOP7BDq0fnV7I96z3QjwaYCtYBmhG3FFO
         MEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UZ4OVZ+jewSNs3hMlEEXDyZTzR/1omsXhaYPAot8mck=;
        fh=SudFQjZ2/B6yfhmjv34SMPuSSiifg6iXyQBpFaepb+Q=;
        b=e+3BLYf/IwZmWK5l7Wr8vHijOUD34bc9gQk5jQ03QVFTp4MhpmxgqPQEeybeNMv+zg
         XWTG2ZmMHMhGfYiCmVWw3TPH2ZkkuM7l6Rv2stSFO2kkBgDVdJvuhiOnLxD6jIOoMkDW
         okhHDqE2Bm+HlxhqMiQUkeIIu297WA+a5rpEQAG70nSU+X42WbPOw1Duk1iJ9AbXgFME
         dxXapFrkTZ5ZNApeWyhX3CRwfrscnsZT7g1Qy6sKtB1ixFk4yDkpHTRpIgTzHh5DncbM
         9fZv1bQp3Zd+KXZs5Dtcv95BOlPbSBM7O5B6BdUFMiS88sljSdcBylu2dKjvMhDnt3q/
         I+sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795275; x=1794400075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UZ4OVZ+jewSNs3hMlEEXDyZTzR/1omsXhaYPAot8mck=;
        b=CAImsSRiyTJ6r/Moaae0i7Cd5z1cWliCjQCGJyLPxzpW78cB8n3+3PMrn83kIHAksw
         ocuffwBEtsWE9LfdiN0/1rrcsCn+M3AsQ5oFPT5680RGeH6KeJL2UZb5k5hI82bDVnai
         1d5AU0q+lQYhEWZ9HG2CMxJjzoFRs9AbLz1UfrsKpkvErI28uEyKsv3O2nJEuTQfEvQM
         OpmVc1joAcNf0eHuICZrjMxszltkQT2aAueSLTzLolkRHFxsv6UBVK+J4/8q6Upycud3
         1LgclKhhkFUyDQkuoAHZFb78e1lA9YNUTmTKd/hprfQ9ThCBt3gDQe5nvRBSiYzfCehq
         L5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795275; x=1794400075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZ4OVZ+jewSNs3hMlEEXDyZTzR/1omsXhaYPAot8mck=;
        b=rodSzD4BGbJHsj90QVqFn65ZXdpdmc4YIo8khMzvoF676pVWikoyZ3nSBoeRmvRHqJ
         66pi/qGpfMf2aWw259MBcJoaBwCaagl/gTv/VTDHKPbTnIcOaiiBZwV5bHxX7l0Vn7lA
         c8+WtMyfPVKnYDWHc+G9c2HFIxP3cm7VFdWjJMMz2UCPgpCJmL7DdbsxKS1TZoLbhZEf
         nm5lq2xJfbUDMnItwOGkEb/jEXGefrZTxI1w9XSrqWCvzdiuoF/Jq9Ze+l2E/8BObnvI
         IDlWvhqq49WcWO6NjA2Ok9SVX6rK7VuKI+PG4+YTWXwcv6DCSV+N/Uko1wVaMoLK3gSC
         /4Zw==
X-Gm-Message-State: APuU4Z8Wbo+71TmwG5h4p7lon1CVrw+JEE2fqSxbB3OCMjafXbmCi7Yw
	c+rI+cd8CTyK35Uxx7I8y7LBmhSxdufCEld9iCTvLrjvTWi/1LWBtvIvoa9uoNw4u1C96L0v3Su
	1W/aYs5tgkDU6aPDzahuxWotnWiaGvOuyC/PW+w8=
X-Gm-Gg: AYBFou2Ffl/w0hIc2yeHs6MaY0GtleoJB5FPoiRqRK/hveTSoDIv12A/mll2Oub9hc3
	wq+xhYLgtYMEmgrj00RSyBtprVAgpE3ZQIG9M6PMy9HHSiT5IfozbN4Ht8/iaL1mMcEbR66adHc
	vLsHZyh3IAJvwyhWXJRoxIiF/HB7wUYUQx9pRfIdr00cWD6LM+S+phQmiTCryFjr6irtIA4bHTW
	QawgD8HjKCHyvVaXshAxau+Bp13LIzpBo0FesaDRqAvn0VsBZ4qVoM1g0pK6WC+RdLHnxjYLrem
	zw+g1TvEkaY50gTI4lywSBHV7AuLfDfKRI1XSDiDeiwczI1CSwclzqj5tJ93brWMAetigdF5s3S
	9m3rlmO4H13Y1gNnUeUF4BCdx48j/X8atfdR0tZAznXVkEmymPYxF4E/FcHctqUNOyGbOKS6t6E
	lFfC7kzQAw2nmU+GoZ/tCqd4VP
X-Received: by 2002:a05:6102:fa0:b0:7cc:118e:7bfe with SMTP id
 ada2fe7eead31-7d072626940mr5854480137.19.1793795274548; Wed, 04 Nov 2026
 04:27:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
 <CANHmUQSBs=Mq1Y1GTY6P9FtyCQz58bDWFgJPgwv4r5rLP3C1Bg@mail.gmail.com>
In-Reply-To: <CANHmUQSBs=Mq1Y1GTY6P9FtyCQz58bDWFgJPgwv4r5rLP3C1Bg@mail.gmail.com>
From: Shashank S <shashu8660@gmail.com>
Date: Wed, 4 Nov 2026 17:57:39 +0530
X-Gm-Features: AclHuK-6APxfeVRd2S3iDHGFf8nX7qOmaKMjgxY2V-gHbhc0MMSVa4ubhQTt3QY
Message-ID: <CANHmUQSZqXtqXsiDQs+1unGcyEuaPhaF8__E_Cy4fWNqxapY5A@mail.gmail.com>
Subject: [Outreachy] Project Proposal [v2] : Implement promisor remote fetch ordering
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello mentors and Git community,

This is version 2 of my 13-week project proposal for the "Implement
promisor remote fetch ordering" project for the December 2026
Outreachy internship.

Changes since v1:
- Fixed a typo in Kaartic Sivaraam's email address in the CC line.
- Fixed broken/merged URLs in the "Contributions to the Git Community" sect=
ion.
- Included the full text of the proposal inline below for easier
reading on the mailing list.

I would appreciate any feedback from the community.

Personal Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Full Name: Shashank S Mogaveera
Email: shashu8660@gmail.com
GitHub: https://github.com/shashu8660
Location: Kundapur, Karnataka, India (IST, UTC+5:30)

About Me
=3D=3D=3D=3D=3D=3D=3D=3D
I am Shashank, a software developer with a strong passion for C
programming, system architecture, and network protocols. My journey
into open-source development began with a desire to understand how
massive, distributed systems operate under the hood.

During this Outreachy contribution phase, I initially focused on Git's
core libification and option-parsing APIs. However, my true interest
lies in network optimization. Diving into Git's GIT_TRACE2 engine to
map out how partial clones communicate with promisor remotes convinced
me that the "Implement promisor remote fetch ordering" project is
exactly where I want to focus my 13-week internship.

Past Experience with Git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have been using Git extensively for version control in my personal
projects. This contribution period was my first time engaging directly
with a mailing list-based open-source community.

Learning to use git send-email and GitGitGadget to format patches,
manage versioned rerolls, and incorporate maintainer feedback has been
a massive learning curve, but a highly rewarding one. I learned the
importance of atomic commits, clean commit messages, and the strict
rules around not ignoring Git's exit codes in shell scripts.

Contributions to the Git Community
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. t0081: modernize the code testing whether a file exists
   Link: https://lore.kernel.org/git/pull.2254.git.1791962806807.gitgitgadg=
et@gmail.com/
   Status: Merged to master.
   Commit: https://github.com/git/git/commit/e1bb515788e48d500c9d4e36f13c66=
c4daddd3d4

2. t2403: modernize test for directory existence
   Link: https://lore.kernel.org/git/pull.2259.git.1792125111461.gitgitgadg=
et@gmail.com/
   Status: Merged to seen.
   Commit: https://github.com/git/git/commit/c645a5db002ded161115dc8f6c15a4=
0acfdde2b2

3.  prune-packed: remove USE_THE_REPOSITORY_VARIABLE
   Status: Reviewed and marked ready for integration by Patrick Steinhardt.
   Description: I refactored the C file to pass a struct repository *r
pointer through a void *cb_data callback API, successfully removing
the reliance on Git's global state variables.

4.  test-chmtime: use parse_options() to parse command-line flags
   Status: v2 submitted.
   Description: I ported ad-hoc command-line argument scanning to
Git's official C-level parse_options() API, handling edge cases for
relative time offsets, and added t0082-test-chmtime.sh.

Project Overview: Promisor Remote Fetch Ordering
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Before designing the protocol enhancements, I established a verifiable
baseline by building a local partial clone playground with multiple
dummy promisor remotes (server-A and server-B).

To prove the telemetry, I forced a lazy fetch by requesting a missing
object and captured the transaction using GIT_TRACE2_EVENT.
* Verification: While the promisor.fetch_count=3D1 data event simply
confirmed a lazy fetch was triggered, extracting the sequential
child_start subprocess events (e.g., ["git","fetch","cache-a"...])
provided the definitive proof of Git's remote routing order.

The Current Baseline (Ordering Rules): Git currently lacks a
deterministic, user-configurable fetch priority system. Based on my
trace testing, t5710, and the logic in promisor-remote.c, the current
hardcoded fallback hierarchy is:
1. Git first tries "accepted" remotes (server-advertised remotes that
were provided to the client during a previous operation).
2. It then iterates through ordinary configured remotes in the order
they are stored/parsed.
3. The remote configured via extensions.partialClone (usually origin)
is treated strictly as a fallback and checked last.

If a remote fails, Git moves to the next available promisor remote in
this hierarchy until the missing object is found or all remotes are
exhausted.

Internship Plan and 13-Week Timeline
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The internship runs from 7 December 2026 to 8 March 2027.

Weeks 1=E2=80=932 (Dec 7 =E2=80=93 Dec 20): Phase 1 - Visibility and Baseli=
ne
- Goal: Document and lock in Git's current behavior to act as a safety net.
- Tasks: Submit a docs-only upstream patch defining the current
fallback rules (accepted before configured, extensions.partialClone
last, fallback on failure). Develop automated tests utilizing
GIT_TRACE2 to definitively lock in and prove the current sequential
fetch order.

Weeks 3=E2=80=935 (Dec 21 =E2=80=93 Jan 10): Phase 2 - Client-Side Ordering
- Goal: Implement local configuration for promisor remote priorities.
- Tasks: Introduce the promisor.fetchOrder configuration list. A list
is preferred over per-remote integers as it composes cleanly across
config files. Refactor internal sorting logic in promisor-remote.c to
reorder remotes based on this list before initiating lazy fetches.
Implement edge-case handling for unlisted remotes and preserve the
extensions.partialClone-last fallback rule.

Weeks 6=E2=80=939 (Jan 11 =E2=80=93 Feb 7): Phase 3 - Server-Advertised Ord=
er
- Goal: Extend Protocol v2 to allow servers to broadcast their
preferred priority.
- Tasks: Draft an RFC proposing the protocol v2 explicit priority=3D<n>
fields. Implement server-side advertisement gated by a new
promisor.sendFields configuration. Implement the client-side parser,
strictly adhering to the "ignore unknown fields" rule to maintain
backward compatibility.

Weeks 10=E2=80=9312 (Feb 8 =E2=80=93 Feb 28): Phase 4 - Upstreaming & Prece=
dence
- Goal: Secure mailing list approval and resolve precedence rules.
- Tasks: Settle precedence conflicts (Recommendation: local client
config maintains absolute authority, while the server's advertised
order sorts unranked remotes). Split Phase 2 and Phase 3 into a clean,
reviewable patch series. Route through at least two rounds of mailing
list review.

Week 13 (Mar 1 =E2=80=93 Mar 8): Polish & Stretch Goals
- Goal: Finalize documentation and explore dynamic caching.
- Tasks: Write final release notes and user-facing documentation.
Stretch Goal: Implement runtime memory of failed remotes within a
single process to skip them on subsequent lazy fetches to reduce
latency. Submit final Outreachy report.

Availability
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I can commit 40 hours a week to the project during the internship. I
am based in India (IST, UTC+5:30) and can adjust my hours for
synchronous calls, pair programming, and mailing list reviews to
overlap with my mentors' timezones.

Blogging
=3D=3D=3D=3D=3D=3D=3D=3D
I will document my technical journey , posting weekly updates on the
C-level challenges I face, how I navigate network tracing, and the
feedback I receive from the Git community. I will share each post on
the mailing list.

After the Internship
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
After the internship, I intend to remain an active contributor to the
Git core project. Having touched the libification, option parsing, and
network protocol subsystems during my application, I want to continue
bridging these areas=E2=80=94specifically helping remove the remaining
USE_THE_REPOSITORY_VARIABLE macros from network-facing C files like
promisor-remote.c.

Appreciation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I want to express my gratitude to Christian Couder, Usman Akinyemi,
Siddharth Asthana, Kaartic Sivaraam, Patrick Steinhardt, and Junio C
Hamano. Your patience in reviewing my early patches and helping me
understand the git send-email workflow has been incredible. Thank you
for making this community so welcoming.

Thank you

Shashank S Mogaveera
