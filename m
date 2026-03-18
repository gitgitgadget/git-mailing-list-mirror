Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4E329E46
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834172; cv=pass; b=j83hoSttotsz9dyPSm8r6tpJgi5JdVsUCOcJ2F9aoXEPv3eZH2R/J9PaX71etZKicDj54ZMh6tbOt64HSSKB/yoZgm6vnQx9IkUbC15YgNhA5xBu4ua3C7u+ArlBnBGIhPt0CNs26o5xkuhpq/lUBmESz70Y2EzPnf72e0zzW1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834172; c=relaxed/simple;
	bh=dlpUAfOTcUran5dHpvvzmPHJyBGEooQgNhOrbcO8Bgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrHXmxM3zSBo1oq8A3e5aafXKh8OzYk23eTRHM3/z9oXh7DJ31yjtl/EjNys9cf1nofhfUFCgaQTfQFT7NKVlyZfgADpyXKCidkLoFcTm/0JXhlY673aoS0upHvDj2UqivIXNy0nc3wDAhe6P2/BVjQVTEJHJivdNy6Xku0siYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL+uSX/n; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL+uSX/n"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a74765703so5441887b3.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 04:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773834169; cv=none;
        d=google.com; s=arc-20240605;
        b=J/gQW+7Ryt3Tk47vdP17bal8R2vSAwfJHNdW7NqLfYKp1LV3kiwn7MIOmZqNQRzplc
         cdqT/uzFccU2Rtr4f7KQz0LMvuEgH8qIpjRLhm55KBFhSryNbs3OVCTOuyT5JkyvNXhn
         ZY1Z24CgaXlADNsiIw9yT4SxAPeV2QXXSGShiuHlYbnRI4jVlG3xaKK10hKf6rqC5CDX
         5Jlnlu33PIuOGfi+npah/IlbQjU9LwJCvB4W4taRGaFP63SA15y5nWFckg/Ig9mU5y7N
         pAygSh3VzxEJd/fUZ0Nb1O/77Ji4ysuRTjDh/GNZ/vawhZg+nA8WzqKvujjjSW52djRU
         G7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7PAtL0itGam71/qq32Io/k8Ng1c3UoDG0OC1a7jdarg=;
        fh=fdFmI7OrsUgfqBftUI12Hwi8Z3kbiCj1R60KHKfP490=;
        b=GAIYrC7jSIiiWlyDF+57q0zp/f4UghLBdlRKe3J4h9R76XK74V3c+LDZdBsmhN08p7
         xRCxnwNueI3prC//KPCnbuMeSxr3jV+HccyHAVlTeQlLY4cw27LE7YeE74HqFwFOqy2m
         Wt2T/F4LEoet6MbIk39xPXl5vJysk07mTSUTkWoSXiYhCwsKHNCx306SnEWnjUhmAoJE
         zPTryEiFTkKvhiYb4NFv3nBS+WBey9Nwfi27p8w+iK/0+O0m44BX3Y/UhkTYlkEkapdw
         kdKyyCT0WlFsB6hSaljhZe1GyO/hfCV28yybIRQxxH5AhBblI0urxHsNiEwbGzPTtu7d
         lJ9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773834169; x=1774438969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PAtL0itGam71/qq32Io/k8Ng1c3UoDG0OC1a7jdarg=;
        b=XL+uSX/nQpJbIoxtQ1o2Z85p1k8JySAKQgAOOuzrN8F33BmdrFTE3yEyq2XySLSXL1
         rSBvOhEyec1qfImMdRldkAIPVhTM5UHFr0zBFkRQVmZ5V0EmUz3GFpOgkClCGrqPLYJT
         Mu3sWZPrVSzjJ+t0+TEo0cQFjG5k50cRNXYeVWK6vPo3uVcvoyuczFg7CDHZdjJIBNct
         Bm9n7JNecNo9WTipglsR7eKySB0EVqcjb3ODAy7B5Z5/8qL5qnNL2sWN8NaYxFeIprXO
         aIee5D/Vlq/1RYjVaeJtHhqRuF5hVMX+Fhy1K7vFsz9sH1OMuUIK2pUcwGhP6QpeDMHQ
         4x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773834169; x=1774438969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PAtL0itGam71/qq32Io/k8Ng1c3UoDG0OC1a7jdarg=;
        b=Z9tGDxc2p+EccxjnvMdr9brVwuHeiZrEtrXSRSjxTDono0WGLby51+HOhc0Jn7Z7wv
         hg+SwHyReRzZWbKADoVh0hlyItjC3KTz4but6xBGNAkdjf1t9S+6rQTqfMv0GebTmxnR
         PaoscEC2QBJ6EzKeKXKbopaegnP+NaK1fC9UvXhWjmbXtwM2SQCaqj9akjNRNpFko2rk
         wU2aXSfvJcVXOwXJHsqbqhhziL0pUizkJqiSh/COtS2K00e7Quz7nOCWhp84TDZwraAW
         AtiNGt0BULoQeJ1crsC1tQcQ87iv1F8DPcS5KU4SDc9yj7EKf6+qxmYhUgiyleNAUG//
         bTPQ==
