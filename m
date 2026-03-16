Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A634360753
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697098; cv=pass; b=C29hlI3fDpXOWaF1CgEixGa5tAMEXFP2+Miu2ZMXI7QP6bjs9+cjjc0WHTbFIuOFRFEh0L2GvzJovOWWZ9OV/z7IZtbZj6mrRko5VNBr41vym2mB8lz8V4TRAIhFpVBt1GeI7gRZeIDDltNpL9xZwKC3b38ecaIRyP7KbtVvl9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697098; c=relaxed/simple;
	bh=BlE5EzCsOYB1Z/sGYeyY/lfC+LSyRTfWoAhIWsC04MI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYN5WCwg2WJ02AnmKZUrGVx6jMVgforQ07kTe5LoFaMI32R2GlnnBE/AI9Uy79VknzRPyfmLNJKRDZcCrX03A/GOr3EdzeP4zHG7MvYC/E3X3+RkdY7YB6UjhS1pAqdyPnahOKwNpYMv8zyFPPuyEhOM93IP1Nkf4RyPx2mPENQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGANWnnv; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGANWnnv"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56b1b9899d2so4662179e0c.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 14:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773697095; cv=none;
        d=google.com; s=arc-20240605;
        b=aCRTouCY5PbGGpjokoEKZgRCe17q6lxstKjyyliW4l2X1gI4YbcTTJYR5+gHIvruuo
         BtLWp5vnH8IlbVGItO0RHbAsiYpjyvkFAItHjDeDXmui5ite/95vg7vcxjdHxBmEWe4E
         vE3hKTLWhlx+K/vk/OdhE6Wni7o7RjRHGWUX5dNEHcnUUdBcNTc8MyGpWp/rr5F3ZdNg
         F41v9cNCaMZKTOJLfo6lEm8bM5ChN2LvSxiSBPFalS+I1wfUmkheIAzvso97DOcXgAa9
         xWxBdiTh82z2AJIC+RJ/HQH/11MaHmKY6bPyI1DyCcyBgCbSPkQ0ms0DE3QNtEaGE334
         +tNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mYo14qTG3Zpna7uSR/+EQNuSLpdIbohTWFupBGV24/M=;
        fh=1jGbgOtHiIOtyCV15W34kegXYT7BBNQhqlRjebf7M1o=;
        b=Tt4IE6cMHzKLz8DPWWatfqHBm9jE6dwMs6v5zuPIkm+xCS9lBTKnuM/T0qMA7vySaI
         i7pDdsbpMQl5ArmUnzHcgcuuUSO7+KuZpio5r59Y2dlY0LA7DfEVGOCXTYOTdOMhnBGQ
         Mh0vBBG46uROoB6ocsH/h+cmm7NXuE9xFqgjC9gz/hSFfvoRqo0QycKfQtN8EkkYPl03
         XSRLERYSeoBFM13ZJHRJYZvxZANqpH6IdwDz79DSuze1+zeQ5pCDm91g4w3l/a+WwTt4
         86DhW4eGG6DaZkRmdBrX+VskOeZBTNPIVUc4zGKxbrmU7LyTXFR/hQbF5MIrFJCjgNPJ
         ZlSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697095; x=1774301895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYo14qTG3Zpna7uSR/+EQNuSLpdIbohTWFupBGV24/M=;
        b=bGANWnnvQv/b+1br5VU+i7nEuCOM5Viq5AgYNvakMxPwBXyxnMvvFrYFbOSmf0ldbK
         fKW1P3b85vc74r5rR+mydAgcpSfSXrLiFhHEjs43bxDqaTKqKFZf2vHCfIZ2KmzecSBK
         lpHvedErOIcQBh8jRG3qM1fKX3EHXe8BPXrGIwaUhhXNuxmUQ13FM3cVWxEZu/FiVnIf
         wyc8zLxu/8fOx/N7J4hxYcsEOf/FPUqnRosvDFLUHLXaY3vSKLKIuCUVxdGr4ryrP1nD
         3rmz6jXnSjpeJP+E580ch6YrBRBd2NJK1LpgMmznfActsyr5amFoAKhiQKNp+6hIoVI1
         gdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697095; x=1774301895;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYo14qTG3Zpna7uSR/+EQNuSLpdIbohTWFupBGV24/M=;
        b=L6A2P0GaB4i3e3QFbFJg1HbfAItwfVAbotHB22F18/QMZV2rwMRhBlc2G8Q9f2kmt8
         HfnWye7ZtINZOSaVN7JxeGVXhNxsNwPp/yT75I4MG4a55l6ILwXoPLm9G/gHyw/WP4Nc
         +XPecZXYlmHE/21B1JpGdlvA2q0b3azqRATRogRSni3pTSspZb2GoWGuBPKXiFp89Ir7
         u4pjLwPusCcH3Er52Yway/uLgg0gW5v24T6obebA8uj93OjkBYeDcMQqw34V+UDPzV0U
         oqBHCsaACqvaCeoTE8CkUxCwr+sW5p4Jp37CTjK9x7r858ECAE37uIxXhK6/jt42RtG0
         LCQQ==
