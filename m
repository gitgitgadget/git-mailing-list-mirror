Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761131B1502
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873217; cv=none; b=n3eeo1koTolRAyk7lwho0HxlOX53K7JnPDjF5naGUi5sDx5nTN7CGzNOKSa6HOMty/1yGe6jaqJWIrNNO4UM0nHbEVVinJ67KRI0e+v+JJ9mS66pl339HxLKSmLEoQ+SHAofEHb1GMYcw7A71QXjiRRPPveBnIFLee/VEQYDubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873217; c=relaxed/simple;
	bh=t9eyRmcaR5VtSVjkcSFNFNAtmBm1uiczsqeTc2OLABI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=URwMpeu95fK9OK9EYeSRQjOiS6uqfgm0OUQ2kNiCYO0nemBOq8QEUewq0uRDdurQxmMnhNRH1b0HvNzmFtNZr5NFG0D97K1cxpQtTrNmZ1Rw+i2onCxH7noML/Mlalxmcf20fMAjc1gkfRJfTuHd3bBiC4c/ory3mUfIyqTp/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2AoePEH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2AoePEH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso8430395e9.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873214; x=1726478014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq+Ira6sivYiYY7H0c00ElyccgD/k5lL5HXBmyQs4IY=;
        b=T2AoePEHN6bBPdQpthesNFDK3Su2wvUfJW+ZVeqAJbgyPoKhwqT7VKDGGCQBZ6UVYX
         2ukzdpET8gDlfluxh4wS8Zl7QNx/j13hcmd56nJ7PXINARxklQVLLyr3/41of2Lli4Iv
         33jeOOaxV4FI4mwWhkaBLKISsFLFJJD5TKYjI9JmaXYMntz7iit8BVONaPiBTAk4gqkY
         lVtUdXtiPr+wuHgQGrrd57P0DFvskU3bcSOIUhjHG80lVphIwZ6MqGD536f4BW0TIRk4
         qRDvO2Hn5hUSVPSKjgTOk89VlRcbf27iLJgsQED/pQ6YCMYy9RLWXitc7dK18A5YzLaa
         Fhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873214; x=1726478014;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq+Ira6sivYiYY7H0c00ElyccgD/k5lL5HXBmyQs4IY=;
        b=M/icdOBGpUkgfFO4+BSusSSZFkTueYaGdIV6mkifxhO9s7PNyGtQ+XMuenmwhO9aVG
         PrGnmdqWP7A/bx7jLLISfja88zzoFKf8UHaINEOz5LNMrqst09g1YrjTATKOjQFxLRe+
         1p9bdrQUOwS+L29XGlNeF35rY7pHv6NJ055Wyb8B0ATU4FudOvnr64XAMjg2bgWLYsOt
         ZGTFamvWXwDdfKcN5rZndKdapmIrRuCOpeX924eLe7wxs/+2zzgFlfA4Mpb3Ls6eAT7Z
         cIB6b6xXigbwfHtGlAprCNThw0l5pgnHqW/3IMNJmLC90VdP2/K7N4SrfOgJ4x09EMOd
         xRZg==
X-Forwarded-Encrypted: i=1; AJvYcCXuafd84P69RzMxQEnTymqmDCY2b8NfTWlSF63kuNOwaLj+1zSUbwGac0lUk7m5ZNBf6E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOhpFFtpk/e4G1hRSnSOylMH6sXjGGIvpH1cJojnosYot9v7p
	dlqEIeiYS3aQlzZGWGyIX3ODm5U/JJx7X9QNq2hP8pwS8YcMd8EJ
X-Google-Smtp-Source: AGHT+IHgsGTBc+kq+tOqvwbctz22uK4411PoJ67J7AcGds/SdyGXjuB1QXDq7O7/sSHqYbXXuOw5tg==
X-Received: by 2002:a05:600c:4e8d:b0:429:d43e:dbb9 with SMTP id 5b1f17b1804b1-42c9f9caa4emr66576205e9.23.1725873213770;
        Mon, 09 Sep 2024 02:13:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm64773435e9.30.2024.09.09.02.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:13:33 -0700 (PDT)
Message-ID: <ca753ef4-c567-44c3-b4c3-8e483a9a3a95@gmail.com>
Date: Mon, 9 Sep 2024 10:13:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] interpret-trailers: handle message without trailing
 newline
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
 <20240906145743.2059405-1-brianmlyles@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240906145743.2059405-1-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

This version looks good to me

Thanks

Phillip

On 06/09/2024 15:50, Brian Lyles wrote:
> When git-interpret-trailers is used to add a trailer to a message that
> does not end in a trailing newline, the new trailer is added on the line
> immediately following the message instead of as a trailer block
> separated from the message by a blank line.
> 
> For example, if a message's text was exactly "The subject" with no
> trailing newline present, `git interpret-trailers --trailer
> my-trailer=true` will result in the following malformed commit message:
> 
>      The subject
>      my-trailer: true
> 
> While it is generally expected that a commit message should end with a
> newline character, git-interpret-trailers should not be returning an
> invalid message in this case.
> 
> Use `strbuf_complete_line` to ensure that the message ends with a
> newline character when reading the input.
> 
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> 
> Differences from v2:
> - We now use `strbuf_complete_line` when reading the input file instead
>    of handling the lack of a newline when constructing the output, which
>    drastically simplifies the patch. Thanks to Phillip for this
>    suggestion.
> - Removed some unnecessary `\` in the new tests.
> 
> The range-diff from v2 is not included since the patch is so different
> that range-diff is not able to provide anything meaningful.
> 
> 
>   builtin/interpret-trailers.c  |  1 +
>   t/t7513-interpret-trailers.sh | 40 +++++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 1d969494cf..e6f22459f1 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -132,6 +132,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
>   		if (strbuf_read(sb, fileno(stdin), 0) < 0)
>   			die_errno(_("could not read from stdin"));
>   	}
> +	strbuf_complete_line(sb);
>   }
> 
>   static void interpret_trailers(const struct process_trailer_options *opts,
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 3d3e13ccf8..d78cae3e04 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
>   	test_cmp expected actual
>   '
> 
> +test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change" |
> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		details about the change.
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change\n\ndetails about the change." |
> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with a message that lacks a trailing newline after the trailers' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change\n\nReviewed-by: Peff" |
> +	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
>   test_expect_success 'with multiline title in the message' '
>   	cat >expected <<-\EOF &&
>   		place of
> --
> 2.45.2
> 
