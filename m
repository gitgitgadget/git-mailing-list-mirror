Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793971129;
	b=HRMZmWuI4KbYKbpq3Vrn2UGD2vlw/4KNAQ025oqgI3WmV0Y2ajC3ErEhtj07rGsWfyJy
	 4XFyFLdGBGzVtWVLxe6LCYkm85ieZqQvOPIW+RWUBdylzLr7K3GI3NK47TPk3EtZF5zca
	 zj05ShFqO+6wPkVCyMoFCBIvlkU7YhBmPEDS7wxSHQ6U8wLj9ibGkoFD95lb3yCL9R82m
	 QPVbZXYppruFyNEhFd1pR2YACE7F6Yx8wxZV5SVGbvnrZ5Ym6MM0oVskjh79ROafZ9tnW
	 uUtVBWMMPtya35Elg6dh1Aqlol3AuMlW69nBGNYKDbDgsTD5hJsrYp5659KEmpePGng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Otvq3RvGdemZ/ma9w30OS33cMGfp81VRxEx9xbwQx0=;
	b=2qztI9/kGUuzgJKjBNhf3Iy7ajq6ctBmMviRAIaj3a7DECb+QIxrNC7Zi2oW48kObX63
	 drin+dgrGwrOuVzqYTrSvTZNERPt9cCy0oxghznRUGYwcUi31er4VTQNZaWU9SxT489s6
	 8l48KvU3G3L5Y1Ji7e3DEmVn4GHR/pA6eJGN15i7wGWRfbc2cDBDKgPLfJ3DrqYr45ZMQ
	 ZwKStPAHwr3+R8rwp1zy7iscv04x1XOP9VwV8uhF+XFsf/9BeZWw+7nnn+TJVanTKZtfM
	 GePRYQJpZ0b+UoN0UT+knFsDJ+3qETLiyA4PPJjI8QH8r74L1ZwWaqGNJUEaOexSDEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abYJdd4O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3B606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E3B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abYJdd4O
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99be54f9c14so138965241.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 05:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793971128; cv=none;
        d=google.com; s=arc-20260327;
        b=Wkicj37NQuEuR6FuqvvKpMFoY76k5yfnL40qGLU/+AkqBwU3QWDgDC+KJgWEQ0LYcN
         KxHvxKdmDPPN9ECxcURANpmOzX6wbAYC78RSevwNJz7DwyJDR5nCrME18qM6pHUQXOLC
         Dr39xbsTNPJI59d2+zKjlD8Cpd311/USmXf8oYQHi1058FqUqBrj0RiD9fpAGs1n3jbw
         myyzeNEDpX3eEbeIUAAFExtQmettcklZ/PwTcqnbYfjIPdD+5dE+VyFRk4zTgbKGy0Og
         gOxde335yNf9O90U4X3dHAcslYVLcjqExTOMnspqtvE933thqk8a50QdN1uBvC913Gg/
         GCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9Otvq3RvGdemZ/ma9w30OS33cMGfp81VRxEx9xbwQx0=;
        fh=phcT2XEsaKCXyWCNlg2za30Oz+DL/38XIHuAKdWt9Vo=;
        b=MzdURVNE2Ji+PCr4yLVC8nDU9TT43he0BzpfY+PqhSgFdemu/9mg1I+NHe5Kd/lZY8
         U0kLrA8J5DwKayWlFweEX9qtu6UFIRatnBx9s3E+zSyO0d1GqyI5qzMUWNpoyD0ucrCt
         COyGcISQ5BtzQqywY99bJm27rocyWt/kYla5ATHrha4+y6yjaDaGov1mTmQzc8nVc33Z
         Mr6GkvLn9KMLeRNZ/XJNg+eoZ5u+gcq+OA9Ov4zHu4ZJcwxYmUF6hIbgBk7dkza818Ml
         jyQKY/QdMUz76cs3Y94DLGlPNBbaGSSQ9wF6dyEdd1hRM4BmwgnNB/eTt8b6Vp2VYzTd
         GiWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971128; x=1794575928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Otvq3RvGdemZ/ma9w30OS33cMGfp81VRxEx9xbwQx0=;
        b=abYJdd4O5SUVySD1FjsZvrSeKroZe9b2A2S6KOxZQtjkTaks5raSpOOA2zBqvrx7rr
         PJxAo4xXMRIEkrbd3Hh3Nh4ByU3KpIRP8nLfOe0Y69jZHQFK5WsCFZrXJzFDI7BvNyGS
         M2Y3iwD8NO4lKBNCznVyC3XC093TAB0FtKbL0VIB1aWrm1+ptDt/s3z0gYFukRkrAUq8
         EXyXLSo7VMwwwuhwhc+NKa4BMY0+jqlfnVKqJNXYyrgKNtk+f9QpGUmA1HAsQTp2o8YQ
         3Dj1ftw1LjQc77Yydvv0GLoRVRsiEnbjfsad/DH7M3YFeE/+AI8U3oO2rnm9Y20CwikR
         hmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971128; x=1794575928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Otvq3RvGdemZ/ma9w30OS33cMGfp81VRxEx9xbwQx0=;
        b=NDXgndTrgaX1rjt6exArazbCf/sST1sLePfPyx8ofi8TV5acJTQBGGxMBQqfKSNOxc
         pQt0TzHea78gNvlKnoOCu1XYp8Ma57Ed9t3/z33OrV8CoYvIpt8BY+uo9UODyRpcC/jg
         gdo9PCQFFlDi9zrHNIuJxCXMsVoTIQRTx/veeWu0MxUUiD8Eodi0OrHxFx5XUxnVfeDz
         nQeGb9C2swPFihh6VJBuuq+bwbhm8pqJzb1rdhqHt6ULNFdU2AK6wRDdMBDkUtEDD+GX
         P+yakWkq03u1N0iILC7MK0YStsm3o0y2yz8WJBvIeIVPSXncuIZ2QuWQlh7nzMkwWbmj
         U0BQ==
