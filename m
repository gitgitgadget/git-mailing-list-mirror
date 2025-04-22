Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F02836A9
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328265; cv=none; b=nVb15EESpq+VvbGjhGuQROV+VJXsKCRclhfUAX1lJ5EeMR/TB+DTrCtq9pRncrTnpfzp/+k/R/ifcNsum8uynm76SOgZGGKasL2FtnGpdbKG2W2IDUHdA/zrW4UEe2Zxxt560Ue83jYzMR0jJCf+Qy3L3fdbUsFVouQSmu7XVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328265; c=relaxed/simple;
	bh=G3zcoSBDPRt08KqWRAS7cpLtIHaIBq8Gckko8FEn+i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tj3It0usS9YsHvRTGGvsuDpDxKaNsngH6zY8cazEEs9fxSM/U4jZNXefpwzSod3OYwiTBcKa1x9VKTVFPBJBbJa13+aArAGJHAuif4yY1DMOo+Z3dg3nSpnswAjSszFlVt4o+4ssVECrEtgzmBPsFbB6HkOkJXCiNMlFCxXHn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf0J9lWT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf0J9lWT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so36192015e9.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745328262; x=1745933062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H20M9wVfszmHFyHVNnx7urLki/SiE1Sxoym1SfXjsII=;
        b=Nf0J9lWTG6/hurzDFBZp3Fr8hOEdSDdHoTTamvrdMcsq1gx1PhmyoYc/i5L6bU4/7t
         N2eNoH3yCik/IBl4TGrIJzib6Hbc5NwRi9xW/BTIkxk09O7iIHHetLPyo+Hz/8SMyDGZ
         M97Mngq8zJP8sBMXc89mq/nn10W2ewewtoTFZ+7l3roQSZphyyWjSfdYG/fh8MGpq3co
         5JusiJCcI8ZgZ4irLIJ7s/ODXJJQYmRlWBfIG/pIQVyS3/VFwLhMFhCMRzTefVUA9oCQ
         X3A357Z13GihtJahSDtK/x9az04jGkGwTTmJBic7bvTnfWvMkpuNPv8PMclCbQQghap1
         OZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328262; x=1745933062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H20M9wVfszmHFyHVNnx7urLki/SiE1Sxoym1SfXjsII=;
        b=N14Ei0Y2QwLzD8YI1itEi56nqcCQAk8xR22hhbCk3lnPs7blaOVVyY3r6vIxSQd2wN
         iy+Sf9zvZfFxCLYU3OXDbd4xtO8yxZavrycYoOgeSr3F4pVewWU/eggbYDniRLKCsGzP
         6PpucM+065pVbRwIRZNp/GukiYNI7BJy1TZ8UzL64mFJnw1wLhWhzf7FKOrf7iO7WxXc
         PQmZDrxAZLn+feQHLjt11T4vQEDvB74po1ne+XqQclIkDokBcjDazzJun9ZcRnn2cjrD
         z1EuVnHM4EXGtUNnOVzYlyaI99wrWRdWwZAYfGyreYJylX1KQLEfTxlyDrb3JxseRp7Y
         FFfQ==
X-Gm-Message-State: AOJu0Yyi+1jV6PUBw4pAp3xg40W0hcVUTXF9sUe2JkkRBwi06PVA7gC8
	Md6pZfp4ikvfAKD+8hBHwo1kOac4G30t0enMKvYpGQdjP3qwGGQs
X-Gm-Gg: ASbGncuEN0W3O4cLP1aBnW0H4zVnJKUtW2saWw8d/9ydmT2ZvGSKMIXwG08n06Lsimf
	5HYSJSBn0cA7QeXElv2bBlUs7be83fVDqcpL0fHw8ceJDkMY/fn+leT63MzT65BgGAOybsqOVXH
	/Bgc3HXEZp2rRbFN/0Kjed8zj0ST8dYb0W3a1CZUbghJbQTi2Uf2QjhSa4xafeuAxvYue40yHXe
	HUHNS0cctKy16fYbr8xG5pQpj14D8UlBvbNRA+VFbweBuRjGX7IT3gDnBV89IbJTje0IjYkBPd9
	ssW5zxAWaJAZM2tpgol9LHgvUM4RD/zaubNrT9iiN9fiUeaBVLPsDbefJ2iLEMkS82BTiDlog39
	umOV3ys7WlXDeFHSR
X-Google-Smtp-Source: AGHT+IHQ9Tp0SRVwqvXgH4zGUVAIX5YHRGaN/Gow7pavLy5kzoz+bFNF1t058yfGKNKnRAAxYMnwsw==
X-Received: by 2002:a05:600c:1c2a:b0:439:9737:675b with SMTP id 5b1f17b1804b1-4406b23033bmr112561395e9.7.1745328262270;
        Tue, 22 Apr 2025 06:24:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6e0183sm175719445e9.37.2025.04.22.06.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 06:24:21 -0700 (PDT)
Message-ID: <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
Date: Tue, 22 Apr 2025 14:24:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 21/04/2025 16:33, Karthik Nayak wrote:

Thanks for putting this together, I've left a couple of code comments below.

>      Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 37541f3d10..a09fcf4d72 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -414,6 +414,16 @@ jobs:
>       - name: prepare libc6 for actions
>         if: matrix.vector.jobname == 'linux32'
>         run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
> +    - name: install git in container
> +      run: |
> +        if [ -f /etc/alpine-release ]; then
> +          apk update && apk add --no-cache git
> +        elif [ -f /etc/almalinux-release ] || [ -f /etc/redhat-release ]; then
> +           dnf -y install git
> +        else
> +          apt -q update && apt -q -y install git
> +        fi
> +        git config --global --add safe.directory "$GITHUB_WORKSPACE"

I'd be tempted to check for which package manager to use by using 
`command -v`. That way the only distribution specific knowledge we need 
is the package manager and we don't have to worry about the names of the 
various release files in /etc.

	if command -v git
	then
		: nothing to do
	elif command -v apk
	then
		apk add git
	elif command -v dnf
	then
		dnf -y install git
	else
		apt-get -q -y install git
	fi

The commands above omit anything that updates the package cache as we do 
that anyway in install-dependencies.sh and we only really care about 
getting some version of git installed here. It also uses apt-get to 
match what we do in install-dependencies.sh

I also wonder if we should ditch the checkout action and use something like

     git clone --depth=1 --single-branch ${GITHUB_REF_NAME} \
	${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}.git

so that we know we will be building from a git repository.

Best Wishes

Phillip

