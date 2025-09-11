Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3A218592
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557371; cv=none; b=ICCcPJOBUcWUOMX1T7KDVqREAQqhN6eJnWw6Y/Fqn9M2qNLC5aCT3JrBkZMmg5BZZl3fldBQBf/EMoK1ewY2hOBnjhq4NSoY0JbZaZxSaWaPVZUsY2letGN6KXb5INa8nICoDRygiC+ngYRu/KPd0kAnCCQBcwF9pUl4VRjgEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557371; c=relaxed/simple;
	bh=h4/MjVQ8x9roa1dbMroLN7h4hS7X9bhfL4FPXp1gz2s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HFLWfOefBB2FdlP/bpK+5eB3quW0vy1lGy1xSKjdH7/Tgr5SmkIXFwpKm0GcWZsBQv4ccz631KVKAMuxp1rk08tQMrh7/NwAErFrcbQKk97cZJieSabphTiDAXbZZP8yIV3uD0bT1J58wAcUSl37xqO5X/q6nryI9fXTJyfp0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=a6MVglEr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=blXebFb7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="a6MVglEr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="blXebFb7"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C73C1D000B4;
	Wed, 10 Sep 2025 22:22:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 10 Sep 2025 22:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1757557367; x=1757643767; bh=gavXIy7W37M2Kx0wjxZnG73LUuBJ+tZo
	3Yzi86ZCgHA=; b=a6MVglErh5AII3glW84rTW3vV8KR14t/WRbEa9jOrU+Gv3GT
	w9PNFtHvs3YldRYfWEAYuKm0RiV0uUjLjDP1ZaqTUvk/gbrxO/loVVshaKUQlcsa
	slIisxRCD769/a5Df6CW6KPRtqd7MKjJki/7riEOoinlGEqwNww2gHOg3OEXuBNY
	k+cJlQT1O6rJtsSqWUi62fp/yGB0tSBtMdwlFqvzXKFCzzHxI7qp75LkPvZv7a+R
	b4lu3ebxjwfim2rDXc2lHNvrk0hhMH8Fu76Bd2t79WcMDlM70jWVpZX07lhyNwa1
	GFHnLPIJuMs2iYY7ebOBdEKL96Dqf+KohW+kCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757557367; x=
	1757643767; bh=gavXIy7W37M2Kx0wjxZnG73LUuBJ+tZo3Yzi86ZCgHA=; b=b
	lXebFb7pCsA6L1V1VjvmvVmnpiVw7OiMZ0g/zLy/1CprVPEr3saRchBr1DzZV7yg
	E+qskVwNoTn3p6X+F+XQEcz3xpOKPLxBMf5IHRFXQ+L9rjSApD4y+fwelPRfbALU
	hsusosMCFhJRAOaxXVYpR8TN8swD05wdMdVSH827w6tzPXE6S6TC6lFwDrF4EMb0
	CvsL3x0XWScQyYOu9T0ybsdxR8+JL7kZ33jUnIEbDvbOBNvlL8r7Ft/KtiV3Xppn
	gS/lL+48FZAZaqwSBT5d/QaB6OM0ZSilgcyeV/KZqEP4MBZ5TO7ItN6xwVbkfWdj
	UQA2yNKdGWzySx6ARjm6g==
X-ME-Sender: <xms:djLCaNNVp7rNKV8Yh0NDuPVccxjbkLc0yOana_D0AtgUWqXlRA1xIg>
    <xme:djLCaG2YQFMBiiStwNrGYkRFn6UZ0F9S_vPFhJz0bECU2G1dqaZl8f_P2x7pNqYNn
    Ok7hwDC9wTbg0mb>
X-ME-Received: <xmr:djLCaJNVgJCjIESia-mGw-rm2olyk4knFhiPXCchCr8DcrhSOzmUiLGKefYFVQci7xlC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtd
    hhtddvnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpedvvdejveevhfeiffelfe
    fggeeitdejfffgfeelhfetudehgfehjefhteekueegveenucffohhmrghinhepghhithhh
    uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesug
    hunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvght
X-ME-Proxy: <xmx:djLCaG2L3Z4AkP06t3jD9f16lIK8zjT-J8teM7om4jFS_19LMH3Dlg>
    <xmx:djLCaAEMQyG42bixsqPpy_pTGQbOzCae7ySHJC3dJzyYHGyiWvH4uA>
    <xmx:djLCaD4QK8NS_G6Tw5cEmizBuqfllM_ERNvitbp1uyowMKYl04i9Ug>
    <xmx:djLCaGusNWD-vU4c6ADZ-W3BFDIebvSxl9uMWPnD5oFVO9hvg_5iRg>
    <xmx:dzLCaIepc_rLUxhuDF0aL_uJpcBsXNNMxrTKn23r1VOjgNbSPgRDMu_g>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 22:22:45 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Git Stash Synchronization - Best Workflow?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <94d614fb-63b8-4733-b78d-b55c482fbed8@gmail.com>
