Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6941D644
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059512; cv=pass; b=FegScrI1vXycFhno8TYRECU2tcxNDsdYz1moYKWNk3eSW0sXVRs7F1bHKAXFXV1dVsixvOb4GZXKTSroij1jK3ivM+cbAIVwPbiDSUDA97OX8rOSA299xvftIeHvnWTy/reOM5f8kEyCL6V6oaKaJYw/mkFgGeDHEzmvIkkb4Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059512; c=relaxed/simple;
	bh=SfgGxFIcZJEvcoZKKGzwuAUZCg7z1LknRu1uHZIoZ+o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SumKAMm1ZGYoXGKuYRtML2AsgKEON0WvpzwgTcT9IFggSBm7Rct7nsCus4LG9hwft7116V/m6S8m0OBEtiRbfP+Wr2haYsvwBcxcZj9Uq6APyhRj181Pe67kbwM/joMzrsv2x/kp6YqBQfj4tzGkvYaRo67RZhhfVDDSX5Cy/qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unity3d.com; spf=fail smtp.mailfrom=unity3d.com; dkim=pass (2048-bit key) header.d=unity3d.com header.i=@unity3d.com header.b=Q2Yg76S2; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unity3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=unity3d.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unity3d.com header.i=@unity3d.com header.b="Q2Yg76S2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso55307405ad.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784059510; cv=none;
        d=google.com; s=arc-20260327;
        b=LOe5VIGgpjEdKEEwAA9rZP8CkPJ4DpioXpChqAX7nTm+g6PWjxRQM6PJcWJyqsbekf
         5DxDk+A85Y75tedyBZ6ZoY9wL9YLzxavWOQfqeXDIGfXBcwIzZ93Vdytl+3i3x6/O5PG
         S7lgzXutmSol/0mzg7bjd3fzAwVSr8n3npGkiWFdOYg/v+Vaqfc95t5TQZwbloF6YEii
         lAfgzYGnddV80bi0D2EkvkALMjYu98dr4dGt02AKXWRBYtiJJ3CxQVsBHPfJu8vpgUUS
         dvSeFoEXrW2K+cnBgPELENhbuDXDHEfe56LdgTdVGJv3r1gYf8/YiEdYTfosKMmV/vOl
         j3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SfgGxFIcZJEvcoZKKGzwuAUZCg7z1LknRu1uHZIoZ+o=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=nEYoRUYk5Bzv5J2kUEpHu0rt2uIufV0V5hYJxSQbGbN/4fP/dcLiUeeispR/XOjbN5
         qfqKW2A8cbwvn5CLrahJr9CvAIJKVwCnydk2cWtNfgVfrwh10JtIa58sehPyVgV9u9Xy
         0b7OSsV2DNlUHehXVIiKtnNoCKJlm+amiYxWKvFNPUfV/9DTJUD8nmoq1CSE7KQ7UI7k
         fAznyeIoqSKoCh7aGA+Ok88mGUlkE5zD5MJgFIFlU5C0/ZqK95urqfjieDiJsebxnCc6
         kFpVXm7/l8u7G+kMTQohL0wy52OkTyL193HloraERo0ssG0dAWPngFRi/hce+DcI28gy
         uRmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google; t=1784059510; x=1784664310; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SfgGxFIcZJEvcoZKKGzwuAUZCg7z1LknRu1uHZIoZ+o=;
        b=Q2Yg76S2GNKXyzzn4CLlxPli9TL12N3x4zT6q3o4BVrxJOph7apPt4Uvhs7APSJsU3
         a1EcJr+JnuEDXEDDnFm3h5/IoaKjCvCvNz13jQIVidHBX/p5M7gIqEi/LE4EyisdVLZN
         oPDZbdwNNvi/DgXPUcFFk15+OG6lo/cHznOqu6TuUDg61y+13WJkcYJ4EZ9hVQZ3DhJz
         vwkYTSPwdSrSNfiFva9CB8QCwuv4/RbU7SuLYMTRZqdnwTEKFt6LobMJFODmpBmuU/cl
         bZyn1USDnMsnyeAmHPnYoGRycfmU+r74PrcpsDQXykng2BOojST+S+ZhdLSKizyYW2w9
         iMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059510; x=1784664310;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfgGxFIcZJEvcoZKKGzwuAUZCg7z1LknRu1uHZIoZ+o=;
        b=NcJ0klAC+4f4NKEBNbk+KlrsZ9R9ZXCjOvjnUEiYnMAf/21JzRxsE1eTjt9nJp1GpC
         EAGc8HZsqsCfTyS9U+y4NrIF1tuUA26BxDeoPzSlqS0kxcgdjaiU6iwYCfHy+WwjnPU4
         IE9NrvWPCEiY6ZaLCR9OdEN27vD3fyXkugj08T8OMpedTQjxtK6uCkdixs1xoZpEbHcb
         PqAudkHKrZkdg9io7GY28aigemcdElh8KFkVAd1TBZqdLuCC3sK1ZLTYv1KV1lbCf7HJ
         isLTf1NnxyPIkgEQ5pE48i19KCTBNYXnFtcTeNRGjEzJagS0NbV/RX3lwxgybA+xrwoV
         Klxw==
