Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4F3FBA7
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513114; cv=pass; b=Zn+EkLxAli9pMruYbBL/cXRiadsZiqkdN5RaRhQTQXllZTcSCo+sbxHAdSLRwanTZDChRI8KJRSA92XmqSVwU8+mnVkIE6H2QUTJvmvayKBjq95jDkRMWZeemP+P236+xkZ3HiSwOIPGDNtwrqoUdqE3SPCyzlZiT5IPPHut+1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513114; c=relaxed/simple;
	bh=GYL8z7JNukk+bfwkEYFc/3opbSBWSd4VWD2hTaYAPzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osiMqEh4JFeGIDmS9csrJhsFDZqvrEs5sRF4jGT2/EwKkRy5Oe5p4UuzYDFObwD6lvAc77XdW2iR6VxmM9D9PvPQsKzXob/X0KX7UOlJGt3S4HeKm7/Zr6V8eVAvq5Ks98URpCccx7/DUYXIk607n6Ye4JJ0xOiNrG05HKAGnGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bClfK64X; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bClfK64X"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so2690333d50.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 11:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773513111; cv=none;
        d=google.com; s=arc-20240605;
        b=EA5TX+F9g3MTj72d6asVVh0IlNXCnlh9TvgVoCEroHrPNES8pw2sdJAXFkRscE/aEx
         iLBEfRSQIC0gP8rj2qqzdDm+inMA7bvdUfJcWRcS1XJZNCto/sohg/MtpbMRhMUPsdqg
         S6GxmcWeG6YfYRK1YBmU0fq/gpXIhhT2wvbCqd61nrB9+UeZV7lMJ2r8JVz63VsGQEq1
         +FdwAXNxDnhveEgp5yV5p6d+earsf3AGBYBuCJE3vhKh9NsDNFYkAI56HbFkHfjXOINi
         zt74XNpnnZwehoXJr1WrI9cse0j498HYTSO+oUjx0OoaLjxwGwUeJr8IN56ROfEtbFx8
         M2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z1qTwtp/baDx0eJ94T57Y8LGwOr+91G5AV80YJpojuQ=;
        fh=d2oVrdsfCEr3LkwcUK/AUw8S/5wU5SmdeN2o7KY4A2Y=;
        b=jzNbofhIp1rudiDN8NfY1WV54h9KFrGcTRAv2wWKsJMUl8y+g/GDOA7RHCf4P+6ezr
         VnTLGvSqCGcdczn6Hotf1oLcZLNwquuPRHXyFvHvf0YAhY6KxqtRKf+6a87/tsMTOqTe
         40k7FwrVh+Z1CilfccpVaJ7gZO1ONZ+Srmv+Uqi+S5lvGzpZDZJ8a+m052F/ufR3gaRr
         tBSsI7icDMy0BBb+/fRQLCZyjtIzQe1kNOB0xOHAinPCSPUX3eXrEdldXaiCI3rHcCKB
         vI1zf5xDOf4A2Sr+JhxvNiDU8umBzmZLngtm2vtsddiP5mvV9b6+wVUfLGJ2pgYj6anR
         5lzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773513111; x=1774117911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1qTwtp/baDx0eJ94T57Y8LGwOr+91G5AV80YJpojuQ=;
        b=bClfK64X7tVWz8HR2rr8FKXQbA4OgpzxvDaoPto1I1waypyLvEzuhFF0CQtB5FLKEO
         txbM9Q50LXu/TUH+j35MMywRSDKK/xlwsVuysjhgEBlyPB62wrxu2p7AxjRGjAstTNmi
         gN/Qq3ZbNIO9cparfw/YijHbsD8ZpIS0sEOiGtErvPwmR66+DvPrKTfFL3Zi3xsKsqCe
         5y2Z2/ZST+L4tMUbz9qBEGJu7FetNaBBLTs6Md7W0w+nFYVrUvPdxnP1GNw3JPzRZ57M
         fjYGjuwzdASJS6seLYslfyPAnQS1g23VOeNKOWFRV7MAMCl0O69ZEhDRh4AJyAlQeGe3
         QgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773513111; x=1774117911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1qTwtp/baDx0eJ94T57Y8LGwOr+91G5AV80YJpojuQ=;
        b=moR/qJml94KUpBg+PAxsK9Iz/Ka5mF5svahtll2NUd+ox+YzDFEI5szsUgJ1q9sP6t
         XEeUQRbZHoFe6fARV/qF6vDGvQ1aVS5faGcMU1F8mEV0H14RATVubXKJSKLpudYrqoUB
         cIar2cv0L/vqpYvgGZKzpjbvOHlRm2eoMobNrX89Kt9jJ07vIupgRS3wvDu3mlhRBfAu
         pcDcwdjEkEOcuqyk+smpsTs0ZI4fdJSjtnO5HUgyA3S+QGh5oiqVeEBJncCO8GlQmMh0
         CFge5ZyfmT6lHRoLy1t39t73TijdLjrs9qMc0Xv63H2/7aGYrJL9VgoekDuCPl9xXv7Q
         uJJg==
