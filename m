Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AA2D12E9
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773788; cv=none; b=VssskDFcayIH2yMXUP73tntcRlWP5QvHumGJhJSKO+kppgTCYZMWR7I2VgwUVFAQ9cW0dBBDe/B/owetYWwrmM7+MgW7qQHrLiX3n42ZWl918uS/NzXsc76P932eU2BHfeBk0Iqfw/cdbYGhV1kSM01Vj7zcslo2r19KrhFhSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773788; c=relaxed/simple;
	bh=tsL76+DOYWE9vUt8/s6sWnY9urGbij+mHNyMihEAsc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPbxEzTYveMqJJSryETQzwmCsPPMVInH14gxB3rSZRLJJWOgxXmiU/sq6YZjdp/u5hg16k6ynxyAyrKihZx0hy9rcvWF3ODfbr0oThTEc2YTyh+ja9XIdbJiAxHrNOw9Lg6gk6MikRRxcYYaZtLKVXRn/ZzlFOqYAhpNjuZhRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCmblkVb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCmblkVb"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a522224582so286126f8f.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750773785; x=1751378585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NM2ePGS2NWk49451QXrZq8YFAHJvDgbiM5s06ux8zW4=;
        b=jCmblkVbjp6t62O6zpbjDF7M6wVq5lVQXFHqshThG4U2MXNMDrqkPsFT6Zkk238YA0
         6NGxAriStg5EO3FE3ZVsT4LkPBbPKEODzOOEnNLnMzdN9NrWSfHJ97Z7QfuCpb39V3KI
         jR+I2+Ix5gII4xcJG/VPNpDfECTFgRrUUQ2Ct1Kqn9u9dIrZzoqp00ZE+Ok3aAkTMXWJ
         hbpFOwv+Om/6eA4oVcUn7OqPEU7KKLHT+JZw/KyBfzgaUqa01oviTkMOPAPshnUzwEdm
         6EYgsd2G725R6N2zbL79pf0nlg2LiS1quVc7E7johq7QPX1KoG51/e3wwaY5491lexxN
         nAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773785; x=1751378585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM2ePGS2NWk49451QXrZq8YFAHJvDgbiM5s06ux8zW4=;
        b=B4k4gAGPrVpW0DrYX+qoel1//oP3AGCOUe+5I7ldKM5kH4633aZ4Hyn7/xbRthmq+8
         5F3mbrk0+H2jwKQgUG3h4emj3DHY20lZXBmW95DwDl9bmHkFcqen0zh4bCuupAnmJjuX
         6tHUbRsNf3jfgNOoe2k2gra6b7UY/1vHrBy50CcilYmAeYUjpMMnOUUnXP9S7/wri6IN
         Y/B3Nor/ITOZWiywjx8pdUjPBy4tyXSEBRLYFTui3bzd7zvw0lJcPPRtMNU//epG4TP7
         H8ZTNvihBeMwTkzG4tObKHrCNCLvQmdnzbDKzIqFipYNe6ViIDf7hs9uPlTEb1JGaWPR
         Nqcg==
X-Forwarded-Encrypted: i=1; AJvYcCVeYdof84rhpNMdtCVe8PhcM7asFOESFq0eQJPiAhcgaICFNSunjHH3DNhqpPkFFN1NTRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9QZYL7jxUa/b20Lb1p3JnBQm3bogwKLEKYt6L0kScB2SB0ML
	aMEPfM27ixSRd5oXwQ3yZHeolq3dquUTIiKQrZJqtPZPy/M+KTEjcYLc
X-Gm-Gg: ASbGnctkkIXhoUkv11m1IvATm+G1eyFMVV2OJxxG2NSxrshKbBV7LND1BSjksK/rgr9
	dwlDn9dnDyU6y5gOIMAFCH5mBK0weve25v/+lzePQt6l+MNNXaWL+dTzY2tfOG7N5KJSE9uQezr
	AfivDFzLqY2ecpON57zxH4Xgn15z9UhBWMr5o9yuNkrop/Kz00Htl3LvdOkCR/Pvnrj+svmo4DJ
	kXKe1ALYaVbAoJMGDj2TdY7VP+L//j4aqBPT+Ox8ulto0cCslLtOxfB5XnDpbcg8led/HHk6k9I
	z5NTC3DJbE34bxmYyGSDS5bwP5acVVc/4FGZW78RPrCQEmcsfiN27eUhUbGoWyIHg8RgW50in55
	gCDAP3IFjTSjydcsHTiTUptoJwrVjvLxMYU2Mtw==