X-Gm-Message-State: AOJu0YzPEwToR9BuIdjY/u9fUttkxHU+jwpF4rqz/DmV91zgAt+M5sgQ
	dCT4SGAFQlYoYOPeiAfQezz2/PLH2xDPOUUAh8mCeaaz3xA8yBEHZndmd2geblocenJrfMNF7Vu
	ytKx5nCZYwREOf0mbmXkcghpXwNaqpxRerQfjDUcYnvUjddSjoq0nwiv9QVIa
X-Gm-Gg: AfdE7cnTA1u8+eUqXrwvnezM1n69bC+RR0wOfkHK7PesjVtN3UPZPodD5YHe1GxnBBS
	13n0KZZN0RZ5UVNwVOKGyrM4xVMZ8yuApx6LWI1yPCUNbK93LV9r2GfCdDzBQv3JDFU5E9Vo0XP
	lKe/tKHE3xwcmTnhA3pWykMgfbqRhkU2H8bkWiVuN1Y6C9Em9PIF/vj8ljC5Mt+pKSWnjPBdQRd
	HvWft+AtxJhxLv5XO7CpkrUNuBcG49bNfF2jUSLHhpoDt/uAyLDgfYJhUvYfwkUE1UrjlSGGdMS
	oscquAyCJopa2BEkgDKOCZlDCgUrmw==
X-Received: by 2002:a05:6a21:9d91:b0:3c0:9c19:658b with SMTP id
 adf61e73a8af0-3c357661e1fmr4341937637.69.1784059510235; Tue, 14 Jul 2026
 13:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Fine <richardf@unity3d.com>
Date: Tue, 14 Jul 2026 16:04:58 -0400
X-Gm-Features: AUfX_mymdreCWxaLCrbyhdfzHbB7JISXOW1cYXiMpK-rEmDTlW3jT7gP7OroGEY
Message-ID: <CAAFFBtiOBsbHuKh0J2ytUXOB1PpzMhT6LvyjGozH5g5ygYZjHw@mail.gmail.com>
Subject: Persistent shallow + fake-linearizing a whole mainline
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

The repository at my company uses a standard branch-and-pull-request
model for developers to make changes. Pull requests are integrated as
2-parent merge commits. I'm trying to find ways to optimise working
with the repository, particularly by reducing the Git database size to
make git operations faster. I see two clear opportunities, though I'm
struggling to get engineering alignment on each:

* Squash-merging. If we switched to squash-merging pull requests into
our mainline branch, developers wouldn't have to carry the added load
of the individual commits from the branches used to construct the PR.
However, two objections arise: first, landing a sequence of stacked
PRs becomes painful because Git can no longer accurately identify
merge-bases; and second, in-branch history is sometimes useful for
code archaeology. Suggestions that the in-branch history would still
be available in our source-of-truth repository are met with complaints
that looking at a second repo for history is inconvenient :)

* Shallow cloning. Setting a shallow boundary with something like
--shallow-since="3 months ago" gives us an intuitive way to trade off
repository size/speed against history availability. The problem with
this is that we sometimes have PRs which initially branched off old
revisions - earlier than our shallow-since point - and then get landed
with merge commits. When people pull those merge commits, git follows
the second parent of the merge, pulls the history of the branch, and
ends up bypassing the 'firebreak' revisions defined in `.git/shallow`,
pulling large amounts of history. People can avoid this by specifying
the --shallow options when running `git fetch`, but very often, this
is not something they are running manually: UI tools are running it
for them, or they run `git remote update`, or an AI agent is doing it
for them, etc. Suggestions that we should block people from landing
PRs with branches based on ancient revisions, and that people should
instead rebase the work on a newer revision, are met with the
objection that if the branch is based on that old of a revision it's
typically because it's a long-running branch which accumulated a lot
of work, and rebasing that work on a more recent revision of mainline
is painful.

I've not yet given up trying to get my colleagues to change their
workflows (and I welcome advice on how others approach these
engineering-culture problems). In the meantime, I have a couple of
thoughts for possible Git improvements that might help, which I
figured I'd raise here.

* The biggest issue with the shallow clone solution is the possibility
that someone fetches one of these 'based on ancient history' merges
without passing --shallow-since, causing Git to end up pulling huge
amounts of history. What if one could set the shallow options
persistently? For example, a "remote.origin.shallowsince" in the
.git/config. If set, it would make fetches from that remote behave as
if --shallow-since was specified on the command-line, regardless of
how the fetch was triggered.

* This is more complicated, but... I did wonder if there is some way
to use .git/shallow (or something similar, like replace refs) to make
Git pretend that the merge commits on our mainline are actually linear
commits (i.e. pretend they only have their first parent). Then when a
developer actually wants to delve into the commits that made up a
specific branch, they could make Git stop pretending for that specific
merge commit, and Git would then fetch the commits needed to fill in
the missing second parent and its ancestors. When they're done, they
flip it back to being a fake linear commit, and the branch commits
would no longer be reachable, eventually being cleaned up by `git gc`.
I think I could probably write a script to convert an existing
repository into this 'fake linear mainline' mode, but I'm not sure how
I'd then make incremental fetches of the mainline continue to keep up
the masquerade without pulling all the commits first and then running
the script. I'd like to avoid pulling the extra commits if possible.

What do you think? I could probably take on at least the first idea if
there is interest in it.

- Richard
