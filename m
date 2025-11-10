Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD97270ED2
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792065; cv=none; b=Ax7pKiTEGwzxI7KulrgBi9k6E/rOjN0D7BmXS2xuXtAbXQb7GcKWYWCX4PxBU2N4eDNb+ofX3mD/T2iehlOaD4OUCTEZt3b7FGil90He/pew9f1z6BN2McDL4A4jMCYfpzFxVq5YzVYnKhVQek7z/meBGqyeRVBQ6MNB2U9/NHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792065; c=relaxed/simple;
	bh=xzNl7dkhrTpiq2pmf85ok4sAOIoItGNOpJxE8nD1frg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPVOngj77h++rstGazxTnYmDd9G83XYgsXdrbq+whMD7Dl7jHhDfUziqAkfKMdTUBNis2GCOCMUMpUEn8v0I3Vf4TWfkRtoxdSsqIJtTT7IBuCjR8Jz+bToY5zPKMWMXBrzod4s0H/T/Yo4IEVPvPYjcDETNB/eycDb6QYGRV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSfPDmmg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSfPDmmg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4777a9aeedaso13337535e9.3
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792061; x=1763396861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mVD9bEdZm3BDq5EqY2q3CgRYdLvs4AcPdfCWxHidhok=;
        b=KSfPDmmg27b9L5SwAaQPpzSQPrsAtHYxUB2AfHNwxE9xSx3ZW77IgT0cPEjIvOS/xX
         KsRi1cTaCeDLPJVo3W6m0eSHh2Q/6Kv8Z4kFwA/Y2sOx60Fi8iip9wTp+BmwhB3Afzlq
         6vbeECrdyOr/6fVgQ2WYwEM/J6h4ngDnvEymH9hPPm8uxBFO55+VltRxvbeifMg5IZp2
         Zd3/xFhZrnB3B17Ir1VEuN+MFmGsHAGLk6kdXaiDJW0Nk4Q60kHOjJhjW7nxnYYMS91U
         ToP2QL454iw0vH9JR6SN96jhe7iQ0E0DYKQI2CErmf4/7dXcq2rW0Y51Lke6inpMhiph
         XBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792061; x=1763396861;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVD9bEdZm3BDq5EqY2q3CgRYdLvs4AcPdfCWxHidhok=;
        b=tLqFWAq4JTVvPzwJhkEDGVG49lFmu1+FHXnZwi3Ql6WyKGBGBEb0AN6aFnlT1Uq8OL
         KXsm0bCNWczje3Tr4t1yz4Qzgo1Rn1piBQa8eUBakO9geR3SB/xr3ndkZzDe0hY3d6O2
         He48RtSsr9tAlk6zAzj4kjfNHCGyQe+Q1GNr6IQuKLERIsy8WFyWH9VR0c4CKtiEfjlX
         76qqQJY/CiYZFzss2zeLKl5Jca6Dz+ljcOKWdE2ym/mqc2Boe4NB2peWKP4YaTrmt6wD
         9Q5wEoQkOvU4Oz0vcAS1ibbYrZpMIN3pdVOE7aNqXhstYLYlHIwVHOVfpt8O8ZahROtV
         ZrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFv1rjjsJA7J0xP2ux+QAmpRcsTLkQxyUonhltylGSWt0QSZ4pEH4YjI8HRgHo9MuAyis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDje+EaZD+UnrRqYDpO8V9bJQ4GPUBIG/4ntz2cwCHu38YkXNi
	JkOpJgaN7ILs0kNbtBUoQqObSopM4MP+p1B7cM3pgAfEkhUSjEcWi6MC
