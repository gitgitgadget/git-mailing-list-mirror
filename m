Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F461BD4E4
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392258; cv=none; b=ASYTVdoyWt8NiKiC7oPuEcl3nc/CtBDGDWIcFMG8Q39GgNpPVmyJHcwvw2Y15tqyeo7am8L/VQPSuRnZ19vaSD/f4HWCWl7CpeBmUwCHUPxH/ed8vxYXMlwlQuMPuxrKoPXF+t/l6EuR+s0GRlLVju2vZ6gcVc2UajoXb4Ktt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392258; c=relaxed/simple;
	bh=nYaz40sXFX4H14MrAIkerjN7jNNwBUj/k4Esj9pJYyg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qDEFjBl4vZ8j+2it20TcEfZrBjkoXZpZv0AA2/0wmVnI+Y/0mpNLxBvntGK8SsYECNYdUqxixDUmSBcWBfPPxDWCuZp11QFZo+9WPJijHjPgfo/sDLx5iabrws+q+/+neYKkYki7m9nHcNLrKrFUzm/fOyitvnZt90kqx5Cgwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZjljeXj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZjljeXj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so9522745e9.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730392254; x=1730997054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U+DiEem18+2/FBeorOkwRWUASFLAR+WOmovrLrDvOY=;
        b=FZjljeXjn5n0QWiuIcVBP5ukEPFXJ+/cYQghBOT/HQghR9Fo8Y9CR1CucE3yMDgxoO
         rmgkzX0YisBktzmkVWxzVBRYGf9OCypxUyyMn2T44Lj2eoLOAsn67Fc4zPTDVCWyKDss
         CZhYgppkKLo7a8bQuwqwsgtyMBP3KCjkJ+h2NFVQ7mti3qb+cQ++l9+71cCrD4HSUALV
         GWqteRPYj6m6IyLnSSfu7AawTGk7McvSs3uy9rlbVHCRVIX1/AvwynycEdrjcgAH39K3
         iz7rW9ewJ/MJulHLQZhlJBK/AjIiNXduQG8oTX5Ml2SsrZsOAuCqQ9VleqpCiO5qARls
         kURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392254; x=1730997054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U+DiEem18+2/FBeorOkwRWUASFLAR+WOmovrLrDvOY=;
        b=AVp0B3fLmG//Tw7QEZFRc4KegeX2bHhjVFhdS0Vbrujd6VmXLAJbVvv1wkNstwBYV6
         p1dznZ224addHhsQZGuBPutjOCZTaNNQMuMhDSifDUFqkHwTRvR2vU+/zWCd1UrDsPw5
         Wfk1ghPdTZvZpVIUM8VeQYMHIxnrqpQWzc72y6fMZ4FVfZOKuSyV6rxjnGU3zQA2tpOJ
         JJk10D61e4Okf67ZpICv86FrLYHDy7ulHYAdZ2LSGikSzWypQpjbLaQ3SkwCcyejKvpW
         784zPDSo5yahWkg9jbsntU8ILCpLCilJMud/MP3LZtKo5RGhOfqWU2QP0aiOSydGXUv7
         h5+Q==
X-Gm-Message-State: AOJu0YxBhHR+PoS3ZGbugdcdCjM1lykSwU6rnRgHPhFMJbvgTL3/KKx2
	fuf95EbnIRZGfG4RLp1mxIBgcYYjxXcPi+ODofzCUn+kyrmZJJrj
X-Google-Smtp-Source: AGHT+IGhYEHbbfS7oiH7hrWD8V6M+RI/HKSolyndoSY1rys5dSHcNqmDCf58IEaXnR5XwWlKACccdg==
X-Received: by 2002:a05:600c:450d:b0:431:5ba1:a529 with SMTP id 5b1f17b1804b1-4328324b343mr3727065e9.14.1730392254102;
        Thu, 31 Oct 2024 09:30:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d42adsm2598232f8f.40.2024.10.31.09.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 09:30:53 -0700 (PDT)
Message-ID: <e1928475-7e11-4e74-92da-fe6768ccabca@gmail.com>
Date: Thu, 31 Oct 2024 16:30:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Derrick Stolee <stolee@gmail.com>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
 <c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com>
 <9c29cb98-541b-4a18-9936-81477c7c13ab@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <9c29cb98-541b-4a18-9936-81477c7c13ab@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 31/10/2024 10:07, Kristoffer Haugsbakk wrote:
> On Thu, Oct 31, 2024, at 10:58, Phillip Wood wrote:
>> On 23/10/2024 19:44, Taylor Blau wrote:
>>> On Wed, Oct 23, 2024 at 07:27:58PM +0200, kristofferhaugsbakk@fastmail.com wrote:
>>>> @@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struct commit *commit,
>>>>    		/* If the branch is checked out, then leave a comment instead. */
>>>>    		if ((path = branch_checked_out(decoration->name))) {
>>>>    			item->command = TODO_COMMENT;
>>>> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
>>>> -				    decoration->name, path);
>>>> +			strbuf_commented_addf(ctx->buf, comment_line_str,
>>>> +					      "Ref %s checked out at '%s'\n",
>>>> +					      decoration->name, path);
>>>
>>> Makes sense, but the following command turns up a couple more results
>>> even after applying:
>>>
>>>       $ git grep -p 'strbuf_addf([^,]*, "#'
>>>       sequencer.c=static void update_squash_message_for_fixup(struct strbuf *msg)
>>>       sequencer.c:    strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
>>>       sequencer.c:    strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
>>
>> Good find - it's surprising that those have survived so long without
>> anyone complaining. There is also
>>
>> 	"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***",
>>
>> in do_pick_commit()
> 
> I’m including an update to “say why” in the next version.
> 
> Those others look correct to me: https://lore.kernel.org/git/c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com/T/#mf299f1ac7bdb772b396068200d32b5fac669fb55

Oh, sorry I'd missed that message.

Best Wishes

Phillip

> Cheers :)
> 
> Kristoffer

