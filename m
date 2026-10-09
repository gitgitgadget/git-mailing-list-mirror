Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9E4DEC1B
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552608; cv=none; b=uRfJRoFKOyfpp9JgQjmP3JKIDohHvdFvjbVqeVSxy/sdlvHy0SVvLtYxFvWictHl/0nuMJE4QC7LTQIKdqpA/JjLvpRrCHKnkAT4P4BVg1/tLudZDdSWZ8VBHPxhKRhLkWS6+Grm4L23nO7/Hl6bofBsVHpQVnJfxXlp6EurXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552608; c=relaxed/simple;
	bh=kof9eXf3m+/nD+TqFS74WkxUSwwKqwCvXkoALhL7Ikk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JnAYLL4I7/jx0Pfca89cVA5yzcKKmPwV/GTWi498uS3ElOKfI8qvXxOi+C3dmLl9QSek8QxpKsDqTxeauH4R4NCylAWuOCDbZpKGUT7CFJoP+VAhgt6S79FVY6MxZ+gtoFUOGTVxiVHqE6PQpENbIAohJ/XAz3xmlPHr3S+bjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG/B+zAW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG/B+zAW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso39664005e9.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791552605; x=1792157405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9tN4VPv6zXVweMAc2kC203o4h3vNma7DtBEd9QbAhc=;
        b=LG/B+zAWK1xjPTGamrRls1OXZ5hpYgI17YabvI54wxo1gN3kdUS0IjbwTARQG0uXdd
         oMdYKApuvtn4wxVw7qsaPm5DhMgW2VT1n16+u7WXJLhRO4FH8hgyFTNATKGPm90U4VXK
         rhrlORhYWYdGT58v1XpVZNR/1Xii3weoZrSbRg8i1KDTf2Vd3NzrJ4HFQ8tjQAC2slxi
         dgRnczlD5plQiWjPs1EOESZRguoGCpJTsJMtZCXOvbv6Us/m8EGevpRtK27O3gyNz9wo
         TiRm3IwUs8WsvpSSaSleOL0Myq/HGA++1Ek9R6ADYITPmOBgOXHcRO12tdmM4ZEMa45U
         iFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552605; x=1792157405;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9tN4VPv6zXVweMAc2kC203o4h3vNma7DtBEd9QbAhc=;
        b=DULk3TCO6cmAP1Q8M5yQKMiOA2Xa5ZPf7rlhNlubc7Dqc1pLARX1vWi3ypyhdwgbCk
         I3L0jLrCts7IxS01NkpULmcxaCrutIU1/qKBJgkoDx9QCN9SIL6npGIDyOZvyqsXrkjm
         7loYpghTc3d0dQfVEORf50ajRu2YhKvLlRBTwO1mNHIhFJbjke9b/SY3GMxn/JaW4MuM
         K2EK0KE2l/5ex+jugYL3UXQ1l992xshaH+sFoM7cD+WcNbvkFRFlF/CQZGjQZ5B2Qmwk
         h5jixlAQrMB25A3q6X3gQpontzwe8JTvPBDEjKsxBBV23AMIgOYtkamhsBW0itab4XH4
         8XiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM1+Awf52dysywwYByTUclROgmQvjj9gr0sy99JbLMHpG5nU2v/ohPx3Yx9Hik87BAGPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mKmZGFFL0aXzTp9ChtkuRxuRMIr8nFQ7aLcmcyuUaGTIRBD8xE
	6zkPplXAAMB/W2Dq//5EYMQMLeiWENoWN360ueKP1hRdG0NgAI5xclI3
