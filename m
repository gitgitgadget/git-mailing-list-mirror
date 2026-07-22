Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2B433031
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708221; cv=pass; b=h77muS1zVwLX7mIEa6Kk4MW8leBlGW8/O39B5YlqFBMf1zmmZ/l9gf2IpmGOUAgH57Q21nF0wHOGXG3fBiHBR/qSBz6hjeQPa5xtS0OKoa9joZUplFBHW1YGZpHNAlOwIam/C6WaNvPksxhtOJ4PXW6ZgrlaYnD4rFIRkN1RwoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708221; c=relaxed/simple;
	bh=5aw5A9HmBEEYG/WuEfwMIkJDp0bOKdARsA99MXHo/Sc=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPENrTp7WfLvXeWZuUJ3hCFcA3jh7+/jnOhfhe2TY9o3P4W3mV1ER0/u1ZPjsahf80fLhqntayO3a518PjesTYBSSwvh3jIAA+cbk1KiCjSAfhuTAsxLW/EIRzpbUP1lj5Y3xCylkYRYS7UZB2rNge+AgcoWzSA+6AjJKV5/Qo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odTmt02D; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odTmt02D"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66899fe9077so165085d50.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 01:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784708217; cv=none;
        d=google.com; s=arc-20260327;
        b=e9X46NStuiC/IgAZbP/+K7QJ7gfIP9yhbmCU8AgtvVkEOH1MoPKetWbHtjKh7zbmPS
         mbQbSOelCzEFL7wFGPHWpycxhv3HoU7m7CGNkTRmnjsJvZvQxrb97ycTcRUjrl3mKOO4
         ez/p7r/+eBxFbTBnxwuREdSNKbI5AxJhYWUGK4QoF8rmnaTHBwQYETCFTCr0DhX63A68
         A+gjAXvgTIf0FQRcR1RWASASCT/+gvA5IZ+WG+yQTw04uLA7Ry3V8oTEtWmpza57seN2
         t6G8Scd3jV0Wlos2MDS2VcCE/E6PdmTi+LNb6TnNe+2GTCfVOS5ebOlO9Ob4M1utQ882
         d+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=6vWrMawUguAgHGRgtyu0AbI+6ccE/RLbRNgRu1yxlhQ=;
        fh=5vreiGbpL4Da2npMv9hFGA+rNmfyGxQjC0u5gtZ05Zk=;
        b=PHy46TwAZ4poRhueaMMAZHX88Zrg5Zi3e13m/pwmrfZm8hPe1l6gd1t6rY5scjd56D
         3kWt48F4r6Fg2mMc18JlYFZYr/IUTMX/KbVdzqTdgSMOddm7D5Ax9dUKnRwEb5n1vL/Y
         i+jBsW0I2oBxxeTdTTw3GZv1VYIjxvU0zwHvg7P9Y2jab9WXdYvuy9SnCOBG9gDviXR0
         jfGlZaG/Y3eo6NTLNjHANxFjNmZH8rZ7p5ESa1R/vjZ8xWmPJAI57VEfREJG7V3ZatVA
         REjoO/+OS5V+nifGcmT09pJU3QLbKAQ8KeEQvm4Mb9iuc554O+TNHH3wwJ+gJOlzpdbr
         a9KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708217; x=1785313017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vWrMawUguAgHGRgtyu0AbI+6ccE/RLbRNgRu1yxlhQ=;
        b=odTmt02DkbbZD7NT30RkDnS/XSC/0xX3I9/aGsGkwdLe/HZyGwucDiRMjOY6kqdOEC
         Cc0mQSrH27VGgFgPF+v65QfmQdxn+SMx2JcPqzOwtiSGzrVN7HeM77/+pKZxgB63WYqc
         QoUPkVfL5qGVRh6SDRgypUQRDi79DQkpAEhp9XRaUDTAKZqBaWII8EYdCYK31HuoRek7
         Vh4T7wCI6Q96csDsOOOFyurivIbSgpw9GZRyF+/+oCb72FzNkUybzuBc8eRzRyi2GU8S
         diwkeN4luBZc+XCM47gVeNWDkbggN+jruAYDJZhD/YgU075acOLGdUxwp33Nbi54FGUb
         zz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708217; x=1785313017;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6vWrMawUguAgHGRgtyu0AbI+6ccE/RLbRNgRu1yxlhQ=;
        b=Krm8p/U5XVas8uI/TQ/J6NhJjK82BSxIyRYmpiIqg1/IR/9DK6ZyF4ikv2O7DvQm1C
         a69IalW4nNds5ttCSXG3fZIX4idx58dRjuZThZ2ZMlbmdey9M0JfsCSAZV2uIpkZyglk
         542gC0GLfI4mowqY0YrnmI7ntp6XdsLA/klOKdEiJtmSg2cImpAkttldlPV9ZaUkxyVL
         CreedKgQidmXDW70T+ReTrBLQB016VTZJnwwfxMKEsyY637Vhgm9I1g4+ANoD3QVjwHj
         b4+rTivjJ8qOphS7Oi23amI3YNap3/oSPBhFp2eabpm/OUPCNfv/4zWoliGLMCassnoD
         25Bw==