X-Gm-Message-State: AOJu0Yw3/o+/EcVPTqxcygiK2jPVjXeFJMpQvaSw0tSuatwPgO+Csi9c
	CYvqu4Xu4I0bFE/qWcASMfanc+dUMfgTPdMkvuWX5og22uLKQjf+2+mSPnUmAIQjxoPPW1T+Wps
	L12Rmpq+VOYczk/CAc0nw3okxMVO401c=
X-Gm-Gg: ATEYQzwGKpiZD4g0r2I7oYQ3UQyqJth9t35AUz67sG1X9SNFL800X9nGD854SyPhCO+
	farzKHmxI1DgRWpFDJUhAOXUR1hYbAN0ME2uEZLIjVct1n133M9cT2iRT7Vy8Pl+VmCjlH0U4za
	p2l2y07Vnsxr4pStqvGnAqUixCyCngLHLu0rpHWMJR3IoBPr5HvXYbF2/ecWPRSJGGDaYZUO6xS
	CjewRDfx8kxjiNVBaZ61TKhv2jNunIyRxMl1eKtr3OZ3dfVkf+v9BcINaASf5NofI5truyUMZMF
	6BubYECtp9HKD7GDOKo4GT4QjBPYABBoMZ1Le9OgwxM2DdpMP791IzYCXum4gLTG2vN1TJoJs2I
	vszrbt/vwvhmEPjgQxond5+QWesHE9BGcVA==
X-Received: by 2002:a05:690c:c4e9:b0:799:1a03:84ff with SMTP id
 00721157ae682-79a1c0e3bb9mr79608727b3.21.1773513111275; Sat, 14 Mar 2026
 11:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
 <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com>
In-Reply-To: <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sat, 14 Mar 2026 19:31:37 +0100
X-Gm-Features: AaiRm50C2xg2uye_Laq2fJfi56jeJCG2gEpqQOARCmTjtxQhi5wbsoGsdQKaKSo
Message-ID: <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
Subject: Re: [GSoC] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandra, thanks a lot for the feedback! :)

> You should upload your proposal on the GSoC website and add the link to i=
t here.
> The proposal can be then updated later as many times as you like.

GSoC proposals opens March 16th, for now I'll send my v2 here and as
soon as I can I'll swap to GSoC website and send the link to the
thread.

To avoid having you reread everything again this is what I've done from v1:

  Moved context explanation from The Problem to Synopsis and
Availability below About Me and Contact.
  Split Pre-GSoC patches into status (for code patches) and
description to improve readability.
  Added a code review and proposal thread to the Pre-GSoC section.
  Added new lines where noted and fixed capitalization.
  Correctly credited Jeff King for the allow_list idea and added new
[8] for Calvin Wan's work.
  Community bonding now includes continuing patches and setting up a blog.
  Removed most of the duplicated iteration on the Timeline from The
Problem. (feels a bit empty now tho).

I paste here my v2 with the requested changes:

## Synopsis

Git's partial clone allows cloning repositories without downloading
all objects (blobs, trees, ...). These objects are fetched on demand
from the remote when needed. However, when a user needs metadata about
these remote objects (size, type, hash, ...), Git has no efficient way
of doing this without downloading all the object content.

The server side support for `object-info` protocol was implemented by
Calvin Wan in 2021 [8]. Eric Ju built the client-side
`remote-object-info` for `cat-file --batch-command`.

