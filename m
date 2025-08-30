Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916532472BD
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565066; cv=none; b=nLi45YPJ3vRHlZNC4my4bpmrQo8UqJBYBc+a8k4io24fP1AUMZWiBVBoZgeN/NT+XBl1O8QkgsagbdDs16he2WfDxjyFK+ttkEWRop+4mL/peiuU1BjxW/vAGrLRkMILoMOG13G2E/HBnPyMfrgNmBpe7JferrVn2eR4cmWQqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565066; c=relaxed/simple;
	bh=vRgvbaKwBMOiX/lLUCxuoZynN9GFQx3XxZ42S3wPjcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGzoS95jhfeQTSZNfsgDIs8PF9uX4Ypg9UttGcfzQoF1kl32LceqKj9Gr568AvnAErHnEf4gTn2ET8N1HFslzAoa2Dj8E7T4KN7GxXtiTWkUx9h1CPXMFKTbkntfRUItTN1c6r7QO4CCaRuXf3Nioi88uIZtHt/dcNEKUZw8aTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtHRldbM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtHRldbM"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b10c1abfe4so29131511cf.2
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756565063; x=1757169863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FwBP6nVSmcd8HR8crnIprWC7WWgquwin60UzPfpG3s=;
        b=mtHRldbM16oqS2f8rf7pGAoSFTvldhz2yFbwWOorHnWXP/LoX1e98+U4qEsILiu9hS
         CZjqgGWnhf8nNPsZTamyfKhcKbAsforzYqO/vIrQjkNQjOfdy/6h0HU6+Oa7IyS1dAts
         oiYXAu8tiKOAE/wlvKVv6vz+Bjknmdb+jTkyxxE1g8fEujvGh3aRlEXmh3Cj/dRbdrH0
         jBkM8sNwIaeQpEy8CSmBmCPkNYMAKsrDuvmlazvTPy0VT7I53owsd3Yp2Bex4zsroSVa
         5/RONwRni5Dl8HeEdO3FIX8cKXwwOdcPm/Pt/b4wUZTfNfDTe9sWUkwnPwZzo8ECnvyv
         AP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756565063; x=1757169863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FwBP6nVSmcd8HR8crnIprWC7WWgquwin60UzPfpG3s=;
        b=lF/Wej5u63Mo+8+ZNgdcDlmbgREv4RRxvq6Kjm5imqrbIcAJJUzMlLNKtKXDYxZjUM
         YUSIAuGnmh2cDBKPQ/IhmLrHPuWJk69d4JazYzfDr++6bHL5rMvo7TwMvzAx2EzpvMN2
         T05UVw5WQHUSMEMcldACiAxfHmhGWOzHpl1XfCyQWqZDJvmqdzqMYh0u9RxZgD+225ML
         qbq7JIgdOM8AB4g4zMwrkcwSyHBPTJw/ewYCTO+oQcCUsLuSI1CqZxowxXUezeHzz4Vy
         d12VWHC0Nre2FWdhrBljqyJ9EhfSfWmeZcsOvKS4RoAfNPAHxddSqC7KXlyVUJ9YyLQB
         ENGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5jM+iNAKEl5wwZJJ+CFzl+/YIwbZAeXu3gXheESa5GJ//aw4+CIDdZukJFsTEDeUrevM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhg6a9C0L+qtAsMieRDTbjkXNdfKnI4PqZovkyxP6/JEcVEDGf
	/zy1ktclo6T9UGLO/AZYyNiefzFdXSa5A/7EkhpwPDa3jTYnAxZNcpir
X-Gm-Gg: ASbGncsMuppFquOvuLgB1+NhaWEBoYpTIFMNdg9Tw2bLpIBNKowgCOZhJBu9M8Vl9bx
	X1xBFQySCv1r4/plH4MLZ+8Z04zxBnA02zERXzUxqcy4qpia+SHB8PE6mry4BRp6zVkWQklWTNI
	L/+aJID9dnmxLG9qUPOQK51MzbYbQYQ73zplEG3AkCkyrGzylgOLGvPD4/nImE1lS2tXmc2sNop
	phtovXTcobqH0BfQYaa5lqqidAa3esShgph8ntNVjnaGbbIpPu1IdUAEMhtercARgOspMWjYagR
	4o88GnqE9J6aAn+8IZfQb+DqMoKrkJ65PrqyOhf/V8RiSqgEIzJ7ECPysyvuWm9yJ0XCbYjcK+V
	gO3Mgn/28lldiABK/zkQQhT/1SplBvFKg4Afu62u/PXVQcn37VgUBHDOjP9EdQSk/o/wY2VQwQk
	jZlRKw0K4urQ==
