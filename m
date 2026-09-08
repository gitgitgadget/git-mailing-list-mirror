Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4EC4A2A79
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858477; cv=none; b=LgQ6zXw4n38TdxD5fykjCM4G5Sk1gYuwtzyjYg3JEuKo3mJ/JYK02UiES8olRqTYmW/0uhPE2nLWHN0syAAXINKVhLVnmK3bsAOaYTKdHEHBYiHhAyGscfZbNolQT5JlV5LdgCLSxSzhjTREMNOrJ/JPV0d2SrXE6IDjwzDdnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858477; c=relaxed/simple;
	bh=o2CHlhWL3z8fw6KKEwl7FihPC/UruOJzFkyNB4nSt1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaCTi4wBqK9QVH5HLYHl6dCK/JAiJpiB7cFBxfN8VD5VhvGX/IHF/E48is94YkrZwd/3YSRYHiD8iN7xPWWhQ/t0ZksvvnGSnzLsH0fkQrc7r+9l1GrdDFao40GVkV7vZS2PvWRmr65F7vSMxuiDWpZx+ruzHe5FrcFpkp6Awtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5SXFufz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5SXFufz"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so417010166b.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788858474; x=1789463274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XWXdvXpYq5WrX/KJV7YGnamE+VrVUbFdzhYOP4Mp9t4=;
        b=f5SXFufzPFRZ739DJtFHsJLlb6mNxEubzw3X+W5JUoeDQ61kg+C3/0aflCvqg2ozhI
         eloEzIkqZMuus5ObalZSWhO0dggJRuRqMUPzW6qkS6IDD2rOkHbq6SidlN6rZKHYSoh7
         ZDh5E3EBbjB0XyPzWPdtwgPQocBwCk4UUZYNY72rxHJGnva8ZP9LBYw25Cb0tfuMdc/o
         TGvcyIa9y7OeNqpfq2YbfJQt5s/ZQom7SZ6eMu9lLP7ifQmhtUydhBwRTPChtrr3FNNl
         qYrJBniFLfMSGGXu7c3Q43pDsRSbh7OpLVmHtw2iyD2A3nTmGlTUhcPLTJHGGRtbZnab
         6Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858474; x=1789463274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XWXdvXpYq5WrX/KJV7YGnamE+VrVUbFdzhYOP4Mp9t4=;
        b=jZYh3p27Mt6ZeeygVutuTHflcfb0qxghZMI7eIxsraLGhBbtTpmNDas7fo8VmpQmyi
         K1JuNbEeMxsGcDtzIB/HWOSQrFBUEBbFiid7SReYGIULih5I4gRpTDudgEv9Nn0wBFVb
         nylxaxaaqwX6eL5jIqi+mckOuiAL8exDgRZ7Z2e4QYPou7Tbq5+gFPgSLXNpsmLDOLym
         XKjrWei1CTC1nGghBm/mQL0XHEN7S4Rk5CZdFgE9JWHD1mOdRk3HPBUV475A+sNasFhr
         j5JHm+cgWOBi39fU9bigdrpfm4zs6EUmHAcQQZSOFhQqAxxA7BFlWabqiheCXsBS5C6F
         zpVA==
X-Forwarded-Encrypted: i=1; AKwUvBygV5sf4lb593+wfd6qNOumq4Uma3Uws6ELjbPyjdvfeXQ57Uba6ZfWH0dWNbCBgJAdcnE=@vger.kernel.org
X-Gm-Message-State: AFuF++lmjzMZ36NcuPaVerIpJTidMGvJ0Z9bvzWMWHKSwOgPuiJwYgZE
	jmDzQfFUM+anONTxWHVYMEZ5J3GUhqWbGdzFzn1E+X/2XfILwlL21Fyfw/3dTQ==
