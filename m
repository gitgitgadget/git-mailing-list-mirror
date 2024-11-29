Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA9168DA
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901545; cv=none; b=jlJVs8ZfMm7Y5++7wqbK9NLXBpl7zqFuocS+fXLCCTWmlV2n0oeyzL9EJ5iTYEG8WLzwvGe5x8L+mGnkzIE16YKRHQb4EfnJj0p+tvzzQQbosYAX6VLCEB6wpz+/zmh7qcWZm7ZzaEdQwrEF359p4GCLbuoKuuICTL90lABbVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901545; c=relaxed/simple;
	bh=Q/1MTPn32Z7AXpHKq5XVGMwdTyo3q99vAnZPrfD2vDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m20bIzqYyh9w0HzMnNKO6yro0WYUlIuQvXE2kcM9xj4f352V6m7NiX7VaeFPw2uXx172kbr/Fq1jtvzzHo1O41SvwfeGnXpGc9/HFyymkHHd6SueHZVxDk0polSsEE6431QeHYar9+G1ldCo2eZrYKiFevvYpF0jW4kCuaPfzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ2+8DBC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ2+8DBC"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so2139438b3a.0
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732901543; x=1733506343; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T2GoXK5mcxHVbCxTVCuk3l9dCQeVM3YcYU9XRsIGZgc=;
        b=hZ2+8DBChbaQgtZFS0CgyPun2vuVwe1bfNJozWtgQOfj8MneXY6R/suSws51x96iri
         X5zG/9eDJgsP8WQdxYiqkkwv7wMkt9/9Yf0C5YV1yL4Hn1lm/FOFshOlRY6PXMCI0Wd8
         DcQRLwARS5Czn5LZzUaj99sans+ANs78HrpbiS8gQZlSb/3+WDTORrqAX9QR6/IPpt6R
         VZ3TOQUZERZSzRexlgWODz6EqeZGUX3PNPSOpIxz15FrM4zzlmq8zCCIPqS1aXSprIyI
         YPYubE9fNtXzlDA4PQovqRvyS8/Ue0lV8Fmu/8FwYjTkfc0e2pWlQD2fuYmU4TFTlOjv
         4epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732901543; x=1733506343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2GoXK5mcxHVbCxTVCuk3l9dCQeVM3YcYU9XRsIGZgc=;
        b=remGYF2oVv4gW7QgoGGXjS6C3fXaRYKC1WDIGWHzqRRaOIopP+sr52gpWkwUpXMnXh
         rLRtCdJW13XtDsL/gZ40Qv4NdFR9xS96q3xFIxhXHYY46+GuS2ZFETdj2PjDfvWw1DJf
         JtcD8MSPA+NxLGbxwXIIqNaOBSfizZ0LJ7Ya+zJPsvTPF3ryP5b295Yta5rkIXdclUzh
         uBZpVAc1P+2VkABW/0xaQAvqYpPsCehoCz/vMM8TvAKsv7jrKqakGtIrTsexX99dEqW6
         jBY839oBvhPu8/LUIgB6Jo3smPR8y6j0tJAfGh96sXjQnEeDpkYNxHIY5BArQEtk5Fq1
         TvBw==
X-Gm-Message-State: AOJu0YwNINvIKpXEwy4OdZECKOLs8Mz8uV4y8Vxv7dL+AvAC+2ex1zYo
	U6T9UvqS/PhKvqJmppPiBYFb3t29qrX39LzzirjA9cosVIIqQxpt
X-Gm-Gg: ASbGnct93Gq0ie+1Xn0RFCKQVDaxCGMrBr9wKxNEYNtBflLc4FBXPu7zukpGrikMWfM
	cgB7RxjOwMIJA+gKtge7a8Vhy3jjl9USR0r6QwXLjJyUo+QCCod0grT8t/tE5I8d/pLROSbjduK
	qsHDw7+RuC1f4NWmgye1Z1OBvPsWjNRnFh1gZKOV+l/cTo7fKvsAsSXx5p7ZqllIy3vKCPQ9Lg+
	eNshUm+U1SfCUZtTQCpTH1mbKd70MNXPIbDpQgjXWtAGg==
X-Google-Smtp-Source: AGHT+IEIX2R/KykbPdPHbqypCPkU2WhrXzdWwMSdH1Daw4skTG8SYF59dRqooAfG8SS1paGuHKVEew==
X-Received: by 2002:a17:90b:35c9:b0:2ea:4a6b:79d1 with SMTP id 98e67ed59e1d1-2ee08eb2bdfmr15772677a91.11.1732901543272;
        Fri, 29 Nov 2024 09:32:23 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee6cec695csm900424a91.2.2024.11.29.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 09:32:22 -0800 (PST)
