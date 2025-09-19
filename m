Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5F320CC1
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311656; cv=none; b=GVMdOPRPNd8I4z/6GOKZ2rxl//ehHcSbBmoTgE8XpiOofQ4e2S048peHXauJUNANyjhJuRdQR1bBgnK77l1+sflLdy8KoR86c/RR/EqBVNhY2TT6P6rHquyWzwDV4/XIPIqNuovfQQrUVNSTRo6BNTkv9yMwBYmCxikccTfe3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311656; c=relaxed/simple;
	bh=G709imrlHiFH8OQWvvDis2HYwEJg+p6QuBRy9VyCrWw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Yq+vdb3tHbCnG2daKxJF/Z6rLM+hs/wdacqcbH5Dg2n5k/+EUw5F0kMKIud0M9Nu7drnwflQHHOVmnnf7/Zj//h1JtKKRvhDTNbQxK1YWraSK2WF6J7kElqeEI9wPmZS628yBMHOzLngezHcN8Ww6b+cogp4xsnf+pemdYFL6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=d9Z+fieH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lED6Bilz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="d9Z+fieH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lED6Bilz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E2EA41D0013B;
	Fri, 19 Sep 2025 15:54:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 19 Sep 2025 15:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1758311652; x=1758398052; bh=1ZKBDvK94KEXxZFOz37Rf+I9dz1rLs7b
	dVNkrGFW1qM=; b=d9Z+fieHR7P8oebo3i3cQoMs9xO2Ub+AHUXlFM568x7BM6ru
	I5bsh/sRibhEjrBhHyya2LHwIMSO9KOjD3d4rxHBmO9lD4+bV2jxUrQ2AJC088m/
	pIIFUHi4jLa5pBX9JDuDI/5OtNFLDGZcw53hYC6g/S4feztIe1AhvYf5R3AqdYSF
	03SdKSXLxj28Xv2qv31XepCxkPiDHkso1QZCoxlt3DGdd/1nMJSqG5F7dAfIlNW8
	89Pna0uXyehzhOKTYWn/llcnKIdKTVdYPHZl9nmAovGzcha9BrppWvc1QGmvMD1t
	obtAfgUJWMg4g27+6kWtCX+XgvZ1ZAL4VC/iDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758311652; x=
	1758398052; bh=1ZKBDvK94KEXxZFOz37Rf+I9dz1rLs7bdVNkrGFW1qM=; b=l
	ED6Bilz4VEdnVpLXIPvQj3mh1L0h2JEEkfb/CFe1+cHUBLBiTp7T5NRqmAbXET/e
	luyDEzwdzLaHvHyN5cNGZZlsqvW5gjyzgVYFP5ZIskjV33uF8eYEDfNHla8Q0znL
	coVrYymvWeGbYmkF/Rjq5jSYL4H7F99cDdRduf16J+Q60Y9LKDD4NE4oSI8f50+V
	ylDEYzJlh/Y4+Hm7BCz8yl/tIkTks6GJIOOatXMvv+8AINlrnWPfrkeBqE3b8ZaW
	6eu3WfXIcWzu3WwMwb4M+C/p7ZrOB/LGuC85W3Bptuna3ZEJKYKeeHuhNKyGfXGq
	VG+uG4SVZGCRwZhhd6MVw==
X-ME-Sender: <xms:5LTNaBmh3v6WBxTdPpUjIemYBkiqYIgsvKqJJpZsHciSsF7EHp6joA>
    <xme:5LTNaDuJ9CQICm46quVCnZtcCtEfJJYlcyvQq82z2cz1aM5lnAw9Ntw9SnXPXfhr4
    i3kcrnChms4TuAx>
X-ME-Received: <xmr:5LTNaEnxXiZeAfBrY36o1fX_8AiGIwkCS3t1hC9ZGJu1WjtnRda_FGU3ks4lJAMcQyKbGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtd
    hhtdejnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpeegjedvuedvteeileetue
    fhheeikeekfefgvdfhleeggeetheeuleefgeelvdeiveenucffohhmrghinhepghhithhh
    uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesug
    hunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvght
X-ME-Proxy: <xmx:5LTNaOtbU87YzFIGYHw3SHwtPWUc73aPXRct914OQjt2Ev9qLKHPBg>
    <xmx:5LTNaKcF5qegqAV6Ih1OxpVTuAO6f-aM8ee4Z1ETHNJchTlPr5Jkiw>
    <xmx:5LTNaOx_4puxADAqKFbcLraNE5Rh6IbA71BNhi4yLBXV0YweBUe2iw>
    <xmx:5LTNaIGNDk1-FaW2FZWlj5faZbkGb-ZSR5ji90BKiUMOj-GQzx116w>
    <xmx:5LTNaKVYA-j1zNXxPRtVjwVZeDb3XhclPMa9_2fwyvPy06BLqzxfUG3k>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:54:11 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Git Stash Synchronization - Best Workflow?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <A42DC91A-91F2-4AB6-B0EE-52DE5135E99E@alchemists.io>
Date: Fri, 19 Sep 2025 13:54:00 -0600
Cc: git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91B9B7E5-67B2-48C9-9884-3BBE1F427D51@alchemists.io>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
 <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
 <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
 <FEB150D4-2B5E-41CF-ADCE-93DD0B48D364@alchemists.io>
 <94d614fb-63b8-4733-b78d-b55c482fbed8@gmail.com>
 <E308F060-D39C-4C7A-9F38-2CA33BCE4AB2@alchemists.io>
 <adad093d-5129-472c-b054-fb569de9f893@gmail.com>
 <A42DC91A-91F2-4AB6-B0EE-52DE5135E99E@alchemists.io>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.700.81)

