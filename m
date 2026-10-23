Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763365;
	b=dOeSsaBfhdIGcntzDq8LHWmjSbBjqQmMBnv6H38XIFaW6+M0JLPUjZxQkmqoW9fN8TNy
	 fZ+bFxYIqEHQvdqH8VRw7uE5bw0yc8UHzj8LGKrF1SvbTK9nDKhHOwEdW6lO734GnCp4s
	 U9cLJ4/rWTZgoP6bIq5ZH00PaDcMLwaRwl2/Ce3hOlFWHlucb9ZSJaRlJIVMWQMSMsb9A
	 1/H36EO+ZR1VLf2k0RFvdL8B+/LZD9HWiySKFqfLvPNnemj1y16wKi8ZH3D7ArMQ2PlMd
	 PMspyBd03xNyBY+hXhUrEoaUWPGT0baFCSMrhmtQX8om53eX4kzm29/GnPlJ2qqiAhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8fast0KZ4PtLTfSBOkcNM5AeOux3um7Dxw23AbAi1is=;
	b=G6LKkQJUgzAlqYUQ7nIQtU9Th1NyION5kWthd0P1l1GnMEAgjGRmXS3G8uPYeGWPDVGh
	 At9HSpcjQzqoL+D2tc7dRQ0rFgd7+VGU9Msjy1NIQn8J4BuAE+bMFpTrMxt+QOyM+I7kg
	 3svm7aStIDcV+pNmxwDhk9pXlNQq3r3nr4oXjaPrFI8YMAMD7c3lMfybBKZ2YQleL0JO3
	 fZXvYskUZw5W/f0UR3z5DTU0VnjeneOnZWO3tXUOpkHWiiJOGLwRPw6sqt4O+iH0c4dKB
	 ED85C/brvJjphB5BiP+JaQ1H7qJoEiZqSur3UQSTJKKxIU13gkjXI9AyVYN3jB7A66w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n7biKI5A;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D46606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D46606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n7biKI5A
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20c923847so7779665e9.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763364; x=1793368164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fast0KZ4PtLTfSBOkcNM5AeOux3um7Dxw23AbAi1is=;
        b=n7biKI5ALcdxXTLYtL0x4ohjHMUUDxnMpt2txo8qbk72bJEDE8oBwAicE3gmBVzljP
         i4vnqC4D8DeG6wHjuXZ+xOn9ChkAaTKiQRQUIU9/Ee8scNJImbahXYZwWY1mjj82vUfC
         I1sBA4tvQXjQ3E7+0Q/PE/eXzN4djD/F+rI5jYQj5iWLDiSt2tZ5vdj1vYdd2m3SjT3H
         8AvAR4GrJhxF71zCQ5EJBICU4I8mkqZlcRGdNUnaXgotC9mo9QAGXbXlEEn7KskSxYUu
         5/1CQ2ZxdR7IRUeqIylX/sT6yA5ppt0piD+Ku0WkzOLAMBT717w5wx1TqWpATTDmDKRQ
         fZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763364; x=1793368164;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fast0KZ4PtLTfSBOkcNM5AeOux3um7Dxw23AbAi1is=;
        b=BGjPBY1RKv4dNoF8HcRtN5dZedVTDeg9rUa44oi1lW9C+VBlSYtfcwt9uiXBdz142a
         HcVEjvBJCNzHbVhW62Mez0RI5tuNZ7rleO6g6lRT05FsXszqg3CZjlfYEV+6lvF+Xd8t
         +AfFHwfKo/2ac5DXBUFZ2VcZ2uF0Fp8WY7SBM76EpoRvl+p12DwlUzyI0WhMDcRCt1gr
         IahJfSsxI2HKtQoWOjr65nYRuOlLwWMEc3ZEllkxs6wJ6bN8sT7YTUQS4BatX8aVPzdC
         bABSeLZlAdTiL011dUcFmwY2DuCA84XsOonrzAvUfX4fxj9Iv54HvLJT8lZJQ9KLyato
         F3gg==
X-Forwarded-Encrypted: i=1; AKwUvBwCTaFmBWNPlufPoBZLsHJyjrcVlYLGjoDtFafTwHb/EvGzhB+EzVB+OCMzEBPc1H4wDEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIfgFGLEDxMkugg6ldD14m5GWX0SZo9PMCzn8GA+UmKiyExQgp
	5t3DIw7D0XKmmllEzYls/tqvE9HJLzAG/8glOmlCISkinhEWfvkqCkmM
