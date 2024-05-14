Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6C1E4B3
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715465; cv=none; b=DHozy4K/LxfQ/4OzzGVNYTHjqyzkodjzfunI725jfeMsLTHzLO4lNgLJoXlSgNaA997fc4PukHjYQQUq4arvHRdeSPQIvS78ga4JVzwC3hq0cRb0thVUWbAf6Udo0apDO4oGbyBcQsThh+uH4QtzgHu+WAmy5Ga4jPe9w8ZBvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715465; c=relaxed/simple;
	bh=nZYgWMFbdT87tfkAhNvfCuH7c3xFTXDrbTHJT+Ls2e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFpiLjcqaBfOUIanLJzkivtlE2FFq5NieQkE4DGRnfkQcc6mvDjdjs2umCkuj/4FaZuhDiG/xgXZmb41XZ6g3KV4HwtB5AfJf9IDHY1ZAJnHD/JtwtvS99+fsIM+1yHaD8iqv8RLTb8DQDY/00wrnMPu881pb1SEXV4XUpJKgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1fU0CcB; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1fU0CcB"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df32efa5baso2017902e0c.2
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715715462; x=1716320262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o42O5V88VITNfxdmUeac51UUPDEqKN1Z5jZ1e8R1bFs=;
        b=L1fU0CcBqpi5+Y6Dc2bOw9pYNWZtqe2P+LF4m8TYoThh5P5ic3DdkRbguhPdkr/kqj
         mG+Dgf8YzH7vVguC+9UYw8N11qccwh2LeoYLB3Iukz/UtNjp1N8hS19imKgIHrW5PwbE
         vLTjf8geCB2NSLpKwUVwOqrLowZY9dTZl4Y7pkoi2KK7/EunTtuLgM3In2CzXc2J4qLz
         EY6qck6Fh8RZfBANn2R+BEtWjdVZJZk8v3BmaBer76SynBwdHCXnx8aZ2fCv/5qYuNW+
         CrvDAKXFZ5UVoQqC7NBclLsAa3oD9LP1aLPFwbtJWjFjz/A8DKFHme9m7DwzRu9SqbGA
         FBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715715462; x=1716320262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o42O5V88VITNfxdmUeac51UUPDEqKN1Z5jZ1e8R1bFs=;
        b=JO3du71xrbt/cHRSeyBbV4jPnzQHfPzRsUXv9zzXsx28yzZ4C2wUgOTFxIbd0aQsCs
         siOxEViq6SYjVcttuqsR6n+sbd0eOhPLiPQjP79fKPK1Krt7zne1V7Y4sb6YJA9kC87r
         PyelXlSi1teBbGd44J5cAvKigkG4EWDWU0mV5X+cE5b/fiYfwcabWmFnM8piY+OFxfDm
         5mHDe4YQYBD1m7fDhDkq5Vi8DMn5QfIiJl4xXNcNoXxvlNuXIljb8Luzx3H45u5zMEss
         0jz2+coL0zhnYqUwzTJhuPYGQkI6ZdGn/3cD9HBGhQriWPt00ruonvoFIenoEpXM4mjd
         9xZA==
X-Forwarded-Encrypted: i=1; AJvYcCVdbOTXppnnL6t7JUgUHh19aIIVGAxPTGCGcTUeiX2w2qu0G/bSvpVntQSkiN5qDgYeW1kbpY7jWHb7cSdPhKFaD9PV
X-Gm-Message-State: AOJu0YzPIntIj8BT5YoRICiEVFbCpxyMwKFWb5zv4Si6OMJVJJF9CFJX
	/tobW/9piFg0QPwfyzzhQGK9OXVO+vcO0oXL3VWW/w67K8r23bVvDdIt2lD1FxJkPxGpI5JCjzm
	hLvZVOnHnQKdQd1pRP3skCJ/zUyoKWCNd
X-Google-Smtp-Source: AGHT+IGtMVd++SH/wL2hiHcbpXBto1J8D5WWTkrIMnSlvflwfOQfj+3F66b48oSDCFKsCN3VMNPqycD+bdnAb/Bpd48=
X-Received: by 2002:a05:6122:1d10:b0:4da:704f:7fc6 with SMTP id
 71dfb90a1353d-4df88386653mr10511989e0c.15.1715715461099; Tue, 14 May 2024
 12:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com> <xmqqmssan841.fsf@gitster.g>
In-Reply-To: <xmqqmssan841.fsf@gitster.g>
From: Phil Hord <phil.hord@gmail.com>
Date: Tue, 14 May 2024 12:37:28 -0700
Message-ID: <CABURp0oNyOcrDySmMtbnGrFLuWWUybeo7-osS4NqPNBD3wKdaA@mail.gmail.com>
Subject: Re: [PATCH] prune: mark rebase autostash and orig-head as reachable
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Orgad Shaneh <orgads@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:08=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Rebase records the oid of HEAD before rebasing and the commit created b=
y
> > "--autostash" in files in the rebase state directory. This means that
...
> I do not like this kind of special casing in general, but because
> these are our tools' droppings, I am OK to grandfather them in, as
> long as we promise ourselves that we will not add more of these
> ad-hoc "text files" that record object names, loss of which affects
> correctness.  They should, like "git bisect", be using proper
> references to protect these objects instead, of course.

I have long wanted to have a special ref named "AUTOSTASH" since it
supports my workflow of applying workdir changes to previous commits
during a rebase.  For example, I often do this:

     $ git rebase -i
     Created autostash: c0ffeebea0
     ...
     <stopped to edit some commit in my history>
     $ git stash apply c0ffeebea0
     $ git commit --amend && git rebase --continue

But it requires me to find the text output after "Created autostash:"
from the original rebase command which may have scrolled a lot by now.
It would be easier to say:
     $ git stash apply AUTOSTASH

I see that MERGE_AUTOSTASH has been added lately. And I am inferring
that there's a desire to remove (eventually) these file-based info
trackers such as "rebase-apply/autostash". Is there any reason not to
raise the rebase/autostash notation to a proper ref now?  Should it be
named REBASE_AUTOSTASH if I add this?

Even if we don't remove the file-based notation immediately
"rebase-apply/autostash", I would like to add a ref that duplicates
the information for my workflow. Maybe we can deprecate the file
itself and remove it in some future version.
