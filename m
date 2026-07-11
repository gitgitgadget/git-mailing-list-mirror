Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790603C73D9
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775327; cv=pass; b=KoQK5n8SAba9slsnfHR91iVl3WX3JJyU9Al5nTU+0kWmLbJnfivF4WXaor1mkcfLIo9BOqAn3ECOzD6Awa5zhB2w5g0fFgjW3uqDv8OZl4gHUX3Rg5VArv0zZpQPmJi6EgKL/ZLsD0DnX+LAaYYHzD43xNWB0i8291n3U5cvBSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775327; c=relaxed/simple;
	bh=6T8igMXvY2BQdIhx7B2Xz2EjSSgySQFontprD6z1acs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gn0Fnak7PavYX0wB+FM4El7ougpolVR/Wn5SmDTVQcW0CUslG7sPD/20wPIJjXQaWeUwcr/UXkV/5tzsKYmldkwrOCif32nbb6kCFA/jw2hmEKwks/4dzZ1XwCguDt/jsEJC8XCIh7ExCxIi5Lg3mbgdrGhCbYmxqLwAM5OAzJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc7Wj3dV; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc7Wj3dV"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so77601a12.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783775323; cv=none;
        d=google.com; s=arc-20260327;
        b=Z14DW4KlkU9SZ9kgL6ceTczapb1db7XcRHybLTsHTDtWrgIIW+8JMozPc50N82NKyo
         enk57XR4P5UqxwXA8GoQJ8t8xrQ8xLyTqxPBMMDXxsjFDE7oi3QmbZshb1uvWdsWWKSJ
         gQUwH4LVfMXy2Rp10KMs67HCf3J4Ee3QIbwfmWmPsbA9klG3CT8foU2U5/sBBkBlZzKx
         RZ3D+n4eqYKOfd9llESg/Jc33UfDyM5qPcYPrBirCkXkXtnsYsVxh2NKWL/7mNxEsJUV
         +YSyEpRgWz3SB1zBoK79zLbnIvW+/pxqqEbM3lcAPb3OVIQPb4sRhYrpXnTYbB67ITWy
         8S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l3MrIAHGbz3uzSEiZg0nClpyuqTyNpQY8tHIveh0IyU=;
        fh=1A2iKzAQXNu6x0SGuDVygM0RmyummrUZTAYB+XOhEx8=;
        b=ihM4koqISltcYN82CZxzsYexoo+qUFr6eOmeVdpcLRwRbW6zQf26sK2WHge3La63Kj
         13O/5wQgRFBKDksiFdQLkLN8FWuJhjqge2vQK38x1FNjS24f7zfnlQTlsSNPQw3ZHqmz
         oz4foB2XKY6ob59kNZ3OOndcQ3khz5D9tZgMtaRZgRk6jPsU9GPMPnuOHA1kA2rDybg5
         FnGf8MnhaCTAGOTExCeWBkow7kh5rPDU2Jr8sX2AcH3UzQ8OZKHlC/BEMH1v2mM7Oy1A
         BlvxC7ngzrtw9V8dr9F3mXX5Vqk/8MhM1YD1qSjvkx3+X/kZqZy8cpb65sKCjs9pzhCW
         MGbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783775323; x=1784380123; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3MrIAHGbz3uzSEiZg0nClpyuqTyNpQY8tHIveh0IyU=;
        b=cc7Wj3dVc0yJ9b9P6luwotH9kwyFSstuD29LTOX+KFpyHySYsacZO+5jicddCypMWg
         L0DtHLTVWD54mAZQAR9MKX1rBTmU02dcscWdljrrDtJvV0/X1JGLLWsNIcZE87jzZ40Q
         5RVma8VPiypmXpTaors3AV+bdgoV4AIqlHFOFCXhKhwnzDXjSK5tgs8TsWXfXXgL/1Mk
         SkuQXheoCTeu/h7lQKUU0LX1cg4rdTDwT+rIFPWHHEZFVJ8KzqMH89toMkxdshIOef5C
         zEvefvSnOc6naVyXKrlW8jKTHjLDI/vje5mdRdQP79znQv7rOc/g1t3TeOtBMnzzQ5uF
         ZIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775323; x=1784380123;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l3MrIAHGbz3uzSEiZg0nClpyuqTyNpQY8tHIveh0IyU=;
        b=Avj+P4h+TIX5P4/G5rOAcebbAq6LcsjOPKc8UMVKJ+2amCbO5rN3Z6dDNHC80eQklf
         jJAbExdEceGzUjYCTTY682SWgHLsYFS2FCUtpElMtgVOaAVEuuSc6Z6HJhETvxlKmMt/
         2E2wNpuf0UPiw+qazFr0vcXBpwkIE4i/cg7rwHN1JXv6tan22BDMWBT1pf0jpOzsrYka
         PXcXf8+vCU+yzDaOViyTKFnKnQJNeX0E4iMzL5ydZI4P/1OwI+fVnrUvjFaPwSF0fq60
         orpuXAKEsQMPJfBOO8UwMa849sGbvYKeHqyT+STUeOWFUFz63vySyncO17aFbiEPJD3C
         U2yw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6KZab61aF+YI7nlevKt/nIITFY3iA1X6YsXZYqdwvA7xTE8ShX5ghh3ZaYlJYgM9NeVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3r7NxRpBncC065rE/urba1Or67EmkJWV/HrbP0QAepPOCEsXc
	GaI1iaobw8uaFYQmPxJNetV0lRTFAxJwLyLk7rgMM/nwPNrl5hMBcCe1oEN+AXA6QahsCIIErvz
	BDbm8IZAUQ0bgz4TAEoeFT8OgWz+EUC0=
