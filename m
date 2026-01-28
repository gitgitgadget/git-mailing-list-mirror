Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C32DAFB9
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610533; cv=none; b=ZbFzy14qaUI6RkHlgjXG55E9f+tL0O/8GAorDt5WnHYEcg2679+AFOh2st2WV8Am7B+JtAoVvSpv6vreOZCUkwgkygNnxA0V02pmOAj69DjiGkiu1ms850VIYVouEO1GEooWnRG2P4/k7ecvXcsbMu5mKRJpLRe8WKCXLKVMNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610533; c=relaxed/simple;
	bh=JXKXeJBSnSfk7D2O2kPJm84hMqZ7VXfcYVvYnp9RSqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDG/rdDuBGyfesaq/s6PEQAtaCbNIHTwEwkF36YAF58zmjDOL+zz5W8nAW0c67/FymSDApDw3wW0IrJYtuIu+F2ms7F0jimZ1Ldx4KDY1/RNk34IYSh0m62co64TSy/itU2fE7LOrcQhBy2SxZCoxxCS/7S0hM0vNO1MevYuIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LudCrhl9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LudCrhl9"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-894a2309a29so10256296d6.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769610531; x=1770215331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5e+3zPQ/IJH7Ug6YE5f529dkmtoRaM5rDjsKSOWGzQ=;
        b=LudCrhl9W5ZGWDonG7NElZVRXtWlEGdTiThoyXGPzVUsgE21+544HKW+LJrV+NMh4S
         xONIVgifm45drhErHakfQboN/OAqpW19jlu6rfSKggZVnw2MK5igbmyLJweNAEOMBCG5
         QHyaODcZtliOKonKonG/U3SylxSM0C67LKkD16eFzlV0+dZiNf4TOsXKyRaNbZT7pDQU
         AQjIviOn+pKx5ptYWmkVtb3dUE0Y8x2iJsN2hsy22YHib163EtFXqOssfXr7U0lJn6/t
         pncvmpG9CKy8lwCGbBZL7UZAKTI5GfdBzpoNoec4SD0no2l5qWRj/CjtHoTr2dhy0MDs
         1cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610531; x=1770215331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5e+3zPQ/IJH7Ug6YE5f529dkmtoRaM5rDjsKSOWGzQ=;
        b=c9CKWE1E3cJVcHMWPbsYVcKrjpW8FuAn+reNZCtFZe/4y64Z3rk8u8aJrODN9KH3+I
         jSVIllbUuua/nakaqL2Do/C0wbYiUhs8ePCVSdI2ydiLCYhBDHnZaYvmNxING2OVKJD0
         m08tCvEZoMyADtTg6VXI5GzIFcWsdWHdmLnVnl70Nl7DNmHbbo4XN9ZU9rGAegmkhrqf
         j/oI1zonICMk2q+POik3k6kblmG9iSYCgtIB9bOP6NQMApsWIZaRV+vTptEj2ezisAJP
         or33DewnzJ1u7z8DB0HMHNa7gamvtbMd6ljkno2ILwyZPvh3vPwzsxEVU0ZF2Opg1HJg
         6AGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGZUj0eSBM2ReSPj3El6i6WF6tQI6VN2kOjKy9BoNpSPH5Fn7/IRGguL0Y2s35AKYOz2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0WAR0a+d0A/SGsJpcTi2Hf/410Cx1s+VU6JMIMAnxwkbf6wT
	VERaheKJA1xEMBzszlw92YVKua9mLlBhUVyXC6YvlCJOGgMg0BPbJrB/
X-Gm-Gg: AZuq6aJooDeUhKAh6PrTbttxpuyStUHb2ng97jV9cz/EQWk54sakiwJFYybP1SbdYtY
	jxHLLoW/MAZOJqmy+4m623clyQn8P++rfXUaxQZUthuL3S6alOqLPdRGztC4zSiDJhdvDhZl3HX
	3UcSoNOVc66Ti8iqhozztSdk6fTngmgy2aOhSGQfAi6sjJnNMDlf6YWsF6nZGYZ1UNymDBCwf0o
	rMgoTmX9BVztaZ/5su30pMt591jde1/bWEao1XH/Mqg5yfTcZPYMMPLvYk+gK9MDBwUbsC9BxBh
	dlvpWfBXmRZnX3IP/rJbvIR0poOXNHVSYEMDfuoEIX3F6cS9HsHXbljwEp84sfk36nAP/Ypuzsk
	iIxQM4DHUjFMtCtGqZ+jGasJ4QmlkyxpMQ5J3z7kGM60hzlUZE2JBjtN+yAhiUCgl10/DZ4X+Ur
	eLde1VFbRv2dE1lqZfFaE7ysip31Xf0bP15qnJZs/o776zV6qa1WwqTFCkRlgdhVRLVwldIUzAC
	H8nDymUINEafekxlMPYNPHmU5uQksP4o9Cpk5YjH0BZtSnwmw==
X-Received: by 2002:ad4:4ea2:0:b0:894:cc3b:95a7 with SMTP id 6a1803df08f44-894cd2d1bfdmr66647246d6.4.1769610530825;
        Wed, 28 Jan 2026 06:28:50 -0800 (PST)
Received: from ?IPV6:2600:1004:b2a2:c7ea:f847:9c11:f011:f40b? ([2600:1004:b2a2:c7ea:f847:9c11:f011:f40b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375e1c8sm19452716d6.48.2026.01.28.06.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 06:28:50 -0800 (PST)
Message-ID: <c506f9aa-31c9-4c37-98eb-d60076e2e8f5@gmail.com>
Date: Wed, 28 Jan 2026 09:28:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] revision: add --maximal-only option
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
 <xmqqikctl3vj.fsf@gitster.g> <7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
 <13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org> <xmqqecngjp87.fsf@gitster.g>
 <f363c16c-1c36-4485-b1e9-22abe32b3a25@gmail.com> <xmqqfr7wgq1p.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfr7wgq1p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/26 1:08 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Interesting. Thanks for the correction. So we _do_ have a way to
>> get this information for a range that doesn't have negative refs
>> or other custom walk modifiers (and this implementation would be
>> faster for this case).
> 
> Perhaps.  If so, perhaps we can improve --maximal-only (and possibly
> rename it to --independent?  I dunno about this part) by special
> casing the logic, and then steer people to use the new implementation
> that can use negative ends, deprecating "merge-base --independent"
> (which was written to be a better "show-branch --independent")?
> 
>> My patch includes test cases that are not covered by the
>> merge-base command. I don't think it would be valuable to extend
>> the merge-base command with even more cases that don't actually
>> output merge-bases / intersections.
> 
> Yup, I do not think show-branch nor merge-base were good home for
> the feature.  We only needed to make reduce_heads_replace()
> available somewhere, and "git show --maximal-only A B C" might be a
> much better way to express "show only the independent ones", as it
> would allow using all kinds of output options the "log" family of
> commands support.

I explored some of these directions, and I see the value of allowing
a --maximal-only option to them in the future. I have some concerns
about them not solving the needs I have that this 'git rev-list'
implementation provides. I believe that you're suggesting that these
are other places where a user could benefit from such an option, and
I agree.

Can we delay such extensions to another series?

Thanks,
-Stolee

