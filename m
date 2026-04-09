Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597533090CC
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762544; cv=pass; b=V65UlW9Rjg6zeFY/oeCvc4fnwSX/7G4/8RQzDHKb4aH3SZVxPQppkr5TZg/ztHF3uXcwHxrxu5jec9saNuVchzUp7nC+k9AX/P3d9CLg7T9305qOLM/XdjuONMxIOLhXWkrXJiy6pM1xYy3RfAP4NWNKIpjtJ5t4emuRfGsQuAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762544; c=relaxed/simple;
	bh=XxfCU7pXpY3Dyi+84nW0vbFQxH8kq5YKGammgBsEsfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1mtXjpFjYCyWG+cmsW2YUV+1nRAueDQRgDIYq5nazuf6aAFcOVINMu1n9Ow4WCNYB/cr51m9nYfBLt5BM9r1m0i8FjCcN9cCAWFfczTfB5ul9/anYVLnffOG8fkvgCqTURZc14d0PrtGFvIJtdoGrLx379k/Ktlvf6atuBaWgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhXOirYK; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhXOirYK"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2cc4c693d59so632924eec.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 12:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775762542; cv=none;
        d=google.com; s=arc-20240605;
        b=gvHPnwhaAzsrOexKrisHcd4P4+picmyES1c0GmvlHdOSUlkGg3KMb9N6v+C6khNOnO
         IEiF7H3d5qmMSQ1p92KyuhjVBwVU38j/Ue+Vv/th25/QjkHNRGD8DN76MW+uzWTQb3nR
         +B4bAXP2uZlfBpVtpC0dBCUMRM3thDXaQpGERyIr/mOGKV37H9kTR5wB7BFya+fdrCkM
         ekDzlaaVKFcsM42K5T+gAErem1B76x3F005Y/kClSZk8kUSTEXkgANK6QGrMqorpBG53
         k/3vRNVkIalS2P86bQupT9oa1WEilRKxNrf4Admn19XKkifEZ94YExczT3hn2vqcH/F/
         VwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XxfCU7pXpY3Dyi+84nW0vbFQxH8kq5YKGammgBsEsfQ=;
        fh=Nt2TKoOUXdqRL5MATIGym57WUmcsRz13M2/xUyPWXLg=;
        b=UDq34SHcq6IsCvvw/4MFIiZJ+uFRtvmKup8ZDZYJFc1iDLWjmKJotjtacIonvL0PeE
         rrVgSSFtqmgeMc+Wdkdx2yCxDoSOWRWYddtBDjp5mrKCQ35xdZ1/kol8jyUdgAo9K/FD
         rAIbq2XuKoAyjn5hP4aaDI42BWFf3GBelfpM93b7FBhyq+A0xBfzlvhT35P+1FAc7PD9
         BAybKBWq8fev/Ngn0BbMqMCwmFFsPkCwnTlkEodi8occWXrqgLo764+hZsCC15FVwHti
         XiMkyiQUZtvXhxrZZp2VIVQiTxbxpRZ//Ynz6ixPrOWueSTc2LXg8c4oheJa7pFwOJwd
         /XMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762542; x=1776367342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XxfCU7pXpY3Dyi+84nW0vbFQxH8kq5YKGammgBsEsfQ=;
        b=bhXOirYKAT/X+i8HQfT+y9A8pAHgg8y0VdxgaK15HBiKczEcPIYsAy3hVQRSURqs89
         KFGsAO9X6agYe0Km5sa19y54WD/MwgZx38tlMwETp16KmTGiD/7aEtq965hH/adaAaXb
         tl1TCDBzE/Ve+qjohsje5p4kKymofOgHwEQJn4HmJLVTA30DgI/+t4CPS7dGQHG0Dddp
         Ywl5qjX9xI+FaijaG2JT/HxPemcSetdUYYP3bNCSpMlHCGttdMWvvwTKWUscUgW7rcTD
         XfZ8CZNTRmCTuCH6klT5UIe5UkTQgIE/wz9gHrM+e7EwV4IDoCXBJhFMUNpLVHVKn/1u
         CoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762542; x=1776367342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfCU7pXpY3Dyi+84nW0vbFQxH8kq5YKGammgBsEsfQ=;
        b=TorkEBbsemrtHty/Kko2ayakPtWvAkuTTqwS0iezXCKw7KNlGal9vRJdpNscCq1pRO
         Bs7E6Byv5wya7xpkdbxe++CMo+3GquY8xtRryLHqXOnZprhD1JJYrWc3Gwj1ErAzp2TG
         gwKsc8p7D5v4fJ2/UTdnOHEisAuMiyTaWZvXBMdmGY2XPFo1V3OLT/ObVPhelNHc5qpy
         KenmBK8VpC7jJ7owANpzhksl61c1kJIu7mdzeMskWXBkvYIcs7L4QedBUsqxbXJf4HnC
         cRCQQTiQX/wfUiEt6ZGBtnP0VpWRiI/V4Mu3YnI0txkmUfJjybbXgIkOBzlMhiXss4i9
         U+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/p+Mm2tuPhVyJ0J6RWkkfk4bBP8fBcftyLynK1tec4F1HN/Q2PQgSPNrQRH15+xCyVXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBF3nFP1hywwJ/M/QaJpEA3gEo0BXkwbb613Fq7CoGGLToljah
	H6nFc5wJfnyLhKwicOpCugWFhBDwHW00bSg+DF5W75umC2hrzvD6/SvVLAKYh5SJARdextyDiE7
	ukukcjap+398MphDkjXrAvrHnmi97P98=