X-Gm-Message-State: APuU4Z+npGrMg7wWMcYDyG4p3IINyg1eWagFQHsr+z1P24z7XplQB8sr
	eYFPrVfUpKV8lNzKlwWb3Zl43qGP3Mx6bfYowctiZkPDNGKWjaTaVgs2GSR9ZSRptbZ2VLDzufX
	QeMmCdXgc2rCYiv+J2UVWHSk2pZkV/6+O3deUYTs=
X-Gm-Gg: AYBFou1yfy/FIa2W3FvuM9KBU9mWwVOUHWr4vlQv6D//rTAUG4UufUM5MhlL2ZxY+n1
	MZNFWDZo9QdJ7bBvlU8k3jXrl6h+4LZsxDzia45TE9xEhqIj6hQcGBbaJLiI6BxE4ViWJrxGVLs
	kVQCvZyk2tzoJOE+6TMFvsJhQWYTwnItOaKZxDcsuTt8cBKhsmOd0J9l8wu0CBXJVkzLKqIOJtx
	rXLwBNhKEcpQc6mYNiHErl8wd5F7Q1NIQjKaoxShUgBtKGClBjqWCORdphaDKK7zqlcqoQtPBiT
	dTd4qLItUB32Ade32n8Ydc6sAh+7vjKAENSoQbxwcJwTlqdEB/fRqkyXvvTWOjA5yfEFXTYWwQR
	BvvImfi6IxFpkYs547qyzLm0+Fc23OvROFJagq56INhPB+jLDWAl+BWhSZwE0rnytFoLdlQsa94
	izDnxAjJeot+nIYVmx18EARPjBQ0gt+BtHq1h1boHs+1kAEQiEptM/Mec=
X-Received: by 2002:a05:6102:504b:b0:7b2:becd:1179 with SMTP id
 ada2fe7eead31-7d286c07f7amr2510969137.44.1793971127806; Fri, 06 Nov 2026
 05:18:47 -0800 (PST)
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
Date: Fri, 6 Nov 2026 18:48:36 +0530
X-Gm-Features: AclHuK-NdUt7mzMOd3__ApmG_csKHhs_X7n5LKJ_WHJoiEveh-y12DaK3QVeL6A
Message-ID: <CANHmUQQvN0xQuXqTE2imochXyQuU_ag3KHb0gkGEZ-cPLFbBYg@mail.gmail.com>
Subject: [Outreachy] Project Proposal [v3]: Implement promisor remote fetch ordering
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello mentors and Git community,

This is my revised proposal for the =E2=80=9CImplement promisor remote fetc=
h
ordering=E2=80=9D project for the December 2026 Outreachy internship.

Changes since v2:

- Corrected my description of the current behavior: it is deterministic,
but it has no separately user-configurable ordering mechanism.

- Reduced the focused Phase 1 implementation work to three days, with
review continuing asynchronously while the RFC discussion begins.

- Removed my pre-selected commitment to promisor.fetchOrder; the
configuration shape will be decided through an early mailing-list RFC.

- Corrected my description of promisor.sendFields: it already exists.
The project may extend the existing optional-field mechanism with an
ordering-related field, subject to RFC consensus.