X-Gm-Gg: AfdE7cl1yTNCuj5Ld3MI8QEQSWbx/V300yQ0e2tQfDUwRfZidGCfT6K8Z8LWmz6CtzD
	MHZjqounEMkOmVX1L0UW4G4+DACqXacv1qUXtDDQhC1UbBkPFXIDFFJORsbOFtk+dVtkVOkHMGq
	QfAGq8J3EApN/wKiwP2l4ad29/iQ/1ylKU1bBOzeih34dhAZpLfW0YzgKA1enISnJirodqDCCIN
	ECrNzCP/rd1O/BpbJ+Z1u1L0OGXVvPwrjHJ2vpxu2C8+OZYA1lsCVZvyJHnDsTySs8AVXAR
X-Received: by 2002:a05:6402:1471:b0:697:4fff:b90a with SMTP id
 4fb4d7f45d1cf-69c5ef84de1mr1381641a12.4.1783775322543; Sat, 11 Jul 2026
 06:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com>
In-Reply-To: <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 11 Jul 2026 15:08:05 +0200
X-Gm-Features: AUfX_mzX_h-P8WOr-2njfE9Se2Jl04YTv7vdi_DEnJApV6kXGvShm8NMpkQxROc
Message-ID: <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> >       git branch --delete-merged <branch>...
>
> This design means that unlike --forked there is no way to limit the
> branches considered for deletion. I wonder if we'd be better to have
> --delete-merged take an argument like --forked so that the user can
> limit the branches that might be deleted without resorting to the config
> setting added in the next patch.

Makes sense, I updated it now and it seems to work fine.

> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > index 3104c555f6..047ba54778 100755
> > --- a/t/t3200-branch.sh
> > +++ b/t/t3200-branch.sh
> > @@ -1839,4 +1839,189 @@ test_expect_success '--forked narrows a <pattern> argument' '
> >       test_cmp expect actual
> >   '
> >
> > +test_expect_success '--delete-merged: setup' '
> > +     git init -b main upstream &&
> > +     (
> > +             cd upstream &&
> > +             test_commit base &&
> > +             git checkout -b next &&
> > +             test_commit next-work &&
> > +             git checkout main
> > +     ) &&
> > +     git init -b main other &&
> > +     test_commit -C other other-base &&
> > +     git init -b main fork
> > +'
> > +
> > +setup_repo_for_delete_merged () {
> > +     rm -rf repo &&
> > +     git clone upstream repo &&
> > +     (
> > +             cd repo &&
> > +             git remote add fork ../fork &&
> > +             git remote add other ../other &&
> > +             git config remote.pushDefault fork &&
> > +             git config push.default current &&
> > +             git fetch other
> > +     )
> > +}
> > +
> > +merged_branch () {
>
> A comment would have helped to explain what this helper does. Also
> calling it create_merged_branch() would be clearer too I think.

I want to avoid comments because of the maintenance burden they
introduce, I think 'create_merged_branch' will be a very clear name.
Thanks for that suggestion!

> > +     (
> > +             cd repo &&
> > +             git checkout -b "$1" "$2" &&
>
> If we add '--track' we can avoid having to run "git branch
> --set-upstream-to" below. The same goes for many if not all of the
> branches created by "git checkout -b" and "git branch" in these tests.

That's a very good point. I wanted to keep it "vanilla" since I worked
a lot on upstreams and tracking branches in my other topics and didn't
want it to bleed over, but yes it's much nicer.

> > +             git commit --allow-empty -m "$1 work" &&
> > +             git push origin "$1:next" &&
>
> We let the caller specify the upstream branch, but then always push to
> origin/next - should be be using 'git push ${2%%/*} "$1:${2#*/}"', or if
> we don't need that flexibility hard coding the upstream branch?

I'll hardcode for now.

> > +             git fetch origin &&
>
> We've just pushed, what are we fetching here?
>
> > +             git branch --set-upstream-to="$2" "$1"
> > +     )
> > +}
> > +
> > +test_expect_success '--delete-merged deletes merged branches and spares the rest' '
> > +     test_when_finished "rm -rf repo" &&
>
> The first thing setup_repo_for_delete does is delete repo so do we need
> this as well?

