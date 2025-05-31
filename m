Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4E12B63
	for <git@vger.kernel.org>; Sat, 31 May 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748694059; cv=none; b=YwZ9rQh1Yz9sGsKNT6kwkIYcopwC9fcklg4dOFmfa2Ha9OO8LZDZPq/ZKcMiZXU1eXaXyZ6k4KUPm3RP93jMQYh1hV00V8dHZzJyUjh5QI1Qz7X+qI+IDNfUqBUbkmUgvpwNpcwJDQA0xfYlWpWxnyM37jsvlYXIUlLMNWq8Yt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748694059; c=relaxed/simple;
	bh=USa0SzjAd8BacCiQ9YICQawNqkMp4UthaZn9L5QJpDE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YRljfN+OtYgW2jw5uCTC6nTkAGH+ZVW+lGNKXB2PULCwb7ErkRzgDeFPoejGXMmZdpNNHqHpY6YetX4gh7eiVTgfZCSI6ma/T983kYG39gf+6PbuEyGKzZTlJEdu2rdEfi6zVhPEFCjqAcK3VrtxkvmJsADs/8wBqdBvKdEsMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mbIcLR7E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUqnJY3F; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mbIcLR7E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUqnJY3F"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEC8D11401A0;
	Sat, 31 May 2025 08:20:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 31 May 2025 08:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1748694055; x=1748780455; bh=tKMrOeBk/Te1E2SK9yOl/vWR34WnH8a9
	MuU63JCBGpw=; b=mbIcLR7EiAwrcF4AS8qfHeTkamFtqG+MVXKVvxWbpOazvQh9
	6PIDdDwT5e6vhlpuJ56BHl/N/EWetwl3kX1abgexg7mG0BoOBMAtCubSjtD/WuE5
	75dcCq0ljLFa2do3coyzhSkFksgANcBvIT9LRkrpqwb1efkAEqNfq8Np64/LfGfL
	JpTlKNn1Kdqn1enillx8F9khMOEQjuNDdz4OmTRepjUJ4D9jrLEY/ymZ6IaQ0jrb
	5DQsOHUTqozzqDEiOU94nkqsDaMtngXaQ1iy7mhf17rYL9fM5CIKJjI5HAGfjotS
	Tnk8cQ4W9Y6YK3SS+XVkdvBcxi/p57XJIcX3qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748694055; x=
	1748780455; bh=tKMrOeBk/Te1E2SK9yOl/vWR34WnH8a9MuU63JCBGpw=; b=D
	UqnJY3FJaQQdqygMHaWS3/wWxA/ZT0hTFZEpd0QVdh29ekwC1rZpcWJsyIQkeLgp
	Jo15YbhOq4tf8cDl5T3hITR1IoYSMqWF3Or7L7A4SrcsrhWDxGyC93fjOXhiIQJ+
	SxApDGY94yJt+5d5wwxSsJkXnDRo9rbzDebLbdAby1dN/pwJZblofgDfHOUy1dir
	07P7Lw55Vl6yHYsNFMR30c4KblOv+8K+geYp0ddPLZw0/542u/bgk/T191aviT+p
	y20GdH1YPSfG16MVfadVXrOZutgBfhvcLYTtdOjkOkBFt3owBaYGDWYq9Feso0/U
	SW3y3nnNH1LoHMMNruvkQ==
X-ME-Sender: <xms:JvQ6aDBfMyW6tw1AoIEEwUS8AvC3Ckvw_yV6UqvPrtJGmpktYISSrQ4>
    <xme:JvQ6aJjDmqZlmo7wASlDWzvJXiOJyxQaWwkaMB38LMl_TTmEpG3CK7fhY5zpChhvt
    lNVrl4OkD7IoHgWZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudekkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffr
    rghtthgvrhhnpefggfeuteekjedutefffedtgfetveelledtheffhfegueduieeuhfekhe
    ffueefhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JvQ6aOkvIBPJu7AMSILB_M4V1N7kA_iIMCw6AFvTY1zWzg7PjYBxQg>
    <xmx:J_Q6aFwob40kl-asLL02R07AdafWT_ZvepJInuKNkIK1KEEOa5J-yA>
    <xmx:J_Q6aISbqk8gUK2V4nk0dcQC_rMyXK9zlwq7933FSSed70VI8wD0zw>
    <xmx:J_Q6aIZr84kSKznMKUx4Kubead0YMOI8PCDX_iIKxssfeY0IyvLgHg>
    <xmx:J_Q6aKWVeYguW8mwKuq6iLM5Ryb1jKHjVD_u2NvsS-kLFFkon-2g9oZe>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1D5A1EA0060; Sat, 31 May 2025 08:20:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T148f96a354bfd0b2