Date: Sat, 30 Nov 2024 01:32:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <Z0n6uuNdQZCLqAz2@ArchLinux>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
 <Z0mgAt9ssu_32tTQ@ArchLinux>
 <D5YSBQXU7FYD.25KOIM1N3US88@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5YSBQXU7FYD.25KOIM1N3US88@pm.me>

On Fri, Nov 29, 2024 at 03:58:16PM +0000, Caleb White wrote:
> On Fri Nov 29, 2024 at 5:05 AM CST, shejialuo wrote:
> > On Fri, Nov 29, 2024 at 02:44:24AM +0000, Caleb White wrote:
> >> The `es/worktree-repair-copied` topic added support for repairing a
> >> worktree from a copy scenario. I noted[1,2] that the topic added the
> >> ability for a repository to "take over" a worktree from another
> >> repository if the worktree_id matched a worktree inside the current
> >> repository which can happen if two repositories use the same worktree name.
> >
> > I somehow understand why we need to append a hash or a random number
> > into the current "id" field of the "struct worktree *". But I don't see
> > a _strong_ reason.
> >
> > I think we need to figure out the following things:
> >
> >     1. In what situation, there is a possibility that the user will
> >     repair the worktree from another repository.
> 
> This can happen if a user accidentally mistypes a directory name when
> executing `git worktree repair`. Or if a user copies a worktree from one
> repository and the executes `git worktree repair` in a different repository.
> 
> The point is to prevent this from happening before it becomes a problem.
> 

If we could prevent this, this is great. But the current implementation
will cause much burden for the refs-related code. In other words, my
concern is that if we use this way, we may put a lot of efforts to
change the ref-related codes to adapt into this new design. So, we
should think carefully whether we should put so many efforts to solve
this corner case by this way.

I somehow know the background, because we have allowed both the absolute
and relative paths for worktree, we need to handle this problem.

I agree with your motivation, but we need to consider the burden
introduced. This is my point.

> >     2. Why we need to hash to make sure the worktree is unique? From the
> >     expression, my intuitive way is that we need to distinguish whether
> >     the repository is the same.
> 
> During `worktree repair`, an "inferred backlink" is established by
> parsing the worktree id from the `.git` file and checking if that
> matches an existing worktree id in the current repository. If so, then
> the link is established even if that worktree belonged to another
> repository. The easiest way I thought to prevent this from happening is
> to ensure that no "inferred backlink" can be established by using an
> effectively unique worktree_id. So two repositories can have the same
> worktree name (e.g., `develop`) but the actual ids would be different.
> Additionally, if the ids **do match**, then this would be indicative of
> a copy situation like the original topic addressed.
> 

OK.

> How do you propose to distinguish whether the repository is the same?
> 

I am sorry that I cannot tell you the answer. I haven't dived into the
worktree. I just gave my thoughts above.

> >> This series teaches Git to create worktrees with a unique suffix so
> >> that the worktree_id is unique across all repositories even if they have
> >> the same name. For example creating a worktree `develop` would look like:
> >>
> >>     foo/
> >>     ├── .git/worktrees/develop-5445874156/
> >>     └── develop/
> >>     bar/
> >>     ├── .git/worktrees/develop-1549518426/
> >>     └── develop/
> >>
> >> The actual worktree directory name is still `develop`, but the
> >> worktree_id is unique and prevents the "take over" scenario. The suffix
> >> is given by the `git_rand()` function, but I'm open to suggestions if
> >> there's a better random or hashing function to use.
> >
> > The actual worktree directory name is unchanged. But we have changed the
> > "worktree->id" and the git filesystem. Now, we will encounter much
> > trouble. The main reason is that we make the worktree name and worktree
> > id inconsistent. There are many tools which assume that worktree id is
> > the worktree name.
> 
> Do you have any sources for these tools? Because I'm not aware of any.
> Any tool that needs the actual worktree id should be extracting the id
> from the `.git` file and not using the worktree directory name.
> 

I am sorry that my words may confuse you here. These tools are just the
git builtins. Such as "git update-ref" and "git symbolic-ref".