-Added technical risks, design criteria, and explicit coordination with
active upstream work.

- Updated contribution status and restored mailing-list links.

Personal Information:
-----------------------------

Full Name: Shashank S Mogaveera
Email: shashu8660@gmail.com
GitHub: https://github.com/shashu8660
Location: Kundapur, Karnataka, India (IST, UTC+5:30)

About Me
-------------

I am a software developer interested in C programming, distributed
systems and network-facing infrastructure.

During the Outreachy contribution period, I contributed to Git=E2=80=99s te=
st,
option-parsing, and repository-libification work. Studying partial
clones,the promisor-remote protocol, and Trace2 traces of lazy
fetching showed me how a missing object travels from object lookup to
a git fetch subprocess. That made promisor remote fetch ordering the
project I most want to pursue.

Past Experience with Git
---------------------------------

I have been using Git extensively for version control in my personal
projects. This contribution period was my first time engaging directly
with a mailing list-based open-source community.

Learning to use git send-email and GitGitGadget to format patches,
manage versioned rerolls, and incorporate maintainer feedback has been
a massive learning curve, but a highly rewarding one. I learned the
importance of atomic commits, clean commit messages, and the strict
rules around not ignoring Git's exit codes in shell scripts.

Contributions to the Git Community
-----------------------------------------------

1. t0081: modernize the code testing whether a file exists
    Mailing-list thread:
 https://lore.kernel.org/git/pull.2254.git.1791962806807.gitgitgadget@gmail=
.com/
    Status: Merged to master.
     Commit:
https://github.com/gitgitgadget/git/commit/e1bb515788e48d500c9d4e36f13c66c4=
daddd3d4

2. t2403: modernize test for directory existence
     Mailing-list thread:
https://lore.kernel.org/git/pull.2259.git.1792125111461.gitgitgadget@gmail.=
com/
      Status: Merged into the seen integration branch.
      Commit:
https://github.com/git/git/commit/c645a5db002ded161115dc8f6c15a40acfdde2b2

3. prune-packed: remove USE_THE_REPOSITORY_VARIABLE
     Mailing list thread:
https://lore.kernel.org/git/pull.2266.git.1792341073005.gitgitgadget@gmail.=
com/
     Status: =E2=80=9CWill merge to master=E2=80=9D according to =E2=80=9CW=
hat=E2=80=99s cooking=E2=80=9D.
    Commit :
 https://github.com/git/git/commit/936609cfa0a57e1b047c345a91fec79ab255897c

4. test-chmtime: use parse_options() to parse command-line flags
     Mailing list thread:
https://lore.kernel.org/git/pull.2280.git.1793099688076.gitgitgadget@gmail.=
com/
     Status: Merged into the seen integration branch.
     Commit :
https://github.com/git/git/commit/c6a318cc4b8c6f6ce1a403e497816cd195c57cf7

Project Overview: Promisor Remote Fetch Ordering
----------------------------------------------------------------------

Git can lazily fetch missing objects from multiple promisor remotes in
a partial clone. Today, Git uses a deterministic baseline order:
accepted server-advertised remotes are tried first, other configured
promisor remotes follow configuration order, and the
`extensions.partialClone` remote is tried last. However, users cannot
explicitly configure that order, and servers cannot provide a separate
ordering preference for clients to combine with local policy.

This project will design and implement a configurable ordering
mechanism for promisor remotes. The client-side configuration shape
and any protocol-v2 advertisement format will be decided through
mailing-list RFC discussion, with attention to backward compatibility,
local-versus-server precedence, and safe handling of invalid data.

Phase 0 Progress:
-------------------------

I completed the relevant onboarding work before the internship.

Build and test verification:

I built Git from source on macOS. The resulting binary reports:
[git version 2.56.GIT]

I ran the two relevant test scripts:

- t5710-promisor-remote-capability.sh reported all 33 tests passed.
- t0410-partial-clone.sh reported all 39 tests passed. Its loca
Apache-based web-server setup was skipped because Apache could not
access its configuration path on my macOS setup.


Multi-promisor-remote playground:

I created local origin, cache-a, and cache-b repositories, configured
them as promisor remotes, and created a blob:none partial clone with
no-checkout. This ensured that the commit and tree were present
locally while the content of bar remained absent.

I then accessed HEAD:bar with GIT_TRACE2_EVENT enabled.

With extensions.partialClone=3Dorigin, the Trace2 child_start event showed:

-   git fetch cache-a ...

This demonstrated that Git tried cache-a before origin.

