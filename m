Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795487652;
	b=Kc6Ov/5VcgtfUJ+hLqA3flbRLQ8QcbZ5NAknYh8yVhrpLrt0dMrH21VcJHYSKRaA6jMQ
	 syYbrh84erGadoMva0LbogcnkLiGKBQBSY3xFruxASv63hYap03cLYAbEQAbny5+pnzWZ
	 7OUemC3P2PwKgzjd+IGN4QkDPcVULkujZwZkw7QfT02sgLfaEXiHB3G2Ujpi2UlztNlt2
	 x+b0raj0xFE5gRdIsRONe0ZPzASKRbc2Cqvpya/kNUQHY88yDoqGFQ0dLKSuZkIiZHUvg
	 +tVA7sf/DTk2lY0rk+tiD/1o98RhplZyzSEA1tiXXagW+sIB+h1suRq9nmcUHwyDUGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f6lUhquaYzgRwBV+AAjB2mH4Lf01CXGmantmu/c0SH8=;
	b=mHka7RaPZT9JK35KsPozaGzuViNU+MjeKqh9MDT3LjR4L87zCQfD2ZqKn8LOoXq5vD09
	 kX4Gp+6pqjvEDP4ZBuTcbBCMNu0F2nMd5YS2ZGQRLg3osaN6qpqYtsJ+zVmneDYflAZXZ
	 opgoMn871jkXffbxgxDKkiAZH7OGigVBpaQ95NYpsfqwUwsSA5hHBARq7NzLJHeHqNyXg
	 2Y8hR7mj3YlH26R8fxL8Nbli9qWxLpS9LTYkeQCiaNajk4AW5HDNE6+G6quYrgqS2F6xX
	 bLu7ZzSfP+xdb67YqQ8PxfrBQqn1kLlAut2REKxAdRj0QuNcmJ30KxqibAcLDCl4Z+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=CJnFAIay;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6B606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 02:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9C6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=CJnFAIay
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so534952766b.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:34:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795487649; cv=none;
        d=google.com; s=arc-20260327;
        b=qh4LD2nHvanoW+RKdInAZegSQLl+wzLwnF4HTt0jEmYf0M9dEc0K4/M9aGtlFxnmuT
         nA3H8qsDvKWfVPD0v05zUCXbpo6BDyaNqRjcjv6Ym+UahYhpCw2R6os4OWCpJYieYuuu
         vNOWoRTao/fTjNoa39SUnQV9jOZgwLqUK8RiTeNKDGE9ZlvJago3/zrzMxYwuKrmNJ42
         O3aTaWyaGryXwpx7fFkAk+SjcfqS1zSCSdqTHsAhVxyJ/XDCcBWgXCYms2Oz8cGXsyYD
         jAm5dMQXpBuiuRneB4SyI3A/p2rlGoO4skB68j60rJct778wxv4f5IKrrX6Yvs5rPhsW
         CbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6lUhquaYzgRwBV+AAjB2mH4Lf01CXGmantmu/c0SH8=;
        fh=9w61F+ColeX267DsRvJs5zMNKhCo+92HydPc+Ow1Kz4=;
        b=gNF89b2D8ta7Y8zGzclJF0iqFmnaQgWw07cHMHG1v3dIAv3sqHG5fNSOsKidxLm4TZ
         otW2O+ul+Jxs8T9zDEcc9WUZcNSvedLpwowoA8Z5FlPuujqpf36LEM4FRC74aUxjwuXy
         OTm5x6IdKp8QxKbZJiIfE2uMfkeC06tWoKKHwyFSDJgvDsljZ9VLzTRefMXsrkwnRRZS
         PHtb0QTEamzDRC3gihn0vkVsYyE2uBA/NSXa1zzLHmWGFgXWes7h9PuDPt53UttdtXrp
         DiLa7WXoF0b/QvLDXmhGgC1ValQuMcnJfeKHuEb0NgZTlmjhfr5L066U5fEe4WDwPqyE
         g6Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1795487649; x=1796092449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f6lUhquaYzgRwBV+AAjB2mH4Lf01CXGmantmu/c0SH8=;
        b=CJnFAIayKs4Hsv4fLkFnn4JZ6KGp6Oqaa2lDY3cJH6LO5biSY9q89mMEqUD4yR+ELn
         +k64F40j0B/yTzyvd4m15Prj9WzMBnIHak9DlxLhkpdSZwb4PSdbGY4hbQhpRB0Ytm30
         jLdb2BI9qvYM+Be2kW4aKHisKBndZp+2yzgi8ZNtOc49Nrbu2TmVH+mZTrEaAS+wl32I
         s7veiYeLyEKGpIh8Y6eEhU8p+FLJXQ8BR4zxWzLy2I7mFaCDfCEuDTd475UeY3LdTVBx
         GNmcWXej4MXQihyUyoizVoxMbsHv4IJHVXM5Yvs45TtnYZyyyQkVPxdtwDQIXtfYt2tO
         uUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795487649; x=1796092449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6lUhquaYzgRwBV+AAjB2mH4Lf01CXGmantmu/c0SH8=;
        b=enQV+2CPf05zf4b+4EZJp3bxkzn/Yi5yadCcXDXroJbxhdPUoVihWKJt5aZ3lVfoFD
         iMRuvC+NC5My7wIoCU/Gp5rkWmA6+sPHRjwNPCFbPqzBiFVWJ5l3gFAFHbcQQ6xheVeK
         tDHzXor6RPgDHQ7KvN+LnIaowTK9UoV82JUVa+ARtns5eCGrCW6eAjOA2MXQr2za4oNW
         DqW063Gh+XkfLm2wPqu/8Uba6JcCaeqFHnsImlaEZjxZjsHQO1RVBmPRqxUagn1FJ9Bh
         LI0xtZWO3lE7i+0yJ2rBoufPfOvATs+oN/KmCqWPSI6YBoOJEaj4G/KT2g4iDBSyhPAK
         rUdQ==
