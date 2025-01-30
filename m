Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB11E9B27
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247557; cv=none; b=hEpA2NZfeg2IsI+SkhsRVZHUJDGiKfTeOpkffBKVpMrC/+IpMIUv3F3hABOMHMOxpWotXHP6wj9OTaQY33JucyCOi5+XiI8Fu6/WAU195sUkUDueZ/V60rcIsT/tx0QEwWPbHMAuwp86xVIXg1t/LKFbL9U4ScpA/SacQ1BnD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247557; c=relaxed/simple;
	bh=YljyOJteGpZsIQnJaCt4ckPvUGuLJ2UJJe7ssE6ApMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOFTVe2KQB2OkPgoGkFB4Mk7aE/d0eut683JKGBeVaxwv2tMwRyYWjBfKIfvPVrEj1fg2aNynykhdN/tcvuSjnaCDfOfdcpxDLmZfc1Mtij6VSAB6iDd1KEksy5rV14Jf2EVw2x1JJ9i1lC3CnfNM/gZG2uDA6aQDW30NM9HogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d90044ac35so533246d6.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738247554; x=1738852354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICIQJ5i4Lg1Q+R4skftjutO92e3DyfJ8D4uT8Fk2eeE=;
        b=ueaB1ziaCrZRRTXQHoMeA33wPygYVUmL9yTQUX5g9RQ0oO+dnjtdX0S8Kci1DhxUe6
         /ZjmsdhxIxrIi+dkgpV6KexExkVowY4fbHiRjSSIKIVUHC4AO0zhFaIo0PLNA/pLeaCV
         WVK0PApOg9nnYc7KCGZaYqSGBn2YsgPavT7ncdSGWyJyRc0i7pWRaRXhqcQAaQcXFSTP
         0mmV+MGcYwL/ndIBgmJEF6AtFuHF4VPy8Ur0QH1oHXz9C7/VzCiou79whktoTLVoJ22T
         CAnNBp/UXWjzL417SQQA5ztohuzkzAX3C4r3rWlTC599WKjAM+xAUgXbjQXUdH6KV2Om
         ozXA==
X-Forwarded-Encrypted: i=1; AJvYcCV2d2gMFPtsj6/VabltTxtWmg+KuW8eegzGEXUv4C3TJBaAjH6FFw8mkNKEENd8PlJRYp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAqkCWR8MRg5myv1O/3XlfwgQDeBilolI/5Y9m7vKlCkFR+ZR
	b/VW0ei7lDdOlxHJULH38dxopCJiUCGP+WjlWMFES4r2rnYJP41qlcN6AHuiElC6B6pHYDPGcBd
	3AD3NH8vfv+jQ5JSs22Cr50KPThFOfKa4
X-Gm-Gg: ASbGnct3mpFVedPNAtRpqHx0mGEt7IMpcKqUuP09STUP7bXRXY3WFskcslpcpBdsgL4
	s6MJAjXbMAPMw5QtpLjEBTq+A69+YbJ2WVQ21+9FP7AF7Wc3zgkjaduHW4/c8zyBXI0HN3be0kk
	cqqoxgPeU8cDTqEXbQBq6906N7hAxumw==
X-Google-Smtp-Source: AGHT+IG+zG0cqe5cjJCT3iXygeRAE6ntH/g0lGYuWHb2W4RuIvmWDJ6IWLZys5UgW/7KXckhszu3/TY0a/RW68RRXUM=
X-Received: by 2002:a05:6214:3018:b0:6d8:adb8:eb8c with SMTP id
 6a1803df08f44-6e243cdda8emr41046396d6.10.1738247553988; Thu, 30 Jan 2025
 06:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
 <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com> <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
 <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com> <CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
 <F15C12AB-2238-4553-AFA5-18277B18CE5A@shopify.com>
In-Reply-To: <F15C12AB-2238-4553-AFA5-18277B18CE5A@shopify.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 30 Jan 2025 09:32:22 -0500
X-Gm-Features: AWEUYZnV9bk5P_ZCtdyGpbQjtzw5DqftcmU9ohPDdn1pEpeeF2RTVepJnAlfJdg
Message-ID: <CAPig+cTHfD1fK73+S3fqQ+Oz_VpBzap5=nFFE1bntSeaHLcu8g@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
To: Olga Pilipenco <olga.pilipenco@shopify.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 2:09 AM Olga Pilipenco <olga.pilipenco@shopify.com>=
 wrot
