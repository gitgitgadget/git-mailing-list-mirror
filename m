Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3942A15A
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299067; cv=pass; b=ns9+dXS6fY4om0xeHS3ceVfnKbEvwF7z/9b4uCmtBJrge11CLmHtCX+Ysu2btq+Mayk/dSpXtbcR61u1Y1Fm5T8rHKZr5SwTo4GRWy8U5YpoVnerlEvL8+Mcy9UncfjYhoYqfjbJs+27cDkrOqHlCtZg6q/1nyVxL/IIbl4tH10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299067; c=relaxed/simple;
	bh=ojrJmlMB3+B8N/DOWEi+6IfsnYN7DoB3XzkMxWXqozg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcBwBMGK+5+V0epJTjmIXkelSNmwYkGc6QCHEZpf6LZLfuQhra5T2AeIFHCM+YATceJ3n0BZSvE1fpMlNOPDQQt9RY18JZaM53p9gBVL/q5ly+E342UdFlU/Ayqb54yAmoaQsWMuvIJhyvDuV7B6kwJSx4KsbB8XvW6zTOWGHV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWCOw3+B; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWCOw3+B"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b0148201fbso3735422e87.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 07:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299064; cv=none;
        d=google.com; s=arc-20260327;
        b=QNXZ92KxcLo2z2SEtSRTpxMDcunfYxr/7t3qWbQ1zmLpaYQSKgkzAerfXf/33Gk6Ha
         TY7pIAsUQI7UuxKOgQgrWvUnOvTXZpApv6Rv7FIE2UQcqRCZjEPWCUkEDHTyYuXcGVJh
         jPSU0XqLdJdprdUp9XO2d1Uj++HHue2QL/ST5VklCPv8hZKm75vwEGCipgWXKPCIHsQH
         R2l46WpivWcufRG8iFAafq1ZAsWgoKuBUkwqIGcV9RD+BSEk7+B/Mj/JZsUM9vYvnn8p
         eN4xC9Aq2Deor6t1+dYBgMpag7Vj00takz1EurjXtZFBTB4EZ0xMIpAJUiLAhAd7fhXf
         6lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojrJmlMB3+B8N/DOWEi+6IfsnYN7DoB3XzkMxWXqozg=;
        fh=hoj2Bb5OARi+0RXbZnQImcX78zzFYv8108Yb9eEYrak=;
        b=jXPUFf+lLYDdt88U7wbR3pJ4e4Rsx2/Pzqn9WupXYdbPoy3N7nMwUe7TjaU2mBEHw5
         4hDQiVxZssNboj3JVJ4BH78gVJndlubxcmPR27Sp/MrhW1/vStBuYAyCS4CLtLzuATvn
         Rr7Z6bAfU1zS+kgjT0et6ZH+DicmNSHptlFmtuCr9NAot6F8/vrWWHaJXz3DZT++HzDq
         8pJ2JCqOTObPdxdhIkuEQmx4CAwHjBka93t+zkQQSlyGULiZhuGIDT3xI3A1xJ6Zazv9
         aUa2q1wAoRv3K+r+Ntxa85pYccQWcy6iDr9n2Jq9G75CY0R1V8k2JOO2BqHUMcyPYjMr
         ZIxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299064; x=1784903864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ojrJmlMB3+B8N/DOWEi+6IfsnYN7DoB3XzkMxWXqozg=;
        b=rWCOw3+BH54Fw1LOMGsX0mldn4UHi9AOHMDyv9raQCTvwA30739GQ+g7WwuFnZGLvG
         3Fkw8lEwy4Uaxgab6ZeTX2DqkfWMUm+whQ8NQh1plRIiYxzVz3S+wIv2KBW7yD6/Pptp
         4M0JVnoFVJzDel7iPWShDky4/FfbTkt+yPfas3DKLhk0ydYaE2R8W7cbUIW89NNr2Xf5
         DMssIA6QI36tApdRZ8V6Q3wGFyRLN9rrI91E0vPiSdG/ilX9utt+fwpsaaL8luQuwuUM
         NQv3N7bQpm6VJBFFIsV0vqP8TABHjfkbfgcxeB35WXoQDyW4NXgsIOq50dnfqcfMqH1N
         2jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299064; x=1784903864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ojrJmlMB3+B8N/DOWEi+6IfsnYN7DoB3XzkMxWXqozg=;
        b=a34PA6LWgIwnGzYMIwvyAZsAeJZXb09ZRO0q8oghw/CxP9/GtdgC12FmMvBofiKI3u
         gRY7UYm7W6AAF936eBEV5YUT4VorKgGZH4/PV2M8CheGvC5V8etf4l2tkHHHd2oeHdf9
         KzsUo73fc25hWQ5wHJZuxeXN5JqSV9rNDeSUo9io/cSbxFPqF9f8Tj1MDnaSKiC0CKMj
         CAvzjjB2AMS0MbOpop7xfbViSLPus+raCIy72luwgxl4uEnoi2xExDqCsbx507ktrOYz
         KHXhxvEJ+luw/asjCQqLRQryTiBi2JQ2dd/pHBD5izN07HQeiKH9LhLnIj3UVHDCb6IG
         qbTg==
