Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAD3368B5
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464015; cv=pass; b=OoxaAMz9esrafyp82d7cXffmlJzsJDuULxp8i5gp7QNESHLK954iB9RXuP2KYn2ltCedpvfdIjIH6BWqxXjvoGnYuZhuD/fOG7nnPRGH2vKPXRRl+L7C3H6z2xP+6ixb+g90VVH2Yz5Scfzc87bdCRQnYmuW4FnQqGnJGvSAmJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464015; c=relaxed/simple;
	bh=0YoZyjkDuIKXBzID9+X4WIWXRmtyc8oA1lFILyy5MI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVG9e+r4kqkfEGEQNCawkdq8qIZHuD4U/zfzR64HxK+M0ek0uzGJF25SoKnV8oy6bpA0UkrAipg80wssqfiqLNtcEhMvCqybGIHOrP/LCeD0oVy7YQsY6UWut9g9RFTCy0Kzb4UKuX8hhpaQZCIz5jgJKRGUAULOqCPTv1F4Q1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQarsAfi; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQarsAfi"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso22135166b.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464011; cv=none;
        d=google.com; s=arc-20240605;
        b=kyoqqTuj8RGN9+GEIGsa0dsX5pwP0ZoFy78J4PkChDhNCiWNhKtTCpEcVGUux8ZfxO
         yoLlET75nfwXeIuGT+/1GiO8XwdIfVzHeObzgU32wDSDFNB8rUOhM4flnId+tu5DGCsM
         /5igc3mP6p7nVwDUT7Rz4aZ6qU9qWqcQeAjlcNsL7nLfhWtN/WUV6sfedQB12AlrnMip
         1WWBgwizoBgRkPTdGxiVSnN3ikC7mtUlCOvTxRaWchLgSVoCFR/0P4JOikRRlqVHCfkl
         MhA3SJN8Oy0UBvX0r/gcaEUeNHDL3W0f4A8YDNzZkC6bTZ27At6Rn5YrWbC4iGiIbKYV
         QteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVmoViznrXshhpoGr0Hdiiqx3lZmfJ4gNP+q48gHWZM=;
        fh=99CoRlyez3AkiifBSXw68uGNsgPpwO3OqeReCBBNCzE=;
        b=WAbmOyUe+kSCNu87fuzvSg1IkdbtuiEqmSqPGTIc731RBrJoVIfqr1q5C0uNvB4SDc
         euylj9uvGNUVPublrWZaZRXU2NA+8OLt49RM8sOfXrxc23KJTPbc4O2F6r2R94O7232j
         kSeCGfBT1hLsJrR0dfY6yJDz2B/xnc8izd7DxlstIworSuEZ+srVbjhMdK9G9ujo5mPp
         di6FJcFwQ/Lb9k+CUXTtei3crvje4N0PLfcNRxqQxFUDXYHWcMibxpuQ9ZK7fX0kJ0TS
         RkOScRiSt6wHSk9fMUnfSvAUN13HIczJssp97Vfl9A/nf+tjdvf7nrVvQeOuvPU4V3pT
         8Z5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464011; x=1775068811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVmoViznrXshhpoGr0Hdiiqx3lZmfJ4gNP+q48gHWZM=;
        b=TQarsAfiHI7be7jgJ4fuSX1gyhwWi0wsoXLGDODyPg4XuGVTVdz0/niDoBMbiyuqJb
         B1WrNidWtPtEDPDEYdpDSIZ+laiTc0UHgFO0EQrL3jZZTYd1u09qraG4upwcQEOAWFGp
         IA/XW6OlS/44boH2Cf44Bi7lxMtDlYxglquyCVo0E4phm5eCfUlu9A0RooK3X+Zu3LRy
         RlaN3KxmDOOtFG1OhdAWmgMSYP5MqhpUHLaGYaE5QM33XiaDZufbBvP9krVRfP//dNeW
         G4agoVbjXH3WSAmVcD4iy4Oys6RN3sDSys/VJlwiAt8e/NpuNKsxdEH4UyI3HOC94WEW
         DK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464011; x=1775068811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVmoViznrXshhpoGr0Hdiiqx3lZmfJ4gNP+q48gHWZM=;
        b=RRDflO86yBhNGlNkwchbARiFKpCcPXD59gYOP6Zz+upsCNnUxnQUXCv4cs/f74g1Gf
         a89gzB3ORuECo5MUFL1e0r6i6wyC9CQLnwrXMfHHXzXh9n31kEU0cB8vTRSRyFcchJV3
         sw3GljDw8prrtoTy4hvQztce5bYKc3SnovbXO7jp9spFsz59mvjCVrbr2xQf7luJp9iW
         QWhq/9o4XIecLA8ke65BYh8LGHJ94WTTodcZPzMu5LSH0Bq0M5pVTWt3oaPVgecSAhl4
         ku9dSwal6O1u5KrASSxgV7b36kfwnFEC2XFMcTtCwDcLmn5/j1GUtcFS0RF3AE+nbTMJ
         6XrA==
