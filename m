Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CD1E511
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4JbcB8l"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9EDE
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 15:06:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32fbf271346so758447f8f.1
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699135559; x=1699740359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgzZ0N8aOgdOCoi8EFvH/WmEoOcVLPlEulW9fC/qk4E=;
        b=T4JbcB8leImZWbeijNoV/6dYEUfsoDSEGIUSQ6hog9pQm9qU0Xcw3MGnXxO1tNTxXG
         WjGCULYDcM0a/SSAgzQL/7DGaPNQ1QzZSfHFwLiz98aMwV0jQon0QHCeBzIJOmlCjIkd
         UoLFIj7eJLZOOxDelJjbrk+g21ezoRQ0soMfOzYOeQxv3cHZ7ldK6oCJZ3zjCC8KsRY6
         6uRf4QQj4/AmpHRW9vSTxRILTCUX+d2lnFt3qg/C1BFs/TNJ+30unbChJL8spxoHF+68
         JXXkFCUeJ38idDowzl14vLaxNtAXFeLxFiiT9sX+kP1A3OD4BXoftU4mJBzSsGJO1dqh
         Jenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699135559; x=1699740359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgzZ0N8aOgdOCoi8EFvH/WmEoOcVLPlEulW9fC/qk4E=;
        b=dGrRGVgvlIm4FUF/jd62IFUVFWLmO4Zb9Y+/XT71qTuuDrO6o/rHNh9cFnPqGyTQ+q
         m1VoG9FjmYDpdEFC2tJV4x2Yz9gpXnRqLZa9xNI8KacwXwxRV2KDXnR66Brq1gbQN5+6
         gUuQNhsko7CVAYP274ZLPxPNxPqzR25q7uKu/hjOu92aUJI6hkmSP9xONOOMtH+LAF59
         h0bvQjo2QwB0RXS8aYH3gElt+e/54xe+DoSj37WwTvRfegPAK6JtMfSoq8FGXPBpGkZC
         ov/cQCOrFhS3YwGDoBFYMu1oxR6+4kdIJct0PVBtEACE7wd5HoxuYUvXY/VewxE3+MbD
         Pn6w==
X-Gm-Message-State: AOJu0YzX5hBKctH8Ch4aWdPRkjU6ZfgYeO8kGOYm4aLmVENeziIxWTQI
	vw839LIGhr2aqLFOfsWAVns=
X-Google-Smtp-Source: AGHT+IGMkleEE6SnbWhW58Ol5EPcLsWh9HMHs5HHWW2LdxgCpiH2y3x2M+391CjjTPz+OEHryojUgA==
X-Received: by 2002:a05:6000:1882:b0:32f:7f02:daca with SMTP id a2-20020a056000188200b0032f7f02dacamr17778521wri.13.1699135558707;
        Sat, 04 Nov 2023 15:05:58 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6847000000b0032f7e832cabsm5314611wrw.90.2023.11.04.15.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 15:05:58 -0700 (PDT)
Message-ID: <20531e2a-deb5-4bbf-93dc-a83648f59fca@gmail.com>
Date: Sat, 4 Nov 2023 22:05:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rebase: support non-interactive autosquash
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, newren@gmail.com
References: <20231103212958.18472-1-andy.koppe@gmail.com>
 <xmqqil6iiacq.fsf@gitster.g>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqil6iiacq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2023 01:19, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>>   rebase.autoSquash::
>> -	If set to true enable `--autosquash` option by default.
>> +	When set to 'interactive' or 'true', enable the `--autosquash` option
>> +	for interactive rebase. When set to 'always', enable it for
>> +	non-interactive rebase as well. Defaults to 'false'.
> 
> I think a better and more extensible way to coax the new feature
> into the configuration system is to arrange it more like so:
> 
>      false	  - synonym for "".
>      true	  - synonym for "interactive".
>      anything else - comman separated list of rebase methods, e.g.,
> 		    "interactive,noninteractive"
> 
> 		    possible rebase method names might include other
> 		    stuff like "apply" or "merge", but I haven't
> 		    thought it through, so take this part with a
> 		    grain of salt.
> 
> That way, the Boolean versions can be considered historical spelling
> of a more general system where you can exactly tell when autosquash
> takes place.  When we add to a new variant on top of 'interactive'
> and 'non-interactive' variants the current rebase has, we do not
> know if it makes sense to allow it to also handle autosquash without
> knowing how that new variant's behavior appears to the end user, so
> 'always' that blindly enables autosquash for any unforseen future
> variants of 'rebase' is probably not what you want.

Thanks, done in v2.

Andy