This project finishes Eric Ju's work on `remote-object-info` for `git
cat-file --batch-command` [1], resolves the pending feedback from
Junio Hamano [2] and Jeff King [3] [4] [5], and extends support for
`%(objecttype)`.

Expected project size: 350 hours (Medium)

## About Me and Contact

Name: Pablo Sabater Jim=C3=A9nez (he/him)

Age: 19

Education: Currently on my second Computer Science year at University
of Murcia, Spain

Location: Murcia, Spain (CET, UTC+1)

Languages: C (solid), shell(bash) (good)

Tools: git(proficient)

I've checked that I'm eligible for GSoC 2026.

Email: pabloosabaterr@gmail.com
GitHub: https://github.com/pabloosabaterr

## Availability

My classes end the first week of May. From then until September I
won't have any classes which leaves me free to fully focus on the
project. I can dedicate 8+ hours each day, and for sure 40 hours a
week.

## Relevant Projects

- 16 bit CPU emulator. Good example of C programming.

  cpu: https://github.com/pabloosabaterr/CPU16

- Compiler. Good example of working on bigger projects.

  compiler: https://github.com/pabloosabaterr/Orn

## Pre-GSoC Work

### Introduction

**[GSoC] Introduction Pablo Sabater**

https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi=
8YGA@mail.gmail.com

**Description**: A mailing list thread where I introduced myself to
the git community.

### Microproject

**[GSoC PATCH v4] t9200: replace test -f/-d with modern path helpers**

https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@gmail.com=
/

**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`.

**Description**: Replaces `test -f` with helper `test_path_is_file`,
which makes debugging failing tests easier with better reporting.
As suggested as microproject.

### Other contributions

**[GSoC PATCH v2] test-lib: print escape sequence names**

https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.com=
/

**Status**: Will merge to `next`.

**Description**: In failed expected/actual checks printing, the escape
sequences were shown as their octal code. This patch fixes that to
print the actual escape sequence name, adds tests, and updates the
expected output.

**[GSoC PATCH] t9200: handle missing CVS with skip_all**

https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.co=
m/

**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`.

**Description**: wraps CVS setup in a skip_all for clearer failure
reporting and moves Git initialization into its own
test_expect_success.

**Re: [PATCH] gc: add git maintenance list command**

https://lore.kernel.org/git/20260313115932.15259-1-pabloosabaterr@gmail.com=
/

**Description**: code review for a patch sent.

**[GSoC] Proposal: Complete and extend remote-object-info for git cat-file*=
*

https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=3D66rjeY=3DN=
qKbqRkhA@mail.gmail.com/

**Description**: Proposal draft thread.

**[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-comm=
and**

https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gmail.com=
/

**Description**: While testing Eric's v11 I've found and reported a
new bug. On `remote-object-info` when it's preceded by a local query,
`data->type` isn't being cleared. Causing it to return the wrong type.

I have also studied the documentation provided and Eric Ju's work from
v0 to v11 including all the feedback he got up to March 2025, the
feedback he got from Junio Hamano and Jeff King, taking notes about
what's left to be done and what else I can contribute to the already
proposed project. That's how I've identified everything that I will
address on the Problem, Solution and Timeline sections.

I built Eric Ju's v11 and tested the bugs reported to his patch [5],
I've confirmed the segfault and the `die()`, and found a new one:
- When a local `info` runs before `remote-object-info` sharing the
same format string, `data->type` isn't being cleared. A blob queried
remotely after a local commit, `data->type` for blob becomes 'commit'
with no error. I reported it on the mailing list [6].

I attempted to test rebasing Eric Ju's v11 to master and got conflicts
on 4 out of the 8 commits:
- `d04cf85ece` t1006: split test utility functions into new "lib-cat-file.s=
h".
        - `t/t1006-cat-file.sh`
- `d918f720d8` fetch-pack: refactor packet writing.
        - `fetch-pack.c`
- `2daf9ed803` transport: add client support for object-info.
        - `Makefile`
- `c3ba4afaf6` cat-file: add remote-object-info to batch-command.
        - `object-file.c`, `object-store-ll.h` (deleted).

I'm being active on the mailing list and learning the Git flow of work
and from the feedback I've received from the maintainers (Junio) from
my patches.

Following the project guidelines, I haven't done anything on the
project that could step on other candidates' work before being
accepted, and instead I'm focusing on understanding the project and
its needs, and independent patches that will make the Git project more
familiar and understandable to me.

## The Problem

Eric Ju's work remains unmerged after v11 because of these issues:

 - The format validation uses `strstr()` which only checks for
`%(objectsize)`. This causes two different errors:
   - Atoms that `expand_atom()` recognizes but the remote doesn't
(`objecttype`,`deltabase`, ...), `expand_atom()` returns 1, but when
accessing `data->type` it only contains garbage, causing segfault, as
Jeff King noted [3].
   - Unknown atoms by `expand_atom()`, returns 0, calling
`strbuf_expand_bad_format` on `expand_format()`, which calls `die()`,
as Jeff King found [3].
   Both cases block the command, including local `info` queries if the
same format string is shared. Unsupported remote placeholders should
return an empty string, matching how `for-each-ref` returns empty for
known, but inapplicable atoms like `%(tagger)` on non-tags [4] [5].

 - When local and remote queries are mixed, `data->type` is not being
cleared between commands. `remote-object-info` returns the wrong type
data from a previous local query [6].

 - Style and code issues marked by Junio Hamano [2] and Jeff King [3]
[5] are still undone.
   - comment style.
   - `#define` formatting.
   - line length.
   - misleading error messages.
   - missing `count > MAX_ALLOWED_OBJ_LIMIT` check at `split_cmdline().`
   - if/else invert at `get_remote_info()`.
 - `%(objecttype)` is not yet supported on either client or server side.

