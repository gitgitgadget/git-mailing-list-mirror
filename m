Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C591A6802
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773566489; cv=pass; b=tnC5vveoCrbYY40toFF2WMmb+rYmofxtFKZ0/zHp/BSfslyG5PhwsOhdqJXSfWGcU4rzVcNx5EquoMPuJfrEExBMC+L2/TVqNzft+UMHu2hvsChCe+8ILSKPEEapfWXd7Gqbo3hEwXgw7kjy0CTqWyilYJaFbkG3SHls80brJXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773566489; c=relaxed/simple;
	bh=dbGep8uqX3N5z2fmsxvsQWKKtgjkLt9BjiXX+S8/3Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jc/MfxNBQYeoG/bKkCFxfsS1F0fdZNtOt1lt/WnvPbW6X61iirPCn6CIAge7kJaTelF+emh2IVgJuWniptaMsiwoWgNXJgFQa0dWrQJoNgxub7YNts9dJIlxZx7mriM31QBPp9CqwCx8zIz1mvyTKte/mHOzib6bXdX7P16ydLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXRD6Ds4; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXRD6Ds4"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso5063516a12.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773566486; cv=none;
        d=google.com; s=arc-20240605;
        b=AojyR7O7dlflePpe6FwFBHrrdpuau/bJjbZLLRUigoOrJaJ/Y1oiekD/FPaSiRDZRK
         oQSbLSEI1l2MlvN7VNvXRyJIs0XODCHfdm/MTyYs4k8V4c6nFYr5W9me83/nUp8BakUz
         CQdRXyGrU5A1ponaqKX/cROR3+298w6wkSGWqTDb2R/HICaJ5C+zXRqcFn+X+4ezfX+9
         f0d+p8SC+7xrwTC8f75B7P6QZ5aTmAn/8+uNCGghGdtrkP5bw1XBP/JFvAuZuxM5Rond
         3HY5KlpjDGAAiJQ1XS+TVe4fLNMzJaA1f3ZY6EYMDfJNrckUdmoAKRTlnpXF+Jtmi12R
         NQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NO6Hq6xDq0sNhwxvCdexyhsGSaxTRUHc0zBevRhZ5pk=;
        fh=B7tQVbxLGDVdUp5OnJwJZ1OcDVmTE69vrypiXV3/Tig=;
        b=irtAwIwFY+o1nXU2LEPMyr4OIJ0zqfuiEv2K9pxOy9rIqv1RIAsiLB4tkTm+xzkhMT
         uUPzrbLazHvyd7vmp/oIsxME9Z4q9CBhgFSSSGaFRPgq6bl8H0Ku0eEibTh9dyjUYDK7
         QPBicsN6p6iTcJN6Yl1tNNeJrOXQoGg6+z6le6KoS55rQyKCdUv2JWe4rxuiU6m7Pj5T
         OXc4soJb5cnIoG8ovVKhB9uja5W9yUC0XT8vdHZooTMDDQQ7sC/mKJ4LdIIXUEEHOYA9
         yEQEAlrJbNBQj8vfk9nnieC+ZVdSxHCivDzBAYwNNGddzBAxiWY9p0wGt7t7AOlfIMWE
         iGcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773566486; x=1774171286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO6Hq6xDq0sNhwxvCdexyhsGSaxTRUHc0zBevRhZ5pk=;
        b=BXRD6Ds4g5PcLstrZamrrEqO8pmymO5vLb9P4R6RH9PY3NB9Dw0nKCcr9fJhs/HdHs
         8vkFve1Qm9ESs6PWOyaf8ChtGhLMxu+5wdwISu1eUQ3a3RKvnphByuWy2h1qmCFJ2tOx
         Oo6wNyVRZ/+fcKuqrOPu+T1uk70jMuCwcVn2VBQ5Uzyi0zpS1Q9Ed+4Wnblc5exOobju
         TSu/kOMEIcOCQoG+M95h89h/jTe0N4QMawDwUJg1HpHHlZ7lxpPYqGKJG/Nw9ewzcfn6
         bgIgxEf0Jpi0ct92Pnr6idCpJbjlDNKPpirokIzUEkrQRTg2CPz+0ROMMsaOyKXgavsY
         52Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773566486; x=1774171286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NO6Hq6xDq0sNhwxvCdexyhsGSaxTRUHc0zBevRhZ5pk=;
        b=LwU1NUgJitNlHJEJglM3kyA2IBYVCSUsnamr1/TlzsETc8F+OEF2eChSS3Su0X051j
         j7jT5cIrlhAawSGHWqQiwzPHzVbW458O5+kL4jzjoIGEp9/7fOv08KpQ8UyDVCsZkCSw
         9uHW5FFWDT/myl88iilXVv4RNLBuDx4dxInJ+EHXoSjWCtkiS9xLaszcULLfk++GeIUj
         uaI1SN8UjHWVVVX2TmcwrNtUfE3gbCHpNgS9dSLhS1RVwSt5N6PFEMkW+wLZoFFeDpx/
         W5OFWE3XNGFQTZlr2zXSRjWGkUmVF0uwmt8gumo5391Bwc0RMFAeDz9pgWa0cfbkMFXb
         /8tw==
