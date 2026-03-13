Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB23389441
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397060; cv=pass; b=nHK7tZPWUpo5FxVm4cCdzJOTDfbgT186CAXwDACr8f6Fak3DkBTgCk1i4kRZYjnvZe0eMuimeeL9/+Z4kjO1VJRrYiWIU4ZonJIV7jo/x13ndhA/FFMlGRxVetZ0EJKBGWaFSsWCHYHpygllLJAuDtBJRBGhBlyW/nxSxM9/tEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397060; c=relaxed/simple;
	bh=iAwM272h9D8bwckl18giWRibPD5FPI9fX3q6ILq8MvU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f9teRlwOVELlANS91c2YbIbiea5nsmdKInbNYTcT6ChSEwNHykwvaH5uzkabe4965k6ti5EeJoTsaMUAiCod6AlGKLvSz7+Ofh44uUTy6ejruvNAm/sbyqimQQPlN/tXsN12I8lZIdX2+P/rtgoAnlEc7ct/79jI5vBM/kcy8kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6dQFfB3; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6dQFfB3"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca2b32f46so1609468d50.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773397056; cv=none;
        d=google.com; s=arc-20240605;
        b=jOnEj9KmPYrdLvtKqau3y9LI4FUJLJapG7+MpqDI+HrQlPm5xocZpTS2mZDvsVuLbl
         8Pa3ukhWpDwYIdcoLvtu65UDqCgfHUqzdY/87h/kLq8/L+04iDHW9BKswrqP54qQXU/P
         FNfnXcDgoSKVjIenL2vga8CqDc2hRio0Tb39IaYkVeyI9oSQahLsS+/mYF3RVFFT6o2t
         +GBp/FKN3Q/NrMybeQp1jnhn+1sGOPGbK4m/7/4kFcu2Dnms/9DcoX0jSR1OOualCmro
         Pfg166D9Rch1HJdWPivnODZgNtf4lKKou/Cy9uXArod/GLWUG9NN8w4idnsKjubEPnGN
         7a8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=09Hoql6r+Xh47R9ak1X9BnQYwUNZm1BQLjFn9XK5KDQ=;
        fh=tEqxrRpDzi30Smfngwt0DpbMVN7fSkopalTjnX/15Sc=;
        b=CzNe6Sx9Fg2a+R0X1IoL6S/e1BostpRsc3Pxx7EKFPwUY5BVlbLGtavM8M0kU0vh5u
         aXOXBTFuUbzDWraHr6pXIRKRoVjGJXaFVOkqIJZEsLMP/Ti24iIQSE2O3Xt7gk9kcCEY
         B2sBq6vOmnOkNhEV8kbE97uRibvbQIaVw5Gw18s1AwWr3fvOnkuLgYvISfxasE/LN0fx
         yr+90KkGYLBkEPh8rGPV4XSlJvN85AoM7Ftqo5oecF8xLu+GmWChfsVfbpyQLK3k0qS0
         Vovu+ifWRPQqiR/mNZqN67HR8u9X6qJU8EyAm6SngJzfHwnCYp3xw25bCVIHcgxjtaA9
         CQMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773397056; x=1774001856; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09Hoql6r+Xh47R9ak1X9BnQYwUNZm1BQLjFn9XK5KDQ=;
        b=N6dQFfB3KIshByOGWqcmnRjwkZoSRCIQ+C4ykeFWjOrMn5boiWOneOLKRZLiiBcKHm
         gc9uhCKIN5fZt0dwEd+xpLfyNyYJ7u7QzY68OJFMbjFriK1U/CGEljyUDqAsGuqF6YTF
         gjQtjkQas+iFt4x1amu1vvLVpsP6VO98ticEeefTd+90nMqBJwP3Vyj8RHOCT56A1Del
         D4EEK6mCZm1JY7lfcU0AXmPBQYp/kmNPMd3CdfqUsLHm+ievzZlr8YjlxZop6YwhcJfR
         yADz66dGSit+SpBWvZLiQoXetZBkOP82ykNlqQlxzCZA0PzSqdvcLo99HH2+CB/xNaBr
         NleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773397056; x=1774001856;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09Hoql6r+Xh47R9ak1X9BnQYwUNZm1BQLjFn9XK5KDQ=;
        b=ZMBV0gSXNkfMdKsOHx1xz+CKyc5mSGGmoCNFVFPSNJjQpRJOlIx2xbBKRHbvwpPSvn
         0CjI2AdgX72FwRtD2XOaWU+8Vdb10wCTXjlvcSYzIg4GgmNaxRjW2NaL+IoPpnEGJPNT
         GbOZK9G/UZbpzoSLVI8LNsuANduj94ILIKy85cjtC+aKiRD7AS9EVKeyTsGWXRv8miTP
         aVOEPk75X65eY573E520XFr7bjg4/EjkNL8K87mJrWF2BCirToBCacH1Z2jNFaURkAP6
         hbLZe92cueVCeRGoBu78sFhje8mdwepK2AIF8D4Kyu2BGGMVZzGFILoOIYkdwyuJuWMs
         bn9Q==