X-Gm-Message-State: AOJu0YxOnf4MVnws2tzDnUwVlztiySCanPcpbh7edP41RvZ4PyaNYO4N
	Dc2xE07WtQn1CNIzOTobx82bPM8v7y19rqQ8Ggk1UYrgrtXCkgbed7ezKPmhRy9MJ+mkI0aDWVz
	vYAa5dm0b0eMniozn3ktl/NdMreCps6f/i4VJj97Amw==
X-Gm-Gg: ATEYQzx74ffA7FAL2e+FHxVfAdC1hnntCrXbc5vLhXzTedpTtAq4gPvpIoEBEUPFm1f
	bJbw1q1MhwuuKSAbl84rXLeCdc+rtHKf1NZYcECgNGH7PKgsyJXJz1hKRWNMVw2MTzWRiZb1OPk
	qjJBsqqbTNb3UGfMm7LC5YAIk3tAuJYwysQt3T8affD3eQGdib3BwPpm5IYrbRDKc5S69arfi0x
	3Je5P2gye0AUF7QNmkleHUspDH55ITkbsQqab4rToPpohs2n+cfFwH8dNlxv06lF0eXEHqnzIXJ
	0shmXQSnSVMaXIvquW5PGNmGki82xjYaCEE/lN4jY5i76Gy9eQRb3cth11tdbQLDIOvKKiwN3tf
	2QRH49Z8kvKh2zgX6CrsiUlA=
X-Received: by 2002:a05:690c:6c06:b0:79a:6d65:c34b with SMTP id
 00721157ae682-79a71bdfeedmr27605637b3.32.1773834168420; Wed, 18 Mar 2026
 04:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
 <20260316160558.143619-1-pabloosabaterr@gmail.com>
In-Reply-To: <20260316160558.143619-1-pabloosabaterr@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 18 Mar 2026 12:42:33 +0100
X-Gm-Features: AaiRm53J4LTbFLi-_E7o3vU0oZS9_XBfSCpoh0t8XpNsi3mzDeLa4OiLNO9x8sw
Message-ID: <CAN5EUNQWvL7McJg833+pcZOmGyxegPewMpC4472-=V41-uaoJQ@mail.gmail.com>
Subject: Re: [GSoC v4] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, karthik nayak <karthik.188@gmail.com>, 
	jltobler@gmail.com, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've realised that I've sent v3 in reply to v1 instead of v2, here and on s=
ome
of the patches. I'm very sorry about that, I'll do it correctly from now on=
.

This v4 addresses v3 improvements and karthik feedback on v2

changes from v3: (detailed diff below the proposal):
- Patch status updated
- Timeline shows explicitly to rebase on week1
- Extra objective return missing blobs updated to be more clear
- fixed format for pdf creation

GSoC doesn't let me share the pdf sent. so I can't share a link.
I'm sending this as markdown because it is preferred plain text
but to see the actual pdf that will be delivered, it can be done with:

  pandoc <file> -f markdown+autolink_bare_uris -o proposal.pdf -V
geometry:"margin=3D2cm" -V colorlinks=3Dtrue -V urlcolor=3Dblue --toc
--number-sections

# Synopsis

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