X-Gm-Gg: AYBFou2nAi/JJ295HMsbf4AaIokyWl1FpY3Oabl3csCfS717NfTKscUCT796C5qjJo4
	Nfm7DfhPunmAvoXbpmGxfY5gS+cEmd3Dm5/pHgRKdslFoZvQvdYCYX7vFnulV7LIs+O3WlD5TRu
	baOnc/MVOtnQObRNd2mbiflx6wg0LFHPMOTHzf3MXCx1eL7jl3wLFb4g1bx9FZ5nzXTcF5UPqBm
	+3d2fxUN9mYIQShK2Pd5aMQqbBmS05BpxfU3y4QATDw3QoBEcZKGBGYjVT0VdCi3T8ZleM9Ffmg
	0Yaxx90UOtF1yCl/FAc+HavpQ0rG2tsHmzD7r1aBklbpwqK0ectUQLKwoIWKPEs89uJ/GNTdZkv
	01noLP+vRtKiyMDogBTMxa8h5JOAtYE6ECC211s8nADxiQupcYK0sfcQmaGVD26vcfwLZvvmZMv
	9Fw5QGE9XbHeVSmvZr0Q6w6BOAY46X2c+PiCryUpF+pBo3FZeP0szA5OqJ5g3oxtHz/8UXxIB/S
	fVCEAA4fTFg+cms90CNpAnLUiUIJpv77gppYN1zRiI=
X-Received: by 2002:a17:907:c0d:b0:c12:74af:51f3 with SMTP id a640c23a62f3a-c260c7ac988mr1079380866b.6.1788858473529;
        Tue, 08 Sep 2026 02:07:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d575fccsm595044366b.37.2026.09.08.02.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:07:52 -0700 (PDT)
Message-ID: <f3db3c4c-f80d-4f27-bc5a-e339e62d5ea2@gmail.com>
Date: Tue, 8 Sep 2026 10:07:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] var: support broken-down idents, default key, multiple
 args, and -z
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Andrew Pleeter <andrewpleeter@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
 <pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
 <5634fdc4-d0f8-493d-b401-3c9753524034@gmail.com> <xmqqqzj957rm.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqqzj957rm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 04/09/2026 16:57, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>    	if (value)
>>> -		printf("%s=%s\n", var, value);
>>> +		printf("%s=%s%c", var, value, eol);
>>
>> A key can contain "=" so this format is ambiguous. When the user passes
>> "-z" we should use the same format as "git config list -z" which avoids
>> that ambiguity
>>
>> 	printf("%s%c%s%c", var, eol == '\n' ? '=' : '\n', value, eol);
>>
>>>    	else
>>> -		printf("%s\n", var);
>>> +		printf("%s%c", var, eol);
>>
>> It would be worth checking what "git config list -z" does when there is
>> no value and matching that. Does it print "key\n\0", or "key\0"?
> 
> By "key" do you mean "var"? 

I meant the config key which is in variable var

> The namespace of "var" for "git var"
> proper (like GIT_COMMITTER_IDENT) are very much under our control,
> but it also gives all the configuration variables, whose names can
> indeed have '=' in a three-level varlable name.  This is an
> excellent suggestion.

>>> [...]
>>> -	printf("%s\n", val);
>>> -	free(val);
>>> +		printf("%s%c", val, null_term ? '\0' : '\n');
>>
>> Multi-valued variables are a bit of a problem here, they're built on the
>> assumption that the individual values do not contain a newline, but as
>> they are paths I'm not sure that is necessarily true. With -z it would
>> be better to print '\0' after each value as we do in list_vars().
>> Ideally we wouldn't use a single string to pass multiple values around,
>> but a simple fix would be to use '\0' to separate the individual values
>> instead of '\n' so that we can split them unambiguously when we print them.
> 
> Hmph, what does "git config -l" do for multi-valued keys?  We should
> mimick it, I would think.

With -z it nul terminates each value. I wonder if we should be printing 
the variable names here when the user passes more than one var name. 
That would make it easier to parse multivalued vars which can have a 
variable number of values, or we could print an extra delimiter after 
the last value of multivalued vars like "git merge-tree" does to 
separate the different sections of its output.

> Another thing that might be worth doing is to see if we can separate
> out "git config -l" handling out of "git var" with a breaking change
> at big version boundary.

Yes, it would be nice to be able to print just the GIT_* vars without 
having to print the config as well.

>> Thanks for working on this, being able to specify multiple variables
>> that are printed unambiguously is a really useful improvement.
> 
> Indeed.  Thanks, both.
> 