X-Gm-Message-State: AOJu0Yy+LY8dhJELuJbClKfkbV11a0Uu+RHDQwtiNiFEaAkCYDD6Jrrt
	TwImrQQCnc1xZGcPERA/dX1sbj8HrV0SL+hrZjBBIwqBLWq7Qvd+eHXvQh45ZYfqRv9g31kiJG2
	2Ej+kdxZW0MNn507s0T2o6Xvwaq9d8eD6wbGSORsFVQ==
X-Gm-Gg: ATEYQzzzKbUu7+4r8RLBvPdGEyySk6tuDFh5/YMMAMavNWW+TuZW2cHuUAeelOUvk4+
	YEMED/AnTfOrn+nt8Idn/be1q42pklE7NjKPPY3JG7MpiTqDK0lVJARFsTLaWvYj4TBsgdi7Z9n
	OJ7U9BQPAMIEuQiFCIqiau1rdmMugsGi7x/b0x2zGb62DzlnqoeIdIZXpwP77DU3YYTTWPthc4b
	i9X8HBDTZLccmzlQEFHRE88SSOmWewb5EH/L5TXr7iYrTC5mRe7n8BczAH99lwUAYJnKHarrUax
	gD19Vz53HO6rz9Y7oYkzz1/Q6exOZmChuaetv9zDOLePa7q1O/c8Hfc3qZ1Oruv1W7w+0+sArw5
	bZFYY4D/CtJzv+jmiNc8Fz0c=
X-Received: by 2002:a05:690e:e08:b0:649:c36a:a9b4 with SMTP id
 956f58d0204a3-64e62fd5cb9mr2025729d50.36.1773397056308; Fri, 13 Mar 2026
 03:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 13 Mar 2026 11:17:25 +0100
X-Gm-Features: AaiRm51HmQiKgl1cglbEnhNkz7LxMD4AolmSzdZkwlb0KrD_r6EBo2OiwdrIOUk
Message-ID: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
Subject: [GSoC] Proposal: Complete and extend the remote-object-info command
 for git cat-file
To: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

## Synopsis

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

A mailing list thread where I introduced myself to the git community.
### Microproject

**[GSoC PATCH v4] t9200: replace test -f/-d with modern path helpers**

https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@gmail.com=
/

Merged to `next` on 2026-03-12 at 8500bdf172. Replaces `test -f` with
helper `test_path_is_file`, which makes debugging failing tests easier
with better reporting.
As suggested as microproject.

### Other contributions

**[GSoC PATCH v2] test-lib: print escape sequence names**

https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.com=
/

Will merge to `next`, in failed expected/actual checks printing, the
escape sequences were shown as their octal code. This patch fixes that
to print the actual escape sequence name, adds tests, and updates the
expected output.

**[GSoC PATCH] t9200: handle missing CVS with skip_all**

https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.co=
m/

Merged to `next` on 2026-03-12 at 8500bdf172, wraps CVS setup in a
skip_all for clearer failure reporting and moves Git initialization
into its own test_expect_success.