Date: Sat, 31 May 2025 14:17:34 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <3f731776-9a9e-4c8f-8de9-99d470503345@app.fastmail.com>
In-Reply-To: <aDp55upE6AhYunz7@ArchLinux>
References: 
 <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked worktrees
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025, at 05:39, shejialuo wrote:
> It is reported that "git refs verify" would fail when encountering
> worktrees created on Git v2.43.0 or older versions. These versions

Nit: maybe

    "git refs verify" doesn't work if there are worktrees created on Git
    v2.43.0 ...

The part about it specifically not working if there are no worktree refs
might be obvious when you take in all of the context here (no refs/
directory).  I don=E2=80=99t know.

> don't automatically create the "refs" directory, causing the error:
>
>     error: cannot open directory .git/worktrees/<worktree name>/refs:
>     No such file or directory
>
> Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
> 2024-01-08), we automatically create the "refs" directory for new
> worktrees. However, the fsck code incorrectly assumes all linked
> worktrees have this directory, thus introducing compatibility issue.

Thanks for finding that commit.

At this point in the message it seems like the fsck code never worked
with these old linked worktrees.  But `git refs verify` used to work
with them until 7c78d819e6a (ref: support multiple worktrees check for
refs, 2024-11-20) which was part of v2.48.0.  So I think it=E2=80=99s wo=
rth
mentioning that commit as well.

You wrote on the first email which I=E2=80=99ll just respond to here sin=
ce
it=E2=80=99s relevant:

https://lore.kernel.org/git/a2a50127-6ab9-4d8a-abcc-b1a741df293e@app.fas=
tmail.com/T/#mada29f8b0d02091d21412d8bd57cc666bc657c04

> > And hope that this fix would land in this release.

Like I said in the first email the only minor regression in this release
cycle is that git-fsck(1) reports these errors on stderr because the
default `--reference`.  This was how I spotted the issue on rc0.  But I
neglected to mention that the commit that introduced `--references`
(default) for git-fsck(1) is v2.48.0-rc1-49-gc1cf918d3ad (builtin/fsck:
add `git refs verify` child process, 2025-02-28).[1]

So based on the last what=E2=80=99s cooking email[2] it depends on if th=
e stderr
output regresssion from git-fsck(1) in this release cycle is severe
enough to need be fixed in this release.  Because the `git refs-verify`
problem has been there since v2.48.0.

=E2=80=A0 1: Part of the reason for neglecting that was that building th=
at
    commit fails for me.  So the bisection skipped it and couldn=E2=80=99=
t find the
    commit.  Is that just me?  The merge commit does build de35b7b3ff (M=
erge
    branch 'sj/ref-consistency-checks-more', 2025-03-26).  I changed
    `start_progress(r, _("Checking ref database"), 1);` to
    `progress =3D start_progress(_("Checking ref database"), 1);`.  I
    don=E2=80=99t know if that is wrong but it made the bisection script=
 run
    without having to error out with `125`.

[2]: https://lore.kernel.org/git/xmqqiklhd3tc.fsf@gitster.g/T/#u

>
> Check for ENOENT errno before reporting directory access errors for
> linked worktrees to maintain backward compatibility.
>
> Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c     |  3 +++
>  t/t0602-reffiles-fsck.sh | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4d1f65a57a..bf6f89b1d1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store
> *ref_store,
>
>  	iter =3D dir_iterator_begin(sb.buf, 0);
>  	if (!iter) {
> +		if (errno =3D=3D ENOENT && !is_main_worktree(wt))
> +			goto out;
> +
>  		ret =3D error_errno(_("cannot open directory %s"), sb.buf);
>  		goto out;
>  	}
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index f671ac4d3a..615b7c0683 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -110,6 +110,21 @@ test_expect_success 'ref name check should be
> adapted into fsck messages' '
>  	)
>  '
>
> +test_expect_success 'no refs directory of worktree should not cause p=
roblems' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +

Nit: blank line?

> +		git worktree add --detach ./worktree &&
> +		# Simulate old directory layout
> +		rm -rf ./git/worktrees/worktree/refs &&

Eric[3] had a `git rev-parse --git-dir` suggestion instead of using `.gi=
t`.

[3]: https://lore.kernel.org/git/a2a50127-6ab9-4d8a-abcc-b1a741df293e@ap=
p.fastmail.com/T/#mb42bdb046c391f2583c2200668945408a2d0396f

> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
>  test_expect_success 'ref name check should work for multiple worktree=
s' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
> --
> 2.49.0
