Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792867674;
	b=T3Cy7KA8Ga4HWrKTmZtfuIVryxwSHWXlRiQWEoFTD4Lve8Rjbl2pxpMHIEBi1dTydIy/
	 HL0sA04+ZZ0iyBb1TnuTxF/CAue9U+6qfhvF1I0koLBLA7S9gXmp891LRX9vc5lG5MPck
	 k9iCYn0aQjpkIRQusysNsSrFq9Tuu2SDHEin08Tlqo5thubGssWK7c21N6/6GYjx/Xm2m
	 K3KNda3kLzzPTGVOoRRMy6UrgVj6yMdeh5nWmcgnWlnP3RBXvWD7tvK9lgCg9kqciFPLp
	 NB6OCMNvDV7RC+AAe5Dmjuhfed49biaiAJjq6kGtQusypLRVDtlM84Md6zHzABsI1CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Oxi6AwH2/7zCD49sPzt+QSrQmZGMQGkPKpCGNPgifbU=;
	b=Sg5gBqCsxyWaZWTVPcsRIprDmcxFF2dXVrs9OW3J3sMcU/qMR2ALGQkADleHrzIlCLNr
	 NrrSXoowtS0s7WJQWmNtUDx3BLs+zze3tcbbehqQyetwGNagIaIwwTVDwN+Vu8eEkM/B+
	 tG1jT6s+UeeAwgbTm7PqNtIsNn8PNorfGAw0Cbv7Rei5mDXNfSiGN5WRIYpwp+mbc7mkI
	 VErETyHIcKnoHx2hRLnakyiPVLAxVJGGGeCSjdz8B3LVkr76grFcIuB8ehxnkw6c/a8qI
	 mG/bsk6m9TZbs5a3lb8+zMRErDg4ubvhIenXCsKf3dc2msQo5QrnXjrE5RRQHxAwjZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dwxZl0o6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E922606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E922606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dwxZl0o6
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso276778166b.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792867672; cv=none;
        d=google.com; s=arc-20260327;
        b=qIVFFLTNzu1BkLYf+9Me3zAZQA7DVSTJLu4j5S1IXNEj4dLsnjJcP96hsX10L3IYiC
         DVIXEmEp3NaeZcEEpumkOxTG9LxCHbRBSY4Ge4oF9HY9ZrerOmaDpbP6E7GTuePg20X1
         TsjDfSPRCq5pnrwAU/Vlgi5/W/vSmstlmUQ06rSS9WynfQu+kKbxSYo0peNR+dEwsefL
         OnC86KBvb0lr6wffIAe2krecyuDZBcZbMOZdVMlxHQiMJpfiWu4BA1IOmRpVsFLWtByM
         DQveFMpOHrYf1VC2H0x5JpA9PEJVDUfZx3rAFCpUxM6Zl3eexzIvKLCBKhjhbsbfkeqb
         tnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oxi6AwH2/7zCD49sPzt+QSrQmZGMQGkPKpCGNPgifbU=;
        fh=x6kxQCtCA2GIsHPsJZZ33BTOjMzLVTJ1AA611Jrb2Zc=;
        b=pyeHOQLFSoc6GjKGWyZUwC1EVlyh7zmjtyuAtI5IYdUija99aS/7+WP/FSX7VZR2k2
         2vbHnUxar/BjMsLXDimWdr3ZBjBKopGrwwwFIcQrpOPJMHZwJE0LsrqtyVl7pZa6/jbs
         2kZEQMaZ3h2jDakjgZwb/3JCxPdJkbYm14PMPGwOcdaui3NQQcVL1qWervxyD5rzWgHm
         I8vQrB7sGeXqqLzMDLFcXA07txWLyexKl+sheI1BcFFy3aNftPCveeEYkhm5Bj03D0C5
         hsd9gCOtoNHz/ISrHC8VBoGeo/OyrRBlfrZZxb/1zPBvSIgObGXzrzml42aZYFFUjeeP
         vIzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792867672; x=1793472472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oxi6AwH2/7zCD49sPzt+QSrQmZGMQGkPKpCGNPgifbU=;
        b=dwxZl0o6QAVKgdEfhMGddilwb+MYhnleMgJ5e/Y7x7HKkbzjaWUBF5kIcQMlEcghPL
         +SK5598ZTMwg2QlZzLqiqrTZLlFl+D0IQg6KR46VIJvPKs7iaKT8FoO+3D+0/+9q1qv3
         COf6UowiAFxhLkozQ5TIsSDRY2InHmvfqFWNMjLGKdjkmBbkbNO9FZB4rv9D3p/+iCF2
         82dHRIJZhH93MqV5kKaUJre8qWgU4xoGJEq8Bxiw1JpTG/o6j9247ZD1f9ZyxitGEWUr
         Imp8q5ukd2wAO/y/eAM19vSPxaNEWeSL0RBZSw1LOkekFPlUmDU5rJKIpH1Y7COdl06l
         o+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792867672; x=1793472472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxi6AwH2/7zCD49sPzt+QSrQmZGMQGkPKpCGNPgifbU=;
        b=KQJjxD1nHMRxC9TArM65oJ08pe48wPFoMxMsQlr/47Kh/8ajgJKVNp2l7vIzDuSajw
         Ujk2nflfaacnGMfz2ojLt9cvX9ygeljbowixz9nM67hFp5BCYHj+NzUpwSq1HUPUGhS/
         dz0jcDTUI2ka6QAuk+CX5UObvQBkQEgcYJSTvFYyX54kMTabrACqTMmA7Om13lqGKcJF
         4BOsz0VhLYS9S0DvtmOz70PupjnVcB+Uq5Yb7yZ4waGudw8uGKW6WRiFa5Z/V0rpjl0/
         8S+Qw/fhkPf44mdW34Yvq5F6E/C03MxYP1dP3rjH2HYtUHq0+8/pPSBjz4MTXX+vQmsw
         X7Mg==
