Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C93612C6
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471836; cv=none; b=L8vsGb91aX8j6Qle12umyqJU30vFDeJEOySv1RdY/M7HLRzDi6jGaszj5JMKxiUlJTSw1gLYVtcfZAwFMkrDeBuKJLd2bPtXAZED6NnknazKLITda9CmLVv9fu5+RiXsN3PQuG4LDljcqM1sBZDAWjKE/YJEZuHxT3p13IuO2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471836; c=relaxed/simple;
	bh=fMzVcRBRhyDB/6eMDvHmWrZibCy/TbFexdKrrl6vDMU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGDqckWi6767serlZ0QHr1NLXpzDShJga32nA9G8udosIJf7WdZxHSkuCM1e0IOlM8tsN5UfFJTkw+IdX/lsvUns46P04UFTmMBr47aaVyBHiyFaQj4NSwUz6fRoKIGtXzqyE/nwvu0RHsfRYoyM1QRk6lXw2388jaIuDv6JWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW+yh9fa; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW+yh9fa"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-940c539de8fso500472241.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768471831; x=1769076631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ATL/nOkSLisMlr2XtzslCNoMwl8wJDVOX+wZHtVqWc=;
        b=XW+yh9fahBZP8GeVxqVXCuiKB8ZMA0CQinXWAS70hlxyAaTjg1mmr+lh64P1jl9z+Z
         d9/IbdjNNOgUQjLYbS1GzWA35wr7EPopLfjF8MHUHl6A70YiNiqNf8r5mFaqetglaCus
         +s4NqipYGzMOQeAGTmvQImT6vz+9EkschuzNox0iIKpSYR+AJntPTPGLVxUnY7lLHAU5
         x6KOMt7/qPiqcVO3EGFzBoEBzyVmlBXVJllw1IU/ok2B9TMQSFo2RKGUSIxmYXmLT9xI
         vf/VNTLCBINOujhiyOjJdEI4l3ZtTsfXZDeApwjjyOzn/w5C1fQJhotT/h8VKbkgOCWQ
         kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768471831; x=1769076631;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ATL/nOkSLisMlr2XtzslCNoMwl8wJDVOX+wZHtVqWc=;
        b=QvIz/TotZ7o+1bGqXXm1RnzAQ8Q4Ldeai34NTM5+OrNv4EbkrBomIEzwS6slk8uZx4
         WkJjkqyn+5Z/qRrqdrLfJ2bo2wJUHH7MCDDC4JxE6wGlCBwbpqV7fa6EUJFC7PPx5f5Y
         7BmeiquAAuAci2rfOKhYhAit+vFvhynx5fWt2iVzMmOeicTrpltNLLMSh+U664gtV/nN
         doru3PQ0wf/lVPURRuEox4Z81DOgeRSXPbTwRho9cv3/9FA/VVUFZ+CaGo/HWurERZnu
         eNIQXbeAWrY02mEYe02zLgSmkKlhdQFCZM2ems+UI4fa8fMzM/EAo8Q4fWNRaP9Xhff9
         QlMw==
X-Gm-Message-State: AOJu0YyWNTTeoGwiTYW27/Vik0Tape9stgV+L8rCQiA2BJ2Xt+4fiyFu
	0tcbhDxmahfvsXNGfJHwg2AZpf6t5t9YhlVOdwDw6xyaFNETHZn8U/v6UXauNlqOBgje0b7x3lJ
	39lQ03ZCrgRqGVMbI4xpofQpqYdK4DCw=
X-Gm-Gg: AY/fxX7f8TU94aHfKPz2kK52fhIV28aWbJkVfL/wmzp91AsDWXIOpCt70wrY3i8H22M
	0n3dHzRPBg8IqIRI8dE98HDou81kj8k9Ax1HUFF0Q5oNMvifywJ+eWyqQu2SxyadjkFsv0nlVtM
	Kt7YwlaAuKu5UtRScivjQVb5HhETzKvQbyni3iwB3+2MN1cYQndKYzN7jRNieY8TG5rojaAvtEq
	xgtXXd4jjc5CYP9Uqz1OkgntdK95EH9k063iGxTlOk+P5C6i9li4w5J+OGOCnmzpMRnjg==
X-Received: by 2002:a05:6102:50a0:b0:5ee:a590:6b11 with SMTP id
 ada2fe7eead31-5f183bdcd49mr2132408137.36.1768471830879; Thu, 15 Jan 2026
 02:10:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 02:10:30 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 02:10:30 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260114174458.GF885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-3-f5f8b173c501@gmail.com>
 <20260114174458.GF885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 02:10:30 -0800
X-Gm-Features: AZwV_QgSaC_qQa92tmbUsHNk69x1MdSW4a2yThvkCnVLvU3jVxh24bgP5teOHZM
Message-ID: <CAOLa=ZTX620gT+RuQ44AE_f82CibrGzoNv70G8BK7Wvt5HF4Ow@mail.gmail.com>
Subject: Re: [PATCH 3/6] refs: add rejection detail to the callback function
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, newren@gmail.com
Content-Type: multipart/mixed; boundary="00000000000046993b06486a6fcd"

--00000000000046993b06486a6fcd
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2026 at 04:40:44PM +0100, Karthik Nayak wrote:
>
>> The previous commit started storing the rejection details alongside the
>> error code for rejected updates. Pass this along to the callback
>> function `ref_transaction_for_each_rejected_update()`. Currently the
>> field is unused, but will be integrated in the upcoming commits.
>
> Splitting it out like this seems reasonable.
>
>> Co-authored-by: Jeff King <peff@peff.net>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> In case it matters, you can add my:
>
>   Signed-off-by: Jeff King <peff@peff.net>
>
> to this and any other patches which were derived from my earlier
> attempt.
>
> -Peff

Thanks, will add in the next version.

--00000000000046993b06486a6fcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bb743b0561655a81_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sb3ZSUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1YxQy80MHRENEUzTEZRT2l5MERZaTMwblIwQ3RZdApiY0tGajNhd0Ur
a1lrVkpDUkpDZkhNNHllQWhpb3NzMmJ4eXV4UXhWa0E2L21LejRPc2VOQTJJVkNRODBYVVptCjBN
RHhyWXFwN3pqWlBqTWNaUWI4bkhXQldrYnR5Qzd4SDE3SjY0QWxFaGhpMTJxYmoxaHNPQmMzMG91
NVRlQkIKWXR0YjZyR3ZhTnFhTGdWNE12WUY1bUxNdXp3L3AybndQdlRPY0hKcDNGOWJ3LzY4NEZZ
U2JYRDR3WjFSKzM5QQphdzBkRnNxYTBWWWxlSlUxOE5UN0FPM1J4NklHZVdmeWdkY1c1Uk0yNzNq
ejRyK0RqQ0dlN1gvZUkvSU12S09sClY1bjUvSG1nQ1d1SWQ3TFdWY1FTb3MzMWRWVTc2OUFaOW9m
YnNGZWRDK0VQVEthRXFQeFVlVUlsaWkzRjVEdGEKNXlySWdjV0M5MEF6QUxTNjZIVTVVenNUVFZY
UTlxOW1TRTViMWZ3blJmQ0JCdm1hams0b3czdGRKMWJpL3gyeQpMK1gvd2I3cUNJR0N4RmhGYTZp
OXl2SUk5amVZK05GUHZVR1BhemdHdHFTOEN6akxBUmlrYjIrNkFxSDJVelN0CitKQkhJNG9sY0VD
YTBmRlNpRDg4OFRvazJUR2UyRDJhZmdaSnc5OD0KPXFSL08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000046993b06486a6fcd--
