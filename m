Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11348132469
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029686; cv=none; b=SBlQVCfThfsn/2wDBnkcLBOujky2G7i1Fl9N6JGJrYAxZAOT2ACwgu4bo8N48ScQ7odF0a8XLvJ+BFNP/70nNmHXsuSS9TUWgjjZTRs/4REwHXoyyJODK8bEKj4NvsOGzQ/ZgzkyHZmcQbdi3UKyQV58s+o5+Ej6edd3aKEaeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029686; c=relaxed/simple;
	bh=2ngxBLn+K4nxyaN/bHlnLMKnLBBGIZS1TAYmnzvouQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hqoHABmhyvwlOszi4KSmp1Ys/85KGsSlnZFpvzd+Taax8X++/QeXY03ycpZGIzwbRH88rDM0V6KH0xODsm2B5zyRH3fBQkkZ96HymNPReasthCDS7qbQiNPfSHMt/U/QNDi0N7ht9HO/WXbi30CQtWt7KIcHlD6cilFucba9HnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vlrT7VCr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vlrT7VCr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 840921DDDC9;
	Thu, 15 Feb 2024 15:41:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2ngxBLn+K4nx
	yaN/bHlnLMKnLBBGIZS1TAYmnzvouQM=; b=vlrT7VCrMsBS67qEMeaQA9ddSZuW
	QB7t/f0ApdtaVH8t2obabb3/iQfezgix9eBph57x85l6DHyZF6MPIjdd3pD5NnLH
	wuGP48k3E/9YbpdOEOmQKTULpOHlfmMG+kQEoWQIMv7vbUqHhRYBv/ChM+Uvg+jX
	lXAc+ib7uvVvdUQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A9661DDDC8;
	Thu, 15 Feb 2024 15:41:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA5711DDDC7;
	Thu, 15 Feb 2024 15:41:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Dragan Simic" <dsimic@manjaro.org>,  git@vger.kernel.org,  "Kyle
 Lippincott" <spectral@google.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <f9ec6d31-7158-4381-9701-06fcb33f2e83@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 15 Feb 2024 20:28:45 +0100")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<f9ec6d31-7158-4381-9701-06fcb33f2e83@app.fastmail.com>
Date: Thu, 15 Feb 2024 12:41:21 -0800
Message-ID: <xmqqedddo3ym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 94A99C30-CC42-11EE-934A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> (If I read this part correctly.)
>
>> --m::
>> ---move::
>> -	Move/rename a branch, together with its config and reflog.
>> +-m [<oldbranch>] <newbranch>::
>> +--move [<oldbranch>] <newbranch>::
>> +	Rename an existing branch <oldbranch>, which if not specified defaul=
ts
>> +	to the current branch, to <newbranch>.  The configuration variables
>
> I had to read the first sentence a few times in order to understand wha=
t
> the =E2=80=9Cwhich=E2=80=9D part was saying (which seems to come from [=
1] by Junio). How
> about letting it trail the sentence?
>
>   =C2=AB Rename an existing branch `<oldbranch>` to `<newbranch>`, with
>     `<oldbranch>` defaulting to the current branch if not specified.

Yeah, insertion of "if not specified" in the middle made the
resulting text unnecessarily hard to follow, and moving it to the
end is a fine fix.  But I think we can just drop it (in other words,
we already said "defaulting to" and that should be sufficient).

>> +	for the <oldbranch> branch and its reflog are also renamed appropria=
tely
>> +	to be used with <newbranch>.  Renaming fails if branch <newbranch>
>> +	already exists, but you can use `-M` or `--move --force` to overwrit=
e
>> +	the files in existing branch <newbranch> while renaming.
>
> =E2=80=9Cthe files=E2=80=9D refers to the branch configuration and the =
reflog? People
> who read the man pages might not know that the reflogs are implemented
> as files and get tripped up. Maybe =E2=80=9Cto overwrite=E2=80=9D could=
 be left
> unstated?

Yeah, "overwrite the files in existing branch" can be mislead in
other ways, including "in a similar way that 'checkout -f <other>'
can overwrite the files with local modifications in the working tree
with the <other> branch we are switching to".  We'd be better off
not mentioning files at all [*].

    ... but you can use ... to clobber an existing `<newbranch>`.

would be sufficient.  If the verb "clobber" is unfamiliar to some
readers, "overwrite" is also fine.  The most important part from the
end-user's point of view is that whatever data associated with the
name <newbranch> is now gone, and replaced by what was associated
with the name <oldbranch>.  How we stored such data associated with
each branch is immaterial.

	Side note: Especially because we are not married to the
	files backend that stores one file per branch under
	.git/logs/refs/heads/ and .git/refs/heads/ directories
	forever.  With reftable backend, there is no such files
	specific to <newbranch> to be overwritten.

Another thing.  The existence of a <newbranch> is not the only case
we fail "git branch -m [<oldbranch>] <newbranch>", but the mention
of this particular safety valve is to tell readers that forcing with
`-M` is how to override the safety.  We want to be absolutely clear
that we are not trying to exhaustively enumerate failure modes [*]
to our readers, and I am not sure if we succeeded in the proposed
text.

	Side note: In other words, there are other ways the command
	can fail, and `-M` may not be a way to "fix" these failures.

> This patch also drops this part. Shouldn=E2=80=99t this be noted?
>
>   =C2=AB , and a reflog entry is created to remember the branch renamin=
g.
>
> Right now it looks like (reads like) the reflog is moved and an entry i=
s
> not made about it.

True.  This was missing in my "or something like that" illustration
and the patch copies without checking the original.  It should be
resurrected.

Thanks, both for writing and carefully reading.  Removal of
<newbranch> and <oldbranch> from the OPTIONS enumaration is really
good, too.
