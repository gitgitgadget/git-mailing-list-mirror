Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B8221269
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574643; cv=none; b=VeuPHjDKo45jVsCnp1hUzw6o+mqSSA9kIXXOi2Qbo1/+J+CHFuSP1GpcYE9XWo+L+SisNEM7SEzfW6PIDgHPrl/9nWfEfsD0rCHdjOWRDsmW+Rv+0K9gOGGzlf7g+LnoQ3dt5eWiIjJLb+bb+QsXOvGHcoWGUcprYLSzi/P36fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574643; c=relaxed/simple;
	bh=dCV4HNCtzWS4I7pQ/y8Bq52QqhO207DkSozF501Oul8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoHgvHvViY9iWKRWkFMft22xhpG9OI7P3pr7KrSKESTSSN66EzjJrWwkBTtyzz5B4rfaiJmJq2ejMk4pLLK32TpSxbBm/BYYIBzt7SYR8jBbte+9kHfrbxDTRdluENOSRTwElcYhNj3B0zjg6jHpRNf94fjMjfs6J0ePGeeMqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoR99S+O; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoR99S+O"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso10308775e9.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754574639; x=1755179439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YIeOuRAPJyJuSBYAmZYIAEZe2qddezmuuQFQHT/RZCE=;
        b=HoR99S+O8DTXr8HBrKrTxn5h0cX3VpZAsdDxTtqZ1KPJKuiXwTKRiMpA6O6qqEELoZ
         5e6mHzzLvGhSIP1C5zF3GpcZUiskiFrDobmcxskcDBJNL6KLuwhLfWegpp09l6VTo9pr
         /s12EPhTqlR0hkNglSpu8eZ3NQo4sKFG7LvzLW+NK/YYcha+ZNBfYGJdQ7cY+3pOj/ah
         iNeuwZ669KGvmocwpNgsgkCix2fib2P1nVk6yx2v3VICysrqJkLK6gtnmtsJP0L0ZtsV
         OmwIziXN0y5PeVskH4u9426OlCaA+Wk4LnobE0YWGW8lAEsiCfoJysjEiAkswMMjSUaE
         oEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574639; x=1755179439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIeOuRAPJyJuSBYAmZYIAEZe2qddezmuuQFQHT/RZCE=;
        b=BWg+JPD+GOwD2CIkCCx5ptpU/lzp+1MSmThj9JJ9+jwd2+rPEBPzRlHQKbJw+7Ff78
         8iHnlYVdqiXmTFJ1y9PZwcqgGEdgRoAFfGATBumHELtpCwNEry6NgwrainrtxKw86+UQ
         Zcvhsvpu1NN4S2VJDGJJExI1ZS4uqCu5Fz/TzjTMxeX8QNCmipfdvkg0WFH5Wv+0LJQf
         wuQf4pHaDFMC60gK6TUdPfy9tXLgeQ/HgS2kW1LGDJRnXlCx3vsmgBNSjE/vaxOY6mtm
         U+x4w9hECzD+3kyFDJClIetACz7CJk4zD+Yzdth7dJmIY6J41I2V430GqSIp8IE7OFyQ
         nkkA==
X-Forwarded-Encrypted: i=1; AJvYcCUtzbxJnyyeeLO/N6W22wj4E3VJoqgwW0J5pYG6VPbDDGVfZO1M1t2K9ak+KxmUvmxo0Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ARN6pbXZCWtzwGszNbTJpEF/aEaUpHC5S1EP7jUbNCfeHPRL
	spg6iB4eAAJUSI96m8u75o36J/2GnHSWzbVjiH6dYA03WQdBIdvK/aFt5sJy9A==
X-Gm-Gg: ASbGncsrp1kBx4C28AoG94Ws+VN3K+aRRyV47h/SxeGqqnJWo31Siz2VAkjysaOerdZ
	4JWj5PFSmmwpCj9I/jQiKtfYcAziP1sLYunUmO5MtcRnYgNL6SmGjCl4IKXTjYQ/UV7VRVC4hOL
	WQZ2g3qWzmuW327KS4B3UQy4mKysTVuCyX1LJx1X0l6WveBtypYDEHYNaiqv4w7qM7BFJNmvOfP
	cqGKdmBbgdeJ+y6TH+nIs633wi38v7xTjESfpH3qzYZv4qgEfloaRdQk4iC1ueRog3SrehYxcNq
	imv1T9tRbENfvBZblNotCsooUAndN71aR6d0EzTK0BNhBR2ZpqpraGWdx+owpkJiNdP8Hpuskdw
	oVJsA/MAPU6ddgDzDVEWF1CUbB1MhyZ1T7AuP8zONtmABqyhVvgRmUTEg7+X0OFYYsfATE5mM+W
	uY
X-Google-Smtp-Source: AGHT+IEX6EJtNc3Jtg4XXssHt/CEMUcrjWICDTDfcLYGqHTp51v+bvJWvUm4XodgIu0+OvwvcUmuXw==
X-Received: by 2002:a05:6000:26c1:b0:3b8:d8cc:dcf3 with SMTP id ffacd0b85a97d-3b8f41aca24mr5333765f8f.29.1754574638846;
        Thu, 07 Aug 2025 06:50:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm104864325e9.17.2025.08.07.06.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:50:38 -0700 (PDT)
Message-ID: <7c8b1886-e5cb-420a-894a-f0434a766117@gmail.com>
Date: Thu, 7 Aug 2025 14:50:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: permit 'drop' of a merge commit
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Git Mailing List <git@vger.kernel.org>
References: <37f6e34c-91aa-4e55-88e1-019d2e042df3@kdbg.org>
 <xmqqjz3gtb4w.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqjz3gtb4w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 22:04, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> Thanks.  Now I understand why some people are sometimes tempted to
> omit the default arm in switch() and allow compilers complain when
> explicit case arms are not exhaustive.  I am not saying we should do
> so, and I am not convinced that it is a good idea (there are cases
> you cannot afford to be exhausitive, yet the cases your particular
> switch must care about are multiple to make an if/else if cascade
> impractical).  But this is one of the case it might make sense.

I think there are definitely cases like this where it makes sense to 
require the case statements to be exhaustive. Looking at the 
documentation for -Wswitch [1] which is enabled by -Wall it only issues 
a warning when there is no default arm and the case statements are 
non-exhaustive. So I think we could start relying on that just by 
deleting the default arms where we think it makes sense for the case 
statements to be exhaustive. I've previously worked on a code base that 
enabled -Wswitch-enum which requires the case statements to be 
exhaustive even if there is a default arm and that was a pain in the neck.

Thanks

Phillip

[1] 
https://gcc.gnu.org/onlinedocs/gcc-15.1.0/gcc/Warning-Options.html#index-Wswitch

>> diff --git a/sequencer.c b/sequencer.c
>> index aaf2e4df64..9ae40a91b2 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2720,8 +2720,9 @@ static int check_merge_commit_insn(enum todo_command command)
>>   	case TODO_SQUASH:
>>   		return error(_("cannot squash merge commit into another commit"));
>>   
>>   	case TODO_MERGE:
>> +	case TODO_DROP:
>>   		return 0;
>>   
>>   	default:
>>   		BUG("unexpected todo_command");
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 6bac217ed3..34d6ad0770 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -2262,8 +2262,9 @@ rebase_setup_and_clean () {
>>   	reword $oid
>>   	edit $oid
>>   	fixup $oid
>>   	squash $oid
>> +	drop $oid # acceptable, no advice
>>   	EOF
>>   	(
>>   		set_replace_editor todo &&
>>   		test_must_fail git rebase -i HEAD 2>actual
> 