X-Forwarded-Encrypted: i=1; AL+hErGL/hRe4fViLYXohifqddVktdM3pgnYMhqJkL++IHdQOzEMq5F+pvlRcG0MZ3frp3uiGJI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OD1p8Yy+xx/0YSgRQ3P/Y7J3ZcUkcZDo/bLCsSR0Wvm2/jo3w
	c1BJEHhlaeDjRVQ15NkQshrm+iOljOXPvLIQBa/Q8GMj4ojeTFdq3wj6GSQ/+PPBA7BAg9ai9R5
	H9rKAS/XCoCQDBCoYm1faMmqm1rwyLPJxVbc+TsThfg==
X-Gm-Gg: AZFdTZc1NkhYY/WzJygTiE+IBot2cJvH+VsU3h0B6uw+cIMxI8jPnUPrMsZ1Z5lPtIL
	8vsoJjobiJP7jFipMUREkRWYzjS+fOWeY7I0elo76x4GBDWw1f2KCS23U4a7gSh3oLrMvOT2WJr
	iTG9w0zFkPQl7e82DVKChSZW4WWMFjgmTUFhjnKboc27rvwPwL6rM4HgGCmegUsX20AKEmbrBWK
	SMW8C/jV1Br1YSKaCsmweNMH+q5YjE/OM4o6/b7o1PWs5UK2k99Oi80BINKdZwbzxOM3+7RSOMO
	RU+288iB7BZ9F6wdJZMh/nRI8ZzvX9En7ocmoIVGyB11pTZyKDEpuqY7K+naDdiLqPcd+y638Rv
	0Mk36gMISPIr9AmTXN6KYAUY966A/+DQQOxxWS46BDv0O+J+zwsbyoVvUKAGxKuwx5g8faSo=