In a second fresh clone, I configured cache-a with an unavailable URL.

Trace2 showed:

- git fetch cache-a ...
- git fetch cache-b ..

Git then fetched the missing blob successfully from cache-b; it did not
need to contact origin.

The Trace2 event promisor.fetch_count records the number of object IDs
passed to each promisor-fetch subprocess. It does not identify the
selected remote. I therefore used child_start events to establish
remote order.

Current behavior and code understanding:

I studied -
1. [https://git-scm.com/docs/partial-clone]
2. [https://git-scm.com/docs/gitprotocol-v2]
3. t/t5710-promisor-remote-capability.sh
4. t/t0410-partial-clone.sh
5. promisor-remote.c.

The current behavior is deterministic but has no separately
configurable priority mechanism:

1. lazy_fetch_objects() first calls try_promisor_remotes() for remotes
accepted through the promisor-remote protocol exchange.
2. It then calls the same helper for remaining configured promisor
remotes, whose order comes from configuration parsing order.
3. promisor_remote_init() moves the remote named by
extensions.partialClone to the tail of the list
4. If a fetch fails, Git continues with another eligible promisor
remote until all requested objects are present or no remotes remain.

My manual Trace2 experiment verifies configured-remote order and
fallback. I will not claim it independently proves
accepted-remotes-first behavior that rule is covered by the protocol
test and code path above.

Design Questions and Initial Reasoning:
-----------------------------------------------------

I do not consider the design settled before mailing-list discussion. My
initial analysis identifies the following questions.

Client configuration shape:

The RFC will compare:

- an ordered list, such as promisor.fetchOrder; and
- a per-remote numeric value, such as remote <name>.promisorPriority.

A list makes the intended sequence easy to read in one place, but must
define how values from system, global, and repository configuration
compose. A numeric value can change one remote without naming every
other remote, but requires tie-breaking and a clear convention for
unranked remotes.

The RFC will evaluate both approaches using the same criteria:

- configuration layering and overrides;
- duplicate entries or equal priorities;
- unlisted remotes;
- nonexistent or non-promisor remote names;
- interaction with accepted remotes; and
- interaction with extensions.partialClone.

I will not select an implementation representation until consensus on
these semantics is reached.

Server-advertised ordering

promisor.sendFields already exists. It controls optional fields sent
in a promisor-remote advertisement; currently supported fields include
partialCloneFilter and token.

The protocol RFC will compare two possible designs:

1. advertisement order itself expresses server preference or
2. the server advertises an explicit ordering-related field, such as a
numeric priority.

An explicit field may preserve the server=E2=80=99s intent even if a client=
 later
reorders remotes, but it adds parsing, validation, and documentation
work. Advertisement order is simpler on the wire, but may be less
explicit once a client combines local and server information.

If the RFC selects a new field, the implementation will extend the
existing promisor.sendFields machinery, the promisor-remote parser,
protocol documentation, and tests. Older clients must safely ignore
the unknown field.

Precedence and persistence:

My starting principle for discussion is that an explicit local client polic=
y
should not be silently overridden by a server, because clients may
have their own cost, reliability, or privacy constraints. One possible
policy is for server preference to order only remotes that have no
explicit local ranking.

This is a proposal for discussion, not a fixed decision. The RFC must settl=
e:

- whether local order applies across the accepted/unaccepted two-pass
split or only within each group;
- whether extensions.partialClone remains last even when explicitly ranked;
- whether server-provided ordering is stored through the existing
promisor.storeFields mechanism; and
- whether a stored ordering value remains valid after later local
configuration changes.

Implementation Risks:

The remote list is a singly linked list, and current lazy fetching
makes two passes over it: accepted remotes, then remaining configured
remotes. A refactor must preserve this behavior until a reviewed
semantic decision changes it.

Configuration parsing is also part of the feature design . A change
must not make effective order depend accidentally on an implementation
details of config file loading, or make invalid remote names fatal
during lazy fetching.

If the protocol RFC chooses a numeric field , parsing must reject
malformed and overflowing values safely . If it chooses advertisement
order , tests must still define exactly how the client combines that
order with local policy.

Finally, active patches may land before or during the internship. I
will inspect active threads and current branches before beginning each
patch, avoid duplicating work, and adapt the plan with mentor
guidance.

13-Week Internship Plan:

Week 1: Baseline visibility and safety net

The focused baseline implementation work should take approximately
three days, not two weeks. Review can continue in parallel after
patches are sent.

Days 1=E2=80=933:

- Audit current master, next, seen, and active mailing-list threads.
- Confirm which documentation and test coverage has already landed or
is in review; do not duplicate another contributor=E2=80=99s work.
- Where a baseline gap remains, prepare a small docs or test patch
that documents or asserts existing behavior only accepted remotes
first, configured remotes in configuration order,
extensions.partialClone last, and fallback after failure.
- Send the patch early and respond to review.

Days 4=E2=80=937:

- Begin the client-configuration RFC preparation.
- Refine examples and edge cases from the local playground.
- Continue responding to any Week 1 patch review.

Week 2: Client-ordering RFC

- Send an RFC to the mailing list comparing list and numeric-priority
designs.
- Ask for agreement on configuration layering, invalid entries,
unranked remotes, accepted-remotes interaction, and
extensions.partialClone.
- Revise the proposed semantics from reviewer feedback before
beginning a behavior-changing implementation.

Weeks 3=E2=80=934: Client-side implementation

After agreement on the RFC direction:

- Separate any behavior-preserving list-management refactor from the
configuration behavior change.
- Implement the agreed local configuration parser and ordering logic.
- Preserve existing behavior for users without the new configuration.
- Add tests for empty configuration, duplicate values, unknown names,
unranked remotes, accepted-remotes interaction, and the agreed
extensions.partialClone behavior.
- Update the appropriate configuration documentation:
Documentation/config/promisor.adoc
Documentation/config/remote.adoc
- Send the first coherent client-side patch series no later than the
end of Week 4, and preferably earlier if it is ready.

Week 5: Client-side review and protocol RFC preparation

- Respond to review and send rerolls of the client-side series.
- Write protocol specification wording before implementation.
- Prepare examples demonstrating both explicit-field and
advertisement-order designs.
- Identify exactly what must change in promisor.sendFields,
promisor.checkFields, and promisor.storeFields if a new field is
selected.

Week 6: Protocol RFC and discussion

- Send the protocol RFC to the mailing list.
- Discuss the field format or advertisement-order semantics,
client/server precedence, malformed data handling, backward
compatibility, and persistence.
- Incorporate review before writing server or client protocol code.

Weeks 7=E2=80=938: Server advertisement and client parsing

After protocol agreement:

- Extend the server-side optional-field support to advertise the agreed
ordering information.
- Extend the client parser to recognize and validate that information.
- Keep old-client behavior safe through the existing unknown-field rule.
- Implement the agreed precedence rule between local configuration and
server information.
- Implement persistence through promisor.storeFields only if that
behavior is approved in the RFC.

Week 9: Protocol tests and first server-side series

- Add protocol-v2 tests covering valid advertisements, absent fields,
malformed values, ignored unknown fields, client-versus-server
precedence, and old-client compatibility.
- Extend the relevant tests in t5710-promisor-remote-capability.sh.
- Send the first coherent protocol/server-side patch series for review.

Weeks 10=E2=80=9311: Review and rerolls

- Respond promptly to review on both series.
- Keep rerolls small and explain changes with range-diffs where useful.
- Run focused tests after each revision and wider test coverage before
resubmission.
- Run leak-sanitizer testing where supported by the development environment=
.
- Keep documentation and tests synchronized with reviewer-approved semantic=
s.

Week 12: Stabilization and integration readiness

- Recheck all configuration, protocol, and partial-clone documentation.
- Run the relevant test scripts and broader regression tests.
- Reproduce the key Trace2 scenarios manually to confirm the tested behavio=
r.
- Address remaining review comments and prepare patches for maintainer
integration. The decision to advance a topic through seen, next, or
master remains with maintainers.

Week 13: Final polish and wrap-up

- Finalize release-note and user-facing documentation updates, if appropria=
te.
- Publish the final internship report and a concise technical summary.
- Use any remaining time only for follow-up fixes or review; dynamic
latency-based reordering and in-process failure memory remain stretch
work, not commitments.

Availability

I can commit 40 hours per week exclusively to this project throughout
the internship period. I have no university exams, classes, other
jobs, or planned vacations that conflict with 7 December 2026 through
8 March 2027.

I am based in IST (UTC+5:30) and can adjust my hours for synchronous
discussion, pair programming, and timely mailing-list replies.

Communication and Long-Term Contribution

I will publish concise weekly updates covering experiments, RFC
decisions, patches, review feedback, and next steps. I will remain
active on the mailing list and will communicate early if a schedule or
technical risk affects the plan.

After the internship, I intend to continue contributing to Git,
especially in promisor-remote and repository-libification work,
including reducing remaining unnecessary reliance on global repository
state.

Thank you

Shashank S Mogaveera
