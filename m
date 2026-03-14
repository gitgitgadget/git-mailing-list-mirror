Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9B1A9FAB
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773467956; cv=pass; b=JEEK+K1vR4rmNnCxeGMhUXA2Gwg2drVpVWq6oLVIHElzCnFIFeHyylFoXswwSfSNz1bDassJ8t/zkX4qOD/5TlzmISriojVcrC4LN/GuKrmoRQPkXftKvEibBtmKr5SjKDGpvhpuHYtefyhA2RdlJ9As1z4QtCPyqv2OUszNUFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773467956; c=relaxed/simple;
	bh=5WKQs1kyemZSFlfyujCVPVmN8VKSlH1Xv/MCUJQtCts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlvSzjpo1rwtUkNSf6B+JuucXnu0gNboak4i4aqmmTWRLl1sW9JJhmxiSpF/WiNpMwASHzHM/fRZVhJ3JMSC6W3QEZKRER8rHVghUPWg9uwaluP+xTYijjyMNowSAKQWxhtT40NHehShcLgBlV6FsN6HE++BHnxr/qUFT5SiZm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY6gvBJ4; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY6gvBJ4"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-661568ce781so4282487a12.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 22:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773467953; cv=none;
        d=google.com; s=arc-20240605;
        b=H0DiJx2hTuXIXnrweeamlcE/urPlcOytu7cVPH+tXKO4q3DCn4ZsfeQOh4nUXzgkyY
         amCMVkbN6E4j8yiFWP1bYw4WvqO0fcHrdjyWDwt1+Oj2tUUN4TRR7Qus2XNWouSVoA81
         2+LA9Z5kIlh7UmIgmVqOKPF6Ad/j9M3+nOmu7kbE21E1cIHIg8w0nZKSHoKnJAXxsxpW
         AVXPhdlonxVaJ1zkR4zwPaue0QOmNfEMRncv41kihrmuTPrYANq9KNxDn3rmXUpek5lS
         apWWNNumtGAO/I2uVrXHElNEMzGN6CU2B8ABHunshA4n55+/eNitZ5QJF0Kdceml9oUQ
         MyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PADgh1Tm/uznF8syhWn6EbqSJUq8ClGVyYoRHqdtpDQ=;
        fh=B7tQVbxLGDVdUp5OnJwJZ1OcDVmTE69vrypiXV3/Tig=;
        b=KgpK666dBnyzC/AFyDavuIhnofV79TtGcl0v7+uI0Eufv2Sh41/gsuRgqrskepVUiO
         M6JaDcHf4mhCRf02TMFwMRAzP2Ngp5kzk8kZf42g7xQC5WSfptOjwG3IZPXcr3rvip/A
         ni/wPYNN9ELWYBXs/KltSIrF5nZEyMu6MqFVN76oT4sscW9lRjoHtJOj6Dt73ExxhUmA
         JzzCrlROaX8I8GefJQf+F4xrYQontteoJTaQbVp2HT3d0IrcM+NhZYU1EjGRjKBlum1O
         DLmBZ2gsJfjSPAmHKsiwCj5m52E8Z9PzXP3xKqvqrmTGDdzsEmm1jPg6qs58cwW5UiVe
         bXZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773467953; x=1774072753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PADgh1Tm/uznF8syhWn6EbqSJUq8ClGVyYoRHqdtpDQ=;
        b=fY6gvBJ4XDT3vNk4R20QDeQzjC5oT/9vcWNuwnfNSkkOV+JbeAKYNxDbAmw6fyLR0d
         fcZDmRLV5sua0S3fsYq9P1NPJXoqgN3de1u2HVF2Pv3IfKzLcun1pi/DjSibj3DZyyMI
         /ZAK6rsgnU32KWevhv4luEYId11YZPrZGBlGlSmUjmj/z2gPwlgMeBiSV37m8Bexs4+9
         MlPjbEqtyi1x6pG1Ke+DLYkMoVgPx1bdgMMCioj9fQlP56lAcevBEpEZr09l3Gzp2iDw
         mECyy4Auek4azWtxQbDGAKkePVDJZpltgUikW+WQGa0dYGK996Q4QO+mXFdLLJ8D9OaJ
         +ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773467953; x=1774072753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PADgh1Tm/uznF8syhWn6EbqSJUq8ClGVyYoRHqdtpDQ=;
        b=DuKj4+4pAlVoxeUcWfDkQd7y05q0YxzsvHKfLdN2nrT446Q91SVsKrm3g1y0am4dWi
         Tz2WGmSbNOYb/3d2MGt7YaJK978eZtX9w3PPV692GcTJkAAFS4EKaOfzjLrcMrIXjz3x
         T/riIB9Sp9sF6xM0Omn/LkTBBvldH9sMwg6oFs0CMlDqaHCvDVEytL0UkrFVe6WmwiLp
         kylGCZCmGMb6ayApek+udyHUsVEZtYI1bpCrFfeAcesrKfPXnU7HbS8vu2Rmi7mrEoUW
         QUcZdLkkqKBZDajCEcb+XI3muxIuLWo0AE5AIe8Tgax2jRuoXTnJdfoN+xfu2oSmEnO7
         01mw==
