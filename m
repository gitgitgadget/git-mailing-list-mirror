Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98817A31
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243625; cv=none; b=bozIffxM4gEJtsr2JArwTcvMUzvdCRh16xHrZ80gNzlmlUf0NAqH4UFh5Vncw/2S4mvN8PQwqaibLyosttYRYjIXvnmuF90LcitAmrH87ZxHNCIYKkI+OqmlEoujwQ90rGPcHtVmJAJRbNLyDMVYKcgCTrhAWgLg4Ks8Ve+bdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243625; c=relaxed/simple;
	bh=aqf3QBm+LzuMEeu0lQxw9VZlUXp54iCB/vV9Bhj2fLw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JIMAfCrMLBLXFUtFjNC7bZ04W9WtDQihy9Mh0ZbM7KrMWLFhjTz++t2O93z+0BQnxd9n0FCxg8WU1uxRlfrBfwAVDcOznyBVOls/Ezu8jLzCxqg3yl88RS/btXDt1NlYVhqjKMGyG9O+TU8aEusov89Y08Z8Fuyo4r/dXvX+pdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaaRqn36; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaaRqn36"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1494340a12.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243622; x=1749848422; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YGopF4NOHmLMEUTG9zkDxSGiKwrxLS0nUfKaMppDikA=;
        b=ZaaRqn36zFUwKJ4O3TlrT5bKGHY0KxDFe/2yE9izrSNmOipzWyZ/SpQ08iKQDODiF1
         BzKVwKRiE9PA+lJ7kFkngf9tcAqCSzzoaY18CgSsXkkOEN+20sotTp8ZIcpClSAp4wqF
         kNsB+IdY7EyANu4eTHLysLODyjeP5rX/N8yB7qZIUcerg5LP+q2PYuruRyUQoey4NFEh
         YRxKeZKrieJEcVnsW5pfKfDa32uDtE/CkQ8Lz0J+yDJucMQserC+U9R8f5qF2g1Fybab
         OHKANOizQrxzGJoF6VnzvD+zA1B3yjUHpi/5A70U2n8vJ+d991HbOdz3ysVS46543Poo
         o1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243622; x=1749848422;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGopF4NOHmLMEUTG9zkDxSGiKwrxLS0nUfKaMppDikA=;
        b=UHymeQI3M+35NJxusLlMpIzh608ttGephNwxxbnqU0MiYZIOgqP6lIjqhR6GWKfbz2
         alI6iirm7FwO413EvKVp42Gpz3UCh9471gd4t5hsp52xqrtcmQPwBkr2eQz+1a00wxRQ
         Vdcayc5w/AD45C7FezBcO2w5dHZRJUzCPCeXA0dOnyQzhVM+ecu+MxDW9/tA33D+eshk
         SNFdWpY73pmFQAm6JAjAHTDxmfH4dHZVLs49z8Dnd0hCu67L8BkbONS5b81p68QDEq6T
         hGQjLFSh0wmLzPOSr8gpVQxjEElCsqWTBhuGO3O7UhCWuR428/N+YGmyQivK7afnswy6
         acUg==
X-Gm-Message-State: AOJu0YxarG8NrPyDLkIysQ79/Tcj8bkLg78GuRywKH9p/KLRcBrd1IEI
	rQ/Si2Z3F3NA9iMgBagzq/TQobr5LBQVKhhb+FB5AI3eZz7AdL2oEG0m7f6s/pkKdNCjnHHOhGM
	1C+WMEUpNILJCb7aLudyAgRtQoMSJr2SnU9RV
X-Gm-Gg: ASbGncvpP+Q8KYvtFEUZ3H9MgRnrJ4TqME2ynxmHGBJlh36Qgyy0hHVosxcbsJ0iNEB
	lLpT2Droo4J/+G9zx8Cj0YLGbfYmnToV3sugPlBXbzRtkiWT2GMPL/xjDlFtZ+caJiJjwtr6J9m
	FEdwR3rwSfHP+Sxvr+ICZ1wC4avjdk80MM4A==