X-Forwarded-Encrypted: i=1; AKwUvBzrPdpDDSH3q4Gl9TsewcA1bGA2HBVtwPZBxIB1T6N+RDZG056ESbmzffhkOzTYZ4q8d38=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmCbNO2MX4248lFrXbcVdPgOssrgB11200jCV25kZ9u790zugh
	6+UA6f/X1RNL0X0Rh4nDRFp4vq1cvPp0uQO52zZYp326qbVdxEjtYIdjoLGWw5MbeKrbYKHJ8Br
	apbLsxSFAUUKWL+mhG7yuy+GW4G8uT2w=
X-Gm-Gg: AYBFou1GVavGqgdHPi3t784djYg2YH2jnUIiJr2pdLfj0Z48B0FxvuVGoJLeA8Q5mTg
	q0SRNbT2IYxEN/cPpuTIC1N79TBxAIQKtiuHWoVfcvQ7MNrQZlvc3GR109X5bI5XlP44MV+NYR1
	zb67gV7XjrK3dnZwbAygWkf3jz7AL7NDTa4XzZpKGhxwcSQEDP7dCXPw/cXDjqaeU1r3eh3CcA6
	l3Jabp7Oag7Cs2MuqSal6H1LtB6MovkzF6BM6kHu26pqhcPB4gBsK03pGhC3MxKyF5gtMmjy6mr
	HSreW76NWI/rKXR/pz7RY/SHS8ZYyypbvj3wB6cUEeoYhfTxrVCVmZwPvgp+38Ac5NEPTYcsi8A
	nokBc7yowZHHPijh/vnelVMZED60DjGn5eUO6SA==
X-Received: by 2002:a17:907:3f12:b0:c42:102f:15f0 with SMTP id
 a640c23a62f3a-c46bdacc565mr312637466b.3.1792867672431; Sat, 24 Oct 2026
 11:47:52 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
 <xmqq5wyr128q.fsf@gitster.g>
In-Reply-To: <xmqq5wyr128q.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 20:46:28 +0200
X-Gm-Features: AclHuK9X2G8mLl5PWkzttp5xlR9fwN8zIypkRbkelPSOdr-ji3FhkWwEMlJOkSs
Message-ID: <CAHwyqnVJ618QXq99M=XNm19eEObQC-DTLcpeYOiizzSu_YNEpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 6:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I'm rather skeptical of this in its current form. Not all commands that
> > modify the working tree update the reflog and some commands such as "gi=
t
> > cherry-pick A B C" create multiple reflog entires that are
> > indistinguishable from multiple invocations of a single command.
>
> I like the direction to make the default 'git reflog' output on a
> single branch easier to understand without needing any extra
> filtering in this series.
>
> 'git rebase' doing its work on a detached HEAD was likely the
> first, and we may want to convert more multi-step commands to do
> so, including the multiple 'git cherry-pick' you mention.  'git am'
> way predates the rebase that works on a detached HEAD ('git am'
> introduced in Oct 2005 predates the concept of detached HEAD that
> was introduced in Git 1.5.0 released in Feb 2007), and it does its
> work without detaching HEAD.  Its users grew to expect it to work
> that way, but I am not sure how problematic a regression it would
> be if we taught it to work more like 'git rebase'.  For example,
> because I am used to 'git am' working on the current branch, I
> often do
>
>     $ git checkout --detach master
>     $ git am -s ...mailbox...
>     $ git checkout -b pw/topic-by-phillip
>
> to compensate for the lack of it, in order to keep the events
> recorded in the reflog of the pw/topic-by-phillip branch to "one
> iteration per entry".  This helps me compare iterations more easily,
> e.g.,
>
>     $ git checkout pw/topic-by-phillip
>     $ git diff @{1}
>     $ git range-diff @{1}...
>
> But the workflow to actively detach by the end user would work just
> fine if 'git am' learns to detach first when started on a concrete
> branch, to work more like 'git rebase'.
>
> By the way, I too was annoyed that 'git reflog' defaults to the log
> of HEAD a long time ago, but the irritation soon waned once I made
> it a habit to always provide @{now} or @{0} to the command, as that
> notation refers to the current branch.