X-Received: by 2002:a17:907:6ea9:b0:c46:645f:cee2 with SMTP id
 a640c23a62f3a-c513a3ab024mr1101053866b.4.1795487649051; Mon, 23 Nov 2026
 18:34:09 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com> <27abe897-cba1-4561-816a-875c064ab8c0@gmail.com>
In-Reply-To: <27abe897-cba1-4561-816a-875c064ab8c0@gmail.com>
From: Wonseok Oh <wonseok_oh@korea.ac.kr>
Date: Tue, 24 Nov 2026 11:33:57 +0900
X-Gm-Features: Aa3M54r082GZ8wxVjv_i8pDw-jbQG6oYXo6oOyX8_TZjOdfNbmJVfqPfF_CMrDk
Message-ID: <CAD2pp5sZ29TT6JHwA88XTC3dymjrtAbKmy-gyyZ1oiA2pEomxA@mail.gmail.com>
Subject: Re: [PATCH] sequencer: reset saved HEAD OID when picking onto an
 unborn branch
To: phillip.wood@dunelm.org.uk
Cc: Wonseok Oh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip!

> I had a hard time parsing the second half of that sentence.
> sequencer_rollback() expects us to have saved the null OID when HEAD
> points to an unborn branch, but instead we save some random junk because
> we haven't initialized the 'head' variable. The use of an uninitialized
> variable comes from 0f974e2124 (cherry-pick: allow to pick to unborn
> branches, 2016-06-06). Before that commit we refused to cherry-pick onto
> an unborn branch and so did not use 'head' unless it was initialized.

Thanks for the review and for digging into the history.
I'll reword the commit message along these lines
and mention 0f974e2124 in the updated patch.

> It would be nice to either remove the check for an unborn branch when
> reverting multiple commits, or move the check so that it covers single
> picks as well. It would also be good to allow the user to abort when
> cherry-picking onto a unborn branch. Those changes don't need to be part
> of this series though, they can always come later.

Indeed. I'll think about which direction makes more sense and follow
up separately.

> I see that rollback_is_safe() expects to see a null OID when picking
> onto an unborn branch, but update_abort_safety_file() writes an empty
> file in that case. We should be consistent about the way we represent an
> unborn branch in the state files. Arguably an empty file is a better way
> of representing an unborn branch because there is no OID.

Along with the reworded commit message,
should the updated patch also save an empty ".git/sequencer/head" on
an unborn branch,
to align with update_abort_safety_file()?
If so, I'm happy to include that change.

Thanks
Wonseok Oh

2026=EB=85=84 11=EC=9B=94 23=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 11:32,=
 Phillip Wood <phillip.wood123@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Hi Wonseok