X-Google-Smtp-Source: AGHT+IEzhOM204ndmuMLrFhg13BEwuqJm9DUT9OkoUWFiHubfNBLMXPyyZvctSpQ2thOtR/fccyhOntSPDmOgdlDxh4=
X-Received: by 2002:a17:90b:35cd:b0:312:db8:dbd2 with SMTP id
 98e67ed59e1d1-31346b5651fmr6840592a91.19.1749243622454; Fri, 06 Jun 2025
 14:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date: Fri, 6 Jun 2025 23:00:10 +0200
X-Gm-Features: AX0GCFuJVPemDsoWR_LCTDdnla9efyVOrqS_V8ekFFwBRSavM1uZhY_EvnqtHxQ
Message-ID: <CAOc6etZm_+FPSgdwXszjqy5VBiQXNStEoOJ7-UF+h3AJhiQ_Ng@mail.gmail.com>
Subject: RFC - rebase--
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi, everybody! It's been a while. I hope you are all doing great.

You remember that I had spent some time trying to come around ways to
get rebase to take advantage of the original commits that were being
rebased to tackle conflict resolution... I don't think that anything
was implemented back then from my patches but there were interesting
conversations about the topic. It had been a while since I stopped
thinking about the subject but in the last few days I felt like giving
it another bite and see how far I could take it.

So, I sat down and wrote rebase--, a pygit2-based script (yeah, I
know, I am a shameless cheater :-)) that _attempts_ to run rebases and
take advantage of previous merge commits to try and avoid asking the
user to redo conflicts **if they are easy to deal with**. It is _not_
meant to be a replacement of rebase, given that rebase has a lot of
very powerful (not to mention useful!!!) options that I do not want to
replicate (hence -- instead of ++). I just want to be able to run a
straight-forward non-interactive rebase that might include merges.

At the time, it is able to give me the expected results in some
scenarios where git gives up... here's a quick example using a linux
repo:

$ git rebase --rebase-merges v2.6.39~100 v2.6.39~80 --onto v2.6.39~110
This one breaks on bab0dcc717e2.

with rebase--:
$ rebase-- v2.6.39~100 v2.6.39~80 --onto v2.6.39~110
Rebasing 189/189
Resulting commit: dc3441f19784813f65979f279133bff1c2c6642d

(it ran in less that 0.4 sec... working tree does not move, no
references are changed, it's all done "in-memory" and writing objects
in the repo db)

Now,I should expect to see the same differences between v2.6.39~110
and v2.6.39~100 to be present between dc3441f197848 and v2.6.39~80.

$ git diff v2.6.39~110 v2.6.39~100 | md5sum -
aee0292465ed6ba76fd1d283a820568c  -
$ git diff dc3441f197848 v2.6.39~80 | md5sum -
aee0292465ed6ba76fd1d283a820568c  -

So, at least it is working with this example where rebase-- could
solve the conflicts by taking the appropriate existing object
(tree/blob) in full that made sense for each scenario.... if it can't
solve it, it just reports where it gave up:

$ rebase-- v2.6.39~20 v2.6.39 --onto v2.6.39~100
Rebasing 49/80
Could not rebase commit b5e6ab589d570ac79cc939517fab05c87a23c262: We
could not merge path mm/page_alloc.c


Or with --verbose:

$ rebase-- v2.6.39~20 v2.6.39 --onto v2.6.39~100 --verbose
Rebasing 49/80
Failed to merge commit b5e6ab589d570ac79cc939517fab05c87a23c262
Current path: mm/page_alloc.c
original object: 3f8bce264df66f712e9a44092f871d9f90eafe22
original parent objects: [570d944daeb5d9cd0593c68b57698b2019acfdc9]
rebased parent objects: [9f8a97b9a350d17ec070d5e741c04f8d9998e7a8]
Could not rebase commit b5e6ab589d570ac79cc939517fab05c87a23c262: We
could not merge path mm/page_alloc.c

So, if you feel like it, please, give it a test and let me know how it
goes of if you have comments or questions.

My next steps for it:
- At the moment, it does not try to _merge_ blobs. It deals with them
_in full_ and takes a full blob if the scenario allows it. If not, a
merge would be required to see if any of the conflicts that is popping
up was already solved in the original commit being rebased...... I
will try to turn that paragraph into code.
- allow moving the working tree and adjust checked out reference
- fix bugs

Thanks for reading.
Here's the gh repo:
https://github.com/eantoranz/rebase--

BR!
