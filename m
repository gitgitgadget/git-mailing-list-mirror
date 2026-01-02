Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D224728E
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352315; cv=none; b=LPVdMeBlkxCPxlnlJpTj/1gFQR6AC2dm3q5XG2/QJtHNc5rLnCxraPlNTHvae2DvQQjMFj4SI3HlY+HF+fvFRN/4x/o8wTzOAL+fv4iAtRIcyADFj30CiIJDE/BIMG8QcQFriQieeQLx0xbLhky7hrAPLm02Ioew9rFpdG+3k2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352315; c=relaxed/simple;
	bh=ub4+t0rcX+/bC4VqohbthL4z6HQt8RWBnWTnBZ8REU0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cQ7zKRjZ2KOarmFOlCk4UY9WSq5qULAWFTsU7kezpShCOe1wyQGSrDV+bST6OtIRI29iKyhIBoJ7FE790F3A/V5muf+2IdtsV3xuEPXHIMP7xLNNsKfdf+eY4xhccbmTmj+BgpycASjh3sZmv2XFQV14rYEWAqY/xLVQ/tpvwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=alhOdLRm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2s0lb1W; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="alhOdLRm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2s0lb1W"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 551591D00063;
	Fri,  2 Jan 2026 06:11:52 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 02 Jan 2026 06:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1767352312; x=1767438712; bh=D5VFoFuYQ10iKtnjf9j5FJpN8hsHFnps
	gGCRIEvpvDA=; b=alhOdLRmm28OcBqlnkxMU+CADnuZfRrsndEb9rh3JZsFg/9P
	AFdXXl94uHP26a8JjkCGzk9seQicfHTc4zLoMOdAKW2k/0uXnbOoTczDIaPaKj2w
	DYEzyuLCVTKoviDRSp/GQc4AtKOru0Uc6RzRWD7dpUnx+pCI6YyrQ58AIOH8Ey1j
	GfAeQvTOipjnVMZl/9HHzATY1P/gqsM9TYnvGs5yxH++uHlFB19cZtHRyMKpTfVE
	GwLVfNSLA0kwkUbcDjWq/uaQ8soxQUwj06J6UHzBJljw+b+Q/PQ7qKsmbVu8Sp0x
	kYAXDX8+/kPCILAhZ1N1AZ1/93ibHuKTdll7jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767352312; x=
	1767438712; bh=D5VFoFuYQ10iKtnjf9j5FJpN8hsHFnpsgGCRIEvpvDA=; b=W
	2s0lb1WJ7YX1nRs9Sj076wxVMf607nVh3uN7xhJFG/hyFTUYVwb9z0vY1lbGOtad
	lY5d49u/F/emXD8NqqY4ooBwBcaXls++RDDhEqElhxvVScLplVArAVb0zWv8r9/m
	Hiq7HH205KVt/CEf/VGRCFvuKt5RGJRL9Q83GyaIzfWtwGHxgY7A5Gcybq/6Er2f
	HUqolLi9cDF2ig60H9yRWUr/z+jrl3DGoZsCrUlgdvUbNDb36giaDhQkbH9XNz0k
	SF2x92biOH5vchfWpgI3a/7KJqcs9OzIHNUuQm1U7siO0MWA8UTb/X5Rrrew2Poq
	6/VVlelGWGXMEfjNHQvmA==
