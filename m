Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE6387372
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941484; cv=none; b=on1ueC+nqYuqIbABJnSytM010Il2XG8bUZt8tQrRZ2ODpULL150w+gXt2KqpGhngtRyjWcQauJlL7nlFpdE+ri6h5gfeo0xnYhcdkHMmiZtB5zKyhGBgS0yQnaH/wGBEwr4QecXmjCS8oAQoIyS2pM1cizqy9ElB+FE4J9wMMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941484; c=relaxed/simple;
	bh=9TfOxHnKjlFgHJzlqEHmSH9XzJYHZq3mprDVuRCprjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcAKAO5FGW2lof4cKQGiOCIgPp3Ph5QaHmJ1FtB4z8YDhcen7kY96NF/dvIDrsbIcO8R5VYmXFNd1Rg7uCi88mDUBJNzljfauv2+GV7+23a13/ChQb2JRWn4bGfjJuTZMCWRcMaiZcgNJ14CWfyp0hYtPHaiTNGl8z1CJI4S7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEeCRYnR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEeCRYnR"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c52e25e644so539947485a.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941481; x=1769546281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGgdeMR9+b4UHfM5MJz3I5+00eQjkPqrpF84nsjZ/jA=;
        b=NEeCRYnRjYCIAg9aQSx6Xb8EbV3XCHHjksZFoWVzRNTrnHIwF8CEtJMc397RVFlCQm
         sUjDFZ9QTp72vqtGH+Zk9Mnrt5hbN0MtB75uy6RUZWBUxGG0jR/5ZKUP2SNEmjmCzQWw
         ePVwtFEIrx8vCahO1tB3nQ0lEsNgNAFUQpy21ja5KIs+Rt9D9cBF75sHnnPcp3AxGEn9
         N8qKzk7UL/kFE4hdy97ZWEfficbKcCFaMaGzDrbLdXFGdO8LJztIyXxZi2226qCYnWn3
         GAWqccEUMietDfNfiyE3g5UaVfanimIYnH9qciBqZB4F+8CcREpi0SRqMSxJ+LXwQ9cH
         qRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941481; x=1769546281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGgdeMR9+b4UHfM5MJz3I5+00eQjkPqrpF84nsjZ/jA=;
        b=ik5zQCt5Ha59obmrYcq1Do4xt7yBAIGGk4F7GO1U/aWmB9D6Mglg/jaUtsaDPtXkT1
         uFE4rM8nqdOv16q65QJJpoH2Y+BCjgzGvA72AB+DskX65APEeBUzhggHV+dYw3fN1SH3
         UiH7nXdqwVZXhJyQVOIcDGvBuEGEFaWKOP88TjM3XsdyHohnkLa/n4FsNG6iK9oy5Cho
         Ko4ymXRRjH+vGtHWGN3H+Ih9FVYL3WxrQUNovgBh+d4A/CsbpnlawVRl7S3x84pqn7TI
         1frrN6kK1W5U6LA7v2EmPa2fY3lwCxWgAgx9/Eqs3BkwY0OP0OCQEIYfQSj4u2nOv8pj
         musA==
X-Forwarded-Encrypted: i=1; AJvYcCUITnFbeU2SoqoFVRVup8GGGsgPAnYuzKXRznVW0Qew5Pz8bHra3uWhDIFO8WXKtDdA/ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtlDAVgRu6lW52WHIC6Fh0rGYCeZG9W6b6CGIaoM1AHBvptel
	TLgBWnOGBz8+yJVt1ECVCkbJuN1xWJXvdZEKlqp1G8GXNZz4G3m8GwNY
