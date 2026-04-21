Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1E379EE6
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794773; cv=none; b=MqE3T6B8zM+q6/AuxRn/kRgnFhgoPpAnaEk4dwZVp4OOOn+F9EDax/Xk071Ynu9N6xliwRg26w78xITRZpG3/EGkXyItyONsIRzlvRclaE5r8belxtKo0Z7zFI8KlsQk3yZ1dgCp3Zh+yJygmM+zWaHVz8iHmDFwfSzhdz3vm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794773; c=relaxed/simple;
	bh=SPjk5qyXc/zm6R5SsfJkSI1eQdvyhd0SqcRVa/Vud5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKSEMRfl5S9/zdc+EBys2DWrJSpfcN2CEHJ2XV3r9azybF3u6TXAXeqTgqpjamWmFFbqwT/LNKHV1fQgdRDuHoA8t0ZPJusJT8keJZ8UvPqcsoVcxt6pcpbj+9OchkI5OvjV/1awhhtMSWbpxbQp0uFyQECP8pnjvU+o6lwExGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj18fe4g; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj18fe4g"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ec9f099fc6so198016185a.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776794771; x=1777399571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9X1ArEACyIFcU2KQ2t1XX4hKwNb1VcWAwB6qYZyqJJk=;
        b=fj18fe4gxQXFTk1jiEapolKQWitQws3N7m3Q90Lj9ZpwEY+jKEHt54xd6eHgMvXps0
         c33GqoEW7t8cHDATvxiDYPNdMPtvmcRr/1vl2khBlgj7yAw84B0zFx5mxtCvge1ROQMX
         z2/NiQVCgIz6K85X0shn6JFerLsZ4sW1u/4Rrkq3mTfe5IKpGO7+xoydFRUKPgd3IyH5
         IuYUKD4hJWSeIx0kkRLOyE/aY5Sr04IHvdfb0rmBr0NP1uj9Tl7mqqOosxz4g3BIaqaT
         nO8IvFIL6tVvITJ6zAhpNR0soG8q0WZZoLhMNMZwDlgSoJziPEuXLcHVBa7iLB1mjofq
         b7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794771; x=1777399571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X1ArEACyIFcU2KQ2t1XX4hKwNb1VcWAwB6qYZyqJJk=;
        b=X9FwFu7zAGzwerd3RjoYo6QJAcbY9Nb1U6gvc5z61jpLW9LYQc0tKJw76L27ua12eS
         PYr7+pFKxmH9sRJ0w/tKS2ikFuTP/K+VN36BH7ZFOv8pSHQMjluLzjd54+9pU9dJAJ4e
         a1bUquY/B21Pho3l6jL2YGCs1xIj/5oIF2S4PR9o+sMNtna+3foSo/lobghE7p004Jsb
         wDI7riZdoGch0h5m48wSI9nKdjwTJR3H8ykI92pd4W5XbmtF0yGoz+Z3zG4Hm9ujBm/c
         9lF570sZsPgtEb+Grquk1OnB10+CigoPaE4XYi8qstt7XfaF9EWtyb7l3d7RDflcahfR
         2VZA==
X-Gm-Message-State: AOJu0YwZUQDyT8fiy42eed6vAhhkT6f3XecnJ7xrnwi6ZTJiL1BPVp0v
	j48sItw0Zg4wtImwb1g3Su0IvwvQ3NGRRwkseEtdd02w3NV4XiaMYJVH
X-Gm-Gg: AeBDieuk4b9hgJsBB9X1yM7n7VEbtYmqB1fIaxWswvYf5thmJ7KYWCXBuug3I8hTSqW
	EbXxc4VLZ/PTmu58DhLklOJqMBAdCiDohe4nqzyQS1OQIlqE44lu6frlJXnabF72KSThlx1iLzc
	9zMH8MNl4Zg2Lu7PNEzI+mGyUQg+VaxCqtA92m4sWt1+oXkIKfhby5+8rj4YViS12NanxIreozN
	PYkjmvbsLE0/hybVp5fW0aOXoFheXMfnhOo2SR1SCob8mkyP/hRgPlnr0BcnQg2cJMhKYNRJoDQ
	Kl4b80pNvKJ68DUiAtAcs3CZXN10FJGG/3uY5eeu2g4WdsKqpsy3bEmv450Fheka+oG7Hnvmxss
	cqFRi6LdRgnp6koF/LU+mjPTiNt4tJq+X1uNjRZpUeQzru/5CzaEfuDy1Q8txLHqg2UZijT8/d4
	PnaoBSBKAlvGcBV0rSpeJ4yN9zgYdlslix3aB4Ap3vV3H1EiZhyZEEQFKV1gPJG/Fc9uhg2KNTd
	R0SYvNVZDx9tE3sgBbK3xnWu8lcwxYd09pTKxsAOJ0b1y5qTLgU80x4yw6VlQ==
X-Received: by 2002:a05:620a:460e:b0:8cf:e152:592d with SMTP id af79cd13be357-8e78fd22f5bmr2712892685a.21.1776794770463;
        Tue, 21 Apr 2026 11:06:10 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:1188:ecec:8d54:b702? ([2605:a601:9b88:8300:1188:ecec:8d54:b702])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69abee3sm1107054785a.17.2026.04.21.11.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 11:06:09 -0700 (PDT)