X-Gm-Gg: ASbGncuPkEb7yuzxEjsNq8v8Oi1lyxaNbh/fg7rnoyKMmybcO0NZ6hIY64z0KQvF8E/
	3gguSBjatK8A83dkydzBCMInmm/7XzM9yDf4072hdDLIJoRJQODs11AvMH/PFN6gvqKtJ8YcQx4
	G2ClmybV1Rjpn+xjMoEESCt3ZyZixKyFd3lc18O7xooen69yF2UpA6r7RQIV1YtcESKremURPyp
	NxwtWfXQyak1GpC1haCffAquDcTqJdPCHIQoHiDzwqGbMH4IRKc8k29jpUzlO70YdwmQkrTPCeH
	Imw2/qqJzksSgBgUorO45U0tQ7/ZmwaX/Yvi/4i84neeaXMf6aLO/eHmRbrQnczrYWg7Jbxp08n
	ryaBdFm58EnEgMydsxI5DvuIZaCmKubQNzebHzGC0eIck2pfUKfF+gjFmw3+XxAW+A6xQpttVQj
	dokM1kNdHU00Tljoicbmj7SKyeY4D3mNalugrf1/qP4XFnmmTCvqV+14OdEi0vQzI=
X-Google-Smtp-Source: AGHT+IHRmuyGMc/E5cY8Y1Z88iR3ceFO8upFp4e+leKd8k2S39kJDG+5hNUgwenWNqx29O81ufp1pQ==
X-Received: by 2002:a05:600c:1c03:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-477732285e5mr71270945e9.1.1762792060707;
        Mon, 10 Nov 2025 08:27:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm117324675e9.2.2025.11.10.08.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:27:40 -0800 (PST)
Message-ID: <f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com>
Date: Mon, 10 Nov 2025 16:27:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 1/4] interpret-trailers: factor out buffer-based
 processing to process_trailers()
To: Junio C Hamano <gitster@pobox.com>, Li Chen <me@linux.beauty>
Cc: phillipwood <phillip.wood@dunelm.org.uk>, git <git@vger.kernel.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-2-me@linux.beauty> <xmqq1pmcmn7s.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq1pmcmn7s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2025 16:57, Junio C Hamano wrote:
> Li Chen <me@linux.beauty> writes:
> 
>> From: Li Chen <chenl311@chinatelecom.cn>
>>
>> Extracted trailer processing into a helper that accumulates output in
>> a strbuf before writing.
>>
>> Updated interpret_trailers() to reuse the helper, buffer output, and
>> clean up both input and output buffers after writing.
> 
> Imperative?
> 
>>
>> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
>> ---
>>   builtin/interpret-trailers.c | 51 ++++++++++++++++++++----------------
>>   1 file changed, 29 insertions(+), 22 deletions(-)
>>
>> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
>> index 41b0750e5a..4c90580fff 100644
>> --- a/builtin/interpret-trailers.c
>> +++ b/builtin/interpret-trailers.c
>> @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
>>   	strbuf_complete_line(sb);
>>   }
>>   
>> -static void interpret_trailers(const struct process_trailer_options *opts,
>> -			       struct list_head *new_trailer_head,
>> -			       const char *file)
>> +static void process_trailers(const struct process_trailer_options *opts,
>> +			     struct list_head *new_trailer_head,
>> +			     struct strbuf *sb, struct strbuf *out)
> 
> So we gained *out strbuf; in the preimage below I see fwrite(),
> fprintf(), etc. to outfile that is either stdout or tempfile, but
> presumably the output all will be captured in the strbuf instead,
> which makes sense.  It is a bit curious what the new paramater sb
> is, but this is a file-scope static helper, so it does not strictly
> require documenting.  Having a comment would still be nicer, though,
> unlike "struct process_trailer_options" that is very limited
> purpose, "strbuf" can be used for any string processing, so a good
> variable name like "out" that conveys what it is used for by
> implication is good, but "sb", which is obvious abbreviation for
> "Str Buf", conveys no useful information.

This patch is based on my suggestion[1]. I had intended to rename "sb" 
to "in" but forgot to do so before posting that diff. Here's my signoff 
which Li should add before their own

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks

Phillip

