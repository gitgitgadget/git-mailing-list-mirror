Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29D28033B
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494766; cv=pass; b=tM0UqXF1/j3CjqATdLsZrUyYNn1CeFgTLz5ppdMANu2vL7fntkE7H26Dh01pim1EB3TfqZEeQSdxnnZBWiM11VSkVCJ2bFoII+8yXrSO3ngXkRPD3fkcl86J1Ovbf3qON+t5hywUH2C5NYGRNaC+0zVMkxFSPy8r6V07V4U+9h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494766; c=relaxed/simple;
	bh=tXYFWlLT2TRF+cB2uu6hvhUV8L39BmLL2zb+UMLYWKk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JguZxvOn/8+UoCa9lSYWqd0RHpUn2TInDGd6Xq3+p+cuOCyeDVfQpZz6+bRjKV0Tz+J4QXLCyqLJ0UHNoD8xRTxsl+k2nxb07bwJzRNA/BI31YFiAnb7nbBhSgnIJV0E+/z1gL0HnIqRq3MPsF3t2BYCnYkGRSQAXIao2TFbRzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoddXIfX; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoddXIfX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso4566100a12.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 07:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787494763; cv=none;
        d=google.com; s=arc-20260327;
        b=ZM7T5KynC4gNzCgQyw7kUlpGd85a5AveDAsoQPiQmBfo9VHk9Qgg/QcYe22JuLiYYt
         sTibq0dpOmaH2bUMA8Vd30uoyEFpxSk4nKD2QlRr2QB4+NtuSfcd46tFzVePPPsyt1YB
         PfWnX/AqjVThem7rQNLkHiRGhewG8J6uRO6Py0OJ0wlfEHvWt5m+bs17UQO9BD941kZb
         3m+lCEe5WyrEUvL9PFkCRVlxQh6glMiY9/w+P8VN+96U+AfWFW+cHRazTBU8igXYXBus
         ONNknb8jVxgmh+kwpdXgdyIMZGvLWRahrN7K1kWMV56hNngab+yIOUSiBmZh5AYs6FEv
         Mq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=t+IlFxlQtgWmaAFDMh3aJapvbJDYuUjtmUAiMTgqn8g=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=PvHO6xr5omRYs2UDUOr5mo8hhdMBYOqt/PWcAbA1ijdEDCrs6YEPllufrVuVmZzzg7
         NIPEJAPdadTC2xFvlr7AZgfOjUcdhCZEdRv5C1c4dLmjgI3SFQQ7c52IibmVux49zbuC
         5TBcqabRv6Epd9mhqOp47w1dRuDGID9cTxf1pemrtuWUIh6V9e3yVY+d2Iaju60usmEc
         uWZJaxDnuN86rl4GjrAEQfvEfV9CHMmlT5wu228z5TqT//PZQn1WFo4qHTU5+dGMBBxI
         h6YK8joiUs6ES3IBqGXbnJJ7O763UC6JoJjnIbuZh3LfxXDcImqMzqtqfMgdnc/DM2pU
         DF0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787494763; x=1788099563; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t+IlFxlQtgWmaAFDMh3aJapvbJDYuUjtmUAiMTgqn8g=;
        b=SoddXIfXtrK+gP4yslVpParAs0+lToRasq7swWGfIewWN9l7MbauSygPyzVFNBl6rg
         Cfmr+UNsNZjMj5j+8siVAdpsp8kiHA8/0Yl8KlNxNGFIz/xX9km0cAOelBO93Whgy/Jb
         dLK8vzbHs2yMSB7Pfn9e9OQ+sLUO20Lo7tktgfDkh2ZszAPXc+AG48dX+FdzzUFlJtv6
         rXnY+SC2KpCrV5DRpp1e9GAdWv9BD896JBHt2BLJsYD+tTj6iCO06zzYoh1HbbzGI+3U
         bomTdwjC6hT7gD5QimTuuwMyMFZN1qR0NxwGmBkhkiBToBDX4tXiDalzCNl9YP/AGvAe
         ADGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494763; x=1788099563;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+IlFxlQtgWmaAFDMh3aJapvbJDYuUjtmUAiMTgqn8g=;
        b=RKWlj/bIDzprZ5M2JD00VeRfNXRMp8l/hCAhPmB71mdd62Wb0zLyLBPvMrEXzT3EEM
         WtQz4F5RLBob9X+mqziyOfowKZJ1Us2AMkJC6IMM4v2XbeZjT5vTuYYRqzbV/cavqvuH
         j4AnSFV0XRGODXhLL1Ag996ycw7mgeF1WsCaAV7c0X/QUKgvII9LPNjH11OJCjFQxswL
         uGnLTCVOgGbWF7wp9OzNaCGnRQ8mpvrftjpB3YeQU1FGMzESIvSLjQ8iZ5fNpT72gCUp
         x/Xpdw5yZ/JeVUmKdnHEX5KRWZEMFM1LI7A3YymIwJjPBAgzwnnCEzw3mUT65Qi+q52c
         Urhg==
X-Gm-Message-State: AFuF++msPgp0zBnyxpdjtwPYrJ9zxR+hrpEFPO7VmAx8w+/Gijo9qTyZ
	W0sWOQPVmQjr7Tj7p83rXDM5zHtYeEVk/1u87UAVBrum8cHKnVZ2AcMQ/GIu0KdtV5fWtsdFaN7
	TZcd7O5j0XKNlRw1fC+bIVR/pcF9n8IJIixdzflk=