X-Gm-Message-State: AOJu0YwzIecN1j8GKeSIWL7u5uv/buZdOHeme4uVl4SehL+KlgWfXvpT
	m3HYRu3TmglWLJa/n8Jcw0PY3uvkrEElB70udxBPPXTPudhZTIOQY3EQKYvSIuB4aVEXQGBvNXC
	6zDPLVoNoXW0aY1HcVAHlsS9ieygUXXw=
X-Gm-Gg: ATEYQzy+jCF3wxJnfqIAslnxejc/PiBl+xMg46W68gm+trYmsvMts+Mr2bdLCs6k5ZM
	q4BZdfp7TLSNCbrTKnOrJKhOviPR/3IH8t+0W1NK25LrZp35l3eeJUxoEUPQOvmCKwz8b74rYqF
	xi/zBBqQzlMlNDZoqR/MrrF+gPaAcYGfx9kD8KRd+xE7Ar+w7aqz5T6YtwGomW03jcMJiDzlOUX
	9gZTZncydWmP2Y+G4QPzqpnBti2wILVZsNWahBojNgGXGMjh8ooXkTdJfym+f1MXFrJNjKao9yf
	Z1LFFnXfS5BWXASzSgT/WonepKYwOo4UZLmoFIDH6A==
X-Received: by 2002:a05:6102:324e:20b0:602:6987:e233 with SMTP id
 ada2fe7eead31-6026987fb19mr15372137.37.1773697095133; Mon, 16 Mar 2026
 14:38:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 14:38:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 14:38:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
 <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com> <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 14:38:14 -0700
X-Gm-Features: AaiRm50xiXPFL5jogOyv-hYsHUmbTlPi6o5Ou6JvxjQjrM3DE36BKLNbyvvHzas
Message-ID: <CAOLa=ZREJsZ_p9Hfi_+XePW8c1n7xd-UjEuMSh=AHrQC8X75Tw@mail.gmail.com>
Subject: Re: [GSoC] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: Pablo <pabloosabaterr@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004b890f064d2b09bc"

--0000000000004b890f064d2b09bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pablo <pabloosabaterr@gmail.com> writes:

> Hi Chandra, thanks a lot for the feedback! :)
>
>> You should upload your proposal on the GSoC website and add the link to =
it here.
>> The proposal can be then updated later as many times as you like.
>
> GSoC proposals opens March 16th, for now I'll send my v2 here and as
> soon as I can I'll swap to GSoC website and send the link to the
> thread.
>
> To avoid having you reread everything again this is what I've done from v=
1:
>
>   Moved context explanation from The Problem to Synopsis and
> Availability below About Me and Contact.
>   Split Pre-GSoC patches into status (for code patches) and
> description to improve readability.
>   Added a code review and proposal thread to the Pre-GSoC section.
>   Added new lines where noted and fixed capitalization.
>   Correctly credited Jeff King for the allow_list idea and added new
> [8] for Calvin Wan's work.
>   Community bonding now includes continuing patches and setting up a blog=
.
>   Removed most of the duplicated iteration on the Timeline from The
> Problem. (feels a bit empty now tho).
>

Perhaps a diff would be a good addition for next time? :)

