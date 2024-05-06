Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2A446AC
	for <git@vger.kernel.org>; Mon,  6 May 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031225; cv=none; b=lRXDLFD6xsI5cfh7kpt+CDSJoCDeq1O5x5Lj6fghfsfPazbakWC8V5airf4244dBm47ILRuzslYW7lgqcYJ4pqPgy5eIcNcoiq72hvM3QKXA3KeY5tRaQJ0QeHZmHWbkXkrKYe/7xl4KAVr+dBmbaNvwDnHgyV+f7RmlEcw8WaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031225; c=relaxed/simple;
	bh=n1nqUIdgpt7oZ4HMLPK5Xol0XPyBybWZCmhzH8bIvzk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGsEFM7q80IKIi+JrmyXruVim9FmGPBCr7AfF14OlAJ7c07qc90/FWv+yd8+fTEElCcHRgApo9kd31itKZP3UvfiUvG0+vNLc93xrk6II2KFhPAqT0KeIr6ruj2zbXUnO2WKq6sOkLL21tFBnthXunSzDHLF+HOIWXcNAAsj3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bv/AeSgC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bv/AeSgC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EED882EDA4;
	Mon,  6 May 2024 17:33:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n1nqUIdgpt7oZ4HMLPK5Xol0XPyBybWZCmhzH8
	bIvzk=; b=bv/AeSgCx1dR2Wi1NwS9qHkUXaTs1zcjWkmXz69ZlvrtUI4nJoZST8
	QVKAay1nbpGn/KI6ltOegS/tj4BspPMOpn0Lmz8VPKWXtZmYSLpdanOgvu9ZkNU5
	rg2ZQKbRHmWzhC5LsHLP5gHGDV8vVisVnV8ITSvF/u1DbN0rY1igA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E75F32EDA3;
	Mon,  6 May 2024 17:33:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AC212EDA2;
	Mon,  6 May 2024 17:33:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Git 3.0?
In-Reply-To: <xmqqttjazwwa.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 May 2024 10:13:25 -0700")
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
	<b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
	<CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
	<015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
	<xmqqjzkaanr1.fsf@gitster.g> <ZjiL7vu5kCVwpsLd@tanuki>
	<xmqqttjazwwa.fsf@gitster.g>
Date: Mon, 06 May 2024 14:33:33 -0700
Message-ID: <xmqqa5l2y6aa.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B432C76-0BF0-11EF-9605-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> ... I was pondering
>> whether we want to introduce a document as part of that patch series
>> that starts to keep track of upcoming removals for a potential Git 3.0
>> release.
>
> Finally somebody has bit it ;-)  In the 2.44 cycle, I wrote
>
>     The RelNotes symbolic link says we are now working towards Git 2.44.
>     It may not be a bad idea to reflect on what technical debt and UI
>     warts we have accumulated so far to see if we have enough of them to
>     start planning for a breaking Git 3.0 release (or, of course, keep
>     incrementally improve the system, which is much more preferrable---
>     continuity and stability is good).  End of year being a relatively
>     quiet period, it may be a good time to think about your favorite pet
>     peeve, to be discussed early next year.
>
> in a few of the "What's cooking" reports.
>
>> There are multiple items that could be added:
>>
>>   - Removal of the old syntax of git-config(1).
>>
>>   - Removal of the dumb HTTP transport.
>>
>>   - Removal of `info/grafts`.
>>
>> There are probably other items.
> 
> A list of things I can think of that I won't be the primary advocate
> for but I do not mind too terribly if we had champions for the
> topics are attached at the end.

Just to avoid unnecessary misunderstanding, as I said, what I listed
are not my proposals.  Rather, take them together with Patrick's list
that they are invitations for others to let their imagination go wild,
trying to come up as many ideas regardless of how good they are, sort
of the initial "brain-storming" phase of a discussion.  We will need
to cull bad ideas, pick good ones, and refine what we are going to
implement in later stages, but this is not a time to shoot down what
you do not like, yet.  It is instead for you to add your pet peeve.
