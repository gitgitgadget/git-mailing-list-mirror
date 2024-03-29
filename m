Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DC64B
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754629; cv=none; b=aFdw8GTxYtiOi924ii8BB7DIKqRRH6HPzlZ2q7xTitCovkRoeiZlArJ0C3BFTumI11fAc26xA8zjEiRpeqdX47uVAEdC7DDtg9oZ7O11DkS4PgtBSy4TghF70tRo7Kn7dd8J/PBC5W+EEcx9SzJOxz0YR5lvZXTjwf1pPsBLkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754629; c=relaxed/simple;
	bh=4Y2+S3p+p9UcgncbetR1l2AeYNN+y9GLLecKiSGzLW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c5xPmirt7cMFK+OGFnZCjNTE8XvEZRdu/iat0OYP7rLrzJ4Ed8s6PN1hHrzjsZH4hP7tc5cP90H5KnuWpkcGQnN5Ad15bbZXRGfYxv8BTroqk4kdrhMUsNk2mOW+o9mHmN/7Z61jAxPsOl60eRrEqAXOZ8Yj9SsJJGPhQEzOiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSlh63Dt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSlh63Dt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41551639550so5283085e9.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711754626; x=1712359426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVJjHBLmZuiCYbL3cbHRjHvMB2tGXniGz5j/jaj8uig=;
        b=kSlh63DtrYCldawDDu6KDGRvVkarlzFpZAhv2oWu4SfVx3dqamANXCRN54bHU2S6Mj
         iPupEPnGRvvSJpRv21am/ypsInssEAePlaQi53blhFYg6gBZzRCY1G2qPkAPWSq7nJ4b
         ZXC2He7jBeYcL/f61LIUCtR5gEFFBqn7pArwF70/fI2WOuwc48J9DB57gDFzOCKymMr3
         +5Smix5mbLA7z6rdlpDHKKvfJsbBB+vEacFH+QrGqwIDhFXK9g423g7SkoIxu//ZAdNh
         c+lBhOnVa6mUGiLS4l7OGyfjJQ6HYBKhpxeUvGVnM0+MnwfJOzCzCbeBfuoilYeEe1cm
         8nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711754626; x=1712359426;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVJjHBLmZuiCYbL3cbHRjHvMB2tGXniGz5j/jaj8uig=;
        b=Pwten/BWVhj4dKqanPe/Lq4E4p7ruGhwJUXwg97iCDoa/HQcR3uQlSSSrDUheko+r+
         ycjEujbgB9AjBaK4bRwxTTHqzeMAJ4+NLD5NmBvLWhhcVyJrK+/pNY9kMdJvyY6RpsW2
         w8kzp998Vja0oco9i8ZKwPHx88T5yUzvCGSVhQoN+LpcE9vnqJP7MEtnnzhWrDmPthyB
         76yrRF7ojfUW+n13sA+PtmdzLIlYHLn89k1EkK5Q2NNRIrpbIjim7fUuK10sH3QEx/+7
         HthguRaAQ5N0nhaqpPh56VhdoO97JPVXoFzIWeLmXnDRQbj5vfswTzpUrQWj8KCZUP8n
         6p/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFwClwuEx9SmD7+oEA/v3cdxaLtXqQ0D010UBKmNfxhp3IDhCX4tAcV61UfUK8haSYg+ISdWD+w7dpqH2qQD0xPMUY
X-Gm-Message-State: AOJu0YzX9lbx7MXpxmLL4qaNXGfsUaIyr0RLDf24FI5lMF99rqO2umuB
	lycwRHWLwTOOSitOcVvMX7PflF+0WTYKrbIQFLx2IyD1D5z1E/HE2eZjbQKQ
X-Google-Smtp-Source: AGHT+IERJCnHMNXtU79Bc4tYSQ2NdEWmSRaQu5tB7DLRCmIDtVkh3KYEQrSDyUFO1JbtNAY3O5VLYw==
X-Received: by 2002:a05:600c:5248:b0:414:71b2:73c4 with SMTP id fc8-20020a05600c524800b0041471b273c4mr2900179wmb.12.1711754625893;
        Fri, 29 Mar 2024 16:23:45 -0700 (PDT)
Received: from gmail.com (118.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.118])
        by smtp.gmail.com with ESMTPSA id he12-20020a05600c540c00b0041558f0d689sm125263wmb.16.2024.03.29.16.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 16:23:45 -0700 (PDT)
Message-ID: <fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
Date: Sat, 30 Mar 2024 00:23:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: omit trailing whitespace
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4jcooddp.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq4jcooddp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Mar 29, 2024 at 03:57:06PM -0700, Junio C Hamano wrote:
> Git tools all consistently encourage users to avoid whitespaces at
> the end of line by giving them features like "git diff --check" and
> "git am --whitespace=fix".  Make sure that the advice messages we
> give users avoid trailing whitespaces.  We shouldn't be wasting
> vertical screen real estate by adding blank lines in advice messages
> that are supposed to be concise hints, but as long as we write such
> blank line in our "hints", we should do it right.
> 
> A test that expects the current behaviour of leaving trailing
> whitespaces has been adjusted.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Yeah, ACK.  This is obviously a good thing.  I'll base my other series
in this.  Thanks.

>  advice.c          | 3 ++-
>  t/t3200-branch.sh | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git c/advice.c w/advice.c
> index d19648b7f8..75111191ad 100644
> --- c/advice.c
> +++ w/advice.c
> @@ -105,8 +105,9 @@ static void vadvise(const char *advice, int display_instructions,
>  
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
> -		fprintf(stderr,	_("%shint: %.*s%s\n"),
> +		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
>  			advise_get_color(ADVICE_COLOR_HINT),
> +			(np == cp) ? "" : " ",
>  			(int)(np - cp), cp,
>  			advise_get_color(ADVICE_COLOR_RESET));
>  		if (*np)
> diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
> index d3bbd00b81..ccfa6a720d 100755
> --- c/t/t3200-branch.sh
> +++ w/t/t3200-branch.sh
> @@ -1154,9 +1154,9 @@ test_expect_success 'avoid ambiguous track and advise' '
>  	hint: tracking ref '\''refs/heads/main'\'':
>  	hint:   ambi1
>  	hint:   ambi2
> -	hint: ''
> +	hint:
>  	hint: This is typically a configuration error.
> -	hint: ''
> +	hint:
>  	hint: To support setting up tracking branches, ensure that
>  	hint: different remotes'\'' fetch refspecs map into different
>  	hint: tracking namespaces.


A quick run tells me that this step also needs, I think:

--- >8 ---

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b41a47eb94..03bb4af7d6 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1780,7 +1780,7 @@ test_expect_success 'recursive tagging should give advice' '
        sed -e "s/|$//" <<-EOF >expect &&
        hint: You have created a nested tag. The object referred to by your new tag is
        hint: already a tag. If you meant to tag the object that it points to, use:
-       hint: |
+       hint:
        hint:   git tag -f nested annotated-v4.0^{}
        hint: Disable this message with "git config advice.nestedTag false"
        EOF


