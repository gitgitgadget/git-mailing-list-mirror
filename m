Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457147;
	b=SINUwFrcmbL0XQnw/VDcFdt7a9D1CmVW07t7HEDoLRx+iaDWO++EFT35jx9uCR/3Aqys
	 IEQG6z0MQ5pAdtEsQK8vlM56PWuD0/S0OmWh60dCAILODceXnBAl14qi3UHUiNvlZSO8J
	 nN9YGjAJg/OFtg84XSKfgNUTKTv434iSXSzm/ptAaYWVKUPKvwQDfeYiRAXvhof7F/3rS
	 k9rBHCMFouY1bjU3Dl2ryTLQDhv+Zwv6IWSURkPy+9TfuPb0SrRjQZh5Ejj5qbENo4IzK
	 AqP3FBfk488onOBX133ZoprBtZLBdgewyegIKAiGJXyZV/6ZCUPaosFbyCgAM+P+Hog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7WatdTsIEhGYcnAVANXUTPTIJheTfyYiGU7xlMphtHg=;
	b=42SLsJNE7bDyRHYnEJMVRA2bqIIf81KvL0vY+9iW5bQp1d4CGQ54xbEHcWrxIg+gKDh0
	 99svpo/afkPn7FhFG075o4NgVtEtaTs1AHgHVBuUwsmJ+YHugE9lUFbWciNaDJ5XG0tzK
	 cm+mNhQBIyzLMDWaAaYS0aPG5SZXJLrMMnSOIAEf4XmyLGEU7rqW9Fds8hG06RuYL/3au
	 rh7M11G+dY4uoeqQsw4N764+5BRRnEiOEdBBPrxxmt3c119/jpnDDn7bteyURCgKmH1KG
	 8wBYhjHWjFcYzclwIY8fbnBpa+A+o/P5frGaJpOpKcPgtl0BrrGi1OjpzwcRnPEji8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1WRDCLR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A3606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA7A3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1WRDCLR
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so1734447a12.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457146; cv=none;
        d=google.com; s=arc-20260327;
        b=g1AOT4/TlmiLQdosU8wXyk1LV7Td71ATVLToFwHygH0i9mmC2HRFFqgcMSo5hUuRFH
         TUVD6/hpVtmOTxk4o4Sp0OvRRX2NSyZE9SL3Qm71jZcE2QgUQCqA37/zyK/8LTosVBGL
         2IhfC0ly/DmwdhLaInjESP9vAvI07FmJkOuid6kEbgqBPP+m+OGc76e6UMe7Rdjvzpzs
         X0J5PEzPV0AyALA6zQMyMFRR9rdz+CAjwV0Qh/UuaT3ExQ3had54KcAQ6Tr3dxOoN5Rw
         9YcM03AIXtgpqNtpszAWF1OaMZEU+5pcRTTtVPEHS/bwhVeuZDoF9t6IgIjqribRINZH
         HaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7WatdTsIEhGYcnAVANXUTPTIJheTfyYiGU7xlMphtHg=;
        fh=5cBHY3USooCla+yv481n9hsB6we/sj4VskIBrYs8/9g=;
        b=jeo0NeqcMWkvaS7f4H5YMOxl8nkETNyeu2ptxhttdPEU9qTUlMKcbAK7RouNaRZjkf
         5lHzcRB94K9CdRKA/5mQacNO5+hFOB7qysQAcTJrbzaHgNapsLDhoL9bRE8Fl+XugCVS
         QJ/aansP1YMbAjvVB96TEuSjALLxE8QEKQau5iwsZAP2IcBgf+ue09ZthegLdovE5igN
         lFmmCf0ivSV8VSdlc8YBWkTwJDqBxSoFN9WcOxe6JKTLLALacerIuHeAHIDKGEowc6qp
         PTVVaywsXz2p8pafYDTTXFp+mjZ4be1UMc1ncINXirjhG8EItnWIs0pH4o49t0jH3Ecn
         AXDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457146; x=1796061946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7WatdTsIEhGYcnAVANXUTPTIJheTfyYiGU7xlMphtHg=;
        b=t1WRDCLRgkiMs4C/Eu8sm/wl00mFKne0zn82PwSlbBfyAiGLELXr+gnAfEIPgtK+S7
         nrPXfgzA7WgbulJ0FJ5gEVrbLCR/w/e0+vAbuTFQGPKteaOri4emC0imDCbnQdqRmf0k
         UAFIYTPil2NdRdeEEjsLRKbWuz5rVpxPw8bb0JVTwo2s6zk8HBkeum/fX5xdGGU/BuoR
         YvdqHqUm2IXhUnvgjaExPC6x9tsf47JQrh5aSKKYj7eNe8zHISyP5tBBfi93PJqSCi+3
         cKzbRZhxd3eeYg+Wq3ZwR9pYk9mIdk9yoZce/EfCgcqSc+/jPG4ZcXlCM1tUeo853RQT
         oLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457146; x=1796061946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7WatdTsIEhGYcnAVANXUTPTIJheTfyYiGU7xlMphtHg=;
        b=j4kmghWEbZUPz/DO86VKCNSCXXgf9q2s/F3XsK3PLUPn1E9uhLUDkn1v3t2Fb4RDTt
         8kgslozZtgg32QNp8lKhcO4nsyE7+FzILNm1yZBgxr0OqJVzAVMYZAPlvfN0ScBa6wdQ
         lK8EAc6NxRi/sUFJfVQ6hs1rY3Zm+kR3EMuDrVXArlGkhsBpAcCZGCUDOG9lwtUqB5j6
         DmPukEcjumhkGKnuixs6H/tnp4BcUUMwgSkVbiLFrEqNojUrc8qgHFVhgnt8fHvQ73Nt
         71VgxPIvMVsUEBkdRDUu62QcZ4ya7uA93Ll7HCCyoO6pVhiymK9vLnXg1CWK8lM95PXB
         Ub0g==