X-Gm-Message-State: AOJu0YyNJUWl7uuEGJQ1DGUw1cX4KPCnMG2m78uu6vz/Z+1TzGtUjmmM
	FERNJeKVzZjnK1MSmL7G6exjGDk6+eGHpvzk0+p5s5l5tDtrgvAhW2ONWhDHmEwXPNkMVMJBGxW
	8rkkIWju9j3t1eHAImAuSlUCtaNrRv/j1xAM2
X-Gm-Gg: ATEYQzweFc2ivJ2lh8zbAfOvvdV3oWycaTnbPKmQ6cc0qFpz085qeOtK4NjRJkKDln2
	heV98oU7PG0RpJ+GaytBGdoWp982rlf2eUWRXgp/URoWTo8osTp6FIw0Hu5USl6esDr5P5aUYl2
	lPL87/Rc13SJI7paKa2zAtIdNN/HJtYFFraWeQQmVpNT3+6zmmzFMfwgFLvvlnj/l1WkA95Aw/e
	+D4rK1K2NBrXyvg7KN+ZcNGcbBd2jBzgwMHfGjIjonAYLD0q6CN4EuW0iYokUS/9rWUcjxerVfX
	bOIa2slMHNWyBewUu1/GkVDUWOmEjDdIKcTm7yBw9y2gPtBfFOZfpZ/73Q3vmvOxLwJPRJ5yLg=
	=
X-Received: by 2002:a17:907:806:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b9a3f19f050mr364581366b.15.1774464010642; Wed, 25 Mar 2026
 11:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075055.354709-1-luizedc1@gmail.com> <20260325075055.354709-2-luizedc1@gmail.com>
 <2a0ccbfe-3d26-4146-89ed-3b942bdc861e@gmail.com>
In-Reply-To: <2a0ccbfe-3d26-4146-89ed-3b942bdc861e@gmail.com>
From: Luiz Eduardo Campos <luizedc1@gmail.com>
Date: Wed, 25 Mar 2026 15:38:50 -0300
X-Gm-Features: AQROBzB_t5FW08WSaZYbn6UXpA5WY5S6-rrhq_N6ofjoL9tupPs309Ry_BnqKaw
Message-ID: <CAN+A6TtxG_-WuzvAxwoRB_dz4swFbjFG8me09WsShboQWKwang@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, peff@peff.net, sagotsky@gmail.com, 
	Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

Thanks for the thorough review.

> it is rather unexpected for "git add" to modify the working copy

I share that concern. My motivation was allowing stage-and-discard in
a single pass, which I find myself wanting regularly, and discussion in
the linked thread suggested it could live in add -p. That said, I can
see the argument that git add modifying the worktree breaks the mental
model. I'm open to discussing whether a separate command or a flag on
git restore -p would be a better home for this =E2=80=94 the implementation
would be largely the same either way.