# About Me and Contact

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

# Availability

My classes end the first week of May. From then until September I
won't have any classes which leaves me free to fully focus on the
project. I can dedicate 8+ hours each day, and for sure 40 hours a
week.

# Relevant Projects

- 16 bit CPU emulator. Good example of C programming.

  cpu: https://github.com/pabloosabaterr/CPU16

- Compiler. Good example of working on bigger projects.

  compiler: https://github.com/pabloosabaterr/Orn

# Pre-GSoC Work

## Introduction

[[GSoC] Introduction Pablo
Sabater](https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRA=
UoBPo5wWi8YGA@mail.gmail.com)

**Description**: A mailing list thread where I introduced myself to
the git community.

## Microproject

[[GSoC PATCH v4] t9200: replace test -f/-d with modern path
helpers](https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@=
gmail.com/)

**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`. Will merge
to `master`.

**Description**: Replaces `test -f` with helper `test_path_is_file`,
which makes debugging failing tests easier with better reporting.
As suggested as microproject.

## Draft Proposal

[[GSoC] Proposal: Complete and extend remote-object-info for git
cat-file](https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=3D=
66rjeY=3DNqKbqRkhA@mail.gmail.com/)

**Description**: Proposal draft thread.

## Other Contributions

[[GSoC PATCH v2] test-lib: print escape sequence
names](https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gm=
ail.com/)

**Status**: Will merge to `next`.

**Description**: In failed expected/actual checks printing, the escape
sequences were shown as their octal code. This patch fixes that to
print the actual escape sequence name, adds tests, and updates the
expected output.

[[GSoC PATCH] t9200: handle missing CVS with
skip_all](https://lore.kernel.org/git/20260311194002.190195-1-pabloosabater=
r@gmail.com/)

**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`. Will merge
to `master`.

**Description**: Wraps CVS setup in a skip_all for clearer failure
reporting and moves Git initialization into its own
test_expect_success.

[Re: [PATCH] gc: add git maintenance list
command](https://lore.kernel.org/git/20260313115932.15259-1-pabloosabaterr@=
gmail.com/)

**Description**: Code review for a patch sent.

[[GSoC RFC PATCH] graph: add --graph-max option to limit displayed
columns](https://lore.kernel.org/git/20260316133426.117684-1-pabloosabaterr=
@gmail.com/)

**Status**: RFC, waiting for feedback.

**Description**: Adds `--graph-max` option to `git log --graph` to cap
the number of columns that will be displayed. Helps readability for
projects with many branches.

[[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to
batch-command](https://lore.kernel.org/git/20260312214154.89120-1-pabloosab=
aterr@gmail.com/)

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

# The Problem

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

# The Solution

There are two main goals:

## Goal 1: Rebase and finish Eric's work

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

## Goal 2: Adding `%(objecttype)`

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

## Backward Compatibility

There are four possible scenarios to happen between client and server:

1. **The server doesn't know type (new client but old server)**:

   After receiving the server capabilities, the client doesn't see
`type` being advertised. When the user format string has
`%(objecttype)`, `expand_atom()` checks the `allow_list`, finds that
type was not fetched. Appends an empty string to the output buffer and
returns 1. The user will see an empty field where `type` should be, no
errors nor warnings. In Eric Ju's v11, this would crash, as described
in The Problem section, the `allow_list` from Goal 1 is what fixes
this, following `for-each-ref` behaviour for known but inapplicable
atoms as Jeff King suggested [4] [5].

2. **The server knows type but the client doesn't (new server but old clien=
t)**:

   The server advertises `type`, but the client doesn't know `type`
and following `gitprotocol-v2.adoc`, "Clients must ignore all unknown
keys", it silently ignores the `type` and only asks for the known
(`size`). The server returns only what was requested, user will see
the output for `size` but not for `type`. This doesn't need any new
code, the v2 protocol already behaves like this.

3. **Both know type (new client and new server)**:

   The server advertises `type`, the client requests `type` and
receives the type data. `expand_atom()` finds `type` in the
`allow_list`, fills `data->type` and then the user will see the object
type in the output. This is Goal 2.