X-Gm-Gg: AeBDievw7qkdUHDjGtQqPPs9iZBadg+IeootptyuzFKObBmkjM7HOLG6mSrY56nOYsf
	FiTYf5Cexb1x9jyRQFTkV22ujHIRi8BBXIezhmu0ylT8nonfYkJQfbchETlHUr87b8sW5XqMugU
	+VBL25muUt3Ehd8buc7BAXAsPaZ36X+jfRphl8exf4eUeyzgvf+SX3AGT0+vj3Zqz9R98NQZWd2
	3VoP4fBA9uRGevkM8xh/5drpp+0hX6mtnMBRnUIlTkZenmdK21HaYBNlbp1x4NRmImpWJcu4zMd
	SkWjbtohlhCXQZWuaQ3KZUF27r2nQAKsLW7p2ACRdCoHYXHhxIe7EtTRUYTxQDjg4/aHEryzWw=
	=
X-Received: by 2002:a05:7300:7b86:b0:2d4:62f0:b2d4 with SMTP id
 5a478bee46e88-2d586ea98e8mr220711eec.13.1775762542092; Thu, 09 Apr 2026
 12:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260405110953.3316-1-deveshigurgaon@gmail.com> <adP3JZhS7IHDuUxm@exploit> <a280c7de-1357-44a9-afdd-bd473fd4e2a4@gmail.com>
In-Reply-To: <a280c7de-1357-44a9-afdd-bd473fd4e2a4@gmail.com>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Fri, 10 Apr 2026 00:52:06 +0530
X-Gm-Features: AQROBzA2ZrvvkdKuMPyMsvU8_SLsOTAHjWHaKuvC58WhwK5PWkDF17mza2TzO1A
Message-ID: <CAG7UgESxcbKb=Jzi36osBhD51KO9GvQr8esD=6BMupLAi33nWQ@mail.gmail.com>
Subject: Re: [PATCH v3] stash: infer "push" when push-specific options are given
To: phillip.wood@dunelm.org.uk
Cc: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org, ben.knoble@gmail.com, 
	quentin.bernet@bluewin.ch, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

> "create" accepts "-m" as well so that's not unique either. I agree with
> Junio's suggestion in the link above that we should assume "push" when
> there is no subcommand given and error out if we see an unsupported
> option. That does not require the arguments to be unique to "push". A
> complete implementation would also support negated options like "git
> stash --no-stage [<pathspec>]". What is implemented in this patch maybe
> sufficient in practice but it would be good to mention the limitations
> in the commit message.
>
> Thanks
>
> Phillip
Sure, I will send a v4 with an updated commit message. Thank you.