Nope, let's rip it out.

> > +             git branch --set-upstream-to=origin/next unmerged &&
> > +             git checkout -b tracks-other other/main &&
> > +             git branch --set-upstream-to=other/main tracks-other &&
> > +             git checkout --detach
>
> I assume this is to ensure we don't spare a branch because it is checked
> out?

Yes, but it's also a pattern that I copy-pasted a few too many times,
see my other comment where some of these can be removed.

> > +     ) &&
> > +     sha=$(git -C repo rev-parse --short merged) &&
> > +
> > +     git -C repo branch --delete-merged origin/next >actual 2>&1 &&
> > +
> > +     echo "Deleted branch merged (was $sha)." >expect &&
>
> There doesn't seem to be any reason for these command or the ones below
> to be outside the subshell - they're all running commands in "repo".
> That seems to be a common pattern in these tests.

Agreed, but other reviewers were against subshells before. I updated
it now and looks much cleaner.

> > +     (
> > +             cd repo &&
> > +             git checkout -b mainline main &&
> > +             git checkout -b on-local mainline &&
> > +             git branch --set-upstream-to=mainline on-local &&
>
> Why do we need on-local to track mainline rather than main? I'm a bit
> confused what the point of mainline is.

It's to have an indirection of a branch that is the same as main but
will be protected. I tried to delete it now and replace it with just
main, but then main was deleted and subsequent tests failed.

> > +             git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
> > +             git branch --set-upstream-to=origin/topic upstream-gone &&
> > +             git update-ref -d refs/remotes/origin/topic &&
>
> These three lines can be replaced by
>
>         git config branch.gone.merge does-not-exist
>
> > +             git branch --set-upstream-to=origin/main main &&
> > +             git config branch.main.pushRemote origin &&
>
> What does this do? Isn't its pushRemote already origin?

Deleted.

> > +             git checkout -b tracks-other other/main &&
> > +             git branch --set-upstream-to=other/main tracks-other &&
> > +             git checkout checked-out
> > +     ) &&
> > +
> > +     git -C repo branch --delete-merged origin/next mainline &&
>
> Do we want to use "origin/*" here instead so that we check that main is
> not deleted because its push destination matches its upstream?

That's a good point and a good regression test later on.

> > +
> > +     git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> > +     cat >expect <<-\EOF &&
> > +     checked-out
> > +     main
> > +     mainline
> > +     tracks-other
> > +     upstream-gone
> > +     EOF
> > +     test_cmp expect actual
>
> This checks we delete on-local - good. I wonder if we should add a
> comment about the expected outcome so it is clear to the casual reader
> what is happening.

I'll rename to 'local-to-delete' to clarify and to avoid the comment.

> > +'
> > +
> > +test_expect_success '--delete-merged requires at least one <branch>' '
> > +     test_must_fail git -C forked branch --delete-merged 2>err &&
> > +     test_grep "requires at least one <branch>" err
> > +'
> > +
> > +test_expect_success '--delete-merged keeps a branch that is an upstream' '
> > +     test_when_finished "rm -rf repo" &&
> > +     setup_repo_for_delete_merged &&
> > +     merged_branch feature origin/next &&
> > +     (
> > +             cd repo &&
> > +             git checkout -b topic feature &&
> > +             git commit --allow-empty -m "topic work" &&
> > +             git branch --set-upstream-to=feature topic &&
> > +             git checkout --detach
> > +     ) &&
> > +
> > +     git -C repo branch --dry-run --delete-merged origin/next >out &&
>
> This belongs in a later patch and shows that the patches in this series
> have not been individually tested (c.f. my previous mail about running
> "git rebase --keep-base --exec")