X-Gm-Message-State: APuU4Z/Qzb6nNjPQ/hljt84nnIscfBV8d2P9/vS3HnaWmACZbhMoUY8T
	coRzw3X43Oui5kjFGoNwCr1piUE76hSIDrpZjOHoBJdhDoLIZfRjMqanlOUdH4u/23eXZFargm0
	W9HHK3viGv6D9t7WXAM+2cUBFtf0Gdtc=
X-Gm-Gg: AZFdTZeT4n5BknVt4YhB1TvpcKAbB5An4cfTkX2Aa7Zkcdau6ENdtkRIIt1WB1xw56s
	SdfV+czy5oAyvlF2n3VJ/gMh1f5dCKiTsmKuSoSzi/tMLAWHPGR9AHzSJHIPTeZzLUVRBdPyPPB
	SR7v3ZH5JQGfvI2gOM1OuerRYtlLp5WvFZ/dmlF5CXMiPLYdT51Gm5GlZoDo+GQgkHaQcWCnKRB
	1TLm+2n1P2V8Xo+T4tDpV58iMMFz4rosENLX1cSEOBlyegZ9r3Qz4y9siQmBpohLG24cQq3kz8k
	h7FT1oEZULhxT7tRntEB0A90P6b7vGL5QPx5otby7HP2ImP69wf/pFWWr6NB51ODRPOwubD3fNM
	kZxrs2mA0Q+V8k7ieSzXnt/l1U+wjd0oiDe6sHpc60ts1pPMn6o/BOMtTZ1IWcBhsmUyBR6l/0N
	c6eO7Qmq1/BZSfaE17k2nL/66j8Kme5258/0m8Mu+vhiFQgevWo/gug9DuzgfFJlbC3hzk7Hifc
	5xvykeZ423RvrrfE9B7d/KLxyayDTLI+YgY