X-Gm-Gg: AYBFou1cnY6yOIAKCqgzTTU3iNsxxUJiGRXr0ZvbLZbokIfq3owKu4gQbvKwR03ScO+
	kHq01lYwdKzgiWEIKmJ/wBwhrukcDSQaiqzEe2xQ0+o2Pn9d+rYfoIZPyt1RPbIpp/7ByNGAyx9
	BIBdnkUzOz7ubxmEeBdvB1zywqn3IYt/5/LevpZmZbxgOklrNnBpZWhHyqTRNzYKpd2HroURf2r
	G2E0qmTDs0bIYaE2eMfzv132qyyGj4BDvxE8eQAUCd3dn4GJ6pzATGiaI2IYHPyz0QoWme6G3jP
	z5OQRT9nq5BJlHYv0zMkcOKYR6aS/9X4K5/V1QtkwZaeVSyQDs2SqXzvPIbinyRcCvNxyZAQs6g
	ap5CgfG/T4YpAh/t5GqAeHgSP0mEk3eQMkGy0gVsGBPy26ssHbv7f+ipfmZubAjm8/0cmRZTim3
	OMT3siAIsAeLEP4QdHj/Q5ao/0hidvbAy/5YpVph56NRkC3x0EC8xciWsq0CYahHwxFyqHEoKqg
	JuB4i3Ar6aL7BvoJFocND1+5GS+WL3BcCXa1m6gQ3Q2zJSrqjYikA8xEtwKXac=
X-Received: by 2002:a05:600c:8184:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-4a18e4f2221mr27865455e9.32.1791552604956;
        Fri, 09 Oct 2026 06:30:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4a3b4asm90969835e9.5.2026.10.09.06.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 06:30:04 -0700 (PDT)
Message-ID: <0a63a10d-aa9d-4997-888e-2fda82802f59@gmail.com>
Date: Fri, 9 Oct 2026 14:30:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ssh signing: valid-before is checked at the signer's own date,
 and a missing revocationFile fails open
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: =?UTF-8?Q?Christian_No=C3=A9_Ramos_L=C3=B3pez?=
 <chris@nortesoftware.dev>, git@vger.kernel.org
References: <CAHGSfbZ_Q8Ujt3om0POapkjWZed1pZVUrB-mV-e+UjmPgCNvWQ@mail.gmail.com>
 <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com> <asjbyBvnFuYuE0CH@pks.im>
Content-Language: en-US
In-Reply-To: <asjbyBvnFuYuE0CH@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 09/10/2026 13:19, Patrick Steinhardt wrote:
> On Thu, Oct 08, 2026 at 02:42:42PM +0100, Phillip Wood wrote:
>>
>> Having waded through this here is a human readable summary:
> 
> thanks a lot for the summary, I really appreciate it as I already lost
> interest after having read the first sentence.
> 
>> (1) Our documentation implies that we check the expiry date of the key
>> (which is recorded in the allowed signers file) against the date the commit
>> was signed, but we actually use the committer date which can easily be
>> faked.
> 
> Right. I think there isn't even a proper fix for this as we have no way
> to establish the actual time the data was signed. I think this is a
> simple fact in a distributed system, as without coordination there is
> basically nothing that the contributor can give us that would make us
> trust the claimed signature time.

Indeed

> You may be able to create upper bounds if there are subsequent signed
> commits that you trust and that have the untrusted commit as child. But
> that is not going to be always useful.

Yes, on its own checking the signature just tells you that the commit 
was signed by that key, it does not tell you when it was signed.

>> (2) If the revocation file does not exist we print a warning rather than
>> failing the operation like the gpg backend does.
>>
>> For (1) I'd be happy to see a patch that tightens the wording, but we should
>> also note that the timestamp in the gpg signature can also be faked.
> 
> Yeah, agreed. This mode is only safe if the signing key has never
> leaked, but once it has leaked you can basically not guarantee anything
> via "valid-before" and "valid-after". And documenting that would be a
> good idea to not give a sense of false trustworthiness.
> 
>> For (2) I agree failing seems like the safer option.
> 
> Maybe this is another usecase where we can use the ":(optional)" prefix
> that we introduced recently for some of the other pathname options? So
> we'd fail by default, but give the user an escape hatch if they really
> want one.

Oh, I'd not though of that - that's a good idea

Thanks

Phillip

