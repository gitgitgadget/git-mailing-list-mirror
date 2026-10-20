Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508098;
	b=5SBnA+HpFOh8JVEByaisSE0Xyh9ODWIKB36W6KynuO2oV817N8vUJ7TZrQFvmAnvx3q5
	 4FqQ6KHTUk6PTRXpYKz2LMszCSs6MydbBF+VKTnC1BDlr3rY04Fbr5PO28olBs/E0qoTh
	 qVqLKi76lv4Fm0xoLbdNZCL0+CYDpTCjyszCTHCZqo7WHgA6AUt2QtDKWWm8zZ7iPDwi0
	 8SXJ+aBxrc/jt+4iVvza2vY0lrSZVBKKxKBO3AUIVVQc197x+6psqE7Pa2UuilArR53/o
	 GS8+5UxabQka3PvrFQNwGGwQHuHNMNaQWIvSBbx6cJCEPzgpD3Iqtjg7/gM8aIpPYzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RCM/wPdCbo+sXWVHcrEeXXmI7AwLREwrgN0YMDEudaw=;
	b=LIPIZ4NzJjjxBDIF3QooeBuuDJ8TgZ2OgJWlfDqWb6y9YiUvi2Jeqfs0m4mAuQ4eOpAC
	 QDkOPvCkm2TBb6SeTS02Yg0duhrfQGlqYKwyePXqRQb5YAj8sPUHj7le9dICMAUKm0cTd
	 D/cR3H9BpaTQRmA8eqU894H45Y7JzyrQPg6zIymMAZ+tJKbVX5cguCF8K9POzf3eSJNxG
	 Tr6lAudh6WWN3A/yC+Fom4RYGOS424Vzcn7lHj0jEbFWG2ai+/YSHkLNq8VN3e518mUwk
	 uLeAZNMW5ImX6YDVtDbRSyjNXK39r/s65wpsJ/aRTR1aWv7YZdSWV0KQjzJwIr8/AKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L4UdtjJ2;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D92606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D92606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L4UdtjJ2
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso4796311a12.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508096; x=1793112896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RCM/wPdCbo+sXWVHcrEeXXmI7AwLREwrgN0YMDEudaw=;
        b=L4UdtjJ2K8hYvrvB3bl8/LbzinDulnI5KzcjFpW5rRXgpYbEKwnxHnFZJG9rxLIBwW
         472tcikPeskdxDABqDUy0S0M/swERuiBHT5Mj0ohSaxpLvHRJXSdNdU619f/sg4+/YoX
         K99+DZYo09Dm+6bqC51NJufRSqM5RQ30mUYm6LnaNgAtSM0ESlHUH4e4cBmggz6TjV5L
         FwF+oZA6W92lUNf4KuPrmaQdWYEE5WzbrzZSrSg4929DB40TzauiAa63jeubzlE2Ec5K
         dX0IG1D5Ni+uLvtZ+jA+wfFP34SU26GkLjitsjey690NmZLths8OHTXuQCBBXykKFNNp
         0osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508096; x=1793112896;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCM/wPdCbo+sXWVHcrEeXXmI7AwLREwrgN0YMDEudaw=;
        b=xvSaMI3KkiuFoOnxA6Vo5BK/748qs+/FLCwh9yMAzh2Y1uDJj0Y/o34d8hu1UlUSoj
         TJ2SmmdzQmBDStC1Tf2mzuFk+OT5yh75jtvroTBoFxSFbIM7GCOeVsOGvMzeSLWWXjkI
         jCq1tIFv3yD8hdUaAQkvWs3ErMoVmTQvvEiV2e4IhWRwGnWJ2Uejwm6LpLUXIx3QnM/s
         7XQQirfhsFvzlEkxmjiIAW4joP1gIIdisQRdO3MXo0LvWwvKO71AW6NZpkcmrwDtbPg5
         Vx+HXQqkT+eFD2qNZShBz63qUw8/RHGL+TIOBzN9TsdwfaERZ8hjnRrLsl+H1XwlBWGc
         7JcA==
X-Gm-Message-State: AFq9FYKo9QduHwx1F6jzcB87iSVkvL76y3/LKqSpqKx8VfgMVKNGJYHv
	/KRZrin7u9JdgFJx0z1ltKFfK90NrhYSb72Q2rnSwrXCovi65Ce7l4JQPULOIw==