> I paste here my v2 with the requested changes:
>
> ## Synopsis
>
> Git's partial clone allows cloning repositories without downloading
> all objects (blobs, trees, ...). These objects are fetched on demand
> from the remote when needed. However, when a user needs metadata about
> these remote objects (size, type, hash, ...), Git has no efficient way
> of doing this without downloading all the object content.
>
> The server side support for `object-info` protocol was implemented by
> Calvin Wan in 2021 [8]. Eric Ju built the client-side
> `remote-object-info` for `cat-file --batch-command`.
>
> This project finishes Eric Ju's work on `remote-object-info` for `git
> cat-file --batch-command` [1], resolves the pending feedback from
> Junio Hamano [2] and Jeff King [3] [4] [5], and extends support for
> `%(objecttype)`.
>

Nice to see that you've linked in the relevant resources.

> Expected project size: 350 hours (Medium)
>
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
> ## Availability
>
> My classes end the first week of May. From then until September I
> won't have any classes which leaves me free to fully focus on the
> project. I can dedicate 8+ hours each day, and for sure 40 hours a
> week.
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
> ## Pre-GSoC Work
>
> ### Introduction
>
> **[GSoC] Introduction Pablo Sabater**
>
> https://lore.kernel.org/git/CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5w=
Wi8YGA@mail.gmail.com
>
> **Description**: A mailing list thread where I introduced myself to
> the git community.
>
> ### Microproject
>
> **[GSoC PATCH v4] t9200: replace test -f/-d with modern path helpers**
>
> https://lore.kernel.org/git/20260312173305.15112-1-pabloosabaterr@gmail.c=
om/
>
> **Status**: Merged to `next` on 2026-03-12 at `8500bdf172`.
>
> **Description**: Replaces `test -f` with helper `test_path_is_file`,
> which makes debugging failing tests easier with better reporting.
> As suggested as microproject.
>
> ### Other contributions
>
> **[GSoC PATCH v2] test-lib: print escape sequence names**
>
> https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.c=
om/
>
> **Status**: Will merge to `next`.
>
> **Description**: In failed expected/actual checks printing, the escape
> sequences were shown as their octal code. This patch fixes that to
> print the actual escape sequence name, adds tests, and updates the
> expected output.
>
> **[GSoC PATCH] t9200: handle missing CVS with skip_all**
>
> https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.=
com/
>
> **Status**: Merged to `next` on 2026-03-12 at `8500bdf172`.
>
> **Description**: wraps CVS setup in a skip_all for clearer failure
> reporting and moves Git initialization into its own
> test_expect_success.
>
> **Re: [PATCH] gc: add git maintenance list command**
>
> https://lore.kernel.org/git/20260313115932.15259-1-pabloosabaterr@gmail.c=
om/
>
> **Description**: code review for a patch sent.
>
> **[GSoC] Proposal: Complete and extend remote-object-info for git cat-fil=
e**
>
> https://lore.kernel.org/git/CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=3D66rjeY=
=3DNqKbqRkhA@mail.gmail.com/
>
> **Description**: Proposal draft thread.
>
> **[GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-co=
mmand**
>
> https://lore.kernel.org/git/20260312214154.89120-1-pabloosabaterr@gmail.c=
om/
>
> **Description**: While testing Eric's v11 I've found and reported a
> new bug. On `remote-object-info` when it's preceded by a local query,
> `data->type` isn't being cleared. Causing it to return the wrong type.
>

Nice to see that you're proactive and already testing out the branch.

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

It's been a while, so this is expected. I guess the first week[s] would
mostly be getting this series up-to date.

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

I know this is the silent expectation, but nice to see it listed out.

>
> ## The Problem
>
> Eric Ju's work remains unmerged after v11 because of these issues:
>
>  - The format validation uses `strstr()` which only checks for
> `%(objectsize)`. This causes two different errors:
>    - Atoms that `expand_atom()` recognizes but the remote doesn't
> (`objecttype`,`deltabase`, ...), `expand_atom()` returns 1, but when
> accessing `data->type` it only contains garbage, causing segfault, as
> Jeff King noted [3].
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

Again, well done on the research. It is always nice to see the
requirements being listed out clearly which makes the objective clearer.

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
>
> #### Replace `strstr()` format validation with allow_list in `expand_atom=
()`
>
> `strstr()` isn't enough to fully validate the placeholders, it only
> searches for `%(objectsize)` and unsupported placeholders cause
> segfaults. Jeff King noted [4] that the fix was to refactor the
> validation with an allow_list in `expand_atom()` or `expand_format()`.
> The best option is to place the validation at `expand_atom()`, but why
> `expand_atom()` ?
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
>
> ### Goal 2: Adding `%(objecttype)`
>
> Following what Calvin Wan did in 2021 [8] for `%(objectsize)`, v2
> protocol needs to be extended on the server side to support the new
> `%(objecttype)` placeholder:
> - extend `object_info_advertise()` at `serve.c`
> - add .type to `requested_info` struct at `serve.c`
> - support `type` in `cap_object_info()` at `protocol-caps.c`
> - look for type at `send_info()` at `protocol-caps.c`
>
> Following object-info protocol docs [7] it should look like:
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
> #### Backward Compatibility
>
> There are four possible scenarios to happen between client and server:
>
> 1. **The server doesn't know type (new client but old server)**:
>
>    After receiving the server capabilities, a client will only request
> what the server advertises. The `allow_list` would handle this,
> returning an empty string when the server doesn't support it.
>
> 2. **The server knows type but the client doesn't (new server but old cli=
ent)**:
>
>    Following `gitprotocol-v2.adoc`, "Clients must ignore all unknown
> keys", it will ignore type, and request only the known capabilities.
>
> 3. **Both know type (new client and new server)**:
>
>    Server advertises type, client requests it and gets the type data.
>
> 4. **Both know type but protocol middleware doesn't (new client, new
> server but old middleware)**:
>
>    If a server advertises type but client doesn't receive type, a
> client won't ask for anything unadvertised, if a client asks for type
> but the server doesn't receive it, it will only return the known
> capabilities.
>
> **performance considerations**
>
> To get an object type, we have to look only at the header, to get the
> size `oid_object_info()` at `object-file.c` is being called which
> already returns the object type in the same call. Sending the string
> with the type will only be, worst case scenario 6 bytes for the
> "commit" string.
>
> ## Timeline
>
> I've designed this to work with enough time so final work can be
> shorter than what's said here
>
> May 1-24: Community Bonding
> - Keep working on my ongoing patches and new ones.
> - Talk and meet with mentor that I'm assigned with, to get feedback
> about my proposal, how I will report my progress apart from the code
> submitted and possible blogs, and tips and tricks to work better at
> Git.
> - Confirm with mentor that the `allow_list` approach is still the best op=
tion.
> - Draft commits structure.
> - Setup a blog to keep track about how GSoC at Git is going.
>
> Week 1-2: (May 26 - June 8)
> - Start Goal 1 fixes.
> - Fix style and code issues.
>
> Week 3-4: (June 9 - June 22)
> - Start with Goal 1 implementations (allow_list approach).
>
> Week 5-6: (June 23 - July 6):
> - Goal 1 should be polished or close to the final form.
> - Send patch series for Goal 1.
> - Start Goal 2.
> - Prepare the midterm report.
>
> **Midterm evaluation** (July 7 - 11) as specified on GSoC timeline docs
> - Goal 1 submitted.
>
> Week 7-8: (July 14 - July 27)
> - Start with server side v2 protocol extension (`%(objecttype)`).
>
> Week 9-10: (July 28 - August 10)
> - Add `%(objecttype)` to the `allow_list` from Goal 1.
> - Client side extension.
> - End to end tests and documentation.
> - Default format becomes `%(objectname) %(objecttype) %(objectsize)`.
> - Send patch series.
>
> Week 11-12: (August 11 - August 24)
> - Goal 2 should be close to be done.
> - Polish everything, all tests pass, good test coverage, no
> style/comment issues.
> - Final documentation review.
> - Prepare for final evaluation.
>
> **Final evaluation** (August 18-24) as specified on GSoC timeline docs
>
> ### Additional objectives
>
> If there is enough time, or for future work after the project. I've
> some ideas on how this could evolve:
>
> #### More placeholders support
>
> I've checked that Eric's v11 patch only supports `%(objectsize)` on
> server side, but on the client side there are other placeholders that
> can be added too. With the `allow_list` and having Goal 2 implemented,
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
>
> In a partial clone, someone might want to know what blobs are missing
> inside a concrete tree and their size before fetching them.
> The idea is to build on top of `remote-object-info`:
> Given a tree hash, return the missing blobs (inside that tree) ordered by=
 size.
>

You might want to look 'git-backfill(1)', I recall there was some
thoughts on extending that command to do something similar. But I don't
remember on the top of my head.

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
>
> [8]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@googl=
e.com/#t
> "Calvin Wan's patch series"
>
> ---
>
> Again, thanks a lot for the feedback.

Regards,
Karthik

--0000000000004b890f064d2b09bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c2adba721917f2a3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNGVFUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMm5BQy8wZkZXRE42Nis3STltcXhaa0p6SERLQUpBNwpsYlpXUzRTKytC
czFvRG8rWWJwd29oVnV5MlQ5QWtWNnRUY21mbWRZMTdSWkduMTZVUHpObXYyOHF4ckVKa015CjZC
RmlMdXZoanhpcXRDUDRVQVg0aUdqTjU1SVZkUGFwMklZTGJsQjZ1cU5XaWEveEZLRWF6Y21BRjhw
WU5LZm0KTXI3M3J5ZjZXN2tGNzZlc3ovWjl2ZDBaS2pCTW81NURtenl4bks5ODZGTmo0QllwdUQx
ektMVDNKdUEzRjFQRAp0MksvRjMzL1FHSElFR3d5WU5kYm5nUGRvaTY2NlRqdG50OVVxcHV0OGNP
R3h1SStWTFoyYUhRNHJGaXBJc1poClFHTEx4dDF6eHhhNUc3VDNzVzcrS3dPdElRa3prRWVUM3p4
OERTWUNDSjg5WUd5ZmhaQnBzNkxGdzNaM00rbG4KUld3RFpWU213NFRtTUllNGM4cUNvRjIyeVNW
WU51TDErc0ZseDJ6NHVVTnBqczRVT0dKZW8vVnFiZ0VmVEVHbQpHazlFNUhUMjdXTzZTdUlVRE01
R3JUNnkzenZPaTVFZlZ5SllWZTlCQldQN1dqVFVYdWFuZm5YbXRYQVpMTElhCnZ2djZXMFZJdUl3
WjlSc3pwRGZVNlFsSk92WG9HNkl6eTRVak16OD0KPW4vRkoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004b890f064d2b09bc--