X-Gm-Gg: AYBFou1NHuilCjKbHxNsF40+yXcDUFbwbdKEIYfwIXT64XP6sC1HgnypB0JG0le1H8l
	8QtncoMbnxNToj4hzXKn5pNopgP2SluoAnhPgxBjUP/BZFX2g760nHSG4rhXBkF7dHGP0+C/Jue
	uZEtoyHZzjGZJzMNQfjySdN6Q0gmeEXTK0wtI2zfTbMSp/hT2YkHp5ZAfFJpxfBxPxDa+U7qNi9
	mNpmtbEu0DxMKUfFTQ7oCZyhI4N1YeMRL59U8u8FgU7fN4SQOpMJrD0AxnYIa+GNU8SIqVrt61x
	uxF0wa4AItrD7+k7lI77ckx3qV9hT1nhqDBCaT+0foy/Z1GD5zb+vNDfiWG4E8V1q3+BF1Kc6GX
	v8oQS4zPli0jOv6SjrOA2c/BkytD27fwHB+88mXreeUNw3zepEVcqqRnzT9RRx3fHG20EeCy0s7
	M+R/fr+mttCDWhlJ2KAqf4kW3+VssIF0P2hZoy7ax/fQ8h27YQ123pp1ZhtDF6AGyTTOPEUkEzO
	n3GOTKfyja1HWg5QplUTLSajOwJiXjnyh43W08LiD8uhbjlc01hzscoNlIUvNNi8prQgDIrfxgQ
	lOe519meCW8VNWLTak7SX/OqxzLCyVLj3A==
X-Received: by 2002:a05:600c:350e:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4a211c48ccbmr44171915e9.4.1792763363441;
        Fri, 23 Oct 2026 06:49:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3802610fsm5312235f8f.14.2026.10.23.06.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 06:49:21 -0700 (PDT)
Message-ID: <f192e10b-c7d0-45d8-8f67-21383474d16e@gmail.com>
Date: Fri, 23 Oct 2026 14:49:20 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Documentation: propose community voting process
To: Junio C Hamano <gitster@pobox.com>
Cc: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
 Justin Tobler <jltobler@gmail.com>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4iedc99a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/10/2026 05:48, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I agree we want to include those who contribute more widely, but I think
>> restricting the criteria to contributions on the mailing list where the
>> development of git takes place and the impact of any decision will be
>> felt the most is a reasonable place to draw the line. I'm not sure how
>> easy it is going to be to count reviews - does posting "LGTM" count or
>> do we want a more substantial contribution? Should verified bug reports
>> count? - that's also a useful contribution to the project.
> 
> We have patches focusing on documentation as well.  I do not think
> commit count necessarily gives undue advantage to code contributors.

Limiting it to commits does make it much easier to count. Thinking about 
the way the list works, I suspect anyone who would be included by 
counting reviews is probably going to have authored sufficient patches 
that counting reviews does not make much difference.

>> I also think it would be sensible to restrict eligibility to the current
>> set of active contributors, who will have to live with the consequences
>> of the decision, by requiring eligible contributions to have been made
>> in the previous two years. I have historic contributions in a couple of
>> projects that I'm not active in anymore and I would not expect to be
>> able to influence an decisions those projects make now.
> 
> But do you care about these past projects enough to (1) notice that
> they are having a policy discussion, (2) bother visiting them again
> to learn their current voting procedures, and (3) actually cast a
> vote to help improve them?  You may not have been active recently,
> but if you care enough, and if your past knowledge of how the
> project works still applies, wouldn't the project participants
> appreciate your input?

As I understand it the voting systems that are being proposed 
automatically send a voting link to those eligible to vote so I would be 
aware because I'd have received a voting link. Having a time limit also 
limits the amount of admin for the person running the vote, for example 
handling messages from someone claiming to be a past contributor whose 
email address has changed. The voting system is only going to be used 
when we cannot reach a consensus. Having seen how much time and energy 
people, with no real interest in contributing to git, put into posting 
to the list when we we first discussing changing the default branch 
name, I think we should be careful to limit the potential for bad actors 
to try and derail the vote.

> I would recommend reducing the number and complexity of conditions.
> Immediately after you say "last two years", I can hear someone else
> arguing "too short -- why not three?" or "too long -- why not one?".
> I previously mentioned "topic count", but commits are far easier to
> count.  So instead of requiring two topics in released versions,
> perhaps requiring five commits would be easier to implement and
> explain.

People could choose to bike-shed over any aspect of the eligibility so I 
don't think that is a reason not to consider a time limit. Justin has 
also raised the issue of restricting eligibility to current 
participants. I suggested 2 years as it includes regular contributors 
who are having a break for whatever reason while excluding those who 
have not contributed in the recent past, but I don't think the exact 
number matters too much. I don't have a strong opinion either way on 
patch series vs commit count so long as we don't set the bar too low. 
Whether we count commits, or merged patch series, it is quite easy to 
limit the date range that we consider.

Thanks

Phillip

