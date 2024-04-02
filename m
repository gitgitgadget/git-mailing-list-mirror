Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAD12BF23
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070942; cv=none; b=AAoYI2OA9AqVurebNx8rKYPmV+wXNZQAaPdDDbmAmRYxXXcT1O9iS7PoYwVeqLPrmXpb/iPjLm/pMwCVvZlJ4Uif2Ebr8TSxrowXAzWWQZyOPFP+hUQwaO4WLsBQLhkhCoIBmXzeP4TTQV8y8GqVd3Oikq77ePYLpmI/JAZKLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070942; c=relaxed/simple;
	bh=lsG8EdfHeKfudi18ovM597BpnewULwAmgmmwHyqL7WQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=de430S+E3JHY8WquZSAjWY+dO9rd5TuRaeYGE4njsEPMxKNZKqGGJMO1U/+6BfppQXOnM7aJbcCPeFTuX8YVcuHOwBrUkozKXwqBMLJOgGss0eUgq8YthVoDa7LeZHN5eQPMDiviIRFlVcBWha4QSwRzK/zY7pKHB2KBK+n4qtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgHmrh7a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgHmrh7a"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41551639550so24231715e9.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712070939; x=1712675739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF6OEKZKsRr/cR5HbhS95keZf201CG6q4i/Y3XbqheY=;
        b=mgHmrh7amuvE/aowLdMefoxwCQUtGrqP4gaaq+vdkGcFaHZHXQH/PSDLM/MTlf0ZRq
         11WbBH9HN4X0BoLhBnWIXdNDyRnbzoPM1XxLq8W22c30B1HDu0HaBtujqm0g7c+xa8GP
         sMlB14pvoYmNJj0xNmKmi9xNJUY7nDOgTiTt4k2NBcV3iL6yc6giYEzwrdpp6DlogBBq
         gWIWnz2YzExe/3x1LeeZoqsIKjq46LIPHg9JScZpSJlcdCggkMT8PoYj75Wzu0icsUM3
         pK8E1I6OT7Cw6RgIHmpJnBqGwwEI5pIxTePQbsieTg04DhJyT64PLspJTDoyz+x0LZ+b
         KnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712070939; x=1712675739;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF6OEKZKsRr/cR5HbhS95keZf201CG6q4i/Y3XbqheY=;
        b=OoHyoaLjKaI4oqGNFsMRwJ6XpId5f9l9ZUm/iQpl5J3QhMgnpvXFi3Gun+YoVr1xo6
         JCWI1LyaqHpI2teXgj3Mr8vqtRIrgtSIntyVuia7lYtcU90EeBApY7fbSa/pPoSKjDIX
         cvDkY3p5JMTcG2GY/RR5snseKcVo3tHp2OwZZ1wmYtgPB8PtpA0nTXEkm9KLHIgquZIM
         NparLijcFU1CzmkMRgYyPfhXqNTb+RaUfqT9Lr0D9LNxmbNeWc625POWWM/+fD/qkaN5
         Lx31hAy344Q7mRPoPkG6h1CmFinemNCXwPn3rnZSif6K7b/EU5Jn21aTVPu4JiHFBGLv
         lQGw==
X-Forwarded-Encrypted: i=1; AJvYcCUTZHWN53a4oE1bE+/0eBdCSRe4e5ODieWO4GlHwoZ3VkGt7GIR+OAF7jfXsMpzUSZJOTa+7vS/KEzevbQl3V0zfme7
X-Gm-Message-State: AOJu0YwXISGfXaPgiMH+TYUl7H/RAM9DEKVaVvkj4VmZWzWNHxmFLMVu
	t9yP88alTXbUXbR+xtwKhhZUz0i7znnc3bmXLurLvuW/K2FIPxz2
X-Google-Smtp-Source: AGHT+IFEvfoOF9SfEHOnEnZm7dPjYkTEeNcSZJqFIXjZfZp/YzoaaRL8Q6tH5zR9FTM4Y/oGFur6GQ==
X-Received: by 2002:a05:600c:4583:b0:414:7198:88a7 with SMTP id r3-20020a05600c458300b00414719888a7mr9974617wmo.34.1712070939057;
        Tue, 02 Apr 2024 08:15:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r8-20020adfb1c8000000b0033e206a0a7asm14460214wra.26.2024.04.02.08.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:15:38 -0700 (PDT)
Message-ID: <566bc6ac-d4d6-45e2-9875-575e187280a7@gmail.com>
Date: Tue, 2 Apr 2024 16:15:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Tamir Duberstein <tamird@fuseenergy.com>, phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
 <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
 <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com>
 <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
 <740d1f1a-40ce-4714-91bd-1ba448e9d672@gmail.com>
 <CAEYvaskG0BBVr+nsQ+iof=AXu3dcQHx0aRRrKRrf8e_NFANL9A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEYvaskG0BBVr+nsQ+iof=AXu3dcQHx0aRRrKRrf8e_NFANL9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/2024 12:56, Tamir Duberstein wrote:

[cc'ing Christian who knows more about "git bisect" than me]

> On Tue, Apr 2, 2024 at 12:29 PM <phillip.wood123@gmail.com> wrote:
>> On 02/04/2024 11:26, Tamir Duberstein wrote:
>>> On Tue, Apr 2, 2024 at 11:10 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> On 31/03/2024 07:49, Eric Sunshine wrote:
>> Thanks for trying that - at least we know it isn't a problem with
>> rebase. Lets check if there is a stale bisect (sorry I forgot about that
>> earlier). What do
>>
>>       cat .git/BISECT_START
>>       ls .git | grep -i bisect
>>
>> show?
> 
> This was the culprit! There was indeed a ` .git/BISECT_START`
> containing "cleanup". After deleting this file I am able to remove the
> branch.

Oh good I'm glad we've found the problem.

> I guess the only action item would be to improve the error message.

Yes, there was some discussion about that relatively recently when the 
message was changed to say "in use" rather than "checked out". Adding 
the appropriate command name into the message would help.

When bisecting "git switch" prints a warning but still switches 
branches, "git checkout" performs the checkout with no warning. I wonder 
if (a) "git switch" should refuse to run without "--detach" when there 
is a bisection in progress and (b) if "git bisect" could be more helpful 
when it finds the broken commit by telling the user that they should run 
"git bisect reset" to clean up.

Best Wishes

Phillip
