Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318054BC5
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679229; cv=none; b=pfoO1jbVp1ps0Z7Jw8+gzvQZNvu05e6jB2Zsh67C36453fLw/NX8Y8ZjfdZg0xNTToj7aGa/5ED6jmJD1B8TsmztBtZI3y/Kh0uNFjJhXdpctmp5UuNqljPDUbItSATJhukoX7mrNt8Iw6xMJ4xZbuKs4ptw5gcUrSQELTmD2LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679229; c=relaxed/simple;
	bh=FpaBsNeCp2KEvuif1T3/4B4RDQHCR89kvDxghrJE6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lo1SWYHrgkg1MEhAKjpyZK8Bq2s/RHAfBTGBv5RQXSo6TVLUWLF4dFmMa/ypfg3ncKQZVz+NK44gzXfFy5HNmECSRIVl9IngLZ1Bepu5tbdGP3Q9/0yICqU3qY+hMPQFCBQjzs9un3e8bSmb4SLyXtFSVwHRM9vlesqeYEapCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jng5VZb0; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jng5VZb0"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a29882fdeso406581cf.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705679227; x=1706284027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2ExA1/0cavZK7KQaJ5LuJ53EwGo/u7xARW+e6YrR84=;
        b=jng5VZb0EH7WJm0tuHsA4XwhJmuQhceMp5LynqO2qXSQcsfSgp9VI54s/hn6Vdqgsm
         osRFD7PvSUtIXBqYWGYCIGHqjzbgCzydRwasYGaKwvyRQN4ysPywxJjDX0Xjjg19hKEu
         +x3DNxIoyJiWyAcX8892knmcfvveX+hSHC/if56WEsou2U2kuhTkDOF554VtG2rgFVWt
         cdQUbAWd6IzQB9eMS7Et/MyurBFz+i0dfHIVABL47JHsOSZjqwB1yHePdJ+gR2YG7fyJ
         h5bttfFjXSIaXuDfVE2IPPptVf6FBzbTSMSgUo9UOX76Bn6i39M5gwulyq20qrwGDczu
         syng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679227; x=1706284027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2ExA1/0cavZK7KQaJ5LuJ53EwGo/u7xARW+e6YrR84=;
        b=bqs25+3LY2KMf6tBRxZ25TxOyqpKfycyYm70Qt0AfoyPu7e3vsvcALIT8rCM9PuWqK
         1HYGlH2GhW7Q3i/HWmeF02at9Llien/9vh//mockC0neGBxHraztB8ckaOz7Qwc5wbSF
         V6w5wH4ivSTtZ1Jhksi57mwyL8rzI9EHAPWJGw282X9xdtRuO5Jc1VV6BvgdI/tyXCIQ
         goRi5I+ApJKe/ZOIIclPT/a/r33TC1hiqxfTTrkPf5Lz2l0DLwjT6HJxNoR6Ec1tH+iA
         vBu5G5+yCrqO0Ox0dD/1JmzyS2J7zM3DZnhrjbeKVtE6BYFK6Djvu4T9q//f7oNGd2B0
         cDcg==
X-Gm-Message-State: AOJu0YxgAC1qJY/pCTRYHv7eZQVfpdYiT1gxjZ0xLzRkq9hac6VHDuc3
	MqKFEecOup2mNr8e88SnvIXyFf6bYcfNuLH2Voxx4ue+8QgkIgpR0grqZsXl
X-Google-Smtp-Source: AGHT+IHACpI2wy8dWS+hEaF99NwINUdwfjeLQFAyL8VT6sCpbL7ybLavXZG1xBR4dr8hxrCfBNRugg==
X-Received: by 2002:ac8:5e4c:0:b0:42a:29b5:557 with SMTP id i12-20020ac85e4c000000b0042a29b50557mr1146871qtx.4.1705679226684;
        Fri, 19 Jan 2024 07:47:06 -0800 (PST)
Received: from [192.168.1.160] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm6678057qtb.45.2024.01.19.07.47.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2024 07:47:05 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/12] t3903: move reffiles specific tests to t0600
Date: Fri, 19 Jan 2024 10:47:05 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <06EEFC6C-5ACE-49D7-AF24-C0D950241E86@gmail.com>
In-Reply-To: <Zap7jfZlwlm-UZ1X@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <56a9c8f20dd7c8f3e9401b2bd3929fb9c53c7d27.1705521155.git.gitgitgadget@gmail.com>
 <Zap7jfZlwlm-UZ1X@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 19 Jan 2024, at 8:39, Patrick Steinhardt wrote:

> On Wed, Jan 17, 2024 at 07:52:33PM +0000, John Cai via GitGitGadget wro=
te:
>> From: John Cai <johncai86@gmail.com>
>>
>> Move this test into t0600 with other reffiles specific tests since it
>> modifies reflog refs manually and thus is specific to the reffiles
>> backend.
>>
>> This change also consolidates setup_stash() into test-lib-functions.sh=

>>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  t/t0600-reffiles-backend.sh | 27 +++++++++++++++++++++++
>>  t/t3903-stash.sh            | 43 ------------------------------------=
-
>>  t/test-lib-functions.sh     | 16 ++++++++++++++
>>  3 files changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh=

>> index 704b73fdc54..bee61b2d19d 100755
>> --- a/t/t0600-reffiles-backend.sh
>> +++ b/t/t0600-reffiles-backend.sh
>> @@ -527,4 +527,31 @@ test_expect_success SYMLINKS 'ref resolution not =
confused by broken symlinks' '
>>         test_must_fail git rev-parse --verify broken
>>  '
>>
>> +test_expect_success 'drop stash reflog updates refs/stash with rewrit=
e' '
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		setup_stash
>> +	) &&
>> +	echo 9 >repo/file &&
>> +
>> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>> +	git -C repo stash &&
>> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>> +
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $old_oid
>> +	$old_oid $new_oid
>> +	EOF
>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>> +	test_cmp expect actual &&
>> +
>> +	git -C repo stash drop stash@{1} &&
>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $new_oid
>> +	EOF
>> +	test_cmp expect actual
>> +'
>
> I think that there is no need to make this backend-specific. What we're=

> testing here is that `git stash drop` is able to drop the latest reflog=

> entry. The calls to cut(1) are only used to verify that the contents of=

> the reflog entry look as expected while only verifying the old and new
> object IDs.
>
> So how about below patch to make it generic instead?

Nice catch. This sounds perfect to me.

>
> Patrick
>
> -- >8 --
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 34faeac3f1..3319240515 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -200,7 +200,7 @@ test_expect_success 'drop stash reflog updates refs=
/stash' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success REFFILES 'drop stash reflog updates refs/stash wit=
h rewrite' '
> +test_expect_success 'drop stash reflog updates refs/stash with rewrite=
' '
>  	git init repo &&
>  	(
>  		cd repo &&
> @@ -213,16 +213,16 @@ test_expect_success REFFILES 'drop stash reflog u=
pdates refs/stash with rewrite'
>  	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>
>  	cat >expect <<-EOF &&
> -	$(test_oid zero) $old_oid
> -	$old_oid $new_oid
> +	$new_oid
> +	$old_oid
>  	EOF
> -	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	git -C repo reflog show refs/stash --format=3D%H >actual &&
>  	test_cmp expect actual &&
>
>  	git -C repo stash drop stash@{1} &&
> -	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	git -C repo reflog show refs/stash --format=3D%H >actual &&
>  	cat >expect <<-EOF &&
> -	$(test_oid zero) $new_oid
> +	$new_oid
>  	EOF
>  	test_cmp expect actual
>  '
