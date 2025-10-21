Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD2341AC1
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062688; cv=pass; b=sFu2cKbgqg82J4jcxeA1PE0k+E5I0+Ll37W1NO2N0f1lVNOFg1XAT0ljlpmkV+laQuvcWk30A+JAeLdwijXV7LecDt2sS04PebhBZcISIx2Umkz5MWrxuShWojiS5ZefmeDyztqLm0zFZJ0znR0t5eam+ym+fVvSFkCgQts54tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062688; c=relaxed/simple;
	bh=XqO0ppAZS7E9i4C5ADGRIORBV6tfr0zwADG3t8vVubo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k8Mv+OzL8jFiKm19bApxMkah67UHKmgZM6UKv8cG4QTzKuyXp8WjxjyLLuSdbtG//0dHX70bDj1mi3UlrzLXH7p4TVQaQaYlIS0cA6TocuzVFd5MoI67L1PZAlsDok0DQn5/Eyml+NKal8d1ZjtQwaJ6s4yiPl9lsJM8q03+Ps4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HmLHq4d4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HmLHq4d4"
ARC-Seal: i=1; a=rsa-sha256; t=1761062676; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bn3jRZb+56oRtnp2dOTN5tlTopG4bTn0/YVq1rHjIyiawJVoLIu2zxkEVBVt2FxxtwLLZOyYOsOeTPie2+Ik43Ypky56IUmJT8BgIUj7FP/ahXZv/Iz/PIEQXo515FxnfJ3Drv4mzLi7TIqljoFmLmdEkCfYQ0A3Mcw1LtBqabI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761062676; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m27ojnAra+8YpP+wBrPcX6XIbzpufdbh2Ma1A2FH57E=; 
	b=lysoB/6adrGJjISIcq0p+XjHBREL5ctPvaqoUBH84GWkCA4SGD9TErMX4BU/NQe9tNq9y+19yXBhENjIcKjs43zMVvhjPSM8l5mDXYI3Kb2nDuMGes/939WHMpw0s4+wV6RoShpwCgSSdnJZP+vnW1ZyOrHdoQNwnwaDfUi46tM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761062675;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=m27ojnAra+8YpP+wBrPcX6XIbzpufdbh2Ma1A2FH57E=;
	b=HmLHq4d4BpIA11wamwe89buCk0M0O496csQ9kJN5diRCTOXiPNKomVmFSXe4vdeq
	krZBqddosIQMhgI0JOrTZ5hZgwFBOcgh9b9dSX0EpI9UAt+OWfgv9/tJyrf+mIgbiyR
	VEFzLryYv0IGtJJ9gjgeOBVUrHviJ7ij6FN68mWI=
Received: by mx.zohomail.com with SMTPS id 1761062670488535.9508854253696;
	Tue, 21 Oct 2025 09:04:30 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 04/10] transport: convert pre-push to hook API
In-Reply-To: <aPc5IE1Ie3i_Axqs@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-5-adrian.ratiu@collabora.com>
 <aPc5IE1Ie3i_Axqs@pks.im>
Date: Tue, 21 Oct 2025 19:04:24 +0300
Message-ID: <87sefcp7g7.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Oct 17, 2025 at 05:15:38PM +0300, Adrian Ratiu wrote: 
>> diff --git a/transport.c b/transport.c index 
>> c7f06a7382..67368754bf 100644 --- a/transport.c +++ 
>> b/transport.c @@ -1316,65 +1316,56 @@ static void 
>> die_with_unpushed_submodules(struct string_list *needs_pushing) 
>>  	die(_("Aborting.")); }  
>> -static int run_pre_push_hook(struct transport *transport, - 
>> struct ref *remote_refs) +static int 
>> pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void 
>> *pp_task_cb UNUSED) 
>>  { 
>> -	int ret = 0, x; -	struct ref *r; -	struct 
>> child_process proc = CHILD_PROCESS_INIT; -	struct strbuf buf; 
>> -	const char *hook_path = find_hook(the_repository, 
>> "pre-push"); +	struct hook_cb_data *hook_cb = pp_cb; + 
>> struct ref *r = hook_cb->options->feed_pipe_ctx; +	struct 
>> strbuf *buf = hook_cb->options->feed_pipe_cb_data; 
> 
> Same question here, isn't `feed_pipe_cb_data` accessible via 
> `pp_task_cb`? May very well be that I misunderstand the two 
> callback context and data, I found that part to be a bit hard to 
> follow. 

I hope I ansewered this in the other replies, so I won't repeat 
here. :)
 
>> +	int ret = 0; 
>>   
>> -	if (!hook_path) -		return 0; +	if (!r) + 
>> return 1; /* no more refs */ 
>>   
>> -	strvec_push(&proc.args, hook_path); - 
>> strvec_push(&proc.args, transport->remote->name); - 
>> strvec_push(&proc.args, transport->url); +	if (!buf) + 
>> BUG("pipe_task_cb must contain a valid strbuf"); 
>>   
>> -	proc.in = -1; -	proc.trace2_hook_name = "pre-push"; + 
>> hook_cb->options->feed_pipe_ctx = r->next; 
> 
> I think that the lines between the "task data" and "task 
> context" are being blurred here. I understood it so that the 
> task data is what is specific to the callback, and that data may 
> be changed to keep track of the state. Subsequent commits do it 
> that way, so shouldn't we also treat the context as immutable 
> here and instead handle iteration via the data? 

Excellent observation! I will do exactly that in v3. Thanks!
 
>> +	strbuf_reset(buf); 
> 
> Nit: it would make sense to move this reset down a bit close to 
> the first call that writes to it.

Yes, will do.
 
> 
>> -	if (start_command(&proc)) { - 
>> finish_command(&proc); -		return -1; -	} - - 
>> sigchain_push(SIGPIPE, SIG_IGN); +	if (!r->peer_ref) return 
>> 0; +	if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) return 
>> 0; +	if (r->status == REF_STATUS_REJECT_STALE) return 0; +	if 
>> (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) return 0; +	if 
>> (r->status == REF_STATUS_UPTODATE) return 0; 
> 
> Nit, feel free to ignore: this might read a tiny bit nicer with 
> a switch statement. 

Ack, will fix in v3.