Date: Wed, 10 Sep 2025 20:22:34 -0600
Cc: git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E308F060-D39C-4C7A-9F38-2CA33BCE4AB2@alchemists.io>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
 <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
 <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
 <FEB150D4-2B5E-41CF-ADCE-93DD0B48D364@alchemists.io>
 <94d614fb-63b8-4733-b78d-b55c482fbed8@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.700.81)

Hey Phillip

> I'm unable to reproduce this. In the script below the final push =
succeeds.

That's because you need to export every time before you push. Like this:

touch one.txt
git stash push --include-untracked --message "One"

git stash export --to-ref "refs/stashes/$USER"
git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"

git stash pop
git stash push --include-untracked --message "One II"

git stash export --to-ref "refs/stashes/$USER"
git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"

The above will yield the following error:

 ! [rejected]                  refs/stashes/bkuhlmann -> =
refs/stashes/bkuhlmann (remote ref updated since checkout)
error: failed to push some refs to 'https://github.com/bkuhlmann/test'
hint: Updates were rejected because the tip of the remote-tracking =
branch has
hint: been updated since the last checkout. If you want to integrate the
hint: remote changes, use 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for =
details.

However, if you perform the above with only the single "git stash =
export" then you won't get the error as you discovered in your workflow.

The only way I've been able to make this work is to do this:

touch one.txt
git stash push --include-untracked --message "One"

git stash export --to-ref "refs/stashes/$USER"
git push --no-verify --force origin "refs/stashes/$USER"

git stash pop
git stash push --include-untracked --message "One II"

git stash export --to-ref "refs/stashes/$USER"
git push --no-verify --force origin "refs/stashes/$USER"

Notice that I always export before the push AND that I'm using `--force` =
each time. That's the only way to ensure your local stash is in sync =
with the remote stash.

You can always verify that the remote stash is being updated by always =
clearing your local stash and then immediately importing to check if =
your stash message was updated properly. Example:

git stash clear
git stash import "refs/stashes/$USER"
git stash list

Once you perform the import, and immediately list what's in your stash, =
you should see something similar to the following:

stash@{0} 6ba4eaea3751 On main: One II

When your remote stash isn't updated, you'll see this:

stash@{0} 6ba4eaea3751 On main: One

(Notice the difference between the message of "One" versus "One II")

> You can force the creation of a reflog

I tried that too which makes the error go away but doesn't update the =
remote stash at all. Example:

touch one.txt
git stash push --include-untracked --message "One"

git stash export --to-ref "refs/stashes/$USER"
git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"

git stash pop
git stash push --include-untracked --message "One II"

oid=3D$(git rev-parse --verify refs/stashes/$USER) &&
  git update-ref -d refs/stashes/$USER &&
  git update-ref --create-reflog -m 'export stashes' refs/stashes/$USER =
$oid

git push --no-verify --force-with-lease --force-if-includes origin =
"refs/stashes/$USER"

The above works but if I run `git stash clear && git stash import =
"refs/stashes/$USER"`, I find that my local stash doesn't have the =
message change (still using "One" instead of "One II" which means the =
remote stash never got updated).

Sadly, I can only seem to make this work when using a force push but =
would definitely be nice to not have to use a force push.

>=20
>    set -ex
>    dir=3D"$(mktemp -d)"
>    cd "$dir"
>    git init --bare origin
>    git init repo
>    cd repo
>    git remote add origin "file://${PWD%/*}/origin"
>    git config core.logAllRefUpdates always
>    git config remote.origin.fetch =
refs/stashes/*:refs/remote/origin/stashes/*
>    echo a >a
>    git add a
>    git commit -m a
>    echo b >a
>    git stash push
>    echo c >a
>    git stash push
>    git stash export --to-ref refs/stashes/test
>    git push origin refs/stashes/test
>    git stash pop
>    git stash push -m message
>    git stash export --to-ref refs/stashes/test
>    git push --force-with-lease --force-if-includes  origin =
refs/stashes/test
>=20
>>> You need to pass the name of the ref whose reflog you want to look =
at,
>>> otherwise it defaults to showing the reflog for HEAD. You should be
>>> able to see the reflog for you exported stashes.>
>> I gave this a try and every time I use `git reflog =
refs/stashes/$USER`,
>> I always get a blank response. No errors and no output.
> Ah, I wonder if core.logAllRefUpdates only affects the creation of new
> refs. You can force the creation of a reflog by running
>=20
> 	oid=3D$(git rev-parse --verify refs/stashes/$USER) &&
> 	git update-ref -d refs/stashes/$USER &&
> 	git update-ref --create-reflog -m 'export stashes' =
refs/stashes/$USER $oid
>=20
> the same applies to refs/remote/stashes/origin/$USER
>=20
>>> Let's try and find why the remote update say's it rejected when it =
isn't
>>> and then we can think about the best way to document pushing and
>>> pulling exported stashes.
> I haven't thought much about the pulling side of this. "git stash =
import"
> appends to the existing stashes so I'm not sure how we'd cope with =
forced
> updates - have got got any experience of handling this from your
> experiments?
>=20
> Thanks
>=20
> Phillip