> It would be simpler just to take USE_HUNK or DISCARD_HUNK as an argument

Agreed. I'll drop both the merge_for_discard boolean and the enum
reassemble_mode, and instead pass the desired hunk type directly
(USE_HUNK or DISCARD_HUNK) through reassemble_patch,
merge_hunks, and should_merge_hunk. That removes the indirection
entirely.

> There's no need to add braces here

Right, the project style omits braces for single-statement blocks.
I'll drop them.

> I'm not sure this is an improvement =E2=80=94 it certainly makes the patc=
h harder to
> read because you end up changing the indentation of otherwise unchanged
> lines that were in the else clause.

> This is unchanged code that re-indented because of the addition of
> "continue" above.

Good point. With the simplified should_merge_hunk() taking a hunk
type, I can keep the original if / else structure in
reassemble_patch() and just swap out the condition. That avoids the
continue rewrite and the indentation churn entirely.

> We need to tell render_hunk whether a hunk is being applied in reverse or
> not so that it knows whether to apply delta to the old offset or the new =
offset.

You're right. I was wrong to think the delta direction would be the same as=
 for
staging. For the discard patch, skipped hunks' changes are still present in
the worktree, so the new_offset (worktree side) is already correct and must=
 not
be adjusted. The adjustment needs to go to old_offset instead =E2=80=94 exa=
ctly the
is_reverse =3D 1 behaviour. This is consistent with patch_mode_checkout_ind=
ex,
which does the same operation (diff-files + apply -R to worktree) and
sets is_reverse =3D 1.

I'll temporarily flip is_reverse (or pass an explicit flag to render_hunk) =
when
assembling the discard patch, and add the split-hunk tests below to confirm=
 the
offsets come out correct.

> It would be nice to avoid showing this for 'checkout -p' etc.

The help text display already filters lines from
help_patch_remainder against the options present in s->buf
(the prompt string). Since 'x' is only added to the prompt in
patch_mode_add, the "x - discard..." line will already be suppressed
for checkout -p, reset -p, etc.

I'll add a comment in the next version to make that clearer, and add a
test that verifies checkout -p help output does not mention 'x'.

> Why do we need to run "git apply --check" here?

We don't =E2=80=94 the existing staging codepath in apply_patch does not ru=
n a
separate --check before applying either; it just runs git apply
directly and checks the exit code. I'll do the same and remove the
redundant --check pass.

I'll remove the redundant check and just run git apply -R directly.

> Isn't this comment still relevant?

Yes, I'll restore it. I removed it by accident when restructuring the
function; it still applies to the USE_HUNK scan that follows.

> What's the point of this change?