4. **Both know type but protocol middleware doesn't (new client, new
server but old middleware)**:

   This becomes case 1 or 2 depending on what side is being affected
by the middleware. If the middleware removes `type` from the server
advertised capabilities, the client never sees it and treats the
server as it was old server, it becomes case 1 (empty string). If the
middleware removes `type` from the client request, the server will
only see `size` being requested and only returns size data, it becomes
case 2.

## Performance Considerations

To get an object type, we have to look only at the header, to get the
size `oid_object_info()` at `object-file.c` is being called which
already returns the object type in the same call. Sending the string
with the type will only be, worst case scenario 6 bytes for the
"commit" string.

# Timeline

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

- First of all will be rebasing Eric Ju's v11.
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

## Additional objectives

If there is enough time, or for future work after the project. I've
some ideas on how this could evolve:

## More placeholders support

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

## Returning missing blobs from a tree ordered

In a partial clone, someone might want to know what blobs are missing
inside a concrete tree and order them before fetching them.
The idea is to build on top of `remote-object-info` and what's been
built in Goal 1 and Goal 2:
Given a tree hash, return the missing blobs (inside that tree) ordered
by an orderable atom (size, name, type, ...).

This looks similar to Stolee's work on `git-backfill` [9], the key
difference is that `git-backfill` fetches the missing objects from a
path/object, while this would only query the metadata of the missing
blobs without fetching them and ordered by a given atom.

Thanks for reading my proposal and considering my application. I'm
very excited about this opportunity,

Pablo

\[1\]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmai=
l.com/
"Eric Ju's v11 patch"

\[2\]: https://lore.kernel.org/git/xmqqo6yr3wc4.fsf@gitster.g/ "Junio
Hamano feedback"

\[3\]: https://lore.kernel.org/git/20250224234720.GC729825@coredump.intra.p=
eff.net/
"Jeff King feedback"

\[4\]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.pe=
ff.net/
"options for strstr() by Jeff King"

\[5\]: https://lore.kernel.org/git/20250324033922.GB690093@coredump.intra.p=
eff.net/
"Jeff King follow-up"

\[6\]: https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gm=
ail.com/
"data->type not being cleared bug"

\[7\]: https://github.com/git/git/blob/master/Documentation/gitprotocol-v2.=
adoc#object-info
"object-info protocol docs"

\[8\]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@googl=
e.com/#t
"Calvin Wan's patch series"

\[9\]: https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@gm=
ail.com/
"git-backfill extension from Stolee"

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

