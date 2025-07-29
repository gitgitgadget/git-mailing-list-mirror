Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A42101EE
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801568; cv=none; b=EuSqaK+poaJQjJt4AFtKyoiq7edMxNTgQ5O4Z1Fbyr00CbYleP7iyqU+8s3X497Yhg9ShUds7GfVCcqjUqSI3FxlUjUKW2r84N7Kmo3p01d5y2eGNElQUiCY9sNxNHCLUgHVZ7aORaIjUued+3Zzxq3HShv0UhCjL+0RlrhVPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801568; c=relaxed/simple;
	bh=aiKuY070JaZVYtinQ6P2xZl7mI+IOKDd0e0UQJY6p2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esjWxOywOBMzWL0S1VVNXlSgKedxi5YSLekNgVG8/ns+OJzjjcgjPDy1sYDGba2aCk2Rx1n4hUFQxZFcWKkr59EDOAN1P5rpaSBryKtmcI7zKZQdt8rIhtoJ0aOHbaW17+34wygOqZt7X4C+8SiHNbS31qOCHaqJ8lDotqziB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnrQs+nP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnrQs+nP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234f17910d8so50477245ad.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753801566; x=1754406366; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENTFoa+uYKLOF/h4CzMjkwqNHnX/kdko4BdiPZ3/sE8=;
        b=LnrQs+nP5iTCA5w5uE4W2vMRfIth4MydOexoWyqOmw6/rvbd+ScaYKb7Bxi9Ft/rPh
         BkenE9Q+Y7tuQ+cPeBhKnpvEJTknG2z9dBrWUgp1rfK0OJsGYb3bsQaDQ1B7Sxpsy+s7
         7k6qcfTWcYfLUdU0MQvxw2oyKO+qHi+Ay4BbSiaGNjU/4vZ3Hi0JM+tN6lRSgye98h2y
         jmNT5qZWbXXa1tj1ejUFn6rhTGghW5YooZyk9O41i8cTwTxq3Ec1b/uIXx/KfR1VCglP
         MdVA9X5pi6FGvxjlSJwvbrTIuM81vaw/GNuddegseZIhH4UclgGuzKwNxUN5+tHKxatY
         f2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801566; x=1754406366;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENTFoa+uYKLOF/h4CzMjkwqNHnX/kdko4BdiPZ3/sE8=;
        b=Ik7ZGcAoLiu4H99k3C4LcU+Dr28yoVl/8DuBQjQean/a5GKFbod6feACT1yEBq/s77
         nwzm3FUqiBMJ87huKE4IXllyN5mZwnmM/m5H5AUbTZs3Pjk61F3lbBraZ/pIZUdoqbRp
         L8qbHiUqEfYsPAlEOMTzYy7nz25W+3QYVUEi6/Kbk2fbLWbanxiDGd7mrqlGrat9UcLG
         Ra2YKb1FdfnX1CKkKAkeIvlK/qRl2qfBikc/9GugpQZR7KONPscb6KmMR5DzJFECBKN/
         Wz5Oc27lLWwRowoG+8mbWLR57N6/tv8E20JQl69yiTs1p0oZWpRYxnv3E7LHyQUQA6Ld
         l8GA==
X-Forwarded-Encrypted: i=1; AJvYcCWmUp5MdK3Xxx6bFxp3bg/ADHWrfqpCCvew0MiIpFnurNByJhrfn3uCXpIRbqWX7aVPo5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDwWaldB+ISak+o6lvXfEL6nBqS2nV1udozJ/cV1OgYx5es4V
	rxSSu8wXhKPRNIg3FoU+hAsnCT+O/VJJhKgWPHx30m/VloSAn3SGXvFC27eS/A==
X-Gm-Gg: ASbGncv/CbZfQBZIve1O6YEx7FNVBDvdsQUgqjHPxZIwCcvwNCNldZiuiM9L6qoVIBk
	fTa1d4vaVqamkCfzTAaAjBRvDKxX/sYe9SJSF/IpMhmA3olZM4LEEHVx41BtEJzFbngzRbhugUi
	+9HWlaCyUUYJ1ScQL3k6wfTydFPD5LllKIx1GwWwSITqAGjck1+P+ShcVzMJr4lbrMChg4nLvgS
	yjDw2uGdPDRptL0lSi7pIrOFGlO8AjVLhfZmXy56t8uJWEL1F1u5b07Nfw/jTaJsS5w8GZECRpB
	G515SarMCGnVJwlYcKWctE5m8sVEuHdvej0jNXmr8q/XMP+sGLnkPmzeB8HdQDUZ5IUZwdUae83
	oQfAxFlyTpOvZmFOEgmDHwXdVXQM8zUU0iHvqIoMbZPqquK7M7UPGJ32oR7CmRmYevaUIAmu+fQ
	==
X-Google-Smtp-Source: AGHT+IEK6Ur2oqPyHGHaPyRc6cnzVfT6l3U8PCR25udCN8GdH66nA88BEE75RoRdja3brXjopqYt4g==
X-Received: by 2002:a17:903:244e:b0:240:10dc:b7c9 with SMTP id d9443c01a7336-24010dcbae1mr120681435ad.9.1753801566176;
        Tue, 29 Jul 2025 08:06:06 -0700 (PDT)
Received: from localhost (197.246.125.34.bc.googleusercontent.com. [34.125.246.197])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2402f044b50sm46522295ad.36.2025.07.29.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 08:06:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t7510: add test cases for non-absolute gpg program
In-Reply-To: <20250729071247.GA1426859@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Jul 2025 03:12:47 -0400")
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
	<20250722190922.51183-3-jonas.brandstoetter@gmx.at>
	<20250725043043.GA3002998@coredump.intra.peff.net>
	<xmqq5xfbuahx.fsf@gitster.g>
	<20250729071247.GA1426859@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 29 Jul 2025 08:06:04 -0700
Message-ID: <xmqqms8nqboj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jul 28, 2025 at 05:05:46PM -0700, Junio C Hamano wrote:
>
>> > Should it be "/d/a/git/git/..." instead of "D:/a/git/git/..."? Which we
>> > could get by using $PWD, I think.
>> >
>> > The earlier one using $HOME uses D:/, but this one is different because
>> > colons are meaningful separators in $PATH.
>> 
>> Here is what I have on top of the posted patches.  If today's
>> integration goes well, I plan to merge it to 'next'; the rest of the
>> series is already in 'next'.
>
> Looks good. Not sure if you saw the patch I posted in this thread. It's
> roughly the same as yours, though I didn't drop the useless "env" (which
> I agree is useless).

Ah, sorry, no I missed it.  Will replace with your variant.

> I did reference 71dd50472d (t0021, t5615: use $PWD instead of $(pwd) in
> PATH-like shell variables, 2016-11-11) to try to give more explanation
> of the two different sources. But re-reading it, it actually doesn't
> really clarify much. ;) So maybe not worth worrying about.
>
> -Peff

Thanks.