X-Gm-Message-State: AOJu0Yx0f4W95uShHijVJqME0l/kjAALw2lwMxmy2i+QvRmwEDEE7161
	RM4YyM9MFpjDEO4mIpnuy705fl0CbzU2pT1wbhUXfo3sPjtzH572WP5iSjpefdratob7/uBiSlC
	6iKEoAEJNfvLg+Z5zVCyUWRY3uHBoseJ9ig==
X-Gm-Gg: AR+sD11cjnM77IFbvc24Or/kcERHgWBveuEI2KoDrk/EhfF5mqprszuOjxTOg4MFeRG
	Bx3yrMdd1EIcExiFz1sh9L9QDAK36jz/FZSuMAlZIkx0N9z/VpdzRz3g1Ga7IKGk28/km5aZ+yQ
	klXDfjvphxGY390dxuFXbFAl6jnuKJ0pRJgSeiqya5wHxD/S51gVQ0Sa3q8LkuHA1Alki3MJM7o
	Kex7h7kCCOEOWMw9aBX9pgC9BGBiMHtMgzZfnlh2LOD/QxwYQnR6vSk9hIEejPf42rsxErabojk
	mnoJjHGBbXcisiso
X-Received: by 2002:a53:b68b:0:b0:667:95f9:bcd7 with SMTP id
 956f58d0204a3-6683bce3a78mr4489686d50.49.1784708216618; Wed, 22 Jul 2026
 01:16:56 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 22 Jul 2026 01:16:56 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 22 Jul 2026 01:16:56 -0700
In-Reply-To: <f982c386-e329-4ab0-b695-e540bcb9de3d@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
 <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com> <f982c386-e329-4ab0-b695-e540bcb9de3d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Son Luong Ngoc <sluongng@gmail.com>
Date: Wed, 22 Jul 2026 01:16:56 -0700
X-Gm-Features: AUfX_mxJ03OYIP0HsoMPDgNJcUMetbxczxhxXHHlNiZNHMfU1NX2jKXG72GRcqs
Message-ID: <CAL3xRKdoGpNOdbY7_dt3oSfn6728gf8uA4qa79Kcp1UuS=jpiQ@mail.gmail.com>
Subject: Re: [PATCH v2] rebase: skip branch symref aliases
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

On 04/06/2026 16:46, Phillip Wood wrote:
> A symref that points to another branch should always be skipped. When we
> look up which branches are checked out (see worktree.c:add_head_info()) we
> use
>
> 	refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
> 				 "HEAD",
> 				 0,
> 				 &wt->head_oid, &flags);
>
> so it will never report a symref as being checked out - it always resolves
> any symrefs first.

Yes, this is the right distinction. Patch 1 now resolves each local
branch decoration before deciding whether to queue it. If the target is
under refs/heads/, the alias is skipped unconditionally and the concrete
branch decoration remains the only update that is queued.

> If we have a symref pointing somewhere outside of "refs/heads" then we
> need to check whether the target is checked out, not the symref itself.
> I'm not sure how likely that is to happen in practice.

Patch 2 handles that case separately. It checks both the literal alias
and its resolved target ref against the checked-out reservations. I also
added a test with a non-branch target checked out in another worktree.

> If a decoration matches the current branch why don't we just skip it like
> we used to? (As an aside the existing code in wrong because if the user
> runs "git rebase --update-refs <upstream> <branch>" HEAD does not point to
> "<branch>" but lets not worry about that now)

Agreed. Patch 1 now skips the current branch before checked-out
handling, as the old code did.

The contrary expectation in t3400 came from head_ref pointing into a
buffer that was reused while resolving another decoration. That could
make the current-branch comparison fail. head_ref is now an owned copy.
The test expects the current branch to be omitted from the todo list.

