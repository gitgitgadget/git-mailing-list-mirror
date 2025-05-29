Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ECB223709
	for <git@vger.kernel.org>; Thu, 29 May 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525992; cv=none; b=bZxi2+72X4N4TCl/Ib6hMlzmGn7WMw2V/FgsRG9WVn1OzhVkZAKVWyTM46VOZ19BUvAvyJGtvV6sCRH8Qjv36galjvRKO4C/kWjLQ1R9fJS8QkcV6QABH+gPboXH17pKHld2BenHuqk7bJTKAwljS/tbbXsaqyC7XAXgr3oVFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525992; c=relaxed/simple;
	bh=qjjJep1OqYQH0orlmTWYrVAz+xgz+2jKkAgoSYNUPF4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDAljVQ9Rm5Zzx6jd8TBB3kjL+XAk79PBWhflq+bwGSfCAziP6NXjTcgU9QbJsP3zIiXzw1GIXUahd+hvJWrrUSpvx2icj2LPlJWrfdUMynkiT7IrOAqf1ikUfmZSBCnUoIdiEZOZTBl12/Vs2dWU8m7h4QidcCetqPyIL5hNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lul8nXoW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lul8nXoW"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a3798794d3so794741f8f.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748525988; x=1749130788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PR/Es5P3rxSlwqI+bg7peNcr1UTslIUAyj4F/fkRvug=;
        b=Lul8nXoWoCOzTEfVyXyIAKJNjFufT6Q6vv7dmckrsRWrk0pL9acN5r4uDqjK9ghius
         P8NyW5pAru2gcSEY8p/KpxyZP0eIaBHs9O8CDZCE/lsDUJHGWWHYQ6I5mo+69gbJm+yY
         jlSdj6hhEX2/0xwpHM2T697wTqLwkTOFrOEnIgnDUtGl46kw511Yo9TkMkD1YtrZCxs4
         LrOlGLWFCD3LZD/alcbha++Ja7dwEUhO38PQbDRMoMgps4CO0wugbRVzwt+zmbaMg100
         teUZHLXUclkzRnIcVa1raXZVUq4draGN2l3J3C2Jfsr+ZKn6eeFfhXmmEUXOXAb5NyLS
         mpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748525988; x=1749130788;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR/Es5P3rxSlwqI+bg7peNcr1UTslIUAyj4F/fkRvug=;
        b=UgZSZMsqUXjFcji0m30k6SWderHjgtkm9nsJMOfschYsor0KoTW+DBlTWYdulT/eyg
         F2mh0UXTPzCtuH+8dSGVjN0F6j389OWwLvz5imT+3bCCZlkghy0rQc3Fkb5v7G3eF2BW
         jQFDuF5fsm0/FfAQ1T3Px1CO16ydE8BzjoLECwjYOE1TxdvbKaEGSruNkygVALGC6SBo
         DVrvUfJXEHvv4DGXflyDXtjbXioF344v/PdP7yOapAxaber/o86LaVbRkRJrpnhACeed
         /r0SNkC6YNiMFyEz6g7LGHXIiHvjxhpzsh3oXW0lv02yudzEuF/fwZJPNRXQYFZH9WZb
         vqTg==
X-Gm-Message-State: AOJu0Ywj/Ph9HNjGUaQi2EfhgK2w79R1kd1hLvfJbBKI3HX8PPjLUW70
	SYAvfBW7IZC5/IO/CV2g27oyrDlgFKm2NmkM5lkIvQwVIJitPKqYH/a0
X-Gm-Gg: ASbGncurciMHMlR1AmsoLxxw0hJV0mVxR4CE8ugu0mraj+W+iKF3EHkVrfAMXp4xTLn
	Igr6itROgTJhMT+Jwo78EW0zU1QWRfzd8MUmWSfBraMTPLLrw81mVbTe75kNdjTb2dOMLp6K5ju
	yf3je8au7oWlYiFP7dtp01vvqnU685l7W1H0u5iXAhnLXWeBpLtd4g+nzRK8fEuWK6Wc94jEjz1
	Cl+eZa/OlXo9nBsQLKHI7sonS69x+nvXeHvZmcip0rFyOp2l0dT4EVqI7LcPvyXD9YodjQL5tSE
	WDpI5STqHb9iUvtMcmBrtVB6VUtWh9MjZTH5xtN2lHh8hEyU/ywVE49M2sk9Vk2e2T9Zdgatjqw
	EfLYbET9ap+eyOTdpEprlFDeWzoMNhoVGj4iwsw==
X-Google-Smtp-Source: AGHT+IFLU6kPNikvE7+rPbqgICA5eEnHBsBw77zai1gKzX/MKUchzJ8LGa26esWxAXBjWTXY4Lx7Fw==
X-Received: by 2002:a5d:64cd:0:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3a4cb4c622emr19127768f8f.57.1748525988276;
        Thu, 29 May 2025 06:39:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm2003600f8f.84.2025.05.29.06.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 06:39:47 -0700 (PDT)
Message-ID: <edd4d392-f124-4e97-b4a9-6cf3fde1e804@gmail.com>
Date: Thu, 29 May 2025 14:39:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: replace error() with BUG() in
 update_squash_messages()
To: Junio C Hamano <gitster@pobox.com>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
 <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
 <xmqqr008peil.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqr008peil.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2025 23:16, Junio C Hamano wrote:
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index b5c4043757e..3cd0dd3434e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2139,7 +2139,7 @@ static int update_squash_messages(struct repository *r,
>>   		strbuf_add_commented_lines(&buf, body, strlen(body),
>>   					   comment_line_str);
>>   	} else
>> -		return error(_("unknown command: %d"), command);
>> +		BUG(_("unknown command: %d"), command);
>>   	repo_unuse_commit_buffer(r, commit, message);
> 
> BUG() is not end-user facing but programmer facing, and we do not
> use _("...") in them.  I see a few existing violators that need to
> be corrected.
> 
> OK.  Or
> 
> 	if (!is_fixup(command))
> 		BUG("not a FIXUP or SQUASH %d", command);
> 
> at the very beginning of the function?

Asserting the precondition at the start of the function sounds like a 
good idea

Best Wishes

Phillip