[9]: https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@gmai=
l.com/
"git-backfill extension from Stolee"
---
diff --git a/v3.md b/v4.md
index 60c86de..c5b8bc6 100755
--- a/v3prop.md
+++ b/proposal-pdfFormat.md
@@ -1 +1 @@
-## Synopsis
+# Synopsis
@@ -11 +11 @@ Expected project size: 350 hours (Medium)
-## About Me and Contact
+# About Me and Contact
@@ -31 +31 @@ GitHub: https://github.com/pabloosabaterr
-## Availability
+# Availability
@@ -35 +35 @@ My classes end the first week of May. From then until
September I won't have any
-## Relevant Projects
+# Relevant Projects
@@ -45 +45 @@ My classes end the first week of May. From then until
September I won't have any
-## Pre-GSoC Work
+# Pre-GSoC Work
@@ -47 +47 @@ My classes end the first week of May. From then until
September I won't have any
-### Introduction
+## Introduction
@@ -49,3 +49 @@ My classes end the first week of May. From then until
September I won't have any
-**[GSoC] Introduction Pablo Sabater**
-
-https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wW=
i8YGA@mail.gmail.com
+[[GSoC] Introduction Pablo
Sabater](https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRA=
UoBPo5wWi8YGA@mail.gmail.com)
@@ -55,3 +53 @@
https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi=
8YGA@
-### Microproject
-
-**[GSoC PATCH v4] t9200: replace test -f/-d with modern path helpers**
+## Microproject
@@ -59 +55 @@ https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa=
0SMRAUoBPo5wWi8YGA@
-https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@gmail.co=
m/
+[[GSoC PATCH v4] t9200: replace test -f/-d with modern path
helpers](https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@=
gmail.com/)
@@ -61 +57 @@ https://lore.kernel.org/git/20260312173305.15112-1-pabloosaba=
terr@gmail.com/
-**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`.
+**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`. Will
merge to `master`.
@@ -66,3 +62 @@ As suggested as microproject.
-### Draft Proposal
-
-**[GSoC] Proposal: Complete and extend remote-object-info for git cat-file=
**
+## Draft Proposal
@@ -70 +64 @@ As suggested as microproject.
-https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=3D66rjeY=3D=
NqKbqRkhA@mail.gmail.com/
+[[GSoC] Proposal: Complete and extend remote-object-info for git
cat-file](https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=3D=
66rjeY=3DNqKbqRkhA@mail.gmail.com/)
@@ -74 +68 @@ https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjN=
R=3D66rjeY=3DNqKbqRkhA@
-### Other Contributions
+## Other Contributions
@@ -76,3 +70 @@
https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=3D66rjeY=3DN=
qKbqRkhA@
-**[GSoC PATCH v2] test-lib: print escape sequence names**
-
-https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.co=
m/
+[[GSoC PATCH v2] test-lib: print escape sequence
names](https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gm=
ail.com/)
@@ -84,3 +76 @@
https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.com=
/
-**[GSoC PATCH] t9200: handle missing CVS with skip_all**
-
-https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.c=
om/
+[[GSoC PATCH] t9200: handle missing CVS with
skip_all](https://lore.kernel.org/git/20260311194002.190195-1-pabloosabater=
r@gmail.com/)
@@ -88 +78 @@ https://lore.kernel.org/git/20260311194002.190195-1-pabloosab=
aterr@gmail.com/
-**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`.
+**Status**: Merged to `next` on 2026-03-12 at `8500bdf172`. Will
merge to `master`.
@@ -92,3 +82 @@
https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.co=
m/
-**Re: [PATCH] gc: add git maintenance list command**
-
-https://lore.kernel.org/git/20260313115932.15259-1-pabloosabaterr@gmail.co=
m/
+[Re: [PATCH] gc: add git maintenance list
command](https://lore.kernel.org/git/20260313115932.15259-1-pabloosabaterr@=
gmail.com/)
@@ -98,3 +86 @@
https://lore.kernel.org/git/20260313115932.15259-1-pabloosabaterr@gmail.com=
/
-**[GSoC RFC PATCH] graph: add --graph-max option to limit displayed column=
s**
-
-https://lore.kernel.org/git/20260316133426.117684-1-pabloosabaterr@gmail.c=
om/
+[[GSoC RFC PATCH] graph: add --graph-max option to limit displayed
columns](https://lore.kernel.org/git/20260316133426.117684-1-pabloosabaterr=
@gmail.com/)
@@ -106,3 +92 @@
https://lore.kernel.org/git/20260316133426.117684-1-pabloosabaterr@gmail.co=
m/
-**[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to
batch-command**
-
-https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gmail.co=
m/
+[[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to
batch-command](https://lore.kernel.org/git/20260312214154.89120-1-pabloosab=
aterr@gmail.com/)
@@ -114,0 +99 @@ I built Eric Ju's v11 and tested the bugs reported to
his patch [5], I've confir
+
@@ -117,0 +103 @@ I attempted to test rebasing Eric Ju's v11 to master
and got conflicts on 4 out
+
@@ -131 +117 @@ Following the project guidelines, I haven't done
anything on the project that co
-## The Problem
+# The Problem
@@ -142,0 +129 @@ Eric Ju's work remains unmerged after v11 because of
these issues:
+
@@ -151 +138 @@ Eric Ju's work remains unmerged after v11 because of
these issues:
-## The Solution
+# The Solution
@@ -155 +142 @@ There are two main goals:
-### Goal 1: Rebase and finish Eric's work
+## Goal 1: Rebase and finish Eric's work
@@ -157,0 +145 @@ Starting from where Eric Ju left off, I will rebase
it on top of the current `ma
+
@@ -165,0 +154 @@ Starting from where Eric Ju left off, I will rebase
it on top of the current `ma
+
@@ -171 +160 @@ Starting from where Eric Ju left off, I will rebase it
on top of the current `ma
-### Goal 2: Adding `%(objecttype)`
+## Goal 2: Adding `%(objecttype)`
@@ -173,0 +163 @@ Following what Calvin Wan did in 2021 [8] for
`%(objectsize)`, v2 protocol needs
+
@@ -192 +182 @@ Default format evolves to `%(objectname) %(objecttype)
%(objectsize)`. Test and
-#### Backward Compatibility
+## Backward Compatibility
@@ -212 +202 @@ There are four possible scenarios to happen between
client and server:
-#### Performance Considerations
+## Performance Considerations
@@ -216 +206 @@ To get an object type, we have to look only at the
header, to get the size `oid_
-## Timeline
+# Timeline
@@ -220,0 +211 @@ May 1-24: Community Bonding
+
@@ -227,0 +219,2 @@ Week 1-2: (May 26 - June 8)
+
+- First of all will be rebasing Eric Ju's v11.
@@ -231,0 +225 @@ Week 3-4: (June 9 - June 22)
+
@@ -234,0 +229 @@ Week 5-6: (June 23 - July 6):
+
@@ -240,0 +236 @@ Week 5-6: (June 23 - July 6):
+
@@ -243,0 +240 @@ Week 7-8: (July 14 - July 27)
+
@@ -246,0 +244 @@ Week 9-10: (July 28 - August 10)
+
@@ -253,0 +252 @@ Week 11-12: (August 11 - August 24)
+
@@ -261 +260 @@ Week 11-12: (August 11 - August 24)
-### Additional objectives
+## Additional objectives
@@ -265 +264 @@ If there is enough time, or for future work after the
project. I've some ideas o
-#### More placeholders support
+## More placeholders support
@@ -273 +272 @@ I've checked that Eric's v11 patch only supports
`%(objectsize)` on server side,
-#### Returning missing blobs from a tree ordered
+## Returning missing blobs from a tree ordered
@@ -275,3 +274,5 @@ I've checked that Eric's v11 patch only supports
`%(objectsize)` on server side,
-In a partial clone, someone might want to know what blobs are missing
inside a concrete tree and their size before fetching them.
-The idea is to build on top of `remote-object-info`:
-Given a tree hash, return the missing blobs (inside that tree) ordered by =
size.
+In a partial clone, someone might want to know what blobs are missing
inside a concrete tree and order them before fetching them.
+The idea is to build on top of `remote-object-info` and what's been
built in Goal 1 and Goal 2:
+Given a tree hash, return the missing blobs (inside that tree)
ordered by an orderable atom (size, name, type, ...).
+
+This looks similar to Stolee's work on `git-backfill` [9], the key
difference is that `git-backfill` fetches the missing objects from a
path/object, while this would only query the metadata of the missing
blobs without fetching them and ordered by a given atom.
@@ -279,0 +281 @@ Thanks for reading my proposal and considering my
application. I'm very excited
+
@@ -281,0 +284,18 @@ Pablo
+\[1\]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gma=
il.com/
"Eric Ju's v11 patch"
+
+\[2\]: https://lore.kernel.org/git/xmqqo6yr3wc4.fsf@gitster.g/ "Junio
Hamano feedback"
+
+\[3\]: https://lore.kernel.org/git/20250224234720.GC729825@coredump.intra.=
peff.net/
"Jeff King feedback"
+
+\[4\]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.p=
eff.net/
"options for strstr() by Jeff King"
+
+\[5\]: https://lore.kernel.org/git/20250324033922.GB690093@coredump.intra.=
peff.net/
"Jeff King follow-up"
+
+\[6\]: https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@g=
mail.com/
"data->type not being cleared bug"
+
+\[7\]: https://github.com/git/git/blob/master/Documentation/gitprotocol-v2=
.adoc#object-info
"object-info protocol docs"
+
+\[8\]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@goog=
le.com/#t
"Calvin Wan's patch series"
+
+\[9\]: https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@g=
mail.com/
"git-backfill extension from Stolee"
+
@@ -296,0 +317,2 @@ Pablo
+
+[9]: https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@gma=
il.com/
"git-backfill extension from Stolee"
\ No newline at end of file