X-Gm-Gg: AR+sD12DbyJuYVwAxLVSIzJz2t8rw4r2mypPwRmiGIhfNXPjvWD5O8nXCPj57Fv0bpY
	FjR3j+g9XHvWHeNY+DeYRPUaGfKG2N7yDlxyLJIvXT92EAYwvJTEx5HbOCXkMGxKzMwc8iQgzNZ
	SNcJzlGOhaYP2j7g8QICfFsfX2+JK8TxExbSV+Kf6gucijvcsqM7roPg8Toq6d+bXrbIF2Jy804
	/cBQvJa0eFUSP42FNHRkfoVBRM8TPzbGPbaEfP8ksfTuUfdIt71t76I4QsSFADE73xfUSPp/E+I
	YnGmAgQGnKQpFvS9oOPHnOhOpFY3cs2f+cV7Maqa9C9skV1aXjuZSmpHzQ==
X-Received: by 2002:a05:6402:510c:b0:6a1:fb46:c405 with SMTP id
 4fb4d7f45d1cf-6a42f1d6a2emr20412871a12.14.1787494763353; Sun, 23 Aug 2026
 07:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>
Date: Sun, 23 Aug 2026 17:19:11 +0300
X-Gm-Features: AcwNN1UKvu9qjx9jQ_X7JR4UFULh3SwwwUrdLSnC6LJ87rvmZg6W14R5zNOYLKU
Message-ID: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
Subject: Subject: [RFC] stash: let the stash stack live in a configurable ref
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

refs/stash is shared by the main checkout and every linked worktree, so
two worktrees push onto and pop from the same stack.  With git 2.52.0:

    git init wt-a && cd wt-a
    git commit --allow-empty -m base
    git worktree add ../wt-b -b b

    echo A >file-a && git add file-a
    git stash push -m "worktree A: half-finished refactor"

    cd ../wt-b
    echo B >file-b && git add file-b
    git stash push -m "worktree B: unrelated fix"
    git stash pop      # worktree B's own entry, as expected
    git stash pop      # worktree A's entry, applied here

After the second pop, wt-b holds both file-a and file-b, and wt-a has an
empty stash and a clean tree.  Nothing warned about it, and the entry is
gone from the stack, so wt-a has no way to find out where its changes
went.

This is documented behavior: git-worktree(1) lists refs/bisect,
refs/worktree and refs/rewritten as the per-worktree exceptions, and
refs/stash is not among them.  For a human who drives one worktree at a
time it is mostly harmless, and sharing is occasionally useful - stash
in one worktree, apply in another, as a way to move work across
checkouts.

What changed is who runs these commands.  Running one coding agent per
worktree, against one repository, has become a common setup, and the
agents stash and pop on their own schedule.  The failure above then
turns into silent data movement between unrelated sessions.  The same
report has already been filed against at least two such tools:

    https://github.com/github/copilot-cli/issues/1725
    https://github.com/stablyai/orca/issues/13695

I would like to propose a configuration knob rather than a new concept,
because most of the machinery is already in the tree:

  - refs/worktree/* is per-worktree, so a private stack has somewhere
    to live;
  - `git stash export --to-ref` and `git stash import` already read and
    write a stash stack under an arbitrary ref;
  - extensions.worktreeConfig and `git config --worktree` already give
    a worktree its own configuration.

The missing piece is telling stash itself which ref to use.  Say
stash.ref, defaulting to refs/stash, honored by push, save, list,
show, pop, apply, drop, branch and clear.  A worktree that wants
isolation then asks for it once:

    git config extensions.worktreeConfig true
    git config --worktree stash.ref refs/worktree/stash

Nothing changes for anyone who does not set it, and the tools that
manage worktrees for agents can set it when they create a worktree.

Alternatives I considered and rejected:

  - Making the stash per-worktree unconditionally.  It breaks the
    stash-here-apply-there workflow, and it moves existing entries out
    from under scripts.  If that is the destination, it belongs in
    Documentation/BreakingChanges.adoc for Git 3.0, with a warning
    released first - but it does not have to block a knob today.

  - Named stashes.  A name that survives a push by another process is
    what a ref already is, so this would grow a second naming scheme
    over the one branches and tags already use, plus commands to list
    and delete those names.

  - Leaving it to tooling.  It works - `git stash create` writes a
    stash commit without touching any ref, so a wrapper can store it
    under refs/worktree/<name> and apply it later - but every tool
    reimplements it, and the failure mode for anyone who does not is
    silent.

Points I am not sure about, and where I would like guidance before
writing a patch:

  - Whether stash.ref is the right name, and whether it should be
    restricted to refs/ (rejecting a value that is not a ref name).

  - Whether `git stash list` should be able to show the other stacks -
    a worktree's entries becoming invisible to the main checkout is the
    cost of the knob, and `git stash list --all` over
    worktrees/*/refs/worktree/stash might be a reasonable answer.

  - Reachability.  fsck and reflog expiry learned to iterate
    per-worktree refs, and I would like a second opinion on whether
    stash entries under refs/worktree/* are safe from gc in the same
    way refs/stash entries are.

If the direction sounds reasonable, I am happy to write the patch.

Thanks,
Vladimir Sitnikov