X-Gm-Gg: AY/fxX47rvg1lQmzjkxp5zZzScmzv8q2v8o9HyYZkGSM5NidxnV/04qg6wHwGEYGjqR
	h3EGYeaQ1Fp3clHHznywTN3n+ILzhazfwn8cU/kVPKEVkygDflt2/InOGTYWQoH9/I7uKpdFboZ
	PZYHEsQtvajPhLe/vH0N5M3fVKvLdvOwDMC1yfteNHUQe1iT4cWoWw+iMvZWoFGr+ZSATMwzv55
	G2/rV3pJIHEeStC/1QwvnpnUkLiBHsNihudT7hR/ILKiqHBqgovxS/GqaIeOEDl6ZpbByDd/Rxj
	JPo5ih8jwbazvSfOT4NDNzGnacdrWmtlOR/7LDR9BnFjuJtdvf89UfaiNwGOxvT2AIIhS+xl8Sr
	m7Oq/lWlYNLP/ZE30PKFE40YWcRfZFJkWYBELp/CoiX2nr8XnvaXVkorOPvcMfruWty/KH3HT6J
	5NzF93XyIkvfR3yNGVfnNVJF65F2mwnRTe+s5EKd7HNbdNsYcnBU5BLj5rlxTX/VLum1hU
X-Received: by 2002:a05:620a:710c:b0:8b2:edf1:7c3f with SMTP id af79cd13be357-8c6a68d938bmr2068352285a.26.1768941481011;
        Tue, 20 Jan 2026 12:38:01 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724ec87sm1163688985a.30.2026.01.20.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 12:38:00 -0800 (PST)
Message-ID: <8a4430e9-26d6-4bc5-bb5d-9896c2a2df9f@gmail.com>
Date: Tue, 20 Jan 2026 15:37:59 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sparse-checkout: optimize string_list construction and
 add tests to verify deduplication.
To: amisha <amishhhaaaa@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260120153829.48044-1-amishhhaaaa@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260120153829.48044-1-amishhhaaaa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/2026 10:38 AM, amisha wrote:
> From: Amisha Chhajed <amishhhaaaa@gmail.com>

Code is the same as last time, which is good.

> +test_expect_success 'sparse-checkout deduplicates repeated cone patterns' '
> +    rm -f repo/.git/info/sparse-checkout &&
> +    git -C repo sparse-checkout init --cone &&
> +    git -C repo sparse-checkout add --stdin <<-\EOF &&
> +	foo/bar/baz
> +	a/b/c
> +	foo/bar/baz
> +	a/b
> +	EOF
> +    cat >expect <<-\EOF &&
> +	/*
> +	!/*/
> +	/a/
> +	!/a/*/
> +	/foo/
> +	!/foo/*/
> +	/foo/bar/
> +	!/foo/bar/*/
> +	/a/b/
> +	/foo/bar/baz/
> +	EOF
> +    test_cmp expect repo/.git/info/sparse-checkout
> +'
> +
> +test_expect_success 'sparse-checkout list deduplicates repeated cone patterns' '
> +    rm -f repo/.git/info/sparse-checkout &&
> +    git -C repo sparse-checkout init --cone &&
> +    cat <<-\EOF >repo/.git/info/sparse-checkout &&
> +	/*
> +	!/*/
> +	/a/
> +	!/a/*/
> +	/foo/
> +	!/foo/*/
> +	/foo/bar/
> +	!/foo/bar/*/
> +	/a/b/
> +	/foo/bar/baz/
> +	/foo/bar/baz/
> +	EOF
> +    git -C repo sparse-checkout list >actual &&
> +    cat <<-\EOF >expect &&
> +	a/b
> +	foo/bar/baz
> +	EOF
> +    test_cmp expect actual
> +'
> +

These tests have the right structure, but there's a problem: it appears
that you've used four spaces for the first level of indent and then
use 8-width tabs for the next level. You can see that it disagrees with
the last line of the previous test in the diff context. This should be
fixed, and likely "git rebase --whitespace=fix" is how you landed on
the current use of tab characters.

I think the content between the EOFs shouldn't be indented more than
the 'cat' it's a part of, but I could be incorrect there.

Outside of the whitespace issues, I think this test looks good.

Thanks,
-Stolee

