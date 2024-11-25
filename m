Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FF2260C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503893; cv=none; b=igCgdGgB7enTmE+BxMtNklXYuTt2F8yQrVGcXAZzKAdW/Mg9vse0IjeB385cmWSRqdHArvLYTqmO8zV5gnnzqNItdFSulmrshwEhObnUbxXoI21DDC6GoRU2VaxCb5pcsEieEQrMM8DKMhnSW1dNe/SZGny9xhGpLhV+gni9OTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503893; c=relaxed/simple;
	bh=CwHc9CArnnHM512Bj1ZECn0jJTD1oEiObhK+D+6X90U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TqInNS/f5YiM4G3Zvsav7ktouVmYrsqecgrmAhEgeAVnQOHZrfEQC+bV436rFl5yHR9ILG0oc1rmTN/fWRYl/Te0VgSZqEVWYOkawb3tjXMYHRt5QPJUoZ+jM6w4UIgEG5l8QBxhztAglMrRtiBEx48bSdvRmlJc6xBJBjIjqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzulV4TV; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzulV4TV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CF93B11400A4;
	Sun, 24 Nov 2024 22:04:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 24 Nov 2024 22:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732503890; x=1732590290; bh=shpi7Iv61Y5TNKK9I+iYV0KJN7GVOxjp/d9
	+0E+j7O4=; b=lzulV4TVMijcmAghDVfHxOl+XZ0DkrfCgsE8SpQnSQD9yn1n4dC
	TtXbyF1D1rTFdTZy0FSTFqEbq1byQP5VW1kKLySFRIXJDxfOCUXBB062Zq8ZWmYz
	Z2F0bcQpoPLUPakajyJpVEMK4uDCPYKBWaAp4yhfruOkj3wORbyH56k9ggZ1EpzU
	VE/qStVphvUjhLZ/C+rxZ8aDwGvDqlGrzm92oSljA310DVQyDsawHJDKwHM0p1LX
	gJeAeFmA8mACBTwhBPHhGzzef5FXD1u9tWW90UPKJ96vfhLb/3A7W2yyHCYv7ATk
	ew9DZDlrIUQf3NDng2uV6nUGFgSZ79tVJ2w==
X-ME-Sender: <xms:UulDZxOgnmh7iNjRp89wUmVlXUTzC-F4NR-NFGfS3dYJVts6Q2RYGQ>
    <xme:UulDZz9W1WLTop5eejm4jgHljVYXUmWPul2vnC8W9uJoAmdJg43ASq1LSeFUtEPPh
    RJzNtcyYKrbrRuNQA>
X-ME-Received: <xmr:UulDZwSrxttRvAJ-TOq5xqlEvG-E_ox6KlteYg-Nj_WUc7w9awIBpRGKVuvQhy5bPOFrmZGh0r8LtSVYy6ONoyhbsbmjw7pqLaqmpfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UulDZ9vUz3XPMl9fBj1En_XCArIpYMsfDjN3I44RvDdR1WMQ0uI5Bg>
    <xmx:UulDZ5cn4kIf3ccadwnlvesJ27Df3XM8IRi81DZJwYMGdu0OgeYpUA>
    <xmx:UulDZ50h95twZDgQmUTwqHWBFsDACH6vPtPvcnk7SgPflwEYPRhkuQ>
    <xmx:UulDZ1_vxQXuxosA0FZbyOIJkl1aRpjNDIF86j2Rj2IGDR6ptWS_EQ>
    <xmx:UulDZ949Fd1sfYFcjrKg3v1rk7YYyoMbgRGkkdsHycIUrr2YIJIpIUTE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 22:04:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: option value may be separate for valid reasons
In-Reply-To: <CAPig+cT_uB-mBwRh_A-HvpO8QCjv_Rw3-6s4gV=BCwYmSGcctg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 24 Nov 2024 18:54:34 -0500")
References: <xmqqjzct9db8.fsf@gitster.g>
	<CAPig+cT_uB-mBwRh_A-HvpO8QCjv_Rw3-6s4gV=BCwYmSGcctg@mail.gmail.com>
Date: Mon, 25 Nov 2024 12:04:49 +0900
Message-ID: <xmqqo7246mjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +   may want to use the separate form, e.g. `git credential-store
>> +   --file ~/sec/rit`, not `git credential-store --file=~/sec/rit`.
>> +   The shell will expand `~/` in the former to your home directory,
>> +   but most shells keep the tilde in the latter.  Some of our
>> +   commands know how to tilde-expand the option value internally,
>> +   but not all.  The `--file` option of `credential-store` is an
>> +   example that it needs shell's help to tilde-expand its value.
>
> I'm not sure the final sentence adds any value considering that
> credential-store was already mentioned in the example earlier in the
> paragraph, though I suppose it doesn't hurt to keep the sentence.

Probably.

>> diff --git c/Documentation/gitcredentials.txt w/Documentation/gitcredentials.txt
>> @@ -240,10 +240,15 @@ Here are some example specifications:
>>  # the arguments are parsed by the shell, so use shell
>>  # quoting if necessary
>>  [credential]
>>         helper = "foo --bar='whitespace arg'"
>>
>> +# store helper (discouraged) with custom location for the db file;
>> +# tilde expansion often requires the filename as a separate argument.
>> +[credential]
>> +       helper = "store --file ~/.git-secret.txt"
>
> In the context of the commit message, I understand why you added the
> comment above this example, but as a mere user without having that
> context, I think the part starting "tilde expansion..." would confuse
> me more than help. Perhaps being a bit more explicit might help:
>
>     # use `--file ~/path` rather than `--file=~/path` to allow the
>     # shell to expand tilde to the home directory

You're right.  That reads much better.

Thanks.