Message-ID: <8f79a311-dbd8-4a86-8b46-1079ebd3c2ce@gmail.com>
Date: Tue, 21 Apr 2026 14:06:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] fetch: add --negotiation-require option for
 negotiation
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>
 <xmqqik9s57gc.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqik9s57gc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/26 3:50 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
...
>> +static struct string_list negotiation_require = STRING_LIST_INIT_NODUP;
> 
> I thought _tip was renamed to _restrict in an earlier step, but that
> was only in the transport in [3/7].  Perhaps we want to rename the
> file-scope static variable negotiation_tip to negotiation_restrict
> in an earlier step, like in [2/7]?

This one was missed but will be fixed in v3.

>> +	for_each_string_list_item(item, negotiation_require) {
>> +		if (!has_glob_specials(item->string)) {
>> +			struct object_id oid;
>> +			if (repo_get_oid(the_repository, item->string, &oid))
>> +				continue;
> 
> The configuration (or command line) says --nego-require=refs/heads/main
> but this old repository only has refs/heads/master; we do not want
> to error out in such a case.
> 
> Is it true, though?  nego-{require,restrict} feels quite tied to
> each project and unless the configuration or command line options
> are applied blindly regardless of the project, such an error should
> not happen.  Perhaps the user who gives a command line option
> "--nego-require=refs/heads/naster" may want to be reminded of a
> possible typo?

You're right here. We shouldn't die() on a bad ref passed this way.

This should be a best-effort attempt to include a "have" and continue
normally if it isn't found.

>> +			if (!odb_has_object(the_repository->objects, &oid, 0))
>> +				continue;
> 
> This is a bit curious.  When does the first condition holds but not
> the second?  A lazy clone whose ref-tip contains a missing commit
> promised by somebody else?

Good point. This would occur if a ref exists but points to a missing
object, which should mean the repo is corrupt and we can't trust that
the fetch will succeed (or should).

> In the presense of "promised objects are allowed to be missing"
> rule, silently skipping a missing object here is certainly
> conservative, but this is not an object that is buried deep in a
> tree hierarchy, but the top-level commit or tag that is directly
> pointed at by a ref, isn't it?  I am a bit uneasy that we ignore
> such potential repository corruption (i.e., a missing object may not
> be something a promisor remote promised but simply missing).

I'll update this to be an error.

>> @@ -474,7 +511,25 @@ static int find_common(struct fetch_negotiator *negotiator,
>>   	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
>>   	flushes = 0;
>>   	retval = -1;
>> +
>> +	/* Send unconditional haves from --negotiation-require */
>> +	resolve_negotiation_require(args->negotiation_require,
>> +				    &negotiation_require_oids);
>> +	if (oidset_size(&negotiation_require_oids)) {
>> +		struct oidset_iter iter;
>> +		oidset_iter_init(&negotiation_require_oids, &iter);
>> +
>> +		while ((oid = oidset_iter_next(&iter))) {
>> +			packet_buf_write(&req_buf, "have %s\n",
>> +					 oid_to_hex(oid));
>> +			print_verbose(args, "have %s", oid_to_hex(oid));
>> +		}
>> +	}
> 
> OK.  I think it makes sense to send these early.  We have already
> dealt with the usual "tips" by calling mark_tips() way earlier, but
> that hasn't produced any "have" yet, and these will go before the
> ones from traversal.  We do not traverse from these "require" and
> that may be why these are not called "_tips"?

It is correct that these required haves are not plugged into the
walk.

> And sending these early means the other side has much less chance to
> say "we've heard enough, stop!", so in a sense they are of much
> higher priority "have"s (I wonder what happens when they do want to
> say "stop!" while we are giving a lot of "have" from this loop,
> though).

I believe that we don't give the server an opportunity to say "stop"
until we've completed a "round" (see the 'if (flush_at <= ++count)'
case).

With this in mind, I should be incrementing 'count' while sending
the required haves.

>>   	while ((oid = negotiator->next(negotiator))) {
>> +		/* avoid duplicate oids from --negotiation-require */
>> +		if (oidset_contains(&negotiation_require_oids, oid))
>> +			continue;
> 
> If objects rechable from "require" are traversed like others, then
> this "avoid duplicate" would become unnecessary, right?

Yes, if we add the required things to the traversal, then we wouldn't
worry about duplicates. We'd also need to do things in a different
way:

1. The negotiator has a next() method that could do a number of
    things, but is responsible for walking history and ignoring IDs
    that are reachable from already-emitted haves.

2. This _could_ help us avoid sending required ID if we have
    emitted a have that could reach that ID.

3. However, this requires waiting until we flush a round of haves
    before determining if we should send the required IDs based on
    the walk to this point.

Perhaps the better way to incorporate things together would be to
mark the required IDs as COMMON as we emit them, which would signal
to the negotiation walks that they should not re-emit it as a have
(but since we don't add SEEN, they still walk through the commit to
its later ancestors).

Thanks,
-Stolee