X-Gm-Message-State: AOJu0Yxyd1Fw3F7r/XYdb6nFYBslItHZZv80QHCs5aNsUi6cZQ+nxnQV
	4AshiNHmsUxKEaFXdlV2+iin0QA/48faCHvgJJvvVvpnuIILff6Wm7O6ZYAkqLS+gyZt2Hl0gJd
	TuWE8AQyaTjlDytJJfmJhPPdAM+MxOQs=
X-Gm-Gg: ATEYQzwC7oryPjYnz5gz5rfPCCkwVSI5EJIyCg0Eau0rXzhK0u0q/2UYNWvA5yqIZyg
	aupjb6IAdXiwjX1wjeqTrLRg/aLxhCzdZzIAvboTh0++8lwQsAAVJhZUZOmj2A2FNQ/zzxF8r0X
	iHRkERcsCg3a+AqaBEPpWEA7olBVVx2DveUT6YU8NgDrF/nCdIJSt9BIMarsaoRAqIqwVzRiZGr
	Bh8dQHfg5yao2zJvU16/r4ukdey8tSbNGuHywMG4uZIR8JLFkrrjMT0OiPxGJ81xj4H1YhDBXPk
	NiFjR7AhzQ==
X-Received: by 2002:a05:6402:5214:b0:663:93f1:6d1 with SMTP id
 4fb4d7f45d1cf-663babff407mr3700857a12.16.1773467952187; Fri, 13 Mar 2026
 22:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