**[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-comm=
and**

https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gmail.com=
/

While testing Eric's v11 I've found and reported a new bug. On
`remote-object-info` when it's preceded by a local query, `data->type`
isn't being cleared. Causing it to return the wrong type.

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

## Availability

My classes end the first week of May. From then until September I
won't have any classes which leaves me free to fully focus on the
project. I can dedicate 8+ hours each day, and for sure 40 hours a
week.

## The Problem

Git's partial clone allows cloning repositories without downloading
all objects (blobs, trees, ...). These objects are fetched on demand
from the remote when needed. However, when a user needs metadata about
these remote objects (size, type, hash, ...), Git has no efficient way
of doing this without downloading all the object content.

 The server side support for `object-info` protocol was implemented by
Calvin Wan in 2021. Eric Ju built the client-side `remote-object-info`
for `cat-file --batch-command`. Eric Ju's work remains unmerged after
v11 because of these issues:

 - The format validation uses `strstr()` which only checks for
`%(objectsize)`. This causes two different errors:
   - Atoms that `expand_atom()` recognizes but the remote doesn't
(`objecttype`,`deltabase`, ...), `expand_atom()` returns 1, but when
accessing `data->type` it only contains garbage, causing segfault. as
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
segfaults. The fix is to refactor the validation with an allow_list in
`expand_atom()`. But why `expand_atom()` when Jeff King suggested
`expand_atom()` or `expand_format()` [4] ?
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

following what Calvin Wan did in 2021 for `%(objectsize)`, v2 protocol
needs to be extended on the server side to support the new
`%(objecttype)` placeholder:
- extend `object_info_advertise()` at `serve.c`
- add .type to `requested_info` struct at `serve.c`
- support `type` in `cap_object_info()` at `protocol-caps.c`
- look for type at `send_info()` at `protocol-caps.c`

following object-info protocol docs [7] it should look like:
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
1. The server doesn't know type (new client but old server):

   After receiving the server capabilities, a client will only request
what the server advertises. The `allow_list` would handle this,
returning an empty string when the server doesn't support it.
2. The server knows type but the client doesn't (new server but old client)=
:

   Following `gitprotocol-v2.adoc`, "Clients must ignore all unknown
keys", it will ignore type, and request only the known capabilities.
3. Both know type (new client and new server):

   Server advertises type, client requests it and gets the type data.
4. Both know type but protocol middleware doesn't (new client, new
server but old middleware):

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
- Talk and meet with mentor that I'm assigned with, to get feedback
about my proposal, how I will report my progress apart from the code
submitted and possible blogs, and tips and tricks to work better at
Git.
- Confirm with mentor that the `allow_list` approach is still the best opti=
on.
- Draft commits structure.

Week 1-2: (May 26 - June 8)
- Rebase Eric Ju's  v11 on top of current `master`.
- Work on style fixes: comments, `#define` formatting, line length.
- Fix the wrong error message in the overflow check.
- Add missing check `count > MAX_ALLOWED_OBJ_LIMIT` after `split_cmdline()`=
.
- Invert if/else in `get_remote_info()`.
- Send first patch.

Week 3-4: (June 9 - June 22)
- Implement `allow_list` in `expand_atom()` using `is_atom()` in remote-mod=
e.
- Initialize `data->type` to `OBJ_BAD` and add null check at `type_name()`.
- Implement empty string return for unsupported placeholders.
- Tests for supported placeholders, unsupported, mix, and the intermix
case `info` + `remote-object-info` with the same format string.
- Work with feedback from the first patch.

Week 5-6: (June 23 - July 6):
- Continue with review feedback.
- Goal 1 should be polished or close to the final form.
- Prepare the midterm report.

Midterm evaluation (July 7 - 11) as specified on GSoC timeline docs
- Goal 1 submitted and keep work with feedback.

Week 7-8: (July 14 - July 27)
- Begin Goal 2.
- Extend server side v2 protocol to serve `%(objecttype)`, following
`%(objectsize)` structure.
- Test server side.

Week 9-10: (July 28 - August 10)
- Add `%(objecttype)` to the `allow_list` from Goal 1.
- Extend client side to ask for `%(objecttype)` from remote on `object-info=
`.
- Parse server answer and fill `expand_data` with the actual type.
- End to end tests and documentation.
- Default format becomes `%(objectname) %(objecttype) %(objectsize)`.
- Send patch series.

Week 11-12: (August 11 - August 24)
- Work with Goal 2 feedback from the patches.
- Polish everything, all tests pass, good test coverage, no
style/comment mistakes.
- Final documentation review.
- Prepare for final evaluation.

Final evaluation (August 18-24) as specified on GSoC timeline docs

### Additional objectives

If there is enough time, or for future work after the project. I've
some ideas on how this could evolve:
#### More placeholders support
I've checked that Eric's v11 patch only supports `%(objectsize)` on
server side, but on the client side there are other placeholders that
can be added too. with the `allow_list` and having Goal 2 implemented
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