X-Gm-Gg: AYBFou2jKXs0EyMG5m/TCTOYYYXT97bafenfuE1UpJumhOIj5PIa0uWG96STazt3sUk
	Ef5iKa9fsx48FZCw+slGC++XpPnYU0NOEAWV5EQJ211f31H03OmUq8Zt2R2v0oAuIUEsDI/XW6L
	ZKpMr2sjxx8LK215GzZoS0WMq1K6KPcwAabOJYHvnCfc1E/YK5O9dOMw02Xa14f8vdQf60TpWL1
	kZSFgIqNVEif+qpB2D2BfZfIyWgtcZvJFQD2Pe6IeP8eARvqlyH6mDFYENN7k/2nvIWE6MT4QCc
	oEEz1USoiiucf9/bTdgK9DazwCMN6CzqX1pMaFhpkOmRV9lZoI0yBgld4Qu7k7Go47Rcxf7LVnM
	O/7K6PMToK6n4nddImzm+q7Sv/Gr38ltnncDQlo8dfJAZSKZUA10Kxi9GvFmBW8+XzcEzp8FMKn
	WpoWq+wiMwTju1DeAxlqoOeJ80bkSS8o9nOlufvArN/+fVjdYG8SrOudsfEMygNVLPAlfgoFpmm
	dYdUQlRQ7FmT/8/FbwPlY9lE1jDIqxFNMjjdux0UtspKHTQ3B42
X-Received: by 2002:a17:906:c142:b0:c2a:34fe:ea4d with SMTP id a640c23a62f3a-c419e639b87mr884160466b.25.1792508096097;
        Tue, 20 Oct 2026 07:54:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eae235sm501110566b.67.2026.10.20.07.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:54:55 -0700 (PDT)
Message-ID: <4124485d-b613-4b11-9fde-158a271b7a8b@gmail.com>
Date: Tue, 20 Oct 2026 15:54:54 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/7] stash create: rework temporary index creation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
 <cover.1791992404.git.phillip.wood@dunelm.org.uk>
 <f799d86f52796cc1b83788460568cc0d9849bed9.1791992404.git.phillip.wood@dunelm.org.uk>
 <xmqqtsmorvux.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtsmorvux.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2026 19:16, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> It is unclear what problem we are trying to solve.  Obviously we can
> enhance create_index_from_tree() and replace reset_tree() just fine,
> but the proposed log message should make it clear why we are doing so.
> 
> Please follow the usual pattern to state "observation" (e.g., "we
> use reset_tree() when we do X"), "problem" (e.g., "use of
> reset_tree() is undesirable because ..."), and "solution" (e.g, "we
> can improve by replacing reset_tree() with create_index_from_tree()
> because the latter has these desirable characteristics") in this
> order, perhaps in separate paragraphs for extra readability.

I'll reword following that pattern. The gist is that the code is easier 
to reason about if we use create_index_from_tree() because we avoid 
depending on global variables for the index path and we don't overwrite 
the in-memory index.

Thanks

Phillip

> 
> 
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/stash.c | 15 ++++-----------
>>   1 file changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> index b4fe7465e4..ddeb5a5d2a 100644
>> --- a/builtin/stash.c
>> +++ b/builtin/stash.c
>> @@ -374,7 +374,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>>   }
>>   
>>   static int create_index_from_tree(const struct object_id *tree_id,
>> -				  const char *index_path)
>> +				  const char *index_path, bool reset)
>>   {
>>   	int nr_trees = 1;
>>   	int ret = 0;
>> @@ -403,7 +403,7 @@ static int create_index_from_tree(const struct object_id *tree_id,
>>   	opts.src_index = the_repository->index;
>>   	opts.dst_index = &dst_istate;
>>   	opts.merge = 1;
>> -	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
>> +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
>>   	opts.fn = oneway_merge;
>>   
>>   	if (unpack_trees(nr_trees, t, &opts)) {
>> @@ -1399,7 +1399,7 @@ static enum create_result stash_patch(struct stash_info *info,
>>   		goto done;
>>   	}
>>   
>> -	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
>> +	if (create_index_from_tree(head_tree, stash_index_path.buf, true)) {
>>   		ret = CREATE_ERROR;
>>   		goto done;
>>   	}
>> @@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>>   	repo_init_revisions(the_repository, &rev, NULL);
>>   	copy_pathspec(&rev.prune_data, ps);
>>   
>> -	set_alternate_index_output(stash_index_path.buf);
>> -	if (reset_tree(&info->i_tree, 0, 0)) {
>> +	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
>>   		ret = -1;
>>   		goto done;
>>   	}
>> -	set_alternate_index_output(NULL);
>>   
>>   	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>>   	rev.diffopt.format_callback = add_diff_to_buf;
>>   	rev.diffopt.format_callback_data = &diff_output;
>>   
>> -	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
>> -		ret = -1;
>> -		goto done;
>> -	}
>> -
>>   	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
>>   			   "");
>>   	run_diff_index(&rev, 0);

