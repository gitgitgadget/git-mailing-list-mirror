Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083B2110E
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131224; cv=pass; b=ErwXOd4qS/cOHZIl0uPfUod91HGYpyhZ0/BFDyCddu89bcnIECKVntPYLm94+Gc8OL8j8p8r9d4eLlLmkAdx0glHQ7xA/4ULJlNXP1lg1p3N89lcxpJOARJzbXXMj14qVB8A1wVlx6pdJHtHKsUvLnHI0Ikhd1eaSm7NYK1xbOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131224; c=relaxed/simple;
	bh=3MyMghkH3YOvPdeA1VPC1YDlEjWXXx0vwd5MeUx8vFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BnM7f1Ci66YzTTEARRQVxNZOYPVebBwNSjj0J6GoJZT6evLHWGg2WZfzPoyzaP+qkDaqOaUhDshRacQJ9tuDnqU37hMoN9Jw1ge4NSN6T3eq5wGJR+8KQ2n0HvzVE78BgMiZ2d8RkQBENXwghgHNt6UxGdtaU4f6jxq9goTiGmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HX/cd6cI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HX/cd6cI"
ARC-Seal: i=1; a=rsa-sha256; t=1759131211; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DI2qq6UELU2G40xBkAelPh1fEZBfapdBMQQiVnoe+a94JLbLEVC0Jms1LaoCZMpJ9umZFkiSKGnwLCSVJ6Pzf98HMerACNdyhtW3wVKDTMBS1ulqD37FUNndjYbY+b1ICAhJoZD4UuoVYEetyUTbf8P8TgSSSrQw5LsyU+5jt+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759131211; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A9PV5fV9O9a/lxSb+VAbsDJMoR3ayzo8rD1+Uy22vyY=; 
	b=bH8sAke3iBQzeniHVs8xU1pg5LHSxW1oKmsOGL27VNkOYryJcywRAi5vibKQYd2kfnzenmkUom9DbuuVeBSnKaNrZqNZ7Oj2dlx3i1SM25EbwHYK+1aEHqYocSKXWyWNf209VU6FLEN3I0JKAIo45RR+P6aqKebf2UMgoXYHbs8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759131211;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=A9PV5fV9O9a/lxSb+VAbsDJMoR3ayzo8rD1+Uy22vyY=;
	b=HX/cd6cIJzHco86ebHUM3XDNWoUVGws9ho7AQNZqp5q3bcjAT1QYhChPzziEwzuD
	cLd7/4MOjwZontHWhiD5em1wKVCJCUjSAAjMe+WSw9dQkWoPZUwgQoaLKRy/FA7LnWM
	f4tJUPDFnAi2SzA+uyfF7Mss3/pVWO4lbE25EewQ=
Received: by mx.zohomail.com with SMTPS id 1759131208487612.5961903936956;
	Mon, 29 Sep 2025 00:33:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, Emily
 Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
In-Reply-To: <xmqqikh5ayoy.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
 <f408e46c-650a-4632-9628-cf817e393e7f@gmail.com>
 <xmqqikh5ayoy.fsf@gitster.g>
Date: Mon, 29 Sep 2025 10:33:23 +0300
Message-ID: <873485d870.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Fri, 26 Sep 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes: 
> 
>>> +	ret = write_in_full(hook_stdin_fd, to_pipe->buf, 
>>> to_pipe->len); 
>> 
>> This will block until the hook has read all of the 
>> input. Unless the hook drains and closes stdin before it does 
>> anything else it will block the parallel execution of other 
>> hooks. 
> 
> Ouch. 

I replied separately to this, because I do not think it is 
correct. :)

Please see my other reply and if there are further questions or 
concerns we can continue the discussion there, happy to address 
them.
 
>>> +	if (ret < 0) { +		if (errno == EPIPE) { + 
>>> return 1; /* child closed pipe, nothing more to feed */ + 
>>> } 
>> 
>> Style: we don't use braces for single statement bodies. 
>> 
>>> +		return ret; +	} + +	/* Reset the input buffer 
>>> to avoid sending it again */ +	strbuf_reset(to_pipe); 
>> 
>> Shouldn't the return value do that? 
> 
> Sorry, I do not understand this comment, but did you mean 
> to_pipe strbuf is left with some buffered bytes when we take the 
> early-return path when we got an error above?

I described in the other reply how this function works. I messed 
up by making it more complicated than necessary. I'll simplify it 
in v2.

Basically I assumed this write works recursively and the reset 
stops the loop, so the next call exits early to stops loop.

Since we write just 1 strbuf once, there is no need for 
recursiveness and we can just return based on the return value, as 
Phillip suggested.
 
> 
> This part of the new code makes me wonder what the lifetime 
> rules for the to_pipe message are? 
> 
> In the original code before this rewrite, it was clear that the 
> caller of this function was responsible to allocate the strbuf, 
> to feed it to the subprocess, and to release the resources it 
> held.  Now, what is the rule?  The caller still prepares the 
> strbuf, but the called machinery using the hook API will release 
> the resources? 

It's the same as before: the caller owns the strbuf and releases 
it (see the strbuf_release(&sb); in this patch's context, I did 
not modify that).

I'll document this in addition to simplifying the function logic in v2.