[1] 
https://lore.kernel.org/git/7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com
>>   {
>>   	LIST_HEAD(head);
>> -	struct strbuf sb = STRBUF_INIT;
>> -	struct strbuf trailer_block_sb = STRBUF_INIT;
> 
> We no longer need a separate strbuf only for trailer block; we will
> see why before we read through this helper function, hopefully.
> 
>>   	struct trailer_block *trailer_block;
>> -	FILE *outfile = stdout;
>> -
>> -	trailer_config_init();
>>   
>> -	read_input_file(&sb, file);
>> -
>> -	if (opts->in_place)
>> -		outfile = create_in_place_tempfile(file);
> 
> OK, so the original code read the input (either "file", or standard
> input) into a tempfile and prepared the output file stream.
> Presumably it is now the responsibility of the caller of this new
> function.  Initializing the trailer configuration is also what the
> caller of this function is reponsible for, as well.
> 
> So this answers one of the questions I had upon starting to read
> this function, i.e. "what is sb?"  It holds the input string, which
> is what?  Something that look like a commit message that has title,
> body and then a trailer block?  We may want to give the parameter a
> better name?  I dunno (as this is file-scope static, as long as it
> is obvious to the local caller, it may be OK, but on the other hand,
> the caller needs to differenciate two strbuf parameters to the
> helper function, one used for input and the other output, so if you
> are calling the latter "out", perhaps you would want to call it
> "in", or "input", perhaps?)
> 
>> -	trailer_block = parse_trailers(opts, sb.buf, &head);
>> +	trailer_block = parse_trailers(opts, sb->buf, &head);
> 
> So we parse existing trailers from the input strbuf that is supplied
> by the caller.  The rest of this hunk is rewriting FILE* I/O with
> strbuf addition.
> 
>> @@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>>   	}
>>   
>>   	/* Print trailer block. */
>> -	format_trailers(opts, &head, &trailer_block_sb);
>> +	format_trailers(opts, &head, out);
>>   	free_trailers(&head);
>> -	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
>> -	strbuf_release(&trailer_block_sb);
> 
> The format_trailers() helper function appends appends to the strbuf
> that is given to it, so instead of using an extra strbuf (and then
> appending that to the output), we just pass our output strbuf to it,
> which is why we no longer need the trailer_block_sb strbuf anymore.
> Makes sense.
> 
>>   	/* Print the lines after the trailer block as is. */
>>   	if (!opts->only_trailers)
>> -		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
>> -		       sb.len - trailer_block_end(trailer_block), outfile);
>> +		strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
>> +			   sb->len - trailer_block_end(trailer_block));
>>   	trailer_block_release(trailer_block);
>> +}
> 
> And again, FILE* I/O is replaced with appending to the output strbuf
> in the rest of this helper function.  Good.
> 
>> +static void interpret_trailers(const struct process_trailer_options *opts,
>> +			       struct list_head *new_trailer_head,
>> +			       const char *file)
> 
> So the original caller of interpret_trailers() now call this outer
> shell, which has the same name and the same function signature as
> the original.  Our new process_trailers() helper assumes a handful
> of preparatory steps are already done by the caller, so what we are
> going read here will be mostly those preparation, a call to our new
> helper, and then printing the result to "file" or standard output.
> 
>> +{
>> +	struct strbuf sb = STRBUF_INIT;
>> +	struct strbuf out = STRBUF_INIT;
>> +	FILE *outfile = stdout;
>> +
>> +	trailer_config_init();
>> +
>> +	read_input_file(&sb, file);
>> +	if (opts->in_place)
>> +		outfile = create_in_place_tempfile(file);
> 
> And these are exactly the lines we lost from the new helper.
> Looking good.
> 
>> +	process_trailers(opts, new_trailer_head, &sb, &out);
> 
> And our call.  "out" should have what we wanted to output to
> outfile, so ...
> 
>> +	fwrite(out.buf, out.len, 1, outfile);
> 
> ... we write it out.  Good.  For a single long string that can never
> have NUL in it, I'd personally find it more natural to call fputs(),
> though.  Use of fwrite() makes readers unnecessarily wonder if there
> is something unusual (like needing to be able to handle NULs in the
> buffer).
> 
>>   	if (opts->in_place)
>>   		if (rename_tempfile(&trailers_tempfile, file))
>>   			die_errno(_("could not rename temporary file to %s"), file);
>>
>>   	strbuf_release(&sb);
>> +	strbuf_release(&out);
> 
> OK.  We could release out a bit earlier, immediately after fwrite().
> 
> Looking mostly good.
> 
>>   }
>>   
>>   int cmd_interpret_trailers(int argc,
> 

