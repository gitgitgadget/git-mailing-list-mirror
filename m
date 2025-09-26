Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E027279359
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881547; cv=none; b=dDw38iy7sihK9QMZUkzaHdmJ9je1f5YZ2yD75OxrVK8sJ86+phUFspzikXv5TwAStuShrIzDeg6LLli8b8iF/iXEorKGFXypYL1tbp/9To0LjmWCj2Lhzw+9CoSFELVbRfr+rReNo45Xq8twlA6XlsmiEZMYXSdmCmRGKbz3iHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881547; c=relaxed/simple;
	bh=qZEEA8SkJRxbpiylXrvJ0tNGaGxUtCJ27Ln50LjmcpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLANoMJtDs14ptW+mjzMS1MAhWpnM+sAu6zhmdwGxdsgQa4cllAOe+jLtA7NV3pbf6tGhqFT3kgE+jIrAo8UPGpjI2mg4OWPPO/HUK1Shg8J0km6TiNJIZPRsVVhxnFIkMFehXVdeAL24DNvoSeDmadPD+jwDngV3toqMJNcsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LllCTCU5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LllCTCU5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso1898424f8f.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758881544; x=1759486344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCeAaMWKXG/l6WKL+2TRibFPD11F3pey77lROvvVktU=;
        b=LllCTCU5rBevIAaKkmXSjX0ymHYyCe/UffuikSblzn+3azr7f9hZm+X8vRfSQTGWlc
         kzBx07OQ87g7TyjFZhpyCDXrbFd34GJrVZhmVv1wznm5eNT7L1Bu0t6Mc20ikTNZcFX5
         d6Znu9ECUlusp0e2TiWeGWQ7LgmuJMOb7NcJ3aF9ch1TCJ5Wb0HT3g10SRvnkLZkzzge
         Ogp6RqmJ8gutAFP+bpwbRLBHhwucqoDInuQa8D1PA8QsMHNRmeC6VecuV63RddLEIe0B
         OIhFuOTVv0iV5E+40oSZKLBJGPyB288qsM6EzvL7eh1fwBjAykVjllgqKZCrnCRJNZaR
         SbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758881544; x=1759486344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCeAaMWKXG/l6WKL+2TRibFPD11F3pey77lROvvVktU=;
        b=AA8+jwu+unWDuqdRIXZEcFQbCz6s3/vR9Diibh1uO3sJ5/IIWU2sUKhnv0gD+vRpBc
         cbXGzXcC04idwpPjQ0kNvlRdEjRZaogJkNApLE9caIkZ9dvOukSmfHGvl68r+4nc0QF0
         +4Sc6DjNESwFe1fDX2WCyONdekinWOmCalyTtC3Qxu0XNBHFtgfHSNq0IsHCgKTVoRPa
         8+Y/7z/DJh8P//2BmalbSmZLkfjOf7UPWJoXYjZcsVouAiydaHshywxPagKKP15JX4RJ
         Mcfb16/qFSqLRA3iHuk7y0hATvp+r5fc+3PCjRoZCeyspKgS/6I5Jz11ocpQw8D69Ejq
         /Yww==
X-Gm-Message-State: AOJu0YyXKyjpOb+OEt/bDzFxdhtgoWVhABGAxZc0ZfrJIAc7BG7hi1iB
	A3cLeoGZbd/r6ug/s2zcFgLYLpy0LGvRUb4nWdqYTPdfa6mdpYdksERG
X-Gm-Gg: ASbGncuI67IntVHL8IlDL3WJzqyct+oqET7L5fJbR2NI/tC3lmP1nFiwU2MmbXO2ESS
	ZrhFjBMGmCGH9edlGx70XOcX21GN5pKPdiQMxFI5y6lVwCmo4YsO3mT+XRyOolu074aEICm+R98
	WLOLhEWw8vkpw3lXXGhKhvREzEcfepoMc3maxv8HnSg2iyqd2C59uU4LbJ92CHzd4LcYuKxA5a4
	T6nT58hknLT+YA7KRBbogvVrK6AYhdKEzovaEsiNyJEznQwk+UuUDPpYvqOiegYlojaIXqSrhYb
	VJ5+QVAN91eczjvzJRs/wXH/G7eMy0X/oUjEmRwo+B4e48tP1qOY3e4rYRPNAzgUiw3zZg45L2F
	JDZoRbrK96nbV9pAb2y03G7+FqsHc0grQ5CwKKBB3s5iFCypYZPebckTERL3RPeGArTyyWJ8250
	j+DGYR
