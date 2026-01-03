Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939821CFFD
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434650; cv=none; b=QM5HAeHe36wXb8+2wS34dUiOeXx6ujn9RWDDm9/9sh5f1R94e3a+Oj33mdLo+XHJSbza8RCE6BXBA+Qkpjif3GY92aaRZ8u7KH80va0QcgMe83UyzO4RvtA44TxZOc9omAkGXmEl+xpTdWtGjC6NyxVOMN/0DpllEb/BMEAWj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434650; c=relaxed/simple;
	bh=czxPj9UHjYuvOCmbhhPiv9J+ydrWzRfUtENoI5aCb28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk8bZ0AstREdijgtYKNbfF1xfkw2xdj6wILmQe/yj8/kW1dwl0d56/d1cpb3+TP7ZUkuHDkSyhRPQvCXhO1h/4eCbZFL5auwv8DIiJwy/NrsK8Qp1nIP/sDLtYQk2eX/rdMmlTaVtA7ejp+xXz0/o4U3oMgn9pkjsS/bW3+O+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m48lx9cy; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m48lx9cy"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so20579975e9.3
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767434643; x=1768039443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8c4Avd0jswT1AGUWDRpEXlqbycDvud6i5r62X3kPB5U=;
        b=m48lx9cy985Ww0nR2s2eOyHZUV5bOgc6UpzsH1OVvGwHxinabNMT+x/bIVk1pBmRgB
         6Iuk4dZw3HWTs569NtB0fQlmUf+K3Xz909XTuEzsHxmNSS1nzCXAj4isLm2b3lNc3OuP
         4lnMkapBkc2QnrQbNHoTbJKCwymrKhjCqKuL4njoAys2Zpw9IKilr7zb4YngytjXZlhZ
         NAgN/mreDZZxl3bgwr0K6PdYoCx6PknwRHTFxhimARAWHl6YR2tMhVXU3BPUQ4JUDkEa
         daUwrBDTnG0KGeFty07dxIk9wOhXsN8vxzps9TaPnaxGoliEZ7nYPi7H3jpIBXAuK2bm
         Cf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434643; x=1768039443;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c4Avd0jswT1AGUWDRpEXlqbycDvud6i5r62X3kPB5U=;
        b=wPvHaJAdXECMhjBgglaW5EHqnGI+mRHpM3A3aOMZmkRO5Iq4tw6vR2Ek/TWRGpa53P
         MnRd4HjfoYSfFl1pAfzq22kmKdF2R+B4vEQf4EQoQtBnEtOAMEwWCXMRXeTzolGtQh09
         L+FLMXEeVVNPoA/8qcs87ixMDxDg9hH29pNbTwo69mU04WAjoDcdkH7cLTHMs/gSQU5+
         P0SUnJVa85Nlvhei54Wv406wWewpGuZPvFAHiqf5bSh55w4k7Sqfspm9NKdqQUJX4PY2
         x73x4782IBrps6llxiAvo+TWXTDUq3XhmY2R7845EK/XrEvHECG7aOgfJJEHd4V0rQFa
         LWyg==
X-Forwarded-Encrypted: i=1; AJvYcCU+V1fitf8bZBd1GitM4lvU8HENlJJfGQQxuYrzC7jiaOnbVWBz0Hc2iHEfCraDJ9H/L0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1f/MRlyEft2sN8PWDi3VbLph0Sir8W3DezPFOaASZ0V+KIR1
	hFH/xZeMDJDnL20rBj7vu+Bl6SarRjEOL4kOy33qr7bJAPDswm4CGSgt
X-Gm-Gg: AY/fxX63XLvwJaleIQHhekKytUUPH4lBhphGpl6+Ve4tA3txXtp+EL68/OC36ETjPwN
	6AK/HdmgDhCEMzfbjRhACbafvJVzNvVDAMFAFRZmig88OUVJPy9xsGBY1ojDRpLHefgmuG2K5X3
	xZYEUcJgaBTwdasTAspqe8S9U5oX/SDzMDa6oqWGZXe9dQyOTh+LJrEsXuJmEzD99oO152R3oSC
	TobQvjnP9IfAQG+fYxpQAYZ1ts56guiE6J8NFBzNipg43mHT8yoYvlmYD4/ijJ4WJ9dd/OcQknE
	mCZD9nGfR/SmQduWS02vjh5Bv9beaTm3zVac01TxyaLsSoLZ7Wz1VjWir7AIohpfWs7882ghKqo
	0MGEQPlnZPAQnxw6KS6ULhImZ5XHpM1YUZfnyu15/k67HgWW7xhk7TrzsAOxNs4QjqZWw3fcpAa
	jn1eNeLHLuE6e+4uwzvagC1Z0xROK7HGxjVeQXmL3pvOiFOInWpyYyGcMgszBLZX2HSo116o0sq
	cFd
X-Google-Smtp-Source: AGHT+IH5DQEEGnPx+T5byACn+D99mZGzkEw8FyEPpXVj8EEp5j7bvRIymu9sSuMfVVjfWQSpwE6g3w==
X-Received: by 2002:a05:600c:4506:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47d1957711fmr506324675e9.18.1767434643114;
        Sat, 03 Jan 2026 02:04:03 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba3af58sm15744245e9.2.2026.01.03.02.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 02:04:02 -0800 (PST)
Message-ID: <9d3407a6-7d88-4f30-9961-5b21b059e1b0@gmail.com>
Date: Sat, 3 Jan 2026 10:04:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Another look?
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: ben.knoble@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 gitster@pobox.com, kristofferhaugsbakk@fastmail.com,
 phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
References: <6526c419-c60c-49d2-9c1a-52be7aca82f0@gmail.com>
 <20260102202738.82432-1-haraldnordgren@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260102202738.82432-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 20:27, Harald Nordgren wrote:
> 
>> Shouldn't we be taking account of the push and fetch refspecs here? There
>> is no guarantee that $branch maps to refs/remotes/$remote/$branch. To take
>> a silly example, if we have
>>
>>       remote.$remote.fetch =
>> refs/heads/$branch:refs/remotes/$remote/abc-$branch remote.$remote.pull =
>> refs/heads/$branch:refs/heads/xyz-$branch
>>
>> Then we should be using "refs/remotes/$remote/abc-xyz-$branch" in the
>> message above as "$branch" will be pushed to "xyz-$branch" on the remote
>> which is fetched to "$remote/abc-xyz-$branch"
> 
> I don't understand this one, can you maybe explain how to code will need to
> change?

You want to display the remote tracking ref that tracks ref on the 
remote that we push to. When git pushes $branch to $remote it checks if 
any of the push refspecs remote.$remote.push match $branch. If there is 
a match then the branch name is mapped according to the refspec and that 
it the ref that is updated in the remote repository. It then takes that 
ref and checks the fetch refspecs remote.$remote.fetch and if it finds a 
match it maps the ref we've pushed to a remote tracking ref in the local 
repository.

It looks like you can find where we would push a branch to with 
remote_ref_for_branch() and you can map that to a remote tracking ref 
with tracking_for_push_dest(). We could use branch_get_push() but does 
more than just map the refs as it checks push.default to see whether 
"git push" would actually push the branch.

Thanks

Phillip

