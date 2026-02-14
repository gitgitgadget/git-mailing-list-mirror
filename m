Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEE30FF30
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771051674; cv=pass; b=Fs4RS5HJrCeBhGE22H9/InGOZdkNdxy7pYG7Yg5ANGPCZY00yNOoE18ouqSuxGU0tdNaoVl2WH3OVAhCGrqbg3ptvbneU93kyneG8F9jVB2hPZDSV6kmnoWoTa7wKl6TplBHT8KaSp3ca8o+vqGayxFhJEuIe5iVRkTueO/6iXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771051674; c=relaxed/simple;
	bh=vxt0olA4SqXhDBKY+tAJgjdMfDJSFksPvZ6l4o8aKug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghqh3vvF5JIJJ/3P4my368KfTB2HG2w8xOl4A4ubIdV1iC9sH7lBqdT4MXq9GEItUYuNF7TWpDmw9HQss+8auPAaHKhlVib43/wO/Rlpt/EOyJESHZbK4sRU10BJW2rf++ctIUPLWo2vrdeOIGLniZks1RNuisx6J8Dj+VV83qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRGidBmv; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRGidBmv"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e5ea93a1aso1341488e87.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771051669; cv=none;
        d=google.com; s=arc-20240605;
        b=W3uHX0O9HFGK+LMeEbOP6ZZPD85iWzTr1dQstWAFfEnnZTcYUMkuKF3IEaNdMhcY/B
         T5E36fw+1oWkN4Ak/uIXB38RrKOOGN5w7hHCvAufglQDnCziIZBqCu0Pv7y49Cieivvm
         ELUDh7+EPKSfEaIEXUuxg2l8zrbxLcJMnnC9nDctVDYTZh8+7ylJg7rNObo8nXbnXD0a
         fbMQd6sEQ9dF2Wckt5q+A4Vpf+QvenJjxWQRD+Xhaxg4eQwam3vxLqy4uwQtjePK8Ups
         MGvwg3uCbq3C2ByaDGM+wG5poYVpsON+JF3VOPwc8J49SLoDWrTvfoCoESzIR4umr1Ml
         a+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vxt0olA4SqXhDBKY+tAJgjdMfDJSFksPvZ6l4o8aKug=;
        fh=HjpZdbNeFHD9mDenQtU5Td0DDcuytoUrs/oZBl9FPuw=;
        b=bQhwGqugXVzX7v5v5tOSDdQ296RjrFfG3nWjdnXSXPQ0gyo7K/H8U3K5SjqUPuZbeX
         7oaYXzPRduWzR0oaQWPwzalZzGfv5LzQnuqMLolGT1AH/zISOHCclSG5gPIrqYeLSb32
         vhANyjp2nlzjKMJFMvhJrKQ+9TbuymgpZ/OeZ9DikylwGeaXCdbaZTzmH6d5lrR494qA
         XiqiD/yi0wY+ebyAjk+sR6jJxcBHkySDvkvg8UFHsTs+eDtUQg34CSlbq/bCkUmCULn2
         EZOp9ofeCAxPyOqbtBWwlclEbTasN4uG1p3bKMmYipSc6EGuIeG4Lm6JuJ9LRsZbuw1L
         0fiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771051669; x=1771656469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxt0olA4SqXhDBKY+tAJgjdMfDJSFksPvZ6l4o8aKug=;
        b=SRGidBmvkhID6O3g/G3AV/sn7O6zuKHhRKWFdJkPvTlB6+amCq8FbKH4ADFT0HUXiT
         IUOthafXjpsuuyL8g1V8o63eZqINzvRF5yEKAd80jQgNoFBQaqRfLR5R7SxuCCbjitKl
         m5i7v3CdPoNlCJH+aaj2RVErBGk/RKtk/LzqJvELpT0amNvyUo8wkNvJIhmyA7pYB+6w
         295lpSfiFqzS9Kr1ts1atPLJqyXvYkZgXxfqA+0IdB7zIgnsMTCCpjONaSKpNnqkV4RY
         FcVZnCW2RR0Vyao/+VZVGo0eXqBFYv198yfyGBM996p3BvZdkvRZuYChHqctKY43/jFk
         Oi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771051669; x=1771656469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxt0olA4SqXhDBKY+tAJgjdMfDJSFksPvZ6l4o8aKug=;
        b=tveo/U3iYS8lHIpFpo9GbK6usKzcpC5myGb2XRwUQq+VicLxKY/xBxvLJK7glSvFtl
         Gn+uDyqGZBeeNJDRnPQBqEdcR6uhmcm9gQqEIvc4yhpsa1ojDK4E08VjhoAIYmlqepWX
         ifgnqZLPQoY5amG7Bqd7dyCKGxVMwQdjivODFRwxKSv/cVM9+YPPAT7bUI8dG1AR8sru
         QXwreJoeKEf2YqWmgf/APuLgqRaTuU0jleXvUAg1JDD0dAC2A6A7FNrQh8kcukoFMOZ6
         SCSosWqr3s0WuDouwnfTmwkiDNYE8ciJHW+ehuthc80uR1Gdz7QmTe1ql9lYroS56DQT
         /PxA==
