Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7343AB2
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118771; cv=none; b=Z9i5sl+9X35N7aRSDRVe4eLqNiZFNSf/mf3znAhx399bGGr9Yi8WO25yZAxHm/PytF0AcYGO9bP7heOMPlMt1pt5ZdosXs17Xu+BWx3piQR3zQb/vSZcJIv+iNPNzSsWoVUV+FkwAamjc7faax3TfeKFhIV3LCA/RdtIYp9N6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118771; c=relaxed/simple;
	bh=A+6/CDWqkiq12X4qvIQ3dIQPj/cUENEgMFKbpTqrDR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tuu92Ihqn1Op61JLMqUU73sDxCELUWiIshIEM6wuriauzkqhDm5OS7pXtlpccd7GRPvzI0IU10xrNhBCYpOVMIqzzDnUEovv6ysTPkzMgwIr6iTlBokYLSkmRVEZ+PeLwmIv/JzxGWFHcdnUjKj7MAwVhRZSddTXKs8DOoKjozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2XKVHHP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2XKVHHP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C4C91F3CB9;
	Fri, 22 Mar 2024 10:46:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=A+6/CDWqkiq12X4qvIQ3dIQPj/cUENEgMFKbpT
	qrDR0=; b=e2XKVHHPVI3IucBohBpJkMf4GE4cQ42BzsPL9MmIUAYGsvP7aNNsnV
	HcSbmhqgcDqiyYbENgv7MKCvMptn8xGxuWAAxeNUOYyzJg6hGbMn8xNPihf8lrt7
	Sg7AQNCzLjlohM4CKCqy5KiClJUcwu4muMm/LJFac3rNVh5PcOCA4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CDD91F3CB8;
	Fri, 22 Mar 2024 10:46:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66B951F3CB7;
	Fri, 22 Mar 2024 10:46:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>,  <phillip.wood123@gmail.com>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Fri, 22 Mar 2024 02:47:59 +0000")
References: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 22 Mar 2024 07:46:06 -0700
Message-ID: <xmqqfrwi495d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA85BE16-E85A-11EE-B1FA-25B3960A682E-77302942!pb-smtp2.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  [for what's cooking]
>>  * An experimental procedure for a topic author to propose the topic
>>    description to be used in "What's cooking" report and in the
>>    release notes have been added to the SubmittingPatches document.
>> 
>>  Documentation/SubmittingPatches | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
>> index e734a3f0f1..05e15b9436 100644
>> --- i/Documentation/SubmittingPatches
>> +++ w/Documentation/SubmittingPatches
>> @@ -459,6 +459,17 @@ an explanation of changes between each iteration can be kept in
>>  Git-notes and inserted automatically following the three-dash
>>  line via `git format-patch --notes`.
>>  
>> +[[a-paragraph-summary]]
>> +
>> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
>> +paragraph summary that appears in the "What's cooking" report when it
>> +is picked up to explain the topic.  If you choose to do so, please
>> +write 2-5 lines of a paragraph that will fit well in our release notes
>> +(see Documentation/RelNotes/* directory for examples), and put it in
>> +the cover letter, clearly marked as such.  For a single-patch series,
>> +use the space between the three-dash line and the diffstat, as
>> +described earlier.
>
> Would it be beneficial to request some specific heading, phrase, or
> other structured text such that this summary is obvious, or even easily
> extracted with some sort of script? Or is that perhaps overkill for now?

We do not even know if it is a good idea, so let's start with a
lightweight process that does not burden participants with too much
red tape.  For a series with a cover letter, the rule might end up
to be as simple as "When the first paragraph of the message looks
like an entry in the Release Notes, it is used as such".  The " a
paragraph that is 2-5 lines long, indented by three SPs, whose first
line has SP-asterisk-SP instead" may be a distinct enough style that
it may not require any further marking.
