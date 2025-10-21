Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881E3321B1
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057904; cv=pass; b=Cvo0/OQ2DUGL5544KGozzB1+FPUFf90MROB6GIhmIpST8NwIFsWLq2Q+C9SSuiZq5NBrvwTw6QfNeue3AaBVe7WMvvrYaTJVcIeTP1y4hQPHv251sQQ0wBdtRbYJ6GUc9S4UmWc2SlIBPPRFf2M7SMiAxwzhM/pUD8Hxic+0KOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057904; c=relaxed/simple;
	bh=sqLsj/PI0dT9x1B3IDwUOpAaYvxWZCuB3RPvxzTLpDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WbqzdVS+DAKejH4l+lqm20UyGqMDf0q6hgVU+y7ye5SicLwMf1V1rWWQjmTcj/G40a+uS6p4nfFOdTFi05LAbBAoMsHUMf0sXpvorrQLQ6zdOn/j+Edorr4mNK9dpN5ooGShtgmctVmur6pZgwpGzWcdkqnlFdtVXmhh3hl/V9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NSkZh/0r; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NSkZh/0r"
ARC-Seal: i=1; a=rsa-sha256; t=1761057893; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=llIj8oaSJjtUizgZHln9DIGmCsiFPw9pDodw5f5lpNdR/sw6vLwzYG4k6QWnKey9zEW83AMdNC2U6PuHmPA0CIaIRXcGzg8GN82Njk/9BSwDhYrAtBH4khlN3uLCNcSHBJeQioKf3ao/E+ZOaqlUT/l7Cp42GhBfk4IUnRuY/g0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761057893; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=596klnApeMBKEQ//+0AdnqloNtX0Mofbjc0m4p/5fR0=; 
	b=MWT5+Xsb1IW/OJvFhornaqaX86sNYFkDF/bttOtoyRiKSE2JCMON/r4nYNYXoQnNaW/0U32Wp0q29naqgTZGkHscDU2K5ZdDUszb/VEPsl9+IMMV2Wtwd5lmnyGDr0PMMp/E7vXTyk52h9OavGSzUm8U7xDDVmE5TUtqIiOGMDA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761057893;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=596klnApeMBKEQ//+0AdnqloNtX0Mofbjc0m4p/5fR0=;
	b=NSkZh/0rZe17LL4QADt/XmX/uflh+RMFPiqroZeKmii2Zr9wNJd1qJoyWUgjJqJe
	gR5YtvAg7ticrBNQub17ftq3TV0g5vx2eTdtuJCbiWrbMOnluQhx5oUCZ7mKjN68KmO
	+mK+AKFFkYiOtYg2C5rdpDZxdfXEK3RD1bSZo/sI=
Received: by mx.zohomail.com with SMTPS id 1761057890889323.268136287139;
	Tue, 21 Oct 2025 07:44:50 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 02/10] hook: provide stdin via callback
In-Reply-To: <aPc5GhzFSdrMvOZK@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-3-adrian.ratiu@collabora.com>
 <aPc5GhzFSdrMvOZK@pks.im>
Date: Tue, 21 Oct 2025 17:44:44 +0300
Message-ID: <87y0p4pb4z.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Oct 17, 2025 at 05:15:36PM +0300, Adrian Ratiu wrote: 
>> diff --git a/hook.h b/hook.h index 11863fa734..ebe5dc450e 
>> 100644 --- a/hook.h +++ b/hook.h @@ -37,6 +38,28 @@ struct 
>> run_hooks_opt 
>>  	 * Path to file which should be piped to stdin for each 
>>  hook.  */ const char *path_to_stdin; 
>> + +	/** +	 * Callback to ask for more content to pipe to 
>> each hook stdin.  +	 * +	 * If a hook needs to consume 
>> large quantities of data (e.g. a +	 * list of all refs 
>> received in a client push), feeding data via +	 * 
>> in-memory strings or slurping to/from files via path_to_stdin + 
>> * is inefficient, so this callback allows for piecemeal writes. 
>> +	 * +	 * Add initalization context to 
>> hook.feed_pipe_ctx.  +	 * +	 * The caller owns 
>> hook.feed_pipe_ctx and has to release any +	 * resources after 
>> hooks finish execution.  +	 */ +	feed_pipe_fn feed_pipe; + 
>> void *feed_pipe_ctx; + +	/** +	 * Use this to keep 
>> internal state for your feed_pipe_fn callback.  +	 * Only 
>> useful when using run_hooks_opt.feed_pipe, otherwise ignore it. 
>> +	 */ +	void *feed_pipe_cb_data; 
> 
> Are these fields used as any of the callback arguments? If so, 
> let's document which of the fields they correspond to, as it's 
> otherwise hard to follow. 
 
I understand your point and will document this better.

They are not the callback args, they are passed as part of the 
struct run_hooks_opt accessible via the void *pp_cb arg like this: 

struct hook_cb_data *hook_cb = pp_cb;
struct receive_hook_feed_state *feed_state = 
hook_cb->options->feed_pipe_cb_data;