> On Jan 29, 2025, at 6:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrot=
e:
> > I see. When reviewing, I was wondering why the git-dir was being
> > passed into the function. Your explanation above answers that
> > question. On that note, in addition to renaming the function as
> > suggested, for clarity, I would probably go a bit further and pass in
> > a `struct repository *` rather than passing in the git-dir itself,
> > just to make it clear that the function is checking main-worktree
> > bareness of the repository in question, as opposed to merely checking
> > bareness of any arbitrary directory. (At least, I would find the
> > intention more clear at-a-glance with that additional change applied.)
>
> Indeed, no need to pass git-dir anymore.  There is actually no need
> to pass `the_repository` because it=E2=80=99s global. I like how this
> simplified things and made code clearer.

The reason I suggested passing in a `struct repository *` is that the
project is slowly moving away from the `the_repository` global, so
making this new function accept a `struct repository *` as its sole
argument means less work later on.

> > One reason I asked the question was due to concern that future readers
> > of this code may very well wonder (as I did) why $commondir/config is
> > being loaded when doing so is (apparently) unnecessary in this
> > particular context. The question is especially pertinent given that
> > this is a private helper function with a single caller. A second
> > reason was that, over the years, a good deal of effort has been put
> > into optimizing Git's startup to avoid doing unnecessary work, and
> > this appears to be unnecessary since $commondir/config would already
> > have been consulted by earlier checks before this function gets called
> > (assuming I'm correctly understanding the code-flow).
>
> I trust your judgement and knowledge of the code and really like the
> reasons presented.  I=E2=80=99ll change this function to only check for
> worktree config.  However I=E2=80=99d like to give it a good name where i=
t=E2=80=99s
> clear we only check worktree config.  It=E2=80=99s a bit challenging to m=
ake
> it short-ish and not to include multiple =E2=80=9Cworktree=E2=80=9D words=
 in the
> name.  Before I submit a new release, maybe I have time to quickly
> align on the name.  What do you think about this one:
>
> is_main_worktree_bare_in_worktree_config
>
> (It will check if bare=3Dtrue in the main worktree=E2=80=99s worktree.con=
fig)
>
> Naming is harder than the code itself :)

It's a historic "accident" that when worktree support was designed,
the idea of linking worktrees to a bare repository was not considered.
Support for using worktrees with a bare repository was added later.
However, by that time, the term "main worktree" was already well
established, with the very unfortunate result that even when there is
no actual "main worktree" but only a bare repository with "linked
worktrees" hanging off it, the repository itself is usually referred
to as the "bare main worktree", which is an obvious misnomer; the
repository is just a repository (i.e. the object database and other
meta-information) and there is no actual main worktree.

Given the very real potential for confusion when employing the "bare
main worktree" misnomer, I suspect that we won't be able to come up
with a good name which easily conveys the function's purpose. Since
this is an internal helper (hence, there is slightly less pressure to
come up with a perfect name) rather than public API, this might be one
of those cases in which it makes more sense to choose a concise name
and then explain the function's purpose with a short comment block.
Perhaps something like this would be most helpful to future readers of
the code:

    /*
     * When in a secondary worktree, and when extensions.worktreeConfig
     * is true, only $commondir/config and $commondir/worktrees/<id>/
     * config.worktree are consulted, hence any core.bare=3Dtrue setting in
     * $commondir/config.worktree gets overlooked. Thus, check it manually
     * to determine if the repository is bare.
     */
    static int is_repo_bare(struct repository *r) {...}

> Thank you for this thorough explanation. I=E2=80=99ll drop the comment
> completely. Less code to read.  (To be honest I=E2=80=99m not a big fan o=
f
> comments and definitely don=E2=80=99t want to introduce confusing comment=
s
> :)

Understood. Self-explanatory code is preferred. That said, a comment
such as the one proposed above can really help readers not intimately
familiar with this otherwise nonobvious behavior, thus may be
justified.

> Fun fact: my email app kept changing =E2=80=9Cworktree=E2=80=9D to =E2=80=
=9Ccorktree=E2=80=9D. Maybe
> another git feature?

Your mailer obviously suffers from Gitophobia or is perhaps a nemophilist.

(By the way, when replying, please use the normal ">", "> >", "> > >"
markers to signify quoted portions of earlier messages in the thread
rather than using only indentation. The reason I make this request is
that when I replied to your message, my mailer stripped away all
indentation from your message, leaving all earlier quoted portions
flush with the left margin, which made it very difficult to figure out
which quotes came from which authors from which earlier messages, and
I ended up having to reinsert the "> >" markers manually to restore
structure to my reply.)
