Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD992AD2C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845127; cv=none; b=G4ubR+0nVnQkt3p3/KmwmQuh7QfqrkIrrhXQ5lJl0XfDAkT5v8jygyl5gGqC0aRVM8xhl++LECFjoUG9Rl1ddsh3YL0HEKsXLk5B2GpA6BDXegXA7ZGSJTNDfdARqEag3hE8y53r3SHUNU/V2lqyPVhKXxE6d7LUupyY6p5eVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845127; c=relaxed/simple;
	bh=YaOy/95Yzm0P87R9X++D6dpuwsMANTXZgPC5L8Q1T14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSOc+5tRKpY2lE7Yohb3diEpizhQ7ouH3gXL4mhz1F8ZnoM1jb4hHM9lJ+U4DZiqZVuTAOw8qkPf9BBld1+owv6SmGsARFS0SjwZtc3bb9RDTjjRtyltZ7hDVGUxrpo2wwM1BZL433zb4kUTy4OIGOGYJ3JqSuJ974Vu+GKTfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM9ypheI; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM9ypheI"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so44420675ab.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 18:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739845123; x=1740449923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB8Cb4doNJ5AB4NDZ8XnkCZUiLos1dPNREYeakA8WV4=;
        b=MM9ypheIDlXVcJbyTY5KNKW500l+gZwYT8ygpWirg98R7Ow4998F0SS5ooRZ3CKCgV
         Ez9zBtG2qWmhwxXoBv+UkxAzEEUnG9ibOKXfvlZKQozkRhvqPC9e5gIT6KVQGa/7ubhL
         STGNYJ62UOgsWZn6wyrrmjvW+O0ZUqkyHLIQo2XWQhaan4AEoK4KuM8jTx+VHQRkpKsf
         Nu5/oDN3uDK5iE6zcDCdrz6XK12ZsHmWPSIG4jUuDks43iWPZYG4CqucJi93BSGd/xt8
         8jCyvG8ThISgesNvcjZ7Fn2OMgt7RgnpAmu5GcLxB7GJuYNaDnbb9cuO8dTnqiSMMqig
         Rj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739845123; x=1740449923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB8Cb4doNJ5AB4NDZ8XnkCZUiLos1dPNREYeakA8WV4=;
        b=CpreuSGgqtlWTTlKRZZwUGK58vAWVYhT9CK7VQY0BDK7hgB6NQQwwO4pWfF6BngUWT
         9Xd9OkYBkVYF3nwqFMto37D7rDouBuPuJqbc9a6Oe3mzm3nnwugEjbhCnNiRfQik44c/
         OxAz9tkPI6wXypmTe7Csm+wmiXYt+A6YEaLk4J0NRqQnNtQJL/G4MdOMRdtVF7ueONpW
         1PwNrENBLYOhtq1uslQHOrKRiL6ktzR9nY9qCoV9Jl+ewpRXiAF9ryOuyoCLJyVotblu
         7qtWLa7uKlvysEunEzLAtfPtwalcJXsv32NqA9PZyOfkV6hYRh/9/WZ9WpNTxqQOZpFd
         3KlQ==
X-Gm-Message-State: AOJu0YynWdNHvKRAzO8ftid8JVNuLUJvSsPl9VJ6wRS0/R+lxOjLV3u0
	qbLVIRqYzj+e3amYFofCui7K4s0OTszCS542HWS1pQ79egwE1Zi7HWzUJmN5IEtI8VS0WlVULPX
	0ztCzV2QZmSYk7w5CUZ2uBsPR3RJmhm6t
X-Gm-Gg: ASbGncsAP3AkB6SUTahkea3wFAxjN4N2nQCAxrn0L/dTOv8zhMfMqvPj5qJ8gyJ9fYN
	ekbYACWxYfJHiO16JlK6R2fCuy9dcDRyV552Wb8QTpdvSUaRiLEvckHb3v46Im/YetzWZ5FwKYG
	t4dq4ZkV+nr7Fqzba14O1jD81ccgC2UQ==