X-ME-Sender: <xms:96dXadnrkgYfFz0-W2X4smwqcL6Tx67Fzl_MbfHzSd8fUxrU0YCcG3w>
    <xme:96dXaTo1DkIRwLQYqehQ2Gf5YFLlwOruFl4m4QLvgFp60Xo6vNC-mSfTKJfshCZAJ
    cV-npMkxpLuMtXZVZ41uRJ09CyN7FpuwoFLYpM7KaKOyeKmp9Z2Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnh
    grfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:96dXaQHJwc2_WFNJahvjvHY1g5uOLJT69mkPZlGLdCdIIgwtIbj4MQ>
    <xmx:96dXaUSaNXAtiUKDvV0CGr2LiFPHdCJq5Kkd9iloSR6vV-MbSl4Twg>
    <xmx:96dXaZI9JCzrJa16GSfhfUfh0rHVBAeFoYPt8uCa2QZ6oF2BJFppQA>
    <xmx:96dXaXZnJbifbVfBLR1Gdvk0vQB7TjN8gSug8oV9Kges7OWIFsGFtA>
    <xmx:-KdXadTrbeaJzvadr_1k50RtAi4FJmuAcgoXaeiMA4J_aZWVetakK0wn>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B7D211EA0066; Fri,  2 Jan 2026 06:11:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANW8zKizbnXw
Date: Fri, 02 Jan 2026 12:11:29 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Elijah Newren" <newren@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <c488a180-b840-43df-a593-4dac6b7f00d2@app.fastmail.com>
In-Reply-To: 
 <CABPp-BH1b3rHi96qXLQwQRX6g7POmqYLKyAc=_1UsWmfiWsGFg@mail.gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <V2_CV_replay_die_descr.17b@msgid.xyz> <V2_replay_die_descr.17e@msgid.xyz>
 <CABPp-BH1b3rHi96qXLQwQRX6g7POmqYLKyAc=_1UsWmfiWsGFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] replay: die descriptively when invalid commit-ish is given
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025, at 23:52, Elijah Newren wrote:
>>[snip]
>> @@ -349,13 +351,10 @@ int cmd_replay(int argc,
>>
>>         populate_for_onto_or_advance_mode(repo, &revs.cmdline,
>>                                           onto_name, &advance_name,
>>                                           &onto, &update_refs);
>>
>> -       if (!onto) /* FIXME: Should handle replaying down to root com=
mit */
>> -               die("Replaying down to root commit is not supported y=
et!");
>> -
>
> Removing the `if` makes sense given the current code, but I wonder if
> we should keep a corrected FIXME here:
>     /* FIXME: Should allow replaying commits with the first as a root =
commit */

Okay, I will change to keeping this updated comment at this line but
remove the if-block. And I will remove the moved comment:

    if (!commit->parents) /* FIXME: Should handle replaying down to root=
 commit */
        die(_("replaying down to root commit is not supported yet!"));

Specifically I will remove the if-block on this patch/commit and make
another patch for both renaming the comment and the =E2=80=9Creplaying d=
own=E2=80=9D
die-statement.

>
> This is out-of-scope for this series, but behind that FIXME...
>
>  I'm guessing the user would specify to cherry-pick onto NULL via some=
thing like
>    git replay --root A..B
> which would translate into making `onto` be NULL, and mean that the
> first commit after A would be a root commit.
>
> Similarly the user could be allowed to do something like
>   git replay --advance new-empty-branch A..B
> where new-empty-branch doesn't yet point to a commit, this would also
> result in `onto` being NULL, and start new-empty-branch by
> cherry-picking some commits into it.

Okay. With options from git-rev-list(1) like `--root` this mode makes se=
nse.

>
>>         if (prepare_revision_walk(&revs) < 0) {
>>                 ret =3D error(_("error preparing revisions"));
>>                 goto cleanup;
>>         }
>>
>>
>> @@ -367,11 +366,11 @@ int cmd_replay(int argc,
>>         while ((commit =3D get_revision(&revs))) {
>>                 const struct name_decoration *decoration;
>>                 khint_t pos;
>>                 int hr;
>>
>> -               if (!commit->parents)
>> +               if (!commit->parents) /* FIXME: Should handle replayi=
ng down to root commit */
>>                         die(_("replaying down to root commit is not s=
upported yet!"));
>
> I wonder if I should have written s/to/from/ here ?

=E2=80=9Creplaying down from=E2=80=9D? Not =E2=80=9Creplaying from=E2=80=
=9D?

>
>
>>[snip]