> > In other words, there is no difference between the worktree id and
> > worktree name at current.
> 
> This is NOT true, there are several scenarios where they can currently differ:
> 
> 1. git currently will append a number to the worktree name if it already
>    exists in the repository. This means that you can create a `develop`
>    worktree and wind up with an id of `develop2`.
> 2. git does not currently rename the id during a `worktree move`. This
>    means that I can create a worktree with a name of `develop` and then
>    execute `git worktree move develop master` and the id will still be
>    `develop` while the directory is now `master`.
> 3. a user can manually move/rename the directory and then repair the
>    worktree and wind up in the same situation as 2).
> 

Thanks for this information. I am not familiar with the worktree. I just
have learned the worktree when doing something related to the refs. So,
it is true that worktree id and worktree name are not the same.

But that's wired. For any situation above, it won't cause any trouble
when the user is in the worktree. Because the user could just use
"refs/worktree/foo" to indicate the worktree specified ref without
knowing the worktree id.

So if a user moves the path from "worktree_1" to "worktree_2" and wants
to do the following operation in the main worktree:

    ```sh
    git update-ref refs/heads/master \
        worktrees/worktree_2/refs/worktree/foo
    ```
It will encounter error, because the worktree id is still the
"worktree_1".

But when the user create the worktree using the following command:

    ```sh
    git worktree add ./worktree_1 branch-1
    ```

The name `worktree_1`(path) will be the worktree id. So, when moving the
path "worktree_1" to "worktree_2". The user won't know the detail about
the worktree id. The user (like me) will just think that "worktree_2"
will be the new worktree id.

That does not make sense. It's impossible for the user know the mapping
between the worktree name and worktree id.

Hi Eric and Junio, I am wondering what the purpose of worktree is. When
I implemented the consistent check for ref contents, Junio has told me
that the main-worktree symref could point to the linked-worktree ref.
The linked-worktree symref could also point to another linked-worktree
ref.

But from above, it gives a feeling that the purpose of the worktree is
to make the environment totally independent. And we shouldn't allow any
ref interactions between the main-worktree and linked-worktree. But we
DO allow at now by using "git symbolic-ref" and "git update-ref".

> The suffix is not a new concept, I've just changed it from occasionally
> adding a suffix to always adding a (unique) suffix. The worktree id has
> never been guaranteed to be the same as the worktree name, and as
> mentioned above, any tools/scripts/intelligence that need the id should
> always be extracting it from the `.git` file.
> 

Yes, I agree. Thanks.

> One thing we can do is to add the worktree id to the `git worktree list`
> output so that users can see the id and the name together. This would
> make it easier for users/tools obtain the id if they need it without
> having to parse the `.git` file.
> 

This is a good idea, if we need to use this way. And we may also need to
add documentation.

> > Let me give you an example.
> >
> > So, with this patch, we make worktree-id not the same as worktree name.
> > If we do this. "git update-ref" cannot find the
> > ".git/worktrees/worktree-1/refs/worktree/branch-2". This is because the
> > filesystem is changed to ".git/worktrees/worktree-1-<hash>/...".
> 
> Yes this is expected because the worktree id is not the same as the
> name.
> 
> > If we use hash / random number to distinguish. We also need to change
> > the ref-related code to ignore the "-<hash>". It's impossible to let the
> > user type the extra hash / random number. However, this requires a lot
> > of effort.
> 
> This would be possible as long as the given worktree slug is unambiguous.
> However, I think this is more trouble than it's worth.
> 

As you can see from above, the main problem is that we allow some ref
interactions between the main-worktree and linked-worktrees.

The reason why I use this example is that I am afraid that the user will
create a new symbolic ref in the main worktree which points to the
linked-worktree ref.

When the user create a worktree, it is natural to think that there is no
difference between the worktree id and the worktree name. And will use
"worktrees/<worktree_id>/refs/worktree/foo" to access the ref in the
worktree.

And It's OK to add hash / random number to the worktree id if worktree
is totally independent. However, at now, we allow some interactions
between the main-worktree and linked worktrees (even the linked
worktree and another linked worktree).

When doing above, the user must know the worktree id. But at now
worktree name is not the same as worktree id.

So, I don't know...

> > So, I think we need a _strong_ reason to indicate that we must append
> > some chars into worktree id to do this.
> 
> As stated above, git already appends a number to the worktree name if it
> collides with an existing directory. Always appending a unique suffix
> should actually make things simpler / more consistent in the long run
> because the worktree id will always be different from the name instead
> of occasionally being different.
> 

In general, I agree with your way now after knowing the truth that
worktree name is not the same as the worktree id. However, it seems that
the situation is a little complicated.

> Best,
> 
> Caleb

Thanks,
Jialuo
