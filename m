Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672E172760
	for <git@vger.kernel.org>; Fri, 10 May 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356763; cv=none; b=nSg9mgYkGC0t0jJ7mcEWdazzvU7d91WWQ9t4iww/5rm/HgcOReCpx5vMjGbZ5YV2HjfRSD/GwAiqvmXWUNilYzfzQd+eVMJIq6FfCMfVPCz9Kkc742Mq13Sv9bsWlbbEEeGJaJEVzyMm+abIsJTQuJOgB38GD+VGkqlo+0x4vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356763; c=relaxed/simple;
	bh=k7rd2hRaVigDTw+BS9pCFYhM0ZNR77yuM/if0PNsRG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjjqfO/hSo8OvV167I5s5Ldx5Q4VtlUwvUYEsBHzCQ7/VRVHtVG9l/WsIyIRf3uLNaVlTMRgolQELt01R1uYzH5RKHH3GNUdGMS5SlIo+3BpfccXmrP/A/pp3WwXLUw7XOzID7aSx87Gr4cFHk7CxlYMFUnvlKNJUoQMXiqBJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICsfcfSZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICsfcfSZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B740319FF;
	Fri, 10 May 2024 11:59:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=k7rd2hRaVigDTw+BS9pCFYhM0ZNR77yuM/if0P
	NsRG8=; b=ICsfcfSZzj64h79af/XtiRXlqOFIa+y6W/CLZHiXZe3HkXQZWVoTSC
	h0mj5DPHSdfG8lqPFp9QREKLfwYQEufnc2lUcsN3bSvP6yNzEPpGhYQcdP1V4YIa
	ANGIiJIyxIQfQzC1jh/gDvH8kZzZ6HU+Xv7zHsgIh/PxhWRtLPqSg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 547B0319FD;
	Fri, 10 May 2024 11:59:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA4D2319FC;
	Fri, 10 May 2024 11:59:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] SubmittingPatches: extend the "flow" section
In-Reply-To: <CAOLa=ZS_5+x7_xxppD8BE7RA0X+BFHPm=ffWg4JDgORqR5=sqQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 10 May 2024 03:08:59 -0700")
References: <xmqqy18issfv.fsf@gitster.g>
	<20240509211318.641896-1-gitster@pobox.com>
	<20240509211318.641896-3-gitster@pobox.com>
	<CAOLa=ZS_5+x7_xxppD8BE7RA0X+BFHPm=ffWg4JDgORqR5=sqQ@mail.gmail.com>
Date: Fri, 10 May 2024 08:59:18 -0700
Message-ID: <xmqqh6f564kp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42CCDFDA-0EE6-11EF-8D04-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> +=== A not-so ideal patch flow
>> +
>> +To help us understand the reason behind various guidelines given later
>> +in the document, first lets understand how the lifecycle of a typical
>> +patch series for this project goes.
>> +
>> +. You come up with an itch.  You code it up.  You do not need any
>> +  pre-authorization from the project to do so.  Your patches will be
>
> Wouldn't it be better to have the following sentences after the next
> para?
>
> So the flow would be
> - Have an itch. Code it up.
> - Send patches to list.
> - Get reviews.

I am not sure what exactly you are suggesting.  "The next para"
meaning?  The sentence far below that begins with "In the following
sections, many techniques and ..."?

Also, "Get reviews" is not a single step that is an end of story, so
what you wrote is a bit misleading as a short summary.

The goal of this update is to reduce duplicates by describing a
typical life-cycle of a patch series from the inception of an idea
to the decision to include it in the next release here, so the
proposed "decision making" document can focus on issues at a level
larger than a topic of a patch series, and a contributor, especially
a new one who wants to give us their first patch series, can learn
by only reading these paragraphs how the world works around here
with their patch series from the beginning to the end.  So what
happens after "Get reviews." is a part of the same "flow".  Namely
these three paragraphs---the original submitter cannot just leave
with "now it is their problem" after they get reviews.  They are now
integral part of the discussion and we expect to see them see the
process through.

>> +. While the above iterations improve your patches, the maintainer may
>> +  pick the patches up from the list and queue them to the `seen`
>> +  branch, in order to make it easier for people to play with it
>> +  without having to pick up and apply the patches to their trees
>> +  themselves.  Being in `seen` has no other meaning.  Specifically, it
>> +  does not mean the patch was "accepted" in any way.
>> +
>> +. When the discussion reaches a consensus that the latest iteration of
>> +  the patches are in good enough shape, the maintainer includes the
>> +  topic in the "What's cooking" report that are sent out a few times a
>> +  week to the mailing list, marked as "Will merge to 'next'."  This
>> +  decision is primarily made by the maintainer with the help from
>> +  reviewers.
>> +
>> +. Once the patches hit 'next', the discussion can still continue to
>> +  further improve them by adding more patches on top, but by the time
>> +  a topic gets merged to 'next', it is expected that everybody agreed
>> +  that the scope and the basic direction of the topic are appropriate,
>> +  so such an incremental updates are expected to be limited to small
>> +  corrections and polishing.  After a topic cooks for some time (like
>> +  7 calendar days) in 'next' without further tweaks on top, it gets
>> +  merged to the 'master' branch and wait to become part of the next
>> +  major release.

>> +Earlier versions of this document outlined a slightly different patch
>> +flow in an idealized world, where the original submitter gathered
>> +agreements from the participants of the discussion and sent the final
>> +"we all agreed that this is the good version--please apply" patches
>> +to the maintainer.  In practice, this almost never happened.  The flow
>> +described above reflects the reality much better and can be considered
>> +the "canonical" procedure to get the patch accepted to the project.

I actually was expecting to hear more comments about this paragraph,
which makes a lame excuse for naming the section "A not-so ideal".
After sleeping on it, I think it belongs to the log message of this
change, not here.  Future wanna-be developers do not have to know
what process we wanted to have---they benefit from reading what the
process _is_ in practice in a more direct way.

>> +In the following sections, many techniques and conventions are listed
>> +to help your patches get reviewed effectively.

Thanks.