X-Gm-Message-State: AOJu0Yyv3/DJnda/EEvaMdKlORCFqxU2VxZGNDB9lrF6omksHkDxSx/N
	fT0fmoaNl/4RdjYuBiNayfVzPqF6b3X9vFlvt8oNvKodDN/F5Y2L74mP0WQot6dd/ALWHPybW7j
	eh6coT7CV+f7VFOuc3sUc5tR/UcV3aAI=
X-Gm-Gg: AfdE7ckIT8uBdG2kavZIYrACJ+THu0szVMpw8ISIK+ok9xkL2MEbBYSuRriNKdGwTHs
	vCOjaKAXEvguQVE4Bxp19hYasCLBdvEfshf4jn0/bpIeHDt0kfL7P8zh3OgiU9iMHnw5EAk07Sm
	dp8BGrJPNohJOe93qK7rDJTUqPpzi0CQbJ12ljVbZfYC99hXji0W6/7PaSPawPwl8Lm/eJ25DtG
	7QOGUKNoAjQKTILcorR834Gpspd3Zj4avMyMhLlSlAy0ori2ZQxAVe4VlDZ9KfqEzC5BNFQfZCB
	0ozSJKKDipsjkVNKfFM=
X-Received: by 2002:a05:6512:1094:b0:5ae:b765:ac58 with SMTP id
 2adb3069b0e04-5b28f84a1b4mr685451e87.5.1784299063580; Fri, 17 Jul 2026
 07:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716185045.229320-1-sahityajb@gmail.com> <alnLPSnOt_Sf7cA5@pks.im>
In-Reply-To: <alnLPSnOt_Sf7cA5@pks.im>
From: Sahitya Chandra <sahityajb@gmail.com>
Date: Fri, 17 Jul 2026 20:07:31 +0530
X-Gm-Features: AUfX_mwDRKC215asytEfmPlhc_lJ_BJidA2hzTX8opUZ1PUz7sLE_emOHlo63Cc
Message-ID: <CAP=WS+tb-HnMmOjH7i+ZY0EBOT0xfDPi4wsTboiH0mRtCCs=ng@mail.gmail.com>
Subject: Re: [PATCH] wt-status: avoid quadratic insertion for untracked paths
To: ps@pks.im
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com, stolee@gmail.com, 
	peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> Out of curiosity: is this something that you have encountered in the
> real world as inefficient, or is this rather a theoretical inefficiency?
> If the former it would be great to add a small benchmark to the commit
> message.

Thanks for asking. I do not have a real-world benchmark for this. After
Jeff's reply, I agree that the O(n^2) claim is too strong for the current
code path because fill_directory() already returns the entries sorted, so
string_list_insert() should usually append at the end.

I have reworded v2 to avoid that performance claim and describe the
change as making the collection strategy explicit instead.

> Instead of sorting and then deduplicating you can call
> `string_list_sort_u()`. It does the exact same thing as you do here, but
> I guess it makes sense to use that interface anyway.

Done in v2. Thanks.