It's subtle but you have to use `--force` instead of `--force-with-lease =
--force-if-includes` after you make a modification to an existing stash. =
This means you must export AND push each time you make a change to the =
stash (i.e. pushing, popping).

So what I was trying to illustrate is that you must export and push each =
time. In order to do that -- and keep the remote up-to-date -- you have =
to use a force push. That's the only way I've found that I can ensure my =
remote stash stays in sync with my local stash. Otherwise, if I clear my =
local stash (to simulate losing it) then import the remote stash, I can =
ensure everything is restored with all changes restored.

I'm also using GitHub as my remote. Not sure if that matters, though.

>=20
>> On Sep 19, 2025, at 8:04=E2=80=AFAM, Phillip Wood =
<phillip.wood123@gmail.com> wrote:
>>=20
>> Hi Brooke
>>=20
>> On 11/09/2025 03:22, Brooke Kuhlmann wrote:
>>>> I'm unable to reproduce this. In the script below the final push =
succeeds.
>>> That's because you need to export every time before you push. Like =
this:
>>> touch one.txt
>>> git stash push --include-untracked --message "One"
>>> git stash export --to-ref "refs/stashes/$USER"
>>> git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"
>>> git stash pop
>>> git stash push --include-untracked --message "One II"
>>> git stash export --to-ref "refs/stashes/$USER"
>>> git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"
>>> The above will yield the following error:
>>>  ! [rejected]                  refs/stashes/bkuhlmann -> =
refs/stashes/bkuhlmann (remote ref updated since checkout)
>>> error: failed to push some refs to =
'https://github.com/bkuhlmann/test'
>>> hint: Updates were rejected because the tip of the remote-tracking =
branch has
>>> hint: been updated since the last checkout. If you want to integrate =
the
>>> hint: remote changes, use 'git pull' before pushing again.
>>> hint: See the 'Note about fast-forwards' in 'git push --help' for =
details.
>>> However, if you perform the above with only the single "git stash =
export" then you won't get the error as you discovered in your workflow.
>>=20
>> I'm confused by this, here is the relevant part of my script again
>>=20
>> >>     git stash push
>> >>     git stash export --to-ref refs/stashes/test
>>=20
>> This is the first export before pushing
>>=20
>> >>     git push origin refs/stashes/test
>> >>     git stash pop
>> >>     git stash push -m message
>> >>     git stash export --to-ref refs/stashes/test
>>=20
>> This is the second export before pushing
>>=20
>> >>     git push --force-with-lease --force-if-includes  origin =
refs/stashes/test
>>=20
>> I'm afraid I'm struggling to see what the difference is.
>>=20
>> Thanks
>>=20
>> Phillip
>>=20
>>> The only way I've been able to make this work is to do this:
>>> touch one.txt
>>> git stash push --include-untracked --message "One"
>>> git stash export --to-ref "refs/stashes/$USER"
>>> git push --no-verify --force origin "refs/stashes/$USER"
>>> git stash pop
>>> git stash push --include-untracked --message "One II"
>>> git stash export --to-ref "refs/stashes/$USER"
>>> git push --no-verify --force origin "refs/stashes/$USER"
>>> Notice that I always export before the push AND that I'm using =
`--force` each time. That's the only way to ensure your local stash is =
in sync with the remote stash.
>>> You can always verify that the remote stash is being updated by =
always clearing your local stash and then immediately importing to check =
if your stash message was updated properly. Example:
>>> git stash clear
>>> git stash import "refs/stashes/$USER"
>>> git stash list
>>> Once you perform the import, and immediately list what's in your =
stash, you should see something similar to the following:
>>> stash@{0} 6ba4eaea3751 On main: One II
>>> When your remote stash isn't updated, you'll see this:
>>> stash@{0} 6ba4eaea3751 On main: One
>>> (Notice the difference between the message of "One" versus "One II")
>>>> You can force the creation of a reflog
>>> I tried that too which makes the error go away but doesn't update =
the remote stash at all. Example:
>>> touch one.txt
>>> git stash push --include-untracked --message "One"
>>> git stash export --to-ref "refs/stashes/$USER"
>>> git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"
>>> git stash pop
>>> git stash push --include-untracked --message "One II"
>>> oid=3D$(git rev-parse --verify refs/stashes/$USER) &&
>>>   git update-ref -d refs/stashes/$USER &&
>>>   git update-ref --create-reflog -m 'export stashes' =
refs/stashes/$USER $oid
>>> git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"
>>> The above works but if I run `git stash clear && git stash import =
"refs/stashes/$USER"`, I find that my local stash doesn't have the =
message change (still using "One" instead of "One II" which means the =
remote stash never got updated).
>>> Sadly, I can only seem to make this work when using a force push but =
would definitely be nice to not have to use a force push.
>>>>=20
>>>>    set -ex
>>>>    dir=3D"$(mktemp -d)"
>>>>    cd "$dir"
>>>>    git init --bare origin
>>>>    git init repo
>>>>    cd repo
>>>>    git remote add origin "file://${PWD%/*}/origin"
>>>>    git config core.logAllRefUpdates always
>>>>    git config remote.origin.fetch =
refs/stashes/*:refs/remote/origin/stashes/*
>>>>    echo a >a
>>>>    git add a
>>>>    git commit -m a
>>>>    echo b >a
>>>>    git stash push
>>>>    echo c >a
>>>>    git stash push
>>>>    git stash export --to-ref refs/stashes/test
>>>>    git push origin refs/stashes/test
>>>>    git stash pop
>>>>    git stash push -m message
>>>>    git stash export --to-ref refs/stashes/test
>>>>    git push --force-with-lease --force-if-includes  origin =
refs/stashes/test
>>>>=20
>>>>>> You need to pass the name of the ref whose reflog you want to =
look at,
>>>>>> otherwise it defaults to showing the reflog for HEAD. You should =
be
>>>>>> able to see the reflog for you exported stashes.>
>>>>> I gave this a try and every time I use `git reflog =
refs/stashes/$USER`,
>>>>> I always get a blank response. No errors and no output.
>>>> Ah, I wonder if core.logAllRefUpdates only affects the creation of =
new
>>>> refs. You can force the creation of a reflog by running
>>>>=20
>>>> oid=3D$(git rev-parse --verify refs/stashes/$USER) &&
>>>> git update-ref -d refs/stashes/$USER &&
>>>> git update-ref --create-reflog -m 'export stashes' =
refs/stashes/$USER $oid
>>>>=20
>>>> the same applies to refs/remote/stashes/origin/$USER
>>>>=20
>>>>>> Let's try and find why the remote update say's it rejected when =
it isn't
>>>>>> and then we can think about the best way to document pushing and
>>>>>> pulling exported stashes.
>>>> I haven't thought much about the pulling side of this. "git stash =
import"
>>>> appends to the existing stashes so I'm not sure how we'd cope with =
forced
>>>> updates - have got got any experience of handling this from your
>>>> experiments?
>>>>=20
>>>> Thanks
>>>>=20
>>>> Phillip