There is none =E2=80=94 it's an accidental whitespace change on the alignme=
nt
of the (!file_diff->hunk_nr continuation line. I'll drop it.

> So 'x' is only permitted if 'e' is =E2=80=94 what's the reason for that?

The nesting was unintentional, but the conditions guarding 'e' =E2=80=94
hunk_index + 1 > file_diff->mode_change and
!file_diff->deleted =E2=80=94 do also apply to 'x', since reverse-applying
a mode-change or deletion hunk is not meaningful.

However, the ADD_P_DISALLOW_EDIT flag (used by git history split)
should not gate 'x'. I'll give 'x' its own block that checks only
mode_change and deleted, independent of ALLOW_EDIT.

> I'm not sure why this test needs to be in a separate repository

The sub-repo was a workaround: the test creates a commit
(git commit -m base), and that extra commit shifted the history and
caused later tests that depend on specific HEAD state to fail.

Instead, I'll rework the test to use a file already tracked in the
shared repo, dirty it, run git add -p with 'x', and clean up with
test_when_finished. No extra commit needed.

> It would be nice to see tests that split a hunk [...] and pathological co=
ntext lines

Agreed. I'll add tests that:

(1) split a three-subhunk change (-a/+A, -c/+C, -e/+E), stage the
first and third, and discard the second
(2) the inverse =E2=80=94 discard the first and third, stage the second
(3) a pathological-context case along the lines of 2bd69b9024c

Thanks again for the review =E2=80=94 very helpful.

Luiz

Em qua., 25 de mar. de 2026 =C3=A0s 13:24, Phillip Wood
<phillip.wood123@gmail.com> escreveu:
>
> Hi Luiz
>
> On 25/03/2026 07:50, Luiz Campos wrote:
> > When using `git add -p`, users can stage or skip hunks,
> > but cannot discard unwanted changes from the working tree.
> >
> > Introduce a new 'x' action to discard the current hunk by
> > reverse-applying it.
> >
> > This idea was suggested in a previous mailing list discussion:
> > https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.ne=
t/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0
>
> I tend to agree with peff's comments in that thread that it is rather
> unexpected for "git add" to modify the working copy. I also think that a
> command that lets you stage some changes and discard others could be
> useful as I do both fairly frequently from my editor. Regardless of
> whether we want a new command the implementation will be similar so I've
> left some comments on the code below.
>
> > diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> > index 941135dc63..0ab81e5615 100644
> > --- a/Documentation/git-add.adoc
> > +++ b/Documentation/git-add.adoc
> > @@ -351,12 +351,15 @@ patch::
> >          K - go to the previous hunk, roll over at the top
> >          s - split the current hunk into smaller hunks
> >          e - manually edit the current hunk
> > +       x - discard this hunk from the worktree
> >          p - print the current hunk
> >          P - print the current hunk using the pager
> >          ? - print help
> >   +
> > -After deciding the fate for all hunks, if there is any hunk
> > -that was chosen, the index is updated with the selected hunks.
> > +After deciding the fate for all hunks, any hunks marked for
> > +discard are removed from the working tree (reverted to the index
> > +version for those lines).  Then, if there is any hunk chosen for
> > +staging, the index is updated with those hunks.
>
> Makes sense.
>
> >   +
> >   You can omit having to type return here, by setting the configuration
> >   variable `interactive.singleKey` to `true`.
> > diff --git a/add-patch.c b/add-patch.c
> > index 4e28e5c187..ea38ab453e 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -259,7 +259,7 @@ struct hunk_header {
> >   struct hunk {
> >       size_t start, end, colored_start, colored_end, splittable_into;
> >       ssize_t delta;
> > -     enum { UNDECIDED_HUNK =3D 0, SKIP_HUNK, USE_HUNK } use;
> > +     enum { UNDECIDED_HUNK =3D 0, SKIP_HUNK, USE_HUNK, DISCARD_HUNK } =
use;
> >       struct hunk_header header;
> >   };
> >
> > @@ -884,17 +884,35 @@ static void render_diff_header(struct add_p_state=
 *s,
> >       }
> >   }
> >
> > +static bool should_merge_hunk(struct file_diff *file_diff,
> > +                           size_t hunk_index, int use_all,
> > +                           int merge_for_discard)
> > +{
> > +     if (use_all)
> > +             return true;
>
> If we're looking for hunks to discard then we want to return false if
> all the hunks have been selected to be staged.
>
> > +     return merge_for_discard
> > +             ? file_diff->hunk[hunk_index].use =3D=3D DISCARD_HUNK
> > +             : file_diff->hunk[hunk_index].use =3D=3D USE_HUNK;
>
> It would be simpler just to take USE_HUNK or DISCARD_HUNK as an argument
> rather than a boolean here.
>
> >   /* Coalesce hunks again that were split */
> >   static int merge_hunks(struct add_p_state *s, struct file_diff *file_=
diff,
> > -                    size_t *hunk_index, int use_all, struct hunk *merg=
ed)
> > +                    size_t *hunk_index, int use_all, struct hunk *merg=
ed,
> > +                    int merge_for_discard)
>
> Taking the type of hunk we want to retain (USE_HUNK or DISCARD_HUNK)
> would avoid having to convert merge_for_discard back into the hunk type
> in should_merge_hunk().
>
> >   {
> >       size_t i =3D *hunk_index, delta;
> >       struct hunk *hunk =3D file_diff->hunk + i;
> >       /* `header` corresponds to the merged hunk */
> >       struct hunk_header *header =3D &merged->header, *next;
> >
> > -     if (!use_all && hunk->use !=3D USE_HUNK)
> > +     if (!should_merge_hunk(file_diff, *hunk_index, use_all, merge_for=
_discard)) {
> >               return 0;
> > +     }
>
> There's no need to add braces here
>
> > @@ -1014,11 +1032,13 @@ static int merge_hunks(struct add_p_state *s, s=
truct file_diff *file_diff,
> >
> >   static void reassemble_patch(struct add_p_state *s,
> >                            struct file_diff *file_diff, int use_all,
> > +                          enum reassemble_mode mode,
> >                            struct strbuf *out)
> >   {
> >       struct hunk *hunk;
> >       size_t save_len =3D s->plain.len, i;
> >       ssize_t delta =3D 0;
> > +     int merge_for_discard =3D (mode =3D=3D REASSEMBLE_DISCARD);
>
> It would by simpler just to take USE_HUNK or DISCARD_HUNK as a parameter
> and pass that to reassemble_patch() rather than forcing the caller to
> pass an enum that we then transform to a boolean.
>
> >
> >       render_diff_header(s, file_diff, 0, out);
> >
> > @@ -1026,25 +1046,26 @@ static void reassemble_patch(struct add_p_state=
 *s,
> >               struct hunk merged =3D { 0 };
> >
> >               hunk =3D file_diff->hunk + i;
> > -             if (!use_all && hunk->use !=3D USE_HUNK)
> > +             if (!should_merge_hunk(file_diff, i, use_all, merge_for_d=
iscard)) {
> >                       delta +=3D hunk->header.old_count
> >                               - hunk->header.new_count;
> > -             else {
> > -                     /* merge overlapping hunks into a temporary hunk =
*/
> > -                     if (merge_hunks(s, file_diff, &i, use_all, &merge=
d))
> > -                             hunk =3D &merged;
> > +                     continue;
>
> I'm not sure this is an improvement - it certainly makes the patch
> harder to read because you end up changing the indentation of otherwise
> unchanged lines that were in the else clause.
>
> > +             }
> >
> > -                     render_hunk(s, hunk, delta, 0, out);
> > +             if (merge_hunks(s, file_diff, &i, use_all, &merged,
> > +                             merge_for_discard))
> > +                     hunk =3D &merged;
> >
> > -                     /*
> > -                      * In case `merge_hunks()` used `plain` as a scra=
tch
> > -                      * pad (this happens when an edited hunk had to b=
e
> > -                      * coalesced with another hunk).
> > -                      */
> > -                     strbuf_setlen(&s->plain, save_len);
> > +             render_hunk(s, hunk, delta, 0, out);
>
> We need to tell render_hunk whether a hunk is being applied in reverse
> or not so that it knows whether to apply delta to the old offset or the
> new offset. Currently it uses s->mode->reverse but that will not be
> correct for the patch that discards changes from the working tree. I'm
> not sure what the best way of doing that is, the simplest approach is to
> invert s->mode->reverse when we want to keep hunks marked DISCARD_HUNK
> and then restore the original value.
>
> > -                     delta +=3D hunk->delta;
> > -             }
> > +             /*
> > +              * In case `merge_hunks()` used `plain` as a scratch
> > +              * pad (this happens when an edited hunk had to be
> > +              * coalesced with another hunk).
> > +              */
> > +             strbuf_setlen(&s->plain, save_len);
> > +
> > +             delta +=3D hunk->delta;
>
> This is unchanged code that re-indented because of the addition of
> "continue" above.
>
> >       }
> >   }
>
> > @@ -1540,6 +1562,7 @@ N_("j - go to the next undecided hunk, roll over =
at the bottom\n"
> >      "/ - search for a hunk matching the given regex\n"
> >      "s - split the current hunk into smaller hunks\n"
> >      "e - manually edit the current hunk\n"
> > +   "x - discard this hunk from the worktree\n"
>
> It would be nice to avoid showing this for 'checkout -p' etc.
>
> >      "p - print the current hunk\n"
> >      "P - print the current hunk using the pager\n"
> >      "> - go to the next file, roll over at the bottom\n"
> > @@ -1547,21 +1570,57 @@ N_("j - go to the next undecided hunk, roll ove=
r at the bottom\n"
> >      "? - print help\n"
> >      "HUNKS SUMMARY - Hunks: %d, USE: %d, SKIP: %d\n");
> >
> > +static int apply_discard_hunks(struct add_p_state *s,
> > +                            struct file_diff *file_diff)
> > +{
> > +     struct child_process check_cp =3D CHILD_PROCESS_INIT;
> > +     struct child_process apply_cp =3D CHILD_PROCESS_INIT;
> > +
> > +     strbuf_reset(&s->buf);
> > +     reassemble_patch(s, file_diff, 0, REASSEMBLE_DISCARD, &s->buf);
> > +
> > +     discard_index(s->index);
> > +
> > +     setup_child_process(s, &check_cp, "apply", "-R", "--check", NULL)=
;
> > +     if (pipe_command(&check_cp, s->buf.buf, s->buf.len, NULL, 0, NULL=
, 0)) {
> > +             error(_("'git apply -R --check' failed"));
> > +             return -1;
> > +     }
>
> Why do we need to run "git apply --check" here?
>
> > +     setup_child_process(s, &apply_cp, "apply", "-R", NULL);
> > +     if (pipe_command(&apply_cp, s->buf.buf, s->buf.len, NULL, 0, NULL=
, 0)) {
> > +             error(_("'git apply -R' failed"));
> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static void apply_patch(struct add_p_state *s, struct file_diff *file=
_diff)
> >   {
> >       struct child_process cp =3D CHILD_PROCESS_INIT;
> >       size_t j;
> > +     int needs_refresh =3D 0;
> > +
> > +     if (s->mode =3D=3D &patch_mode_add) {
> > +             for (j =3D 0; j < file_diff->hunk_nr; j++) {
> > +                     if (file_diff->hunk[j].use =3D=3D DISCARD_HUNK)
> > +                             break;
> > +             }
> > +             if (j < file_diff->hunk_nr && apply_discard_hunks(s, file=
_diff))
> > +                     return;
> > +             if (j < file_diff->hunk_nr)
> > +                     needs_refresh =3D 1;
> > +     }
> >
> > -     /* Any hunk to be used? */
>
> Isn't this comment still relevant?
>
> >       for (j =3D 0; j < file_diff->hunk_nr; j++)
> >               if (file_diff->hunk[j].use =3D=3D USE_HUNK)
> >                       break;
> >
> >       if (j < file_diff->hunk_nr ||
> > -             (!file_diff->hunk_nr && file_diff->head.use =3D=3D USE_HU=
NK)) {
> > -             /* At least one hunk selected: apply */
> > +         (!file_diff->hunk_nr && file_diff->head.use =3D=3D USE_HUNK))=
 {
>
> What's the point of this change?
>
> >               strbuf_reset(&s->buf);
> > -             reassemble_patch(s, file_diff, 0, &s->buf);
> > +             reassemble_patch(s, file_diff, 0, REASSEMBLE_STAGE, &s->b=
uf);
> >
> >               discard_index(s->index);
> >               if (s->mode->apply_for_checkout)
> > @@ -1574,13 +1633,15 @@ static void apply_patch(struct add_p_state *s, =
struct file_diff *file_diff)
> >                                       NULL, 0, NULL, 0))
> >                               error(_("'git apply' failed"));
> >               }
> > -             if (read_index_from(s->index, s->index_file, s->r->gitdir=
) >=3D 0 &&
> > -                 s->index =3D=3D s->r->index) {
> > -                     repo_refresh_and_write_index(s->r, REFRESH_QUIET,=
 0,
> > -                                                  1, NULL, NULL, NULL)=
;
> > -             }
> > +             needs_refresh =3D 1;
> >       }
> >
> > +     if (needs_refresh &&
> > +         read_index_from(s->index, s->index_file, s->r->gitdir) >=3D 0=
 &&
> > +         s->index =3D=3D s->r->index) {
> > +             repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
> > +                                          1, NULL, NULL, NULL);
>
> We now wait until we've applied both patches before refreshing the index
> - sounds sensible.
>
> > +     }
> >   }
>
>
> > @@ -1722,6 +1784,10 @@ static size_t patch_update_file(struct add_p_sta=
te *s,
> >                           !file_diff->deleted) {
> >                               permitted |=3D ALLOW_EDIT;
> >                               strbuf_addstr(&s->buf, ",e");
> > +                             if (s->mode =3D=3D &patch_mode_add) {
> > +                                     permitted |=3D ALLOW_DISCARD;
> > +                                     strbuf_addstr(&s->buf, ",x");
> > +                             }
>
> So 'x' is only permitted if 'e' is what's the reason for that?
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > [...]
> > +test_expect_success 'add -p discard removes worktree change' '
> > +     test_when_finished "rm -rf discard-testrepo" &&
> > +     mkdir discard-testrepo &&
>
> It's nice to see a test for 'x', but I'm not sure why this test needs to
> be in a separate repository - why can't it use the same repository as
> the other tests?
>
> > +     (
> > +             cd discard-testrepo &&
> > +             git init -b main &&
> > +             echo clean >discard-me &&
> > +             git add discard-me &&
> > +             git commit -m base &&
> > +             echo extra >>discard-me &&
> > +             test_write_lines x | git add -p discard-me &&
> > +             printf "clean\n" >expect &&
> > +             test_cmp expect discard-me &&
> > +             git diff --cached >tmp &&
> > +             test_must_be_empty tmp
>
> It would be nice to see tests that split a hunk like
>
> -a
> +A
>   b
> -c
> +C
>   d
> -e
> +E
>
> and then (1) stage the first and third sub-hunks and discard the second,
> (2) discard the first and third sub-hunks and stage the second. It would
> also be nice to see a test that discards a hunk with pathological
> context lines - see 2bd69b9024c (add -p: fix checkout -p with
> pathological context, 2019-06-12) for an example.
>
> Thanks
>
> Phillip
>
>
> > +     )
> > +'
> > +
> >   test_expect_success 'setup expected' '
> >       cat >expected <<-\EOF
> >       diff --git a/non-empty b/non-empty
> > @@ -521,13 +539,13 @@ test_expect_success 'split hunk setup' '
> >   test_expect_success 'goto hunk 1 with "g 1"' '
> >       test_when_finished "git reset" &&
> >       tr _ " " >expect <<-EOF &&
> > -     (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,=
3          +15
> > +     (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? + 1:  -1,2 +=
1,3          +15
> >       _ 2:  -2,4 +3,8          +21
> >       go to which hunk? @@ -1,2 +1,3 @@
> >       _10
> >       +15
> >       _20
> > -     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> > +     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?=
_
> >       EOF
> >       test_write_lines s y g 1 | git add -p >actual &&
> >       tail -n 7 <actual >actual.trimmed &&
> > @@ -540,7 +558,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
> >       _10
> >       +15
> >       _20
> > -     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> > +     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?=
_
> >       EOF
> >       test_write_lines s y g1 | git add -p >actual &&
> >       tail -n 4 <actual >actual.trimmed &&
> > @@ -550,11 +568,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
> >   test_expect_success 'navigate to hunk via regex /pattern' '
> >       test_when_finished "git reset" &&
> >       tr _ " " >expect <<-EOF &&
> > -     (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @=
@
> > +     (2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? @@ -1,2 +1,3=
 @@
> >       _10
> >       +15
> >       _20
> > -     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> > +     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?=
_
> >       EOF
> >       test_write_lines s y /1,2 | git add -p >actual &&
> >       tail -n 5 <actual >actual.trimmed &&
> > @@ -567,7 +585,7 @@ test_expect_success 'navigate to hunk via regex / p=
attern' '
> >       _10
> >       +15
> >       _20
> > -     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> > +     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?=
_
> >       EOF
> >       test_write_lines s y / 1,2 | git add -p >actual &&
> >       tail -n 4 <actual >actual.trimmed &&
> > @@ -579,11 +597,11 @@ test_expect_success 'print again the hunk' '
> >       tr _ " " >expect <<-EOF &&
> >       +15
> >        20
> > -     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @=
@ -1,2 +1,3 @@
> > +     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?=
 @@ -1,2 +1,3 @@
> >        10
> >       +15
> >        20
> > -     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> > +     (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?=
_
> >       EOF
> >       test_write_lines s y g 1 p | git add -p >actual &&
> >       tail -n 7 <actual >actual.trimmed &&
> > @@ -595,11 +613,11 @@ test_expect_success TTY 'print again the hunk (PA=
GER)' '
> >       cat >expect <<-EOF &&
> >       <GREEN>+<RESET><GREEN>15<RESET>
> >        20<RESET>
> > -     <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> > +     <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,x,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> >       PAGER  10<RESET>
> >       PAGER <GREEN>+<RESET><GREEN>15<RESET>
> >       PAGER  20<RESET>
> > -     <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,p,P,?]? <RESET>
> > +     <BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,=
e,x,p,P,?]? <RESET>
> >       EOF
> >       test_write_lines s y g 1 P |
> >       (
> > @@ -796,21 +814,21 @@ test_expect_success 'colors can be overridden' '
> >       <BLUE>+<RESET><BLUE>new<RESET>
> >       <CYAN> more-context<RESET>
> >       <BLUE>+<RESET><BLUE>another-one<RESET>
> > -     <YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD=
>Split into 2 hunks.<RESET>
> > +     <YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,x,p,P,?]? <RESET><BO=
LD>Split into 2 hunks.<RESET>
> >       <MAGENTA>@@ -1,3 +1,3 @@<RESET>
> >       <CYAN> context<RESET>
> >       <BOLD>-old<RESET>
> >       <BLUE>+<RESET><BLUE>new<RESET>
> >       <CYAN> more-context<RESET>
> > -     <YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <R=
ESET><MAGENTA>@@ -3 +3,2 @@<RESET>
> > +     <YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? =
<RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
> >       <CYAN> more-context<RESET>
> >       <BLUE>+<RESET><BLUE>another-one<RESET>
> > -     <YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET=
><MAGENTA>@@ -1,3 +1,3 @@<RESET>
> > +     <YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? <RES=
ET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
> >       <CYAN> context<RESET>
> >       <BOLD>-old<RESET>
> >       <BLUE>+new<RESET>
> >       <CYAN> more-context<RESET>
> > -     <YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p=
,P,?]? <RESET>
> > +     <YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x=
,p,P,?]? <RESET>
> >       EOF
> >       test_cmp expect actual
> >   '
> > @@ -1424,9 +1442,9 @@ test_expect_success 'invalid option s is rejected=
' '
> >       test_write_lines j s q | git add -p >out &&
> >       sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
> >       cat >expect <<-EOF &&
> > -     (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
> > -     (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, can=
not split this hunk
> > -     (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
> > +     (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,x,p,P,?]?
> > +     (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? Sorry, c=
annot split this hunk
> > +     (2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?
> >       EOF
> >       test_cmp expect actual
> >   '
>