In-Reply-To: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sat, 14 Mar 2026 11:28:47 +0530
X-Gm-Features: AaiRm51AvZhndPeAHDoqgG6FwjMiVyox171ZUKDUetnWjfMJrZAfA5LBOzDrY1Y
Message-ID: <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com>
Subject: Re: [GSoC] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On Fri, 13 Mar 2026 at 15:47, Pablo <pabloosabaterr@gmail.com> wrote:
>
> ## Synopsis
>
> This project finishes Eric Ju's work on `remote-object-info` for `git
> cat-file --batch-command` [1], resolves the pending feedback from
> Junio Hamano [2] and Jeff King [3] [4] [5], and extends support for
> `%(objecttype)`.
>
> Expected project size: 350 hours (Medium)
> ## About Me and Contact
>
> Name: Pablo Sabater Jim=C3=A9nez (he/him)
>
> Age: 19
>
> Education: Currently on my second Computer Science year at University
> of Murcia, Spain
>
> Location: Murcia, Spain (CET, UTC+1)
>
> Languages: C (solid), shell(bash) (good)
>
> Tools: git(proficient)
>
> I've checked that I'm eligible for GSoC 2026.
>
> Email: pabloosabaterr@gmail.com
> GitHub: https://github.com/pabloosabaterr
>
> ## Relevant Projects
>
> - 16 bit CPU emulator. Good example of C programming.
>
>   cpu: https://github.com/pabloosabaterr/CPU16
>
> - Compiler. Good example of working on bigger projects.
>
>   compiler: https://github.com/pabloosabaterr/Orn
>

Thanks for your interest in contributing to Git this GSoC!

> ## Pre-GSoC Work
>
> ### Introduction
>
> **[GSoC] Introduction Pablo Sabater**
>
> https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5w=
Wi8YGA@mail.gmail.com
>
> A mailing list thread where I introduced myself to the git community.

Nit: Could use a newline here.

> ### Microproject
>
> **[GSoC PATCH v4] t9200: replace test -f/-d with modern path helpers**
>
> https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@gmail.c=
om/
>
> Merged to `next` on 2026-03-12 at 8500bdf172. Replaces `test -f` with
> helper `test_path_is_file`, which makes debugging failing tests easier
> with better reporting.
> As suggested as microproject.
>
> ### Other contributions
>
> **[GSoC PATCH v2] test-lib: print escape sequence names**
>
> https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.c=
om/
>
> Will merge to `next`, in failed expected/actual checks printing, the
> escape sequences were shown as their octal code. This patch fixes that
> to print the actual escape sequence name, adds tests, and updates the
> expected output.
>
> **[GSoC PATCH] t9200: handle missing CVS with skip_all**
>
> https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.=
com/
>
> Merged to `next` on 2026-03-12 at 8500bdf172, wraps CVS setup in a
> skip_all for clearer failure reporting and moves Git initialization
> into its own test_expect_success.
>
> **[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-co=
mmand**
>
> https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gmail.c=
om/
>
> While testing Eric's v11 I've found and reported a new bug. On
> `remote-object-info` when it's preceded by a local query, `data->type`
> isn't being cleared. Causing it to return the wrong type.
>
> I have also studied the documentation provided and Eric Ju's work from
> v0 to v11 including all the feedback he got up to March 2025, the
> feedback he got from Junio Hamano and Jeff King, taking notes about
> what's left to be done and what else I can contribute to the already
> proposed project. That's how I've identified everything that I will
> address on the Problem, Solution and Timeline sections.
>
> I built Eric Ju's v11 and tested the bugs reported to his patch [5],
> I've confirmed the segfault and the `die()`, and found a new one:
> - When a local `info` runs before `remote-object-info` sharing the
> same format string, `data->type` isn't being cleared. A blob queried
> remotely after a local commit, `data->type` for blob becomes 'commit'
> with no error. I reported it on the mailing list [6].
>
> I attempted to test rebasing Eric Ju's v11 to master and got conflicts
> on 4 out of the 8 commits:
> - `d04cf85ece` t1006: split test utility functions into new "lib-cat-file=
.sh".
>         - `t/t1006-cat-file.sh`
> - `d918f720d8` fetch-pack: refactor packet writing.
>         - `fetch-pack.c`
> - `2daf9ed803` transport: add client support for object-info.
>         - `Makefile`
> - `c3ba4afaf6` cat-file: add remote-object-info to batch-command.
>         - `object-file.c`, `object-store-ll.h` (deleted).
>
> I'm being active on the mailing list and learning the Git flow of work
> and from the feedback I've received from the maintainers (Junio) from
> my patches.
>
> Following the project guidelines, I haven't done anything on the
> project that could step on other candidates' work before being
> accepted, and instead I'm focusing on understanding the project and
> its needs, and independent patches that will make the Git project more
> familiar and understandable to me.

Great work! It would help if you could split the description of your patche=
s
into Status, Description, Comments, etc. It helps a lot when reviewing the
proposal.

>
> ## Availability
>
> My classes end the first week of May. From then until September I
> won't have any classes which leaves me free to fully focus on the
> project. I can dedicate 8+ hours each day, and for sure 40 hours a
> week.
>
> ## The Problem
>
> Git's partial clone allows cloning repositories without downloading
> all objects (blobs, trees, ...). These objects are fetched on demand
> from the remote when needed. However, when a user needs metadata about
> these remote objects (size, type, hash, ...), Git has no efficient way
> of doing this without downloading all the object content.
>
>  The server side support for `object-info` protocol was implemented by
> Calvin Wan in 2021. Eric Ju built the client-side `remote-object-info`
> for `cat-file --batch-command`.

This part is likely more relevant in the 'Synopsis' section up top. It prov=
ides
important context that helps the reader tune their expectations for the res=
t
of the proposal.

From my experience, a good rule of thumb when writing a proposal is to
assume the reader doesn't know anything about the project or the problem
it tackles beforehand.

> Eric Ju's work remains unmerged after
> v11 because of these issues:
>
>  - The format validation uses `strstr()` which only checks for
> `%(objectsize)`. This causes two different errors:
>    - Atoms that `expand_atom()` recognizes but the remote doesn't
> (`objecttype`,`deltabase`, ...), `expand_atom()` returns 1, but when
> accessing `data->type` it only contains garbage, causing segfault. as
> Jeff King noted [3].

Grammar nit: should be 'garbage causing segfault, as Jeff King noted[3].'
The sentence could also use some restructuring for better clarity.

It is great that you've referenced the relevant discussion thread here.

>    - Unknown atoms by `expand_atom()`, returns 0, calling
> `strbuf_expand_bad_format` on `expand_format()`, which calls `die()`,
> as Jeff King found [3].
>    Both cases block the command, including local `info` queries if the
> same format string is shared. Unsupported remote placeholders should
> return an empty string, matching how `for-each-ref` returns empty for
> known, but inapplicable atoms like `%(tagger)` on non-tags [4] [5].
>
>  - When local and remote queries are mixed, `data->type` is not being
> cleared between commands. `remote-object-info` returns the wrong type
> data from a previous local query [6].
>

You've mentioned the outstanding issues and their implications for the end =
user.
Good work.

>  - Style and code issues marked by Junio Hamano [2] and Jeff King [3]
> [5] are still undone.
>    - comment style.
>    - `#define` formatting.
>    - line length.
>    - misleading error messages.
>    - missing `count > MAX_ALLOWED_OBJ_LIMIT` check at `split_cmdline().`
>    - if/else invert at `get_remote_info()`.
>  - `%(objecttype)` is not yet supported on either client or server side.
>
> ## The Solution
>
> There are two main goals:
>
> ### Goal 1: Rebase and finish Eric's work
>
> Starting from where Eric Ju left off, I will rebase it on top of the
> current `master` branch and address the feedback left to do:
> - Fix style in comments, `#define` formatting and line length.
> - Fix misleading error message in the overflow check.
> - Add missing `count > MAX_ALLOWED_OBJ_LIMIT` check after `split_cmdline(=
)`.
> - Invert if/else on `get_remote_info()` to keep the small block first
> (the error one) as Junio suggested.
> #### Replace `strstr()` format validation with allow_list in `expand_atom=
()`

Nit: Could use a newline here.

>
> `strstr()` isn't enough to fully validate the placeholders, it only
> searches for `%(objectsize)` and unsupported placeholders cause
> segfaults. The fix is to refactor the validation with an allow_list in
> `expand_atom()`.

It is great if this is your idea, but if not, it would help to credit the
person who suggested this and link to the relevant discussion, if
applicable.

> But why `expand_atom()` when Jeff King suggested
> `expand_atom()` or `expand_format()` [4] ?
> - There are two cases, first, inside `expand_atom()` before returning
> (segfault) and second, calls `die()` when `expand_atom()` returns 0.
>   Placing the `allow_list` at the top of `expand_atom()` prevents both
> errors, on remote mode, append nothing to `sb` and return 1, accessing
> `data->type` won't cause segfault and prevents `expand_format()` from
> reaching `die()`.
>   As extra safety, initializing `data->type` to `OBJ_BAD` and check
> for `NULL` from `type_name()` makes it that even without `allow_list`,
> uninitialized data doesn't cause a segfault.
>   At Goal 1, only `%(objectname)` and `%(objectsize)` will be in the
> allow_list. Goal 2 will bring `%(objecttype)` support.
> ### Goal 2: Adding `%(objecttype)`

Nit: Newline here as well.

>
> following what Calvin Wan did in 2021 for `%(objectsize)`, v2 protocol

Grammar nit: [F]ollowing.

> needs to be extended on the server side to support the new
> `%(objecttype)` placeholder:
> - extend `object_info_advertise()` at `serve.c`
> - add .type to `requested_info` struct at `serve.c`
> - support `type` in `cap_object_info()` at `protocol-caps.c`
> - look for type at `send_info()` at `protocol-caps.c`
>
> following object-info protocol docs [7] it should look like:

Here as well.

> ```
>   attrs =3D "size" SP "type"
>   obj-type =3D "blob" | "tree" | "commit" | "tag"
>   obj-info =3D obj-id SP obj-size SP obj-type
>   info =3D PKT-LINE(attrs LF)
>         *PKT-LINE(obj-info LF)
> ```
>
> `%(objecttype)` needs to be added to the `allow_list`. Client side
> needs to learn to ask for `%(objecttype)` from remote, parse what has
> been received and fill `expand_data` with the actual type. This makes
> it return the object type instead of the empty string returned while
> it was unsupported.
>
> Default format evolves to `%(objectname) %(objecttype) %(objectsize)`.
> Test and document new placeholder support and server side extension.
>

Makes sense.

> #### Backward Compatibility
>
> There are four possible scenarios to happen between client and server:
> 1. The server doesn't know type (new client but old server):
>
>    After receiving the server capabilities, a client will only request
> what the server advertises. The `allow_list` would handle this,
> returning an empty string when the server doesn't support it.
> 2. The server knows type but the client doesn't (new server but old clien=
t):
>
>    Following `gitprotocol-v2.adoc`, "Clients must ignore all unknown
> keys", it will ignore type, and request only the known capabilities.
> 3. Both know type (new client and new server):
>
>    Server advertises type, client requests it and gets the type data.
> 4. Both know type but protocol middleware doesn't (new client, new
> server but old middleware):
>
>    If a server advertises type but client doesn't receive type, a
> client won't ask for anything unadvertised, if a client asks for type
> but the server doesn't receive it, it will only return the known
> capabilities.
>

This section makes sense as well, could use better formatting though.

> **performance considerations**
>
> To get an object type, we have to look only at the header, to get the
> size `oid_object_info()` at `object-file.c` is being called which
> already returns the object type in the same call. Sending the string
> with the type will only be, worst case scenario 6 bytes for the
> "commit" string.
> ## Timeline
>

Nit: newline.

> I've designed this to work with enough time so final work can be
> shorter than what's said here
>
> May 1-24: Community Bonding
> - Talk and meet with mentor that I'm assigned with, to get feedback
> about my proposal, how I will report my progress apart from the code
> submitted and possible blogs, and tips and tricks to work better at
> Git.
> - Confirm with mentor that the `allow_list` approach is still the best op=
tion.
> - Draft commits structure.

It would also be helpful if you continue working on your patches that haven=
't
been merged yet from your pre-GSoC efforts. The goal of Community
Bonding Period is to interact with the wider community as much as possible,
and what better way to do that other than engaging through patches.

Also, GSoC/Git requires you to write weekly blog posts detailing your work,
what's holding you back, etc. So it's good if you use this time to set up y=
our
blog, if you don't have one already.

>
> Week 1-2: (May 26 - June 8)
> - Rebase Eric Ju's  v11 on top of current `master`.
> - Work on style fixes: comments, `#define` formatting, line length.
> - Fix the wrong error message in the overflow check.
> - Add missing check `count > MAX_ALLOWED_OBJ_LIMIT` after `split_cmdline(=
)`.
> - Invert if/else in `get_remote_info()`.

