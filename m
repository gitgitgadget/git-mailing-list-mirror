Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC743AAD
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214481; cv=none; b=s5ueO8kFzM4vetlYp1csjEOneOp86AmZDLcsN+DoUWwXv8u/kpjIRS9gmeOJt0topfFeOQ2b1fdn6AE7hf8zoF1TRWNIFTE45B+6fyf+fH5VoDnKs8taEzsNh20oF/GYc+YJYv4Y1j7pg/XgmD9X1D8tZTNfrAa26Rki+L1RnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214481; c=relaxed/simple;
	bh=86MsG0cUetr54+cn7pA3YBCAPoEDJsTU0nxpgvayfII=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DJe3iIZhDBWU1FDr5YonKzXgcgF4UMDpvADtATLpt/N9IEgUedqB+RfALmDD45G0pu8+ktZE3eZ11/9cqvm73ajfZ9ls7RLY9gbHVn9G1HOHECFBy+wZcgdIaiXreUpp4agL95uZy28xXM4a5Kke7U2bxrzm0ABfefDWDcdU9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDCORhTq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDCORhTq"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf2b218c62so27065071fa.2
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706214476; x=1706819276; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URe0G8rn3/JDtrb7Jre+F9VEznmloiyQ1JdajC9/EMo=;
        b=cDCORhTq4iuHVwFksnNvmL3WP3S12+8JYawQVIoI1xTYL1m0njxwCSRwqhFwpSex4W
         qKNLkmsBNzHW9+ulmoVuUlJ5IfLyoFpWv6q6ZnHaga5RM9oIG5J7R2TMCu1iAj6di5Re
         79KC2QV5OisVWrTd5rNSYMqWb3jXsg2wDNa8ACY/owK3skH5MNZLA7miGoPp30aEEC2g
         /5mCL2LTY7VuvmHCdAXYImZz1FeRRxU+6LFpDfWJfhDV7aXIRLms9a5oewLf/XZZaVY3
         ZP9FugoQpJLbx6b+M+cTd7R8f7EmCRG8zPWsh4IL5kiE1/Epme66V1or81aW+mjJLeEk
         3c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706214476; x=1706819276;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URe0G8rn3/JDtrb7Jre+F9VEznmloiyQ1JdajC9/EMo=;
        b=Bu1p0oSyU5mPJEm3DcLeLNwiHbb/czpq0/Jp+EP1CRjLL8SCKlxTCvfXZc0xUQWmR7
         o8w3bAtn2YFUpU3ByJGz6hyq3iI4CrhsgF4agYFJ5Vt3JlIlLk7EgYJXZWiybL625I1q
         orLR0Cy/cgcEn4U6J8LSlJUWe2+gUdhcW90gg4cq8SI/El0WSGHd1Wtki+WVt47pdCZ4
         /ObzrYrcg/cWixAuQbZasYBb02wUTJCqvpCqmKrjjcNclLP026kfH2e1aIBbMT1GM2GY
         /BGxA5OrcJAXWjD3G5Cj+GTL9hSDg/PciMLsUqbrMMukbTwUAXMoH/SF1WUd6JZ0C9cP
         l4kQ==
X-Gm-Message-State: AOJu0Yz5frn7HDzofYElLyjKSbrgy1tCiO9h5HJfD+zW3m55UbQu2QN+
	xu8IcKqSBQMXG0uta3BPoN2XbFaFCwaETpItELexpoJ4UpbtVHoE4SbmHC57
X-Google-Smtp-Source: AGHT+IGa8IKzfnuxjKC+EzUzxoC0z4lJSng4KdT1koKrZQXvCKe2RAiGL/XzoCkTCgx9XVTXwX7KMQ==
X-Received: by 2002:a05:651c:7a1:b0:2cd:2376:140c with SMTP id g33-20020a05651c07a100b002cd2376140cmr60029lje.57.1706214476041;
        Thu, 25 Jan 2024 12:27:56 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p25-20020a2ea4d9000000b002cd17747bd5sm375759ljm.10.2024.01.25.12.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:27:55 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
Date: Thu, 25 Jan 2024 23:27:53 +0300
In-Reply-To: <xmqq1qa5xq4n.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	25 Jan 2024 09:46:32 -0800")
Message-ID: <87ede56tva.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Now we are going to introduce "dry run" option "-n". Most simple and
>> obvious way to do it is to set internal flag "dry_run" and then at every
>> invocation of "remove(file_name)" put an if(dry_run) that will just
>> print(file_name) instead or removing it. Let's suppose we did just that.
>> We get this behavior:
>>
>>   $ git clean -n
>>   fatal: clean.requireForce defaults to true and neither -i nor -f given; refusing to clean
>>   $ git clean -f -n
>>   would remove "a"
>>   would remove "b"
>>   $ git clean -f -f -n
>>   would remove "a"
>>   would remove "b"
>>   would remove "sub/a"
>>   $
>>
>> I see this as logical, clean, and straightforward behavior, meeting user
>> expectations for "dry run" option, so I suggest to do just that.
>
> I think we are saying the same thing.  If the original semantics
> were "you must force with -f to do anything useful", instead of "you
> must choose either forcing with -f or not doing with -n", then it
> would have led to the above behaviour.
>
> The thing is, it is way too late to change it that way without
> breaking too many folks, and that is the problem.

If we agree on the behavior above for sane "dry run", yet you worry
about backward compatibility so much to deny changing the behavior of
"-n", then a way to go could be to introduce, say, "-d" for sane "dry
run", and obsolete "-n" while keeping it alone.

Thanks,
-- Sergey Organov


