Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AD80604
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145635; cv=pass; b=TT+HG3j/XUH24A3yRukXPGBuq3lAT8P5jgyGsYN6OfhVJrqEaIKMVyuBGbhK7HMBl4Ip99Ae2sGGmb62tKXqg63tK9AxjNyzTrz00gXJ3C2TB+U7FwOUXNaDUDFePUy1Elhr2yKWftbbW185Kjg5BSyIxOEaCe1B4xc7DI/arr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145635; c=relaxed/simple;
	bh=U2hdRZCtpKIqsouFLARsXUfrU7I1TbZW/+JTq89CBSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/s8ixnB3ryoxeb/4DSip/77UrUnK9IyGXydT7lyHzwxMl81KvuAm5h26Ml2zo3K7dE4Syh3XRebTdL91d+vQK1BkRpmBExmjpmhMggyqQJTFmCrzxwuI8ZKihwi2sq6TwJjkqQj6F0QToQ5Yw3QxCDJH8mm2iliZY21T94CE1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=F+dDoIby; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="F+dDoIby"
ARC-Seal: i=1; a=rsa-sha256; t=1759145616; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WYBeyhe0bMz7CjYYELtehB+tXAO9AlGNjGvT2zGKQYERXL/uQzUlcVGcJR8Acl6V6Gm6o2MNeL13mEAS2Gn/44j8hHAPIeMBENQ0TNzACAgH0Mbqvj+woIulZYnrS3wisK8VJGhWRU2+UdloUK0V6p6+JnNtT6er3//7AGWD9d0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759145616; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f/ErkmLBZCo4NYJtIScQ6CoD2KeByMl9Hd2Z3BEy/pA=; 
	b=RUsetDaZPtNAsGMx7VyDD5UEQ/vsd9dG+QV+urX60+IUg5aktvXV7BUYb3NPBsaXCDcSMew5bnw632nqm+rBecVRpepEvgu2UJuIj+qYt2sZIJXXCeYA4wIuz5gx1r0ngJ+HxuKQKw89R57WfVc4P/9nTNHFb//SSnACo/USCN0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759145616;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=f/ErkmLBZCo4NYJtIScQ6CoD2KeByMl9Hd2Z3BEy/pA=;
	b=F+dDoIby+xdUJdi5RgrePWivikgylU13L9YKQBujPiS6Z7nzq7iuN+imVAvY9B/w
	safxi6f7i/fQ0Kf/E9LDSMBCY7ztcgN5UrRN7pRMNfWTC7GeyR+Rf19Axn7uYrYuoNp
	L2phu5MbEUJfWYbugR+QnVMIPylP3rRpbXqIV0E4=
Received: by mx.zohomail.com with SMTPS id 175914561283645.79963114424061;
	Mon, 29 Sep 2025 04:33:32 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 04/10] transport: convert pre-push hook to hook.h
In-Reply-To: <1f942894-9393-4b5c-8d7f-2d0aaad594f1@gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-5-adrian.ratiu@collabora.com>
 <1f942894-9393-4b5c-8d7f-2d0aaad594f1@gmail.com>
Date: Mon, 29 Sep 2025 14:33:29 +0300
Message-ID: <87zfadbiie.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Fri, 26 Sep 2025, Phillip Wood <phillip.wood123@gmail.com> 
wrote:
> Hi Adrian
>
> On 25/09/2025 13:53, Adrian Ratiu wrote:
>>   
>> -static int run_pre_push_hook(struct transport *transport,
>> -			     struct ref *remote_refs)
>> +static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
>>   {
>> -	int ret = 0, x;
>> -	struct ref *r;
>> -	struct child_process proc = CHILD_PROCESS_INIT;
>> -	struct strbuf buf;
>> -	const char *hook_path = find_hook(the_repository, "pre-push");
>> -
>> -	if (!hook_path)
>> -		return 0;
>> +	struct hook_cb_data *hook_cb = pp_cb;
>> +	struct ref *r = hook_cb->options->feed_pipe_ctx;
>>   
>> -	strvec_push(&proc.args, hook_path);
>> -	strvec_push(&proc.args, transport->remote->name);
>> -	strvec_push(&proc.args, transport->url);
>> +	if (r) {
>> +		struct strbuf buf = STRBUF_INIT;
>
> If we passed the strbuf in as part of the context and called 
> strbuf_reset() before using it each time we'd avoid allocating a new 
> buffer for each ref just as the current code does.

That is a good idea. Will do it in v2. Thanks!