X-Received: by 2002:a17:90a:d2c7:b0:3b1:21d9:4c3d with SMTP id
 98e67ed59e1d1-3b41c9324bcmr10307934a91.39.1795457145950; Mon, 23 Nov 2026
 10:05:45 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
In-Reply-To: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 23 Nov 2026 13:05:34 -0500
X-Gm-Features: Aa3M54rjf23o3iP87xO-d7cfgegRmcxxWArUBYUAS0seYGzW4TD_M89sVPMMvE0
Message-ID: <CALnO6CD6vu1ed3jw4oDceV4n0+zdsOaJGqSHhgaeEWsgGk3owg@mail.gmail.com>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Julia, sorry for the delay! I've read the current email thread, so
I'm replying with a bit of "foreknowledge" ;)

On Mon, Nov 9, 2026 at 4:33=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> Because Git's branches are so flexible and the meaning of a branch is
> only what people assign to it, it's important to talk about some of the
> social context about branches. Do this in two ways:
>
> 1. Introduce some imaginary characters who are learning branches for the
>    first time and examples of workflows they might use. Test readers
>    said this was helpful because it helped them see different ways
>    they might use branches.

This is extremely helpful, not least because of what it does for this doc, =
but
because it sets up future guides to refer back to well-known scenarios. In
particular, I'm mulling on a triangular workflow guide, which could feasibl=
y be
one component of a guide to collaboration with remotes; these characters wi=
ll
have different things to say about remotes!

> On `git log`:
>
> - Use the output of `git log --graph` to visualize branches instead of
>   a more abstract ASCII diagram, since it serves a double purpose of
>   teaching people how to read `git log`'s output.
>   But also mention that folks may prefer to use a GUI to visualize
>   branches.
> - Include two sections to explain the output of `git log`, since several
>   test readers found it very hard to understand. In that explanation,
>   only explain `HEAD` fairly briefly and instead keep the focus on the
>   idea of a "current branch", since that's the term Git's UI normally
>   uses.

Much appreciated. Another thing I've been doing at work is showing folks ho=
w to
find a "map", as it were: my recipe for getting folks unstuck with Git is t=
o

1. Find out where you are
2. Decide where you want to go
3. Discover how to get there

and git-log is crucial for step (1).

> On the conceptual introduction at the beginning:
>
> - One of the biggest issues with explaining branches is that there are 3
>   ways in Git to think of branches and it's not straightforward to
>   explain how to reconcile them:
>   1. just the commits that "branch off"
>   2. the latest commit on the branch
>   3. the full history since the beginning of time
>   Handle this by starting with the "tree" metaphor where branches
>   "branch off" a central trunk (way 1), since this makes sense with how
>   people actually want to use branches. Point out some issues with the
>   tree metaphor and talk about how it relates to the way Git represents
>   branches (way 2).
> - Avoid using computer science jargon, because it's a major barrier to
>   folks without a CS background. It's not useful or realistic to teach
>   most beginners the term "directed acyclic graph" just so they can
>   learn branches. Mention the term "directed acyclic graph" briefly in a
>   note for folks who are already familiar with that term and link folks
>   to the data model if they'd like more information.
> - Include some basic facts about commits. Folks seemed to find this
>   helpful, one person said they didn't realize it would be so hard to
>   change their email address later.
>
> To keep it readable:
> - Don't assume that the reader has read `gittutorial`, and instead
>   refer back to it explicitly if it's relevant.
> - Always include the output for every command. Test readers said
>   this was helpful.
>
> Other choices about material that is/isn't included:
>
> - `git-prompt.sh` (yes): Mention how important it is to be aware
>   what branch you're on, and suggest using `git-prompt.sh`. Link to
>   git-prompt.sh on GitHub since several test readers couldn't find it on
>   their machine. The test readers liked this.
> - fast-forward merges (yes): Explain the difference between a fast-forwar=
d
>   merge and a merge commit by giving examples of what each one looks
>   like.
> - upstreams/rebase (no): Don't explain what an upstream is or introduce
>   rebase, since we're already introducing a lot of concepts. Instead
>   include a "Where to learn more" section with some pointers to where to
>   continue learning.
> - GUIs (yes): Some readers wanted a suggestion for what GUI to use. It's
>   very hard to suggest an appropriate GUI because there are so many and
>   so many of them are not open source, but give a couple of suggestions
>   of open source tools that seem to be popular with the community. Also
>   mention that many non-open-source IDEs have built-in Git integrations
>   for folks who are already using those tools who might not be aware,
>   since they're a popular way to use Git.