X-Gm-Message-State: AOJu0YzgKmC+CS+ghFFKnlN12+cQbHocoZqDz5vk7g+y7x9bQIOaOqTr
	4CeyIV/npzZinHM2AGET2d03hC+NKK9yDtlPTPz/A5aHGILouvbKY41qwZOXgO1E3J9mVWl3TpN
	Fd9kcE3T5K+fFxWr99s9MZ4P8JC1SIVg=
X-Gm-Gg: AZuq6aIvxeyRIWwUN74RCHkzFUt2qJTCbCGfzDM2G9gu1E1PdRaBzlYIhbcV0o/xT67
	wHqHWVTmMhSQ2+cXNBAwFC42xr/aWwOMwG6VP6vlMfteTyVCX3Aa+TLE+s52j4aGrL4387h8kkH
	JegJT2Jwo2KDW11U55QbZeHnlXrWde7EKAXJJU19nbdAonc4UqHTmUmyOke5fzglG+UMIBFrHVZ
	WsWwmBNtaV05i9rNlrfsmxn9IFRUMUtSYo8indb5+CqINokGxzN5eeH9lzacX2qdKkKIoijstNr
	CD+dX/eJE9nSiOnm8VrVUEr2gBbcSFJY6j2UELCaMy9Y2x3g
X-Received: by 2002:a05:6512:b27:b0:59d:e774:db0e with SMTP id
 2adb3069b0e04-59f6d35bb22mr590547e87.23.1771051668408; Fri, 13 Feb 2026
 22:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
 <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com> <CAFNBzOckR2yfGvLMHm0VZW+iKJTgFxzfxQAskdBV2HQ_3yXggA@mail.gmail.com>
 <03F6CE03-751E-43D5-80E2-E799D97B09B2@gmail.com>
In-Reply-To: <03F6CE03-751E-43D5-80E2-E799D97B09B2@gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Sat, 14 Feb 2026 12:17:37 +0530
X-Gm-Features: AZwV_QgCw66jWUTuh8BRw5ww_wRZ2qxbaGh0dMIxkFq2Pxmzt-N1KrrzQbfYMis
Message-ID: <CAFNBzOecmfobNTX_j+3E60avv=0XWG79KPc5JY_+kPqLHn=wdA@mail.gmail.com>
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in read_attr
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Thank you for the clarification and for explaining the mailing list convent=
ions.

I understand now that future versions should be sent in reply to the
original cover letter using --in-reply-to, and that referencing
messages by their message-id is preferred. I=E2=80=99ll follow this approac=
h
in the next revision.

Thanks again for the guidance.

Best regards,
Ayush Jha
