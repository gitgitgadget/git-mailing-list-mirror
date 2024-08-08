Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206BB674
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131366; cv=none; b=iGHXG+UWyHu/T01nUJJ1V0xxa2ZblxW1+54ykYC4so3vT2V9AADk/ud7BW8gRah7qFAy1I4nczIeM7zHfCgBzey+WTdWNpNqjlCB5Ac3dN+DENqRhczRvLlV2cOc/bXU2wi5FtEirSni1+dCik72k1H+f4Q5cPpEBxTu0utR4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131366; c=relaxed/simple;
	bh=NPqs/1CXwrxBLmKzQFF2vnNKQZADnozegz6xs6VZ+H0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=duNX6bR/D+iga7tjkPNkHJ8TynVRbCzsv5YobUdpQSGdojK3mjhu8pE7dPLX9yM5AhvSnSczxjIfvI5VfGhuqmdoazKYLFiQkUvW2m5WhnhG5OFh7HRoIJ2NFq/KVX8o5tFqiL1mq+RMdY4SHzvCterjGxq+6jbNWmMuScYHnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UFj/dt74; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UFj/dt74"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E298C22337;
	Thu,  8 Aug 2024 11:36:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NPqs/1CXwrxBLmKzQFF2vnNKQZADnozegz6xs6
	VZ+H0=; b=UFj/dt747klAf3nU8ZlYiD+skjA+ceo3OSgi/Wp3uDsCXsBaYV8q83
	HrQIwuNaTWrU3xSpEonbP4QufYKRQi4VEvVs5bkkkFsDx8OS3nI4mu9dsDXfe82k
	RoW7JCxvGYtrq2RaiZEf2YghJMMeWokcWT0E0MQ6/Qq1HeVIwQR9g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB08822336;
	Thu,  8 Aug 2024 11:36:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 425CC22335;
	Thu,  8 Aug 2024 11:36:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 7/8] t7004: use single quotes instead of double quotes
In-Reply-To: <20240807130259.28381-8-abdobngad@gmail.com> (AbdAlRahman Gad's
	message of "Wed, 7 Aug 2024 15:58:43 +0300")
References: <20240807130259.28381-1-abdobngad@gmail.com>
	<20240807130259.28381-8-abdobngad@gmail.com>
Date: Thu, 08 Aug 2024 08:36:00 -0700
Message-ID: <xmqqed6zkowv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB02C65A-559B-11EF-9132-9B0F950A682E-77302942!pb-smtp2.pobox.com

AbdAlRahman Gad <abdobngad@gmail.com> writes:

> Some test bodies and test description are surrounded with double
> quotes instead of single quotes, violating our coding style.
>
> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
> ---
>  t/t7004-tag.sh | 70 +++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

The conversion in this step can cause unintended breakage and needs
to be carefully done, so I checked with "git show -W" (I probably
should have done -U999 instead of just -W).

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 2b15ede1f3..046a5bd9bc 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1583,7 +1583,7 @@ test_expect_success 'creating third commit without tag' '
>  
>  # simple linear checks of --continue
>  
> -test_expect_success 'checking that first commit is in all tags (hash)' "
> +test_expect_success 'checking that first commit is in all tags (hash)' '
>  	hash3=$(git rev-parse HEAD) &&

The original used to resolve "HEAD" while formulating the command
line of test_expect_success.  Now we resolve "HEAD" as the first
thing the body given to test_expect_success is run.  As HEAD does
not move between these two points in time, hash3 would get the same
value either way.


>  	cat >expected <<-\EOF &&
>  	v0.2.1
> @@ -1594,10 +1594,10 @@ test_expect_success 'checking that first commit is in all tags (hash)' "
>  	EOF
>  	git tag -l --contains $hash1 v* >actual &&
>  	test_cmp expected actual
> -"
> +'

The argument to the "--contains" option was interpolated while the
command line of test_expect_success was formulated.  If the body of
this test_expect_success modified the value of $hash1, this conversion
would have changed what the tested command did, but because nobody
assigns to $hash1 after it gets assigned (and this is true for other
$hash[0-9] variables), this conversion is OK.

>  for option in --contains --with --no-contains --without --merged --no-merged --points-at
>  do
> -	test_expect_success "mixing incompatible modes with $option is forbidden" "
> +	test_expect_success "mixing incompatible modes with $option is forbidden" '
>  		test_must_fail git tag -d $option HEAD &&
>  		test_must_fail git tag -d $option HEAD some-tag &&
>  		test_must_fail git tag -v $option HEAD
> -	"
> -	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
> +	'
> +	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" '
>  		git tag -n $option HEAD HEAD &&
>  		git tag $option HEAD HEAD &&
>  		git tag $option
> -	"
> +	'

Likewise.

The value of $option of course changes for each iteration of the
loop, and the original interpolated it into the tested scripts while
test_expect_success command lines were formulated in the original.
Now the variable $option is used just like any other variable while
the body is run, and the tested scripts behave identically either
way.

Looks good.  Thanks.