Yup, should be fixed now. And I usually run "git rebase --keep-base
--exec" a lot!

> > +     git -C repo rev-parse --verify refs/heads/feature &&
> > +     git -C repo rev-parse --verify refs/heads/topic &&
>
> I preferred the way this as checked in the previous tests with
> for-each-ref and test_cmp as that shows everything that was kept.

Yes, it's better.

> > +     echo origin/next >expect &&
> > +     git -C repo rev-parse --abbrev-ref feature@{upstream} >actual &&
> > +     test_cmp expect actual &&
> > +     echo feature >expect &&
> > +     git -C repo rev-parse --abbrev-ref topic@{upstream} >actual &&
> > +     test_cmp expect actual
>
> This is a bit of a faff. Perhaps
>
>      git config --local --get-regexp
> "branch.(feature|topic).(merge|remote)" >actual
>
> followed by test_cmp would be more concise and more clearly show that
> we're interested in checking that the config settings still exist.

Nice.

> > +'
> > +
> > +test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
> > +     test_when_finished "rm -rf repo" &&
> > +     setup_repo_for_delete_merged &&
> > +     (
> > +             cd repo &&
> > +             git branch b3 origin/next &&
> > +             git branch --set-upstream-to=origin/next b3 &&
> > +             git branch b2 origin/next &&
> > +             git branch --set-upstream-to=b3 b2 &&
> > +             git checkout -b b1 b2 &&
> > +             git commit --allow-empty -m "b1 work" &&
> > +             git branch --set-upstream-to=b2 b1 &&
> > +             git checkout --detach
> > +     ) &&
>
> I'd find this easier to follow if the base branch which is created
> first was numbered 1, rather than the tip of the stack.
>
>
> > +     git -C repo branch --delete-merged origin/next &&
>
> b3 is merged but cannot be deleted because it is the upstream for b2
> which although it is merged into b3 isn't a candidate for deletion
> because its upstream is b3.
>
> I'm not quite sure what this test demonstrates that the next one does not.

Deleting this one, which also removes the question of b1, b2 and b3 naming.

> > +
> > +     git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> > +     cat >expect <<-\EOF &&
> > +     b1
> > +     b2
> > +     b3
> > +     main
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success '--delete-merged clears the upstream of a kept base whose own base is deleted' '
> > +     test_when_finished "rm -rf repo" &&
> > +     setup_repo_for_delete_merged &&
> > +     (
> > +             cd repo &&
> > +             git branch lower origin/next &&
> > +             git branch --set-upstream-to=origin/next lower &&
> > +             git branch mid origin/next &&
> > +             git branch --set-upstream-to=lower mid &&
> > +             git checkout -b tip mid &&
> > +             git commit --allow-empty -m "tip work" &&
> > +             git branch --set-upstream-to=mid tip &&
> > +             git checkout --detach
> > +     ) &&
> > +
> > +     git -C repo branch --delete-merged origin/next lower &&
>
> We expect lower to be deleted, but not mid because although it is merged
> it is the upstream of an unmerged branch. Again it would be nice to
> check that with for-each-ref (maybe that is a common enough pattern to
> justify a helper that takes the expected output on stdin
>
>         check_branches <<-\EOF
>         main
>         mid
>         tip
>         EOF

Very good idea! Created the helper!

> > +     test_must_fail git -C repo rev-parse --verify refs/heads/lower &&
> > +     git -C repo rev-parse --verify refs/heads/mid &&
> > +     test_must_fail git -C repo rev-parse mid@{upstream} &&
> > +     echo mid >expect &&
> > +     git -C repo rev-parse --abbrev-ref tip@{upstream} >actual &&
> > +     test_cmp expect actual
>
> I'd check the config settings here as suggested for the test above. The
> test coverage looks good, there are just a few places where a comment
> would help explain what's going on and some places where we can save a
> few commands.

Will update! Thanks again!


Harald