These four points are specifics of how you're going to tackle the
'Style Issues' problem
you mentioned above. I don't think there's any benefit in reiterating them =
here.

A single 'Fix the style and code issues.' or something similar would be bet=
ter.

> - Send first patch.
>
> Week 3-4: (June 9 - June 22)
> - Implement `allow_list` in `expand_atom()` using `is_atom()` in remote-m=
ode.
> - Initialize `data->type` to `OBJ_BAD` and add null check at `type_name()=
`.
> - Implement empty string return for unsupported placeholders.
> - Tests for supported placeholders, unsupported, mix, and the intermix
> case `info` + `remote-object-info` with the same format string.
> - Work with feedback from the first patch.

Again, specifics of the implementation plan don't need reiteration.

>
> Week 5-6: (June 23 - July 6):
> - Continue with review feedback.
> - Goal 1 should be polished or close to the final form.
> - Prepare the midterm report.
>
> Midterm evaluation (July 7 - 11) as specified on GSoC timeline docs
> - Goal 1 submitted and keep work with feedback.

You could probably dedicate this time to start working on Goal 2.
Addressing feedback is something that occurs spontaneously and
doesn't need dedicated slots in your timeline.

> Week 7-8: (July 14 - July 27)
> - Begin Goal 2.
> - Extend server side v2 protocol to serve `%(objecttype)`, following
> `%(objectsize)` structure.
> - Test server side.
>
> Week 9-10: (July 28 - August 10)
> - Add `%(objecttype)` to the `allow_list` from Goal 1.
> - Extend client side to ask for `%(objecttype)` from remote on `object-in=
fo`.
> - Parse server answer and fill `expand_data` with the actual type.
> - End to end tests and documentation.
> - Default format becomes `%(objectname) %(objecttype) %(objectsize)`.
> - Send patch series.
>
> Week 11-12: (August 11 - August 24)
> - Work with Goal 2 feedback from the patches.
> - Polish everything, all tests pass, good test coverage, no
> style/comment mistakes.
> - Final documentation review.
> - Prepare for final evaluation.
>
> Final evaluation (August 18-24) as specified on GSoC timeline docs
>
> ### Additional objectives
>
> If there is enough time, or for future work after the project. I've
> some ideas on how this could evolve:
> #### More placeholders support
> I've checked that Eric's v11 patch only supports `%(objectsize)` on
> server side, but on the client side there are other placeholders that
> can be added too. with the `allow_list` and having Goal 2 implemented
> adding more placeholders becomes trivial.
>
> - `%(objectsize:disk)`: Returns the size on the disk (compressed or as
> a delta) instead of returning the uncompressed size that
> `%(objectsize)` does. To do this, the server would need to send what's
> the actual size on disk data.
>
> - `%(deltabase)`: Returns the delta base object OID. non delta objects
> return zero OID as it does on local.
>
> #### Returning missing blobs from a tree ordered
> In a partial clone, someone might want to know what blobs are missing
> inside a concrete tree and their size before fetching them.
> The idea is to build on top of `remote-object-info`:
> Given a tree hash, return the missing blobs (inside that tree) ordered by=
 size.
>
> Thanks for reading my proposal and considering my application. I'm
> very excited about this opportunity,
> Pablo
>
> [1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmai=
l.com/
> "Eric Ju's v11 patch"
>
> [2]: https://lore.kernel.org/git/xmqqo6yr3wc4.fsf@gitster.g/ "Junio
> Hamano feedback"
>
> [3]: https://lore.kernel.org/git/20250224234720.GC729825@coredump.intra.p=
eff.net/
> "Jeff King feedback"
>
> [4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.pe=
ff.net/
> "options for strstr() by Jeff King"
>
> [5]: https://lore.kernel.org/git/20250324033922.GB690093@coredump.intra.p=
eff.net/
> "Jeff King follow-up"
>
> [6]: https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gm=
ail.com/
> "data->type not being cleared bug"
>
> [7]: https://github.com/git/git/blob/master/Documentation/gitprotocol-v2.=
adoc#object-info
> "object-info protocol docs"

Overall, great work on the proposal so far! Other than a few stylistic
mishaps, the proposal
looks pretty strong already.

You should upload your proposal on the GSoC website and add the link to it =
here.
The proposal can be then updated later as many times as you like.

Regards,
Chandra.