X-Google-Smtp-Source: AGHT+IGUueaPnrAcbr+6h6Z++ddQOx7zlrPYZOZ6L20Wg5mlx63oH5ALa9KXRrKpRJ70mffrMMyiSA==
X-Received: by 2002:a5d:5f52:0:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-40e429c98f2mr6728795f8f.5.1758881543463;
        Fri, 26 Sep 2025 03:12:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb729sm6213498f8f.6.2025.09.26.03.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 03:12:22 -0700 (PDT)
Message-ID: <58689c52-d692-4a5f-8d55-478325bbd39e@gmail.com>
Date: Fri, 26 Sep 2025 11:12:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
 <pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
 <4935dde39933744ecd957d84d3b71287fc274074.1758813038.git.gitgitgadget@gmail.com>
 <xmqq348agzpk.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq348agzpk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 25/09/2025 19:21, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> ... In the case
>> where the user only wants to change the selection of the first of
>> the split hunks they will now have to do more work re-selecting the
>> remaining split hunks.
> 
> In general, that is not just "first", as you can jump ahead, or just
> keep typing "J" which is not all that hard, until you find the hunk
> you are looking for, at which point you flip its status.

Fair enough, I think that only applies to a single split hunk though. 
One you select or deselect it you can't walk though the remaining split 
hunks J anymore because you'll have been dumped at the next undecided 
hunk after entering 'y' or 'n'

> [...]
> So I like the updated behaviour very much, but I am reluctant to
> pretend as if we are siding one camps of folks who think that
> splitting a selected hunk is done with an intention to deselect most
> of the minihunks most of the time, playing favors.  I think that
> is a wrong way to frame the problem this patch solved.
> 
> In any case, I no longer have problems with the updated behaviour
> with these two patches.  Thanks for working on them.
> 
> Will queue.

Thanks, do you want a different commit message or are you happy to take 
them as-is?

Phillip

> 
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   add-patch.c                |  3 ++-
>>   t/t3701-add-interactive.sh | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/add-patch.c b/add-patch.c
>> index 302e6ba7d9..61f42de9ea 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -956,6 +956,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>>   			* sizeof(*hunk));
>>   	hunk = file_diff->hunk + hunk_index;
>>   	hunk->splittable_into = 1;
>> +	hunk->use = UNDECIDED_HUNK;
>>   	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
>>   
>>   	header = &hunk->header;
>> @@ -1057,7 +1058,7 @@ next_hunk_line:
>>   
>>   		hunk++;
>>   		hunk->splittable_into = 1;
>> -		hunk->use = hunk[-1].use;
>> +		hunk->use = UNDECIDED_HUNK;
>>   		header = &hunk->header;
>>   
>>   		header->old_count = header->new_count = context_line_count;
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> index 04d2a19835..a6829fd085 100755
>> --- a/t/t3701-add-interactive.sh
>> +++ b/t/t3701-add-interactive.sh
>> @@ -1301,4 +1301,14 @@ do
>>   	'
>>   done
>>   
>> +test_expect_success 'splitting previous hunk marks split hunks as undecided' '
>> +	test_write_lines a " " b c d e f g h i j k >file &&
>> +	git add file &&
>> +	test_write_lines x " " b y d e f g h i j x >file &&
>> +	test_write_lines n K s n y q | git add -p file &&
>> +	git cat-file blob :file >actual &&
>> +	test_write_lines a " " b y d e f g h i j k >expect &&
>> +	test_cmp expect actual
>> +'
>> +
>>   test_done