While adding the non-branch coverage, I found that two aliases to the
same target ref could queue the same update twice and make the second
compare-and-swap fail. Patch 2 deduplicates those updates by target ref.
It also records resolved target refs from other worktrees' in-progress
update-refs state so that a different alias honors the same reservation.

I split the reroll into these two patches so that the branch-alias fix
and the non-branch safeguards can be reviewed independently.

Thanks for the review, and sorry for the slow response.

Thanks,
Son


On Thu, 4 Jun 2026 16:37:39 +0100, Phillip Wood
<phillip.wood123@gmail.com> wrote:
> On 03/06/2026 11:27, Son Luong Ngoc via GitGitGadget wrote:
> > From: Son Luong Ngoc <sluongng@gmail.com>
> >
> > git rebase --update-refs can fail after the normal rebase path has
> > updated the current branch when another local branch is a symref to it.
> > This can happen during a default-branch rename where refs/heads/main
> > points at refs/heads/master while users migrate.
> >
> > The sequencer queues update-ref commands from local branch decorations.
> > Commit 106b6885c7 (rebase: ignore non-branch update-refs) filters out
> > decorations that are not local branches, such as HEAD and tags. A branch
> > symref is different: it is still a local branch decoration, but if it
> > resolves to another branch then that target branch is itself present in
> > the decoration list and will be updated as a concrete branch.
> >
> > Skip branch decorations whose symrefs resolve to refs/heads/*, because
> > those targets are already represented by concrete branch decorations.
> > This prevents aliases from scheduling a second update for the same
> > branch. Keep symrefs to non-branch targets on the existing path.
>
> Makes sense
>
> > Preserve the existing checked-out branch handling before applying these
> > skips. Such refs still need a todo-list comment instead of an update-ref
> > command, even when the checked-out ref is the branch being rebased or a
> > branch symref alias. Use a copy of the resolved HEAD ref so later ref
> > resolution does not overwrite it.
>
> I don't quite understand this. A symref that points to another branch
> should always be skipped. When we look up which branches are checked out
> (see worktree.c:add_head_info()) we use
>
> refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
> "HEAD",
> 0,
> &wt->head_oid, &flags);
>
> so it will never report a symref as being checked out - it always
> resolves any symrefs first.
>
> If we have a symref pointing somewhere outside of "refs/heads" then we
> need to check whether the target is checked out, not the symref itself.
> I'm not sure how likely that is to happen in practice.
>
> > diff --git a/sequencer.c b/sequencer.c
> > index 1ee4b2875b..6ab8b47108 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -6445,28 +6445,46 @@ static int add_decorations_to_list(const struct commit *commit,
> > struct todo_add_branch_context *ctx)
> > {
> > const struct name_decoration *decoration = get_name_decoration(&commit->object);
> > - const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> > - "HEAD",
> > - RESOLVE_REF_READING,
> > - NULL,
> > - NULL);
> > + struct ref_store *refs = get_main_ref_store(the_repository);
> > + char *head_ref = refs_resolve_refdup(refs, "HEAD",
> > + RESOLVE_REF_READING,
> > + NULL, NULL);
>
> This part and the test look good now
> > while (decoration) {
> > struct todo_item *item;
> > const char *path;
> > + const char *resolved_ref;
> > + int flags = 0;
> > size_t base_offset = ctx->buf->len;
> >
> > /*
> > - * If the branch is the current HEAD, then it will be
> > - * updated by the default rebase behavior.
> > - * Exclude it from the list of refs to update,
> > - * as well as any non-branch decorations.
> > * Non-branch decorations may be present if the pretty format
> > * includes "%d", which would have loaded all refs
> > * into the global decoration table.
> > */
> > - if ((head_ref && !strcmp(head_ref, decoration->name)) ||
> > - (decoration->type != DECORATION_REF_LOCAL)) {
> > + if (decoration->type != DECORATION_REF_LOCAL) {
> > + decoration = decoration->next;
> > + continue;
> > + }
>
> If a decoration matches the current branch why don't we just skip it
> like we used to? (As an aside the existing code in wrong because if the
> user runs "git rebase --update-refs <upstream> <branch>" HEAD does not
> point to "<branch>" but lets not worry about that now)
>
> > + path = branch_checked_out(decoration->name);
>
> As I said above if the symref target is anther branch we should skip it
> and if the target is not a branch then we need to check if the target is
> checked out so we need to resolve the ref before calling
> branch_checked_out().
>
> Thanks
>
> Phillip