X-Google-Smtp-Source: AGHT+IGvZ1ql69MY+T6VoKBgufbOWgcYOGhmd6ZY6oUGPEijSTepTsqxsykh7HMxpHJzqAppxFiXY+YbU/q30KwuZgI=
X-Received: by 2002:a05:6e02:1c28:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d2807c57ccmr88656955ab.12.1739845122848; Mon, 17 Feb 2025
 18:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217232847.8567-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20250217232847.8567-1-lucasseikioshiro@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Feb 2025 18:18:31 -0800
X-Gm-Features: AWEUYZme0x6edoqVPJ3XK4ae-2u9fF3TD5JivnQLHgYZfxdjI0zRvOtsQ9tGTGg
Message-ID: <CABPp-BGpOi9ZqrPFwxCiRLFjozgnYKV=zbYVAA5c9Z9yDUTBGg@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH] git-merge.adoc: detail submodule merge
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:29=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases on handling the conflict before yielding it to the user. From the
> merge-ort and merge-recursive sources:
>
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
>
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
>
> Add a small paragraph on git-merge.adoc describing this behavior.

It may be worth referencing the commit(s) that introduced the behavior
for other reviewers: commit 68d03e4a6e44 (Implement automatic
fast-forward merge for submodules, 2010-07-07).

> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> Hi,
>
> This is a "scratch-my-own-itch" documentation patch. Some years ago I was
> questioned why some submodule merges on GitHub lead to conflicts while lo=
cally
> they didn't. I only could find a answer for that reading the merge-ort so=
urce
> code, then a wrote a blog post about that, which you check here:
> https://lucasoshiro.github.io/posts-en/2022-03-12-merge-submodule/
>
> Thus, this patch adds to the official documentation what I found at the t=
ime.
> I wasn't certain if this should belong to the submodule or merge document=
ation,
> so, by now, I'm sending it as a merge documentation patch.

The merge_submodule() function was moved years ago from the submodule
code to the merge code -- see 18cfc088661 ("submodule.c: move
submodule merging to merge-recursive.c", 2018-05-15)
-- so to me the documentation makes more sense to be associated with
merging than with submodules.

However, a bigger problem I see is that documenting how the merge
machinery works is not really specific to `git merge` but is general
to any command that uses the merge machinery.  Thus, it also applies
for cherry-pick, merge-tree, rebase, replay, and revert. But I don't
know where that kind of general how-merging-logic-behaves
documentation should go...

>  Documentation/git-merge.adoc | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
> index 64281d6d44..7b12c0d648 100644
> --- a/Documentation/git-merge.adoc
> +++ b/Documentation/git-merge.adoc
> @@ -205,6 +205,13 @@ happens:
>     same and the index entries for them stay as they were,
>     i.e. matching `HEAD`.
>
> +In the case where the path is a submodule, if the commit referred by it =
in HEAD
> +is descendant of the one referred by it in MERGE_HEAD or vice-versa, Git

"referred by it" is hard for me to parse.  Maybe something like

"""
In the case where the path is a submodule, if the HEAD version of the
submodule is a descendant of the MERGE_HEAD version of the submodule,
or vice-versa, Git...
"""
?

Also, the references to HEAD and MERGE_HEAD do tie this documentation
rather directly to `git merge`; the basic idea is applicable to all
callers of the merge machinery, but none of the other callers use
MERGE_HEAD (some use CHERRY_PICK_HEAD or REBASE_HEAD), and some do not
assume HEAD points to one of the parents either (e.g. merge-tree and
replay).  So, if we want to move this somewhere more general, we'd
need to reword it a bit.

> +attempts to fast-forward to the descendant, when using `ort` or `recursi=
ve`
> +strategies.

Oh, maybe we could put this information in
Documentation/merge-strategies.txt?  Hmm....

> Otherwise, Git will treat this case as a conflict, suggesting as a
> +resolution a submodule commit that is descendant of the conflicting ones=
, if one
> +exists.

Thanks for sending this in.  It's always helpful to get researched
documentation improvements, even if I can't help but nitpick and
complicate matters here and there....  ;-)