Thanks Phillip, Ben and Junio for pointing this out!

I didn't realize that reflog could be changed to operate only on one
branch. And it makes it a lot better! Seems like it should be the
default, and I don't think a lot of people would complain, I'll
certainly never run the old reflog again.

However, the format is quite heavy with the full name references,
seems like they could be cleaned up:

```
0b8dc70369 (HEAD -> fetch-shallow-narrow-refspec,
origin/fetch-shallow-narrow-refspec)
refs/heads/fetch-shallow-narrow-refspec@{0}: >
e4882d2794 refs/heads/fetch-shallow-narrow-refspec@{1}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 7e34d8174dcda3>
4b0cb31dd7 refs/heads/fetch-shallow-narrow-refspec@{2}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 7e34d8174dcda3>
11d2326038 refs/heads/fetch-shallow-narrow-refspec@{3}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 4603c84d688c32>
83ce62663e refs/heads/fetch-shallow-narrow-refspec@{4}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 7e34d8174dcda3>
d633b1fc1b refs/heads/fetch-shallow-narrow-refspec@{5}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 7e34d8174dcda3>
9ca7fe6077 refs/heads/fetch-shallow-narrow-refspec@{6}: pull (finish):
refs/heads/fetch-shallow-narrow-refspec onto 7e34d8174dcda343>
552bf08971 (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v10)
refs/heads/fetch-shallow-narrow-refspec@{7}: rebase (f>
9ee090d3d0 (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v9)
refs/heads/fetch-shallow-narrow-refspec@{8}: rebase (fi>
db27c29086 (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v8)
refs/heads/fetch-shallow-narrow-refspec@{9}: rebase (fi>
10c6be7ce9 refs/heads/fetch-shallow-narrow-refspec@{10}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 6de20f6092dcf>
acb47efdc1 refs/heads/fetch-shallow-narrow-refspec@{11}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto b5db64d56fa32>
9fe17a1968 refs/heads/fetch-shallow-narrow-refspec@{12}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto b5db64d56fa32>
591e69aa88 refs/heads/fetch-shallow-narrow-refspec@{13}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto b5db64d56fa32>
16c467682b refs/heads/fetch-shallow-narrow-refspec@{14}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto b5db64d56fa32>
d5107dcb5d refs/heads/fetch-shallow-narrow-refspec@{15}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 6de20f6092dcf>
c8fd073de3 (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v7)
refs/heads/fetch-shallow-narrow-refspec@{16}: rebase (f>
632ad9e6eb refs/heads/fetch-shallow-narrow-refspec@{17}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 6de20f6092dcf>
cbeb1bf547 refs/heads/fetch-shallow-narrow-refspec@{18}: pull
(finish): refs/heads/fetch-shallow-narrow-refspec onto
6de20f6092dcf9b>
005e30ee30 refs/heads/fetch-shallow-narrow-refspec@{19}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 8103b446517e0>
2609473369 refs/heads/fetch-shallow-narrow-refspec@{20}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 8103b446517e0>
d986bb7abe refs/heads/fetch-shallow-narrow-refspec@{21}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 7303c95b3b667>
01d4bba698 refs/heads/fetch-shallow-narrow-refspec@{22}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 8103b446517e0>
844ca50185 refs/heads/fetch-shallow-narrow-refspec@{23}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 2e37944e2883f>
864fc79e86 refs/heads/fetch-shallow-narrow-refspec@{24}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 2e37944e2883f>
8212be8acc refs/heads/fetch-shallow-narrow-refspec@{25}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 8103b446517e0>
de83f683aa refs/heads/fetch-shallow-narrow-refspec@{26}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 8103b446517e0>
bc9f5f0a75 refs/heads/fetch-shallow-narrow-refspec@{27}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto f9856e2cf3f65>
29869baf42 refs/heads/fetch-shallow-narrow-refspec@{28}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 8103b446517e0>
bb9c735cc5 refs/heads/fetch-shallow-narrow-refspec@{29}: pull
(finish): refs/heads/fetch-shallow-narrow-refspec onto
8103b446517e0c4>
84d192445c (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v6)
refs/heads/fetch-shallow-narrow-refspec@{30}: rebase (f>
5dd7145ab7 refs/heads/fetch-shallow-narrow-refspec@{31}: pull
(finish): refs/heads/fetch-shallow-narrow-refspec onto
c46c1e37724f047>
8c2a144eb7 (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v5)
refs/heads/fetch-shallow-narrow-refspec@{32}: rebase (f>
43b9711a2c (tag:
pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v4)
refs/heads/fetch-shallow-narrow-refspec@{33}: pull (fin>
73fec138c3 refs/heads/fetch-shallow-narrow-refspec@{34}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto d3ee079ea9d66>
49f194522a refs/heads/fetch-shallow-narrow-refspec@{35}: commit
(amend): remote: default to --limited-fetch in a shallow repository
84f6640ab9 refs/heads/fetch-shallow-narrow-refspec@{36}: rebase
(finish): refs/heads/fetch-shallow-narrow-refspec onto 0f8e75abebff0>
```


Harald