X-Gm-Message-State: AOJu0Yy/BRyA74WFuvLkIJ9/Qc/FhAPSxm4BNSCLaIdh6njdsiw7s7lP
	lFaSdVuFNZpG2p4PjF6Fq8jwhwqqNC8XujDRB9T8OyuU9yBlDsPAzk/QljShRZFq1TqCdlW+di/
	Z543T+k9FOBhD8CHevm9cwf2l3utoN/I=
X-Gm-Gg: ATEYQzzcXFIzcR53Q+LnurL5IC6p1Jpy3PwQ/5nuQwnRLS+3lHICPYG6DkoOY/SCI/F
	dbNW7RPjwXr9AOunzFJPgNlc31basSNu8T8Vp3NDwJZpnMnx340Eue1VXkKQhtm7A02Z4A4TzkR
	4Yr8t1uLyIA/mwvEy106Al2yzmI5RO8sKeqwd73A1zeGs+wjHoX6ZTffrE0pgZALCFE45NQfd6z
	G9spnPn3QZ8bLp9abmO1Qnwncc1urn29CsnJguAF5yi0CmI2t6BMybaVn3IOjJOELeliYQVkUcJ
	Qum6Vywgqw==
X-Received: by 2002:a05:6402:5212:b0:65c:cda:4c27 with SMTP id
 4fb4d7f45d1cf-663ba9b7762mr4966874a12.1.1773566485308; Sun, 15 Mar 2026
 02:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
 <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com> <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
In-Reply-To: <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 15 Mar 2026 14:50:58 +0530
X-Gm-Features: AaiRm50U2lzX5VcV2ZsPOeyvP9PbydbEPcG0FbpZktyjb-EWJazyGp3MWt7Nsxw
Message-ID: <CA+J6zkSE1ek2einA=CimH0TNoR8Ou_-acp88hhtC5qV09-Xu5w@mail.gmail.com>
Subject: Re: [GSoC] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Mar 2026 at 00:01, Pablo <pabloosabaterr@gmail.com> wrote:
>
> Hi Chandra, thanks a lot for the feedback! :)
>
> > You should upload your proposal on the GSoC website and add the link to=
 it here.
> > The proposal can be then updated later as many times as you like.
>
> GSoC proposals opens March 16th, for now I'll send my v2 here and as
> soon as I can I'll swap to GSoC website and send the link to the
> thread.

I don't think you need to do this, just make sure you include the link when
you send your revised proposals in the future.

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

Quickly skimmed over the new proposal and it definitely looks better
now. Great job!

>   Removed most of the duplicated iteration on the Timeline from The
> Problem. (feels a bit empty now tho).

This is fine because you've already discussed the relevant details in earli=
er
sections.

You could think of fleshing it out with new information, but duplicating de=
tails
just for the sake of a 'fuller' proposal waters down the impact of the rest=
 of
your work. There isn't a word count requirement after all :)

>
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