## The Solution

There are two main goals:

### Goal 1: Rebase and finish Eric's work

Starting from where Eric Ju left off, I will rebase it on top of the
current `master` branch and address the feedback left to do:
- Fix style in comments, `#define` formatting and line length.
- Fix misleading error message in the overflow check.
- Add missing `count > MAX_ALLOWED_OBJ_LIMIT` check after `split_cmdline()`=
.
- Invert if/else on `get_remote_info()` to keep the small block first
(the error one) as Junio suggested.

#### Replace `strstr()` format validation with allow_list in `expand_atom()=
`

`strstr()` isn't enough to fully validate the placeholders, it only
searches for `%(objectsize)` and unsupported placeholders cause
segfaults. Jeff King noted [4] that the fix was to refactor the
validation with an allow_list in `expand_atom()` or `expand_format()`.
The best option is to place the validation at `expand_atom()`, but why
`expand_atom()` ?
- There are two cases, first, inside `expand_atom()` before returning
(segfault) and second, calls `die()` when `expand_atom()` returns 0.
  Placing the `allow_list` at the top of `expand_atom()` prevents both
errors, on remote mode, append nothing to `sb` and return 1, accessing
`data->type` won't cause segfault and prevents `expand_format()` from
reaching `die()`.
  As extra safety, initializing `data->type` to `OBJ_BAD` and check
for `NULL` from `type_name()` makes it that even without `allow_list`,
uninitialized data doesn't cause a segfault.
  At Goal 1, only `%(objectname)` and `%(objectsize)` will be in the
allow_list. Goal 2 will bring `%(objecttype)` support.

### Goal 2: Adding `%(objecttype)`

Following what Calvin Wan did in 2021 [8] for `%(objectsize)`, v2
protocol needs to be extended on the server side to support the new
`%(objecttype)` placeholder:
- extend `object_info_advertise()` at `serve.c`
- add .type to `requested_info` struct at `serve.c`
- support `type` in `cap_object_info()` at `protocol-caps.c`
- look for type at `send_info()` at `protocol-caps.c`

Following object-info protocol docs [7] it should look like:
```
  attrs =3D "size" SP "type"
  obj-type =3D "blob" | "tree" | "commit" | "tag"
  obj-info =3D obj-id SP obj-size SP obj-type
  info =3D PKT-LINE(attrs LF)
        *PKT-LINE(obj-info LF)
