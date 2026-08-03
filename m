Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A883C1D6F
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748312; cv=none; b=P7+FPFp5ATXBkIFs/uIgGOt1Dmk57so5SiB6sOo5Pp45BhZ0yriPr8kWB4c6p3Vlw23Mz/LWkKYbh4iKLoVdtzB9fipF7DNTqxhu9HtgNsic8LLKrcfo47vRHrH3YVYVjryMyTw4zAnEpqqQBI9KFUbS8peIbJk5iUu5Fj5MGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748312; c=relaxed/simple;
	bh=/kRUInZ9KmZgyLO+Zb66mmfx7FZPMDgqqLIEzp+sb2g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c5rSaUb141niu05KvAcogYvWtlNgv5DxQvy1UNscT62decwCu/NrkDvI4FX1k4Qdh8HX366NM0nc1grnMGx2wfnF5SCEQrv31erQvxfjbbfU8RSlCiKfixGdJyGWamg7UHkY8nrlXlWx0kQS6w9RTpuF1dQwil7j6HHxWh9yuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp6tDkWg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp6tDkWg"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so3512492a12.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748309; x=1786353109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLfkUqYUFUufChPJY1ekYz4gq1wytPbjGFS32sZxlEc=;
        b=Zp6tDkWgFoxDgANRaU4cRuKz5GpPPneBMzApkggZx/+Up13oo3ho2u+3gH7CY48NWs
         NoPq0lZTFCh+OCGFX12VIS7RWK25vh0on4T7qLVXUD1Ky3G+J4AUP3gfwF/xO4pf1YuW
         K2viRqTUdRsRm0t22lg/eJdtqrM3iLQpcA8TJo4xAuVJRZHHrutyIbgmOPx/TFGXSYnT
         p12ufC77eqvV85zYd90EOg/DyqT/mjvRb9Rk1kpN4s1OUDShMFti0QVZa6WNdF92a2R3
         Gcv2F9O/99NcdmHbg1jvI6QgZzZHIEyxLnspbxCKRSqK1HI7ililRJKdtSGZf5eBFYIu
         mN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748309; x=1786353109;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLfkUqYUFUufChPJY1ekYz4gq1wytPbjGFS32sZxlEc=;
        b=K70JGgbrc/kiz27B70W1jjOE9lyJXbmIEYNLNhIX5aNZSD7Zk8N82RweVkTtc10mXx
         Jym7qpxEGHUkg6fzGW3yI3Rg3xJCEdxJCxD/6HV1So0fKAqUmztV5ysHWEtB/sn1AUZr
         tYbUcZwig5ibiMZsxU/yF5PeUX4ZQKkiH3AAwSjFh5h6VJ+A4uUshc5BQ//GxD0pDRrl
         MNiA+4kiWYsgsHt9IToaEUpxLCM8pCQXaufIczr3/cv7AUS64oWVypBt9WG5OYiR8oPW
         jasehCPIQvLMQya4cAATUlaF/8StTmm3+2U9TxAASgvPU4Iz0Nds3M/L7Vwber8F6Q0c
         p9GQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrs6lOnVz2DFayTaCc7/LftzLu88Ws5yUquB4QIBVamqeLHHcr6MlYyPpnWRi0ydhsrwW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQsHpzkur0CW1YHCTazCzNejPFIuYL+Z8zujIhakXaQEDj4yj
	zx+VtC7sbfGdIYZg37Kz8+9IRLZ+BfS3iFkyn8IithddFwmnOWBbz3vR
X-Gm-Gg: AR+sD13Lj/+oTKxYPGAw3epk351IX8P4JnltMkTdzhaFRBjXUI6X+gvQX9J7cVx5Hep
	hR/DJ4alwwHCLzT/JBFjO8/B5MDhp2rlBXwc0beOeDU+IULMEe5BKM/72mO7DxV954T6oix7Edx
	ZxzamfU4I7ECLo5g3tVBu6O0MLRXOKTWOQxWNpHgpJH7BFL7IfvyrZRBeB7Ky/gOwWr9SFxi2il
	Z934StBDHa3ojDteEn423SqmHYXOUAtKB2O0iRZIwfarTj6lcdlqIHvtH5aWXgfOZGjdjXdYfCS
	Z70CFj1lJkG3MYtd1/fOiY/xvO3sjVmAL6VBHmhQiZZ/BJcbG10IlRUfwZN9yCg69bSo4LdHEAp
	HL3QNUtOPjFqUGmYIg7Gy4eduZUz4r5VYnV/8Fu0mX9aeu+7732Ookgi2ydpMsKMvh8nRYO/La8
	OXcZ7m9am8YlpPMrXphEfMnL7RmRThoWoa/HZcDJYjaR3h3epN/fAJAdAbFsIJ7HgC65WRgucxr
	L0qzM+b5oRIVPQ9XLxhStEGRc883nratnrF/9KHG10=
X-Received: by 2002:a05:6402:44da:b0:6a0:a5c2:c592 with SMTP id 4fb4d7f45d1cf-6a0a7c6bb3amr6347613a12.5.1785748308939;
        Mon, 03 Aug 2026 02:11:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a09a1sm4864468a12.6.2026.08.03.02.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 02:11:47 -0700 (PDT)
Message-ID: <ddd0160c-7f4c-41c7-855f-58288db00050@gmail.com>
Date: Mon, 3 Aug 2026 10:11:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 30/07/2026 07:11, Harald Nordgren wrote:
>> Without "--reedit-message", it will happily discard "amend!" and
>> "squash!" commit messages even though the user creating them is a strong
>> signal that they intended to use them to reword the commit.
>> "--reedit-message" is a rather verbose option name which does not make
>> sense to me as we're creating a new commit with a new message so we're
>> not re-editing anything. I've commented elsewhere that I strongly
>> dislike reusing the rebase squash message template for this command
>> where we can squash fixups into multiple different commits at the same
>> time.
> 
> Should we always do "--reedit-message" then, i.e. remove the option
> and have it as the default? Do we need a "--no-edit" switch then
> instead? Maybe not, user will then always have the editor opened and
> they can save and quit if they don't care.

I've left some thoughts about the default in my reply to Matt. Whatever 
the default I don't think there is a good reason not to let the user 
override it on the commandline,

> I'm not sure about changing the template.

I know you're reluctant but I don't remembering seeing an explanation as 
to why you think the rebase template, which was designed (or more 
accurately evolved) for squashing fixups into a single target, is a good 
fit for a command that squashes fixups into multiple targets. As I've 
explained before my worry is that we end up with fragments of the commit 
message separated by a screen full of commented lines which makes it 
both hard to edit the message and difficult to get an overview of which 
commits are being squashed.

Thanks

Phillip