X-Google-Smtp-Source: AGHT+IGZTyDF0ndFyQ+IhBXlchHMeBAZPpVVKNPLaeyEj7z4vkE81CxVRdUKSwdhEGyytrRKP28aJw==
X-Received: by 2002:a05:6000:989:b0:3a4:e672:deef with SMTP id ffacd0b85a97d-3a6d12da0b4mr12895080f8f.36.1750773783407;
        Tue, 24 Jun 2025 07:03:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805100dsm2104381f8f.18.2025.06.24.07.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:03:02 -0700 (PDT)
Message-ID: <254e4819-a693-4fb7-aa92-260038cbfbe2@gmail.com>
Date: Tue, 24 Jun 2025 15:03:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v2 5/7] repo-info: add the field
 references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-6-lucasseikioshiro@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250619225751.99699-6-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 19/06/2025 23:57, Lucas Seiki Oshiro wrote:
> Add the field references.format to the repo-info command. The data
> retrieved in this field is the same that currently is obtained by
> running `git rev-parse --show-ref-format`.
> 
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

I've concentrated my comments on the tests as others have commented on 
the code itself. In general test bodies should be wrapped in single 
quotes rather than double quotes and one should prefer test_cmp() over 
test_line_count().

> +# Test if a field is correctly returned in both plaintext and json formats.
> +#
> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init command: a command that creates a repository called 'repo', configured
> +#      accordingly to what is being tested
> +#   key: the key of the field that is being tested
> +#   expected value: the value that the field should contain
> +test_repo_info () {
> +        label=$1
> +        init_command=$2
> +        key=$3
> +        expected_value=$4
> +
> +        test_expect_success PERLJSON "json: $label" "

This double quote should be a single quote. Unlike the test test title, 
the body is passed to eval so there is no need to use double quotes to 
expand shell variables. Indeed doing so is counter productive as it 
means we pass the result of the variable expansion to eval rather that 
the variable name.

> +                test_when_finished 'rm -rf repo' &&
> +                '$SHELL_PATH' -c '$init_command' &&

There is no need to fork a separate shell process here, you can use

     eval "$init_command"

instead.

> +                cd repo &&

If you change directory in a test then you must do so in a subshell so 
that we return to the original directory when the test finishes. In this 
case you're only running a single command in repo so you can use

     git -C repo repo-info ...

instead and avoid using "cd" all together.

> +                echo '$expected_value' >expect &&
> +                git repo-info '$key' >output &&
> +                cat output | parse_json >parsed &&
> +                grep -F 'row[0].$key' parsed | cut -d ' ' -f 2 >value &&
> +                cat value | sed 's/^0$/false/' | sed 's/^1$/true/' >actual &&

sed accepts filenames so there is no need to use "cat" here. It also 
accepts multiple expressions so you only need a single command

     sed "s/^0\$/false/; s/^1\$/true/" value >actual &&

> +                test_cmp expect actual
> +        "

Putting all of the above together the test looks like

	test_expect_success PERLJSON "json: $label" '
		test_when_finished "rm -rf repo" &&
		eval "$init_command" &&
		echo "$expected_value" >expect &&
		git -C repo repo-info "$key" >output &&
		cat output | parse_json >parsed &&
		grep -F "row[0].$key" parsed | cut -d " " -f 2 >value &&
		sed "s/^0\$/false/; s/^1\$/true/" value >actual &&
		test_cmp expect actual
	'

> +        test_expect_success "plaintext: $label" "
> +                test_when_finished 'rm -rf repo' &&
> +                '$SHELL_PATH' -c '$init_command' &&
> +                cd repo &&
> +                echo '$expected_value' >expect &&
> +                git repo-info --format=plaintext '$key' >output &&
> +                cat output | cut -d '=' -f 2 >actual &&
> +                test_cmp expect actual
> +        "

My comments above apply here as well.

> [...]
> +test_expect_success 'plaintext: output all default fields' "

The body should be single quoted as it is eval'd

> +	git repo-info --format=plaintext >actual &&
> +	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
test_line_count is a pretty weak assertion. It would be better to use 
test_cmp()

	git repo-info --format=plaintext >actual &&
	sort actual >actual.sorted &&
	cat >expect <<-\EOF &&
	<EXPECTED OUTPUT>
	EOF
	test_cmp expect actual.sorted

> +"
> +
> +test_expect_success PERLJSON 'json: output all default fields' "
> +	git repo-info --format=json > output &&
> +	cat output | parse_json | grep '.*\..*\..*' >actual &&

You do not need to use "cat" here as you can redirect the standard input 
when you run parse_json.

	parse_json <output | grep ...

> +	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
This is an even weaker assertion as the number of lines in a json file 
is not related to its content. Ideally we should normalize the json 
output into a standard format and use test_cmp. I don't know how 
practical that is.

Best Wishes

Phillip