```

`%(objecttype)` needs to be added to the `allow_list`. Client side
needs to learn to ask for `%(objecttype)` from remote, parse what has
been received and fill `expand_data` with the actual type. This makes
it return the object type instead of the empty string returned while
it was unsupported.

Default format evolves to `%(objectname) %(objecttype) %(objectsize)`.
Test and document new placeholder support and server side extension.

#### Backward Compatibility

There are four possible scenarios to happen between client and server:

1. **The server doesn't know type (new client but old server)**:

   After receiving the server capabilities, a client will only request
what the server advertises. The `allow_list` would handle this,
returning an empty string when the server doesn't support it.

2. **The server knows type but the client doesn't (new server but old clien=
t)**:

   Following `gitprotocol-v2.adoc`, "Clients must ignore all unknown
keys", it will ignore type, and request only the known capabilities.

3. **Both know type (new client and new server)**:

   Server advertises type, client requests it and gets the type data.

4. **Both know type but protocol middleware doesn't (new client, new
server but old middleware)**:

   If a server advertises type but client doesn't receive type, a
client won't ask for anything unadvertised, if a client asks for type
but the server doesn't receive it, it will only return the known
capabilities.

**performance considerations**

To get an object type, we have to look only at the header, to get the
size `oid_object_info()` at `object-file.c` is being called which
already returns the object type in the same call. Sending the string
with the type will only be, worst case scenario 6 bytes for the
"commit" string.

## Timeline

I've designed this to work with enough time so final work can be
shorter than what's said here

May 1-24: Community Bonding
- Keep working on my ongoing patches and new ones.
- Talk and meet with mentor that I'm assigned with, to get feedback
about my proposal, how I will report my progress apart from the code
submitted and possible blogs, and tips and tricks to work better at
Git.
- Confirm with mentor that the `allow_list` approach is still the best opti=
on.
- Draft commits structure.
- Setup a blog to keep track about how GSoC at Git is going.

Week 1-2: (May 26 - June 8)
- Start Goal 1 fixes.
- Fix style and code issues.

Week 3-4: (June 9 - June 22)
- Start with Goal 1 implementations (allow_list approach).

Week 5-6: (June 23 - July 6):
- Goal 1 should be polished or close to the final form.
- Send patch series for Goal 1.
- Start Goal 2.
- Prepare the midterm report.

**Midterm evaluation** (July 7 - 11) as specified on GSoC timeline docs
- Goal 1 submitted.

Week 7-8: (July 14 - July 27)
- Start with server side v2 protocol extension (`%(objecttype)`).

Week 9-10: (July 28 - August 10)
- Add `%(objecttype)` to the `allow_list` from Goal 1.
- Client side extension.
- End to end tests and documentation.
- Default format becomes `%(objectname) %(objecttype) %(objectsize)`.
- Send patch series.

Week 11-12: (August 11 - August 24)
- Goal 2 should be close to be done.
- Polish everything, all tests pass, good test coverage, no
style/comment issues.
- Final documentation review.
- Prepare for final evaluation.

**Final evaluation** (August 18-24) as specified on GSoC timeline docs

### Additional objectives

If there is enough time, or for future work after the project. I've
some ideas on how this could evolve:

#### More placeholders support

I've checked that Eric's v11 patch only supports `%(objectsize)` on
server side, but on the client side there are other placeholders that
can be added too. With the `allow_list` and having Goal 2 implemented,
adding more placeholders becomes trivial.

- `%(objectsize:disk)`: Returns the size on the disk (compressed or as
a delta) instead of returning the uncompressed size that
`%(objectsize)` does. To do this, the server would need to send what's
the actual size on disk data.

- `%(deltabase)`: Returns the delta base object OID. non delta objects
return zero OID as it does on local.

#### Returning missing blobs from a tree ordered

In a partial clone, someone might want to know what blobs are missing
inside a concrete tree and their size before fetching them.
The idea is to build on top of `remote-object-info`:
Given a tree hash, return the missing blobs (inside that tree) ordered by s=
ize.

Thanks for reading my proposal and considering my application. I'm
very excited about this opportunity,
Pablo

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.=
com/
"Eric Ju's v11 patch"

[2]: https://lore.kernel.org/git/xmqqo6yr3wc4.fsf@gitster.g/ "Junio
Hamano feedback"

[3]: https://lore.kernel.org/git/20250224234720.GC729825@coredump.intra.pef=
f.net/
"Jeff King feedback"

[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff=
.net/
"options for strstr() by Jeff King"

[5]: https://lore.kernel.org/git/20250324033922.GB690093@coredump.intra.pef=
f.net/
"Jeff King follow-up"

[6]: https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gmai=
l.com/
"data->type not being cleared bug"

[7]: https://github.com/git/git/blob/master/Documentation/gitprotocol-v2.ad=
oc#object-info
"object-info protocol docs"

[8]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.=
com/#t
"Calvin Wan's patch series"

---

Again, thanks a lot for the feedback.