X-Google-Smtp-Source: AGHT+IGi3/hAU1XSGBAX+a4wT7DWqC3BvDZLVLbeCrG1LdBQlNkWxpWbIeBNzjAt0Byt3YHeu9cTtg==
X-Received: by 2002:ac8:580d:0:b0:4ae:b1c9:85ff with SMTP id d75a77b69052e-4b31d7f0cc0mr27579621cf.2.1756565063357;
        Sat, 30 Aug 2025 07:44:23 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:85d0:178d:3525:8f0e? ([2605:a601:a6de:d300:85d0:178d:3525:8f0e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6f26d1sm33314641cf.50.2025.08.30.07.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 07:44:22 -0700 (PDT)
Message-ID: <eac886a7-0f50-40fa-b10e-92c68d60bac7@gmail.com>
Date: Sat, 30 Aug 2025 10:44:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] midx-write: use cleanup when incremental midx fails
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <a5bee036019a044273f93434f9e382a4cfa6533c.1756402795.git.gitgitgadget@gmail.com>
 <xmqqwm6ntbjt.fsf@gitster.g> <aLECkfDqFVgNA1xh@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLECkfDqFVgNA1xh@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 9:29 PM, Taylor Blau wrote:
> On Thu, Aug 28, 2025 at 01:51:18PM -0700, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <stolee@gmail.com>
>>>
>>> The incremental mode of writing a multi-pack-index has a few extra
>>> conditions that could lead to failure, but these are currently
>>> short-ciruiting with 'return -1' instead of setting the method's
>>> 'result' variable and going to the cleanup tag.
>>>
>>> Replace these returns with gotos to avoid memory issues when exiting
>>> early due to error conditions.
>>>
>>> Unfortunately, these error conditions are difficult to reproduce with
>>> test cases, which is perhaps one reason why the memory loss was not
>>> caught by existing test cases in memory tracking modes.
>>>
>>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>>> ---
>>>   midx-write.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> Good thinking, but may I suggest us to go one more step to adopt
>> even better convention if we were to do this?
>>
>> Pessimistically initialize the "result" to -1 and let many "goto
>> cleanup" just jump there.  And have "result = 0" just before the
>> cleanup label where the success code path joins the final cleanup
>> part of the function.
>>
>> This is often the right way to make the flow easier to see, because
>> often the success code path is straight forward, and these error
>> conditions are what employ the "goto cleanup" from many places.  By
>> starting pessimistic, and declaring the success at the very end of
>> the straight-forward success case code path, all other flows to the
>> clean-up labels do not have to set the "ah I failed" flag.  It would
>> eliminate the need for patches like the previous step if the
>> original were following that pattern.
> 
> Alternatively replacing something like:
> 
>      error(...);
>      result = -1;
>      goto cleanup;
> 
> with just
> 
>      result = error(...);
>      goto cleanup;
> 
> would IMHO make the code easier to read, though I agree that nothing is
> forcing us to remember to assign result in the first place ;-). I am not
> sure the pessimistic initialization is better in all cases either, since
> we have to remember to place it before any "cleanup" label, and make
> sure that that does not regress.
> 
> So, I dunno. I'm OK with what is written here, and I think we could
> certainly have a separate discussion to perhaps have CodingGuidelines
> take a stronger stance here.

I'll look into adding this as a cleanup. This specific patch is
about adding the 'goto's where they were missing. I can make a new
patch that unifies the result initialization to -1 (and thus making
the method unified in returning -1 on error). There are many more
"result = 1" lines that need to change.

Thanks,
-Stolee