>
> Thanks for working on this. I think that as an immediate fix for the use
> of an uninitialized variable the patch looks good, but I'm not sure the
> behavior of cherry-pick and revert onto an unborn branch makes much sense=
.
>
> On 21/11/2026 06:30, Wonseok Oh via GitGitGadget wrote:
> > From: Wonseok Oh <marinelay7@gmail.com>
> >
> > When picking multiple commits, "git cherry-pick" stores the current HEA=
D
> > in .git/sequencer/head for "--abort" to return to. If the branch is
> > unborn, repo_get_oid() fails and leaves the object ID uninitialized,
> > but sequencer_pick_revisions() saves it anyway instead of clearing it
> > to the null OID that sequencer_rollback() checks for to report
> > "cannot abort from a branch yet to be born".
>
> I had a hard time parsing the second half of that sentence.
> sequencer_rollback() expects us to have saved the null OID when HEAD
> points to an unborn branch, but instead we save some random junk because
> we haven't initialized the 'head' variable. The use of an uninitialized
> variable comes from 0f974e2124 (cherry-pick: allow to pick to unborn
> branches, 2016-06-06). Before that commit we refused to cherry-pick onto
> an unborn branch and so did not use 'head' unless it was initialized.
>
> It is rather strange that when sequencer_rollback() rejects an unborn
> branch it refuses to remove the sequencer state so that it is impossible
> to abort a multi-pick cherry-pick started on an unborn branch. It is
> also strange that we will try and revert a single commit onto an unborn
> branch but not multiple commits. 7acaaac275 (revert: allow single-pick
> in the middle of cherry-pick sequence, 2011-12-10) inserted a separate
> code path for single picks before the check for an unborn branch, so
> prior that commit we refused to cherry-pick and revert onto an unborn
> branch regardless of the number of commits. Going further back in
> history, the check for an unborn branch was introduced by 04d3d3cfc4
> (revert: Save data for continuing after conflict resolution,
> 2011-08-04). The commit message does not mention a reason for
> introducing that check and therefore changing the behavior but I assume
> it was to avoid having to support aborting to an unborn branch.
>
> It would be nice to either remove the check for an unborn branch when
> reverting multiple commits, or move the check so that it covers single
> picks as well. It would also be good to allow the user to abort when
> cherry-picking onto a unborn branch. Those changes don't need to be part
> of this series though, they can always come later.
>
> I see that rollback_is_safe() expects to see a null OID when picking
> onto an unborn branch, but update_abort_safety_file() writes an empty
> file in that case. We should be consistent about the way we represent an
> unborn branch in the state files. Arguably an empty file is a better way
> of representing an unborn branch because there is no OID.
>
> Thanks
>
> Phillip
>
> > As a result, "--abort" errors out with "Could not parse object" in my
> > master build, while in Debian's 2.47.3 build the uninitialized memory
> > happened to hold the last picked commit's OID and moved the new branch
> > there.
> >
> > Clear the object ID to the null OID when HEAD cannot be resolved, and
> > add a test.
> >
> > Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
> > ---
> >      sequencer: reset saved HEAD OID when picking onto an unborn branch
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2317%=
2Fmarinelay%2Fcherry-pick-unborn-abort-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2317/mar=
inelay/cherry-pick-unborn-abort-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2317
> >
> >   sequencer.c                     |  9 ++++++---
> >   t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
> >   2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 4a1c0e70b8..20bfe00ba3 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -5788,9 +5788,12 @@ int sequencer_pick_revisions(struct repository *=
r,
> >               goto out;
> >       }
> >
> > -     if (repo_get_oid(r, "HEAD", &oid) && (opts->action =3D=3D REPLAY_=
REVERT)) {
> > -             res =3D error(_("can't revert as initial commit"));
> > -             goto out;
> > +     if (repo_get_oid(r, "HEAD", &oid)) {
> > +             if (opts->action =3D=3D REPLAY_REVERT) {
> > +                     res =3D error(_("can't revert as initial commit")=
);
> > +                     goto out;
> > +             }
> > +             oidclr(&oid, r->hash_algo);
> >       }
> >
> >       if (save_head(oid_to_hex(&oid))) {
> > diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequ=
ence.sh
> > index 9400ddfc45..75004bba0c 100755
> > --- a/t/t3510-cherry-pick-sequence.sh
> > +++ b/t/t3510-cherry-pick-sequence.sh
> > @@ -269,6 +269,16 @@ test_expect_success 'allow skipping commit but not=
 abort for a new history' '
> >       test_cmp expect advice
> >   '
> >
> > +test_expect_success 'cannot abort a cherry-pick sequence on a new hist=
ory' '
> > +     pristine_detach initial &&
> > +     git checkout --orphan new_disconnected_seq &&
> > +     git reset --hard &&
> > +     test_must_fail git cherry-pick base..anotherpick &&
> > +     test_must_fail git cherry-pick --abort 2>advice &&
> > +     test_grep "cannot abort from a branch yet to be born" advice &&
> > +     test_must_fail git rev-parse --verify HEAD
> > +'
> > +
> >   test_expect_success 'allow skipping stopped cherry-pick because of un=
tracked file modifications' '
> >       test_when_finished "rm unrelated" &&
> >       pristine_detach initial &&
> >
> > base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
>
