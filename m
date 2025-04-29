Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BC29DB7E
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917225; cv=none; b=X3mutwxMjTkyTSwYRxXAnl5V0eS7uBgBmBIlVtynyYEuZn9n5xwCpV5CvN1tpYIEsaPT0T84z+3qAv0Wnor/aMqEj5d0mgqi8tn+qKBamKaK4UyNCafVpcdFnDpIDGPy7tQW17m155bH/E9g6+NR0N0Ekj4yHHPUuoc4XcqU+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917225; c=relaxed/simple;
	bh=Oosm5hOxAs/WSs6OpHqNgqiJSUZc9/0OQb1twEjB+lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3rfkQiDNFZaUz6bH8TpxOQPNsmmkuJxBBLk9xQyImrdkVNLAdzqip1oTLpq12PxXL3WkKCrAFc6lI0SS/MVGa+wrGzkI9Ye7XI6aoS1v8b8xkDfLV2PVA7UxowdG3h2SkV+QCkecFgUtFvN+CFwfKs22SW3G4T1MW2xWxBFv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF3hNYkN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF3hNYkN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso27991925e9.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745917221; x=1746522021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k8laCAudJ3QeIigzRAKXMXeLmFt6d9ElHOK/LA0mZjM=;
        b=GF3hNYkNDnOStPRpSde3NmEiaBOrEBIgL74ZB7mvZcbEGhPyK5mVJRmXXwPDChlF8B
         tUyeR9mp+T/b14YOPQpS37jpkybswSHiM3dLoBB5YAUI5U/WhKzyq41oBZQ7/cl0zkCk
         gl+57FnnXKr2poz1yHQXoIYPx+4os4IzqXTvTXn5O2RYJdUBRPdM7NlyGVfwjrxxwNX/
         MFtz/KyGqvPSSjrPDarmNRuSPgxEA24ytmk0hW9xouHS1lCrAOraXBi0y0qRfSWUcE5Q
         3o1qrmJ29FP6G6R0SgnH7TgD09fp2eCQgA72prHfh7OWfApEdUdXNmQLfdIzHP+0JQYH
         Olkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917221; x=1746522021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8laCAudJ3QeIigzRAKXMXeLmFt6d9ElHOK/LA0mZjM=;
        b=Y3OYlzQyRj5eao8jz3y4gxaEuO4+SmfRIIHoI+I95QNBEVY9rDOQr0mfu4cXCF1UU3
         migfvUnxDNIVdqYdECCAYuvz/ZDl5MjIUwOgIugIwqvtW9yEKiBjd/XXODAiGa8a4zzL
         yHXcDp9HB2n3COsT1UFIu1i/b6mEJcdDLuvgtGkRFnyeB77N9XeJ0E2doCL5zZmBSZx+
         nqMuVAfMb9WK69ZRlY/bDunJEGIdOCUxwUSMQy2MZMWqrgExLV+IsqHmcSW9SU7TwDux
         ySGWNc6RINrurZI5m54rcjZVZerCPDtIgyAGPQ+sXecaaq1qjt2edM5/1ikQxsmE7fWO
         +jCg==
X-Forwarded-Encrypted: i=1; AJvYcCXW/SgmZFc15ecvSy84poxPGGR/p3eQbAUj85n8xKoRwgy6dSFpTc3Cv5/QxLtc1F3A/gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wR7kOqGnfqh/K/qKUSoQAPe5CCvfTgMKJivblJwb2Vdi5wKN
	BP1+YcpmF1VVmK1K1Yrqd3s9PNFy7dMbD0PdYDFNlpsv7IfgT7E27N/JmQ==
X-Gm-Gg: ASbGncvbDWBerfZLD7dgndn7IHCEyvxNw6NrCYnSrNOsJ0NrBR7VqOsdT7yVySvODW+
	dJ7rjU2bgbv2+GNnxJtfGb121313H1k77Vy/mCR77iFrqBEZe3bBAX0uibDOIIwP3+tIFwR8703
	dTyDVLRvHMyVuvHGaGdIF1OdaQZcmEJaG+CWKQ7vTlB+9mjggsTU4b7ocHzDibKjyaRIAQVZsyH
	LWRYme4ihK59AhL5aDPLWNt0CwMIiiHlkTxGtIE2xdObUqFmjLaTYPG12Zwhj056Tkp+LW9lP96
	g3D6sdsaODodUVnECZ1QXgmr115GXYn56Ec2+WMMGvTs2dBCuq3rB+PJKFeCgj2RBey8dSabodz
	u3aIOc9EIsl42Ce4v
X-Google-Smtp-Source: AGHT+IFcQd1iKDfj9I6Hr960yWess4WXuyuypL2hX9VbhGIhBh7wQpvlUj7Lf3dPh5l6H7Hwa1Qx1g==
X-Received: by 2002:a05:600c:468a:b0:43d:ac5:11ed with SMTP id 5b1f17b1804b1-441ad4e58cemr14319735e9.24.1745917221339;
        Tue, 29 Apr 2025 02:00:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2abdf7sm181001355e9.19.2025.04.29.02.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:00:20 -0700 (PDT)
Message-ID: <d71b3fc1-d2fc-436d-876c-0bd1475a88ce@gmail.com>
Date: Tue, 29 Apr 2025 10:00:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Toon Claes <toon@iotcl.com>, Scott Chacon <schacon@gmail.com>
References: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
 <pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Scott

Thank you for updating the documentation. This version looks good to me

Thanks

Phillip

On 25/04/2025 20:33, Scott Chacon via GitGitGadget wrote:
> Sorry everyone for the noise. There was a whitespace issue the tests
> complained about, hopefully this fixes it.
> 
>> bundle-uri: copy all bundle references ino the refs/bundle space
>> bundle-uri: update bundle clone tests with new refspec path
> 
> Scott Chacon (2):
>    bundle-uri: copy all bundle references ino the refs/bundle space
>    bundle-uri: add test for bundle-uri clones with tags
> 
>   Documentation/technical/bundle-uri.adoc |  14 +-
>   bundle-uri.c                            |   2 +-
>   t/t5558-clone-bundle-uri.sh             | 202 ++++++++++++++----------
>   3 files changed, 124 insertions(+), 94 deletions(-)
> 
> 
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v7
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v7
> Pull-Request: https://github.com/git/git/pull/1897
> 
> Range-diff vs v6:
> 
>   1:  d6ec5c87b43 ! 1:  1cbf0787d49 bundle-uri: copy all bundle references ino the refs/bundle space
>       @@ Documentation/technical/bundle-uri.adoc: will interact with bundle URIs accordin
>        -   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
>        -   stale bundle refs can be deleted.
>        +   client unbundles that data using a refspec. The refspec used is
>       -+   `+refs/*:refs/bundles/*`. These refs are stored so that later
>       ++   `+refs/*:refs/bundles/*`. These refs are stored so that later
>        +   `git fetch` negotiations can communicate each bundled ref as a `have`,
>        +   reducing the size of the fetch over the Git protocol. To allow pruning
>        +   refs from this ref namespace, Git may introduce a numbered namespace
>   2:  825d2b01eae = 2:  7f36484e267 bundle-uri: add test for bundle-uri clones with tags
> 

