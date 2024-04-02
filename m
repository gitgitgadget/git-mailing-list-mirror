Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970938BEA
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017372; cv=none; b=dlBpux2JyCbvOEznKjrOkXOafjjMDddxaq+b0YutklG9qEujpdirJ7TxhgV94sNWyjv8gum7bO4W2SU44fdjm6n83ybUNi25Xy2ISTxhxy4JYqzUG4kqZoCQxfdU7crLCgit9QEgaycuWede8SBit8RR/9XmhvYcAW8CuYavYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017372; c=relaxed/simple;
	bh=O4SLuz9J3+UIV148K2N92IJbVgrvgcZyW16wdYlQZ3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMiBf3XMv1TR2SGi8HMzWkBtc6GxTQy1Ymj6uQpf9BSTEvWxL5lnjiGOAxQ2waZ4G9CPVmudKfhQR6DJkQ9njqVVSWNkzpAwu5CnvATx7izsdGtgnmqCXoKnWEii+XDOM6CbtceDb5eN5VGJ+txAZhJGUuN6uG2TU9E8UvsY1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3UxiSn/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3UxiSn/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615110c3472so10352677b3.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712017369; x=1712622169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lSfDCRSvyzEmWE0VR6nSryEg3bI8I45UfIWLx6NpZ4=;
        b=E3UxiSn/16V1dHa8SGDqWnAz/C9uUDd8++cgFUoHfVFjUPwTHY19SvjlkfcIngFglc
         IcysuXl+4TL62wr08Qdbzt4qU4/zHJSBA2+FIX5ARlp7307qFfOhb0FTtd/SSEzZb4LE
         FghmMKA1qOe/eGD5TpIWAzFe/XZDHxiCVDCuiHzoIntOIYm/cLdVebEzUmn1QAm7YXNV
         YStIjGzvXgN8JQlNjHgAkZDDFnIbsVp8JQMiuOtuR1qUShOM57TrGlO+Rfti/mGddGak
         gFAkwJH1CRukhIvqns0BFw9WMZ+vE3ib3bSr53tLqqjniaHyPOu1rx0zU4pqjFrk7H8r
         PKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712017369; x=1712622169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lSfDCRSvyzEmWE0VR6nSryEg3bI8I45UfIWLx6NpZ4=;
        b=jU0Wwj9p2gkkiN4NXBZI3dXFRTitEUbrkKz9t4yddLA5gFTJB482WiNg/Jy5fmnoh5
         yH+K6xISYsMO/4s7msX3DLNnt8QqTFTWo4We7Ary85w4bIWOk3rhZ/srggA4Yrs8XNA7
         qiPQuBblH0iF/IUumZ4hNEv6cKapgJLlNh5CPfvRE7qSIhddP3BD4trmiZZBlAW8/2bu
         z4RIsMxnTSurus0CeyDWfkjoQtm6j2CbJKFMSbdPL/hIoDXTcm2RsTX/8xPiF5fmP/qF
         KkvFNKocFB/QANzf6AWxMgyatAoLWRzJJ4vfp+hwyvIpKFiKVbubxJCNoOQEQNXq8EXv
         xq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVPnYouY3onrZgiky7OngWMRwOczOJGD1kUwxq8aqJDvvS2L7uwwkQiNX/FBID1eQz6Yuz5Fyx8nIYxjkLacdueLGcT
X-Gm-Message-State: AOJu0YyzL07h1ud4Z8VwKcbjIMnQuCOxVaMgDNt6oATXUeCudsVua5hV
	RmgBfOd4pOeYVJp62JUQtlDIEuWzDdgG72nyP36zby3ASMaZ6HwRSf+OHd1p+dxoPKR+os3fF4u
	fpg==
X-Google-Smtp-Source: AGHT+IHFf5wHOIjnnWjaFCh07+bKWkyMoqJYHwWybJNSQP8uRjwEKTxgrxta3/SEEO/vsJkzO0pJvFemfWU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:24c:b0:614:2c5c:d275 with SMTP id
 ba12-20020a05690c024c00b006142c5cd275mr2923313ywb.4.1712017369556; Mon, 01
 Apr 2024 17:22:49 -0700 (PDT)
Date: Mon, 01 Apr 2024 17:22:48 -0700
In-Reply-To: <xmqqzfuc7muw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g> <xmqq8r27nhwo.fsf@gitster.g> <ZgPIEgFGVokYWc-H@tanuki>
 <ZgsoOnle3CC8DqUR@nand.local> <xmqqzfuc7muw.fsf@gitster.g>
Message-ID: <owlymsqc62av.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
> [...]
>> Perhaps we haven't been as good at advertising this script as we could
>> be, and that's why it isn't as widely used as it could be? I'm not sure.
>
> Good point.  Do we even mention it in MyFirstSomething docs?

I've pushed up a patch for review to mention it in our docs:
https://lore.kernel.org/git/pull.1704.git.1712017205754.gitgitgadget@gmail.com

(And, sorry for not simply pushing the patch to this thread because I
only know how to use GGG currently... Cheers)
