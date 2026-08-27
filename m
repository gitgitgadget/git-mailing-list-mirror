Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46C490C07
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855055; cv=none; b=M5MvYrF7u5mteJC4zMiY1ahoolrOfGBda0NxutqLKdwUJJTGMBMwQEVrLY53OfWFs5i+Pw3nWqhma0LeCKmiumeYUGTQ2m5qzlNlWb7ytzGDR3HT7HvHpGE+Vj/i9HqLZKT8KTPtCCqgAk+FYWpLkAXOmJA66kRVyq9bUhzZXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855055; c=relaxed/simple;
	bh=y91j5sskEe2AnlvJ0uAT4FyF+YEMvHN+Bf3futYPdZA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Dw0H9YNj2GT4jf5iNKn2iftS6F9hu1l46L8ljBpe302ni/TTy75pLsr8cQ1fkzlGkN6ZdvWEKtmtgQhBbJuR3B1fke0Gy2UJPY766YXMcSIGXP9339JtpMk9eE1Ey3LBEayAs6aTv+ygllmpu7jMmOF5BzuR8q9JzdXkII077uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omMobps5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omMobps5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d560775ca2so1497965ad.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855053; x=1788459853; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8loQPXqIQFzEyHDqI2I2/zMpEJ41V6VyxPp+66l/zE=;
        b=omMobps5wrLDB7iFvgABdHfV6l/ECOQYBkZel2npaK4UAZ3GU6WX+RAKt3t6jSYTOQ
         BzTcMt3C7jHqbY8nv3PkgaolgibJz2nlwupOKAdtaFNtGjZvRUxbGd21CZaTX/9MVawC
         B1jpeM4FxT8XmL791rNUaDC1qK6J3L4v+khxZy0QNz7FKgSAXB06Ve4kaI+SCLA37uMM
         uL4c6jOtnftGGOKVaS3tihfZCyJ+cEOkp5FOKywMR8N6XQC636zmCdkb5YkiWV60z3hn
         LB6UOqm+YvroW/mWrO6snS3JvKjNn6Eyhv7GX59pyacXyQ1dB4WU3vt+5qkAl0JxttF5
         RiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855053; x=1788459853;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8loQPXqIQFzEyHDqI2I2/zMpEJ41V6VyxPp+66l/zE=;
        b=Bx476GvahV99as21uvMOENYt1yxwz9LDGYD5QVEf5MAKA2MdH4quUmLDa5y5goHTlE
         DQXy6DQRdP7DKIq9CuAyDtd+1QA6alNyLRg94e4KWzuyZ10PiMd0SJUf0c3eRwGKIsH+
         1VnHsr9ckHxZuTkE9jnQc1UhDvRMNSuYEi/mh2fWbO07P4wKFbO1zmid5+pFJlwb14j/
         MbpjQLSk3LyVfl5yziuN27ssMJq2S1hySugVX4JkRa/tJ/3U7z4zAFJFhfoJtcUo8GV1
         cFS2QYBrYW/juwSrCzF5wAx5287dnrwpXUIgrpmCtxDQJpL091mOdeeHUqvY3uEJE1T6
         3ukw==
X-Forwarded-Encrypted: i=1; AHgh+RppF44r81rnvVsgoe0OIx1tCvesu7tQ+P6A/8QHvuw1BDYHtd9UtQTNm7noR1940nykZME=@vger.kernel.org
X-Gm-Message-State: AFuF++mvoo1mFlK+3BSOW7zFPqQ43iuY1H/+5fuvm/G2E0f89eg//Gxm
	kOSGx1rwtJBb5EYQIQ1DWNjklzBSaNI4UiGwmIBcMg1vb2kKTyKLoRg9
X-Gm-Gg: AR+sD112LmgDohp0LNTtyJP7aOlWy9VVMdGXQs17MqNblYaSGTJVVv1kEm7ecW65t3M
	rqaDt7NxZjLFbM90Yz7pcS6uhGyKQkszd9OehP2NNbrHqP14cjzVlBVUVWvWZanQqMpAESG4ine
	Dw8XQLzesrKccyqy399YmwbsqP8KjvONdkhJIIvoKr0FF7rZb0B2NFQDfk+0iMThiE7LJQIVBB+
	ZqoGBbbozgpvAwEofFNe5GtAIZPeJQ9CinniaYzjtMl7XLoW+mGgs2KhpqNYzwkch0HFWPybb2r
	bVuVrKfIYZCGxel4Ft3xEsXLsx+FfY05VR6Eb2Q8H3va9XeWPiR70uqbEXFJqGcKk2YeZcQtzI6
	EJDHsZzsWcrvc/ykbddr2IxeVSv3oaFBRoHrF+bEUgZd5P+pSD9cDOcmQ6XboME8AAXBfM+jomx
	AnYE2kj3bunrI1dvyF9eTDFV7oxqz/DW9hpdXxLAurjNSjIa4jkvI=
X-Received: by 2002:a17:90b:54c5:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-396d0e5ccc7mr2241855a91.3.1787855053322;
        Thu, 27 Aug 2026 11:24:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:907b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20036sm32056764c88.5.2026.08.27.11.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 11:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 11:24:11 -0700
Message-Id: <DKZXQ0ACZO4D.172D72QO3E3QF@gmail.com>
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Elijah Newren"
 <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash!
 empties its target
X-Mailer: aerc 0.22.0
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
 <xmqqh5m494yh.fsf@gitster.g>
 <7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
 <DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com> <xmqq8q6jhtws.fsf@gitster.g>
 <DKJ2CZKJC6P0.VHLMCUDH6Z44@gmail.com> <xmqq8q5seh5h.fsf@gitster.g>
In-Reply-To: <xmqq8q5seh5h.fsf@gitster.g>

On Wed Aug 26, 2026 at 1:55 PM PDT, Junio C Hamano wrote:
> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>
>> On Thu Aug 6, 2026 at 1:32 PM PDT, Junio C Hamano wrote:
>>> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>>> ...
>>> It has been quite a while since you received a reply from Phillip to
>>> the quoted message above.  Has there been any progress to share?
>> ...
>> Sorry I let this slip. I was waiting for the work to be accepted to
>> avoid rebasing on top of a moving target -- I am still a little new to
>> mailing list workflow & I have been using b4 (recommended from Linux).
>>
>> I will pick this up again soon.
>
> Any change of plans or situation since then?
>
> Thanks.

Sorry for the delay.

I just published V4 but I see it attached to another thread on lore
(I migth have mixed up the threads).

https://lore.kernel.org/git/20260709-fz-autosquash-empty-v1-1-84cb494c3613@=
gmail.com/T/#m54a4af96c468c4f2b94fc51f10b7d8325ae62654
