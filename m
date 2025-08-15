Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4918A6AD
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273290; cv=none; b=WDIXuFGXu4632TF1B8N9OYXqPjgae7XEozO4fujF5+d0D68AgSfkMneRF8RpCGNEA47jCWi8ikeTwbEqOICyJXvDXCcqqwh25qJXUoRXwXy7GouZ1sT4kKeLjv/y3HldRKYQ0vVugQ/blGjlrRhqlR4Ws4/WHlBWxC/c2JTkOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273290; c=relaxed/simple;
	bh=r1DMD6daawGkN8q4yemw4GNw8975fzqG0dcmgvIx2AA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tcug94EGAJItk4IXTx57gW0E6vPAL6w+o1cF+4szRZXRFs2fl7FxcB00Zgm+thztC4LwQLFdwUXZHaSZsJJx18BQaFHLHyw6T7qJ9X1Em+Pp291KtfPZEh8BlVF92mfenV9OCewCHBM2iWYmdY1z5voN6yT81Ezgr1/H5tG1d3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP44001j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP44001j"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so10974085e9.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755273287; x=1755878087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vq9rD+bgn/X9vpl0d+FGvm/VULBn7MKw+NkR1EtiyE=;
        b=eP44001jAYORJ9RhATjNifPQeBp3AVBfWTEGn6NlaQTksUGV17uZknGM6ULXhtYtCv
         5VjNrJPCL5NvIWvYaoSBCqsxlcm5rmHK0jWzU/TNBxWsyYEGik13K35gbfF5vZtzuwmN
         34VWaBl8CIcGj6eq3rFT0NAetW2ULgMM1wv/hxIQte9MW596H+f00/gfr5UIr8xDezrn
         7HEgPuEK40gzAiJ4yM6HxUlomIXvUmlrS99jMGrAiW+6HOcxGLRblwkxZDzuSGH1DRPF
         GR4Sbw+pZdmVLu4k3agWWbR5r9AzT2KnwW24ZoddjSdy326JNHBL/Etnr94Pk/H2RwDh
         2ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273287; x=1755878087;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vq9rD+bgn/X9vpl0d+FGvm/VULBn7MKw+NkR1EtiyE=;
        b=LHGzUrRUTi6trEpOHSyYlbNt5l13Ud6oGNkfzumQyuPAvn+oap7t+QfFJh/LgQSO/z
         yt2loPwndN/0fk+HtD627ZAl2n2rXHTd7UIEzZ03azGIj5rq34FquUx8HOHS2rJ7rzb2
         zJ1CuxdOczEPCDI+fL9aDOhI4KXdywbYP0fGoPS6KoeKHzvrDaZC2mmwqhzI6SRkkr0B
         VXnV6p8OSwmS+1TCLtaZp+e2rCVHyOEV/hIMMMjpWvbVEHz7FB1A/+uK4ZSdE9KaMGNU
         SGj1KKBAATq5C5cdltDfw/dTr2vvLGc4WFffZC4AmjpsyMvQ1tP1z2cCTdjJh1brVdO9
         0stA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1zsgWTJFUCeBG3lyQWR9LFGyAA7LwEARNshYwgY/FpelfrVGwIw3mZLjUau7rDrj+MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzYEEJ+SSyHWkB9Lk3DMNSKkB84z1Dx1ZM3oJhZxfXG1yiF4K
	ZTeKxXKxEBX7TYvJvWoq0wyontbw8BGefJGX7d2dgg6GiqDKfDqqwg2v
X-Gm-Gg: ASbGncsFnpbZuT6ZMeyONUfQPp0naS+xdM+i4drisc3iNX32VBWC1PcNqKTfwRwsy1o
	7Sna4G5XyY1JEBDxitQIQ0ae5l659H4VRSrHovsekELc5aRQdse+/WGjVD9UV0QEFaqgPoTpwgs
	R5nWM452A02mGDUfEKXPXbwY9cpDkvajblvvnxC+yPrr2xFWWIKMhcN1j5Iz8TOB3fJljQAZ3lH
	wsfPwTmyDdodjijKn04AuqolZ65mf7od+Fm2J/PWEn3ASXDE7Ma8ZS4Ja/FuJefl17KnVfYqeHW
	Ok7gLVV8tj+ZGnfj+KBJEfjWuPG3fKtM0NRNnYRIdupPjsLm+QGQVVeX6XHki2I2YLiPn1zylTS
	30ltj74x+7zE6x+KmfpIwGOMzgkaCJegJ4Nb40CrCQBjV04nFX29KDFdIGblDoM8KFSwxZbRr60
	wC
X-Google-Smtp-Source: AGHT+IFu+oO7go/JF23BF2cVvwdNIpF4hXZkOmE1WyDNrRgG4Nz7Jb29RZdjx/zDrbtPm+V0AjdyZg==
X-Received: by 2002:a05:600c:3b09:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-45a2183d324mr21067755e9.19.1755273286603;
        Fri, 15 Aug 2025 08:54:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b8963casm33778185e9.6.2025.08.15.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:54:46 -0700 (PDT)
Message-ID: <9293393d-e8c2-42e8-9b06-af40c576e841@gmail.com>
Date: Fri, 15 Aug 2025 16:54:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans <julia@jvns.ca>, phillip.wood@dunelm.org.uk,
 Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
 <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
 <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
 <xmqq5xepzjnu.fsf@gitster.g> <c9a4d7ef-8cdf-4d5b-b0af-f43ffc6b7450@gmail.com>
 <xmqqa540twpc.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa540twpc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 16:45, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Although the cherry-pick detection happens inside "git log" that
>> command has a fast step (find the commits on both sides of the merge
>> base) and a slow step (detect cherry-picks) so I think it depends
>> where one draws the step boundaries. The cherry-pick detection is
>> known to be slow when there are a lot of new upstream commits which
>> was the motivation for adding --reapply-cherry-picks in 0fcb4f6b62
>> (rebase --merge: optionally skip upstreamed commits, 2020-04-11)
> 
> Correct, in the description of "reapply-cherry-picks", it may need
> to be discussed to guide the readers decide when to use the option.
> 
> But would it really help understanding of readers to give such level
> of detail in "here is roughly how it works" description?  I am not
> sure about that.

I'd certainly be happy to see these two steps in the description 
simplified and combined as you've suggested elsewhere.

Thanks

Phillip