All quite sensible to me.

> +Step 8: Create another branch
> +-----------------------------
> +
> +Now create a second branch called `add-animals`. We're creating two
> +branches to show what the process of working on multiple changes at the
> +same time looks like.
> +
> +First, switch back to the `main` branch. This is important because
> +normally when you start a new branch, you'll start it from the
> +current `main`.
> +
> +We normally start from `main` because if you create a branch called `two=
`
> +while on the `one` branch, merging `two` into `main` will also
> +merge `one`. Starting from `main` keeps all the branches separate.

This feels a bit confusing to me on first read, if only because the "two" a=
nd
"one" branches are hypothetical (and because we haven't covered merges yet)=
.
I don't love to keep the reader in suspense ("we'll explain why we do this
later"), but I do wonder if we can give a better demonstration of what happ=
ens
when we stack a branch like this by using the example names here?

Perhaps we can start with the idea that we want to keep work independent
("Branches are a tool to organize your work", "working on multiple unrelate=
d
changes"), and then after merges are introduced we can revisit the stacked
version and show what happens in that scenario? There are pros and cons to
stacking, but I think covering "branch per independent idea" as the norm is=
 a
good way to handle it.

(I've used "stack" here because that's what the industry is starting to cal=
l
such things, though even then such a stack is usually held together by a se=
t of
related ideas. This example is independent enough that I would probably tel=
l the
author to split up the branches if they were stacked!)

> +Step 13: Merge the `add-fruits` branch into `main`
> +--------------------------------------------------

> +Here you can see that it created a new commit `e3c630d`. This commit
> +looks different from the other commits because it has two parents:
> +cd4bb48 ("Add fruit list") and 1ceb7b4 ("Add animal list"). This kind
> +of commit with two parents is called a "merge commit".

> +Note: merge conflicts
> +---------------------

> +See linkgit:gitmergeconflicts[7] (`git help mergeconflicts`) for a
> +guide to handling merge conflicts.

> +3 ways to think about branches
> +------------------------------

> +How to use branches to collaborate: it depends
> +----------------------------------------------

> +Using `git pull`: the basics
> +----------------------------

> +Example: Emilia the PhD student
> +-------------------------------

> +Tip: put your current branch in your shell prompt
> +-------------------------------------------------

> +[[guis]]
> +GUI tools
> +---------

> +Where to learn more
> +-------------------

Here are the last handful of sections, and 2 paragraphs that come between w=
hat I
see as major sections. Here alas flat text bites us a bit: it's not particu=
larly
evident that step 13 + it's merge conflict note form "the end" of the pract=
icum,
and the stuff afterwards is (somewhat) back to the introductory concept ide=
a or
examples.

I don't have a particular way in mind to alleviate this, but some ideas:

=E2=80=A2 Transition paragraphs? ("This concludes the tutorial on XYZ; next=
, we'll
  cover a few more branching concepts")
=E2=80=A2 Perhaps the Examples ought to come earlier, but I'm not sure: we =
want both the
  branching material and the collaboration aspect for some. Maybe we could =
move
  the solo project earlier, and return to it to mention the backups/pushes =
after
  the later bits about push?

All in all, I'm quite excited to see this be available to folks.

--=20
D. Ben Knoble
