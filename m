Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BC535A2
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779155; cv=none; b=IRc2wtx9wnd2JWC1DZ6BfhzQMY72P84ZXzhNjOEMf9mYb6vbJlbVvhgokcSEto8AguU8hZzfL/5SkuFwEj9WzuWI26gJBOyP6Id6P0s8OT92R7dWN0kNPTDr2Ty8zaJ6WvgzyNkxfEFDG/wbFc3QHC4JtjqXvkyh3ULE809vSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779155; c=relaxed/simple;
	bh=P9LpPAABluqok61oAfdeP9ieJHRFCsyy7YtDqjh546s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEqonr5rgPITPzpBUpcrzUGthqarTJDVnAt8as3/y/jnjs0NkksCxVPY9g54iglAWPItOd/XQvjqS9La71yTp91BXHkuEouoTvrZRbyHCQvsyxMQWDNIAhH47e9wuyWJn1+fhkWi4fXkEx1tFcHOH9x9YcHKs7GkjKmA84Al2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BhJDjRpL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BhJDjRpL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 080222E1C4;
	Mon, 18 Mar 2024 12:25:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P9LpPAABluqo
	k61oAfdeP9ieJHRFCsyy7YtDqjh546s=; b=BhJDjRpLso7GURcYPzh4l2HMWH+8
	HdWTM9ewQ3GWogc8AdhKr9pxZjD3dbJwvsbChkg96MSdQ267uVAnCpQz/q379nxL
	EJm+JGW7Kv290bHObI2s8iaK4TKB84Fk60Qx0K6mZWLOIsayH4rvGsnzEYpbxMea
	QG4rXuX75x410mw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 00C3E2E1C3;
	Mon, 18 Mar 2024 12:25:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 969432E1C1;
	Mon, 18 Mar 2024 12:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH 1/2] t-prio-queue: shorten array index message
In-Reply-To: <197f5ac9-7257-4caa-aa9e-041016c787f7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 16 Mar 2024 21:45:51 +0100")
References: <197f5ac9-7257-4caa-aa9e-041016c787f7@web.de>
Date: Mon, 18 Mar 2024 09:25:48 -0700
Message-ID: <xmqqa5mvjylv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2F218B3C-E544-11EE-892A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If we get an unexpected result, the prio-queue unit test reports it lik=
e
> this:
>
>  # check "result[j++] =3D=3D show(get)" failed at t/unit-tests/t-prio-q=
ueue.c:43
>  #    left: 5
>  #   right: 1
>  # failed at result[] index 0
>
> That last line repeats "failed" and "result" from the first line.
> Shorten it to resemble a similar one in t-ctype and also remove the
> incrementation from the first line to avoid possible distractions from
> the message of which comparison went wrong where:
>
>  # check "result[j] =3D=3D show(get)" failed at t/unit-tests/t-prio-que=
ue.c:43
>  #    left: 5
>  #   right: 1
>  #       j: 0

Very nice touch, especially the removal of ++ from the message ;-).

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/unit-tests/t-prio-queue.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
> index d78b002f9e..616d0fc86f 100644
> --- a/t/unit-tests/t-prio-queue.c
> +++ b/t/unit-tests/t-prio-queue.c
> @@ -31,16 +31,18 @@ static void test_prio_queue(int *input, int *result=
, size_t input_size)
>  			get =3D prio_queue_get(&pq);
>  			if (!check(peek =3D=3D get))
>  				return;
> -			if(!check_int(result[j++], =3D=3D, show(get)))
> -				test_msg("failed at result[] index %d", j-1);
> +			if (!check_int(result[j], =3D=3D, show(get)))
> +				test_msg("      j: %d", j);
> +			j++;
>  			break;
>  		case DUMP:
>  			while ((peek =3D prio_queue_peek(&pq))) {
>  				get =3D prio_queue_get(&pq);
>  				if (!check(peek =3D=3D get))
>  					return;
> -				if(!check_int(result[j++], =3D=3D, show(get)))
> -					test_msg("failed at result[] index %d", j-1);
> +				if (!check_int(result[j], =3D=3D, show(get)))
> +					test_msg("      j: %d", j);
> +				j++;
>  			}
>  			break;
>  		case STACK:
> --
> 2.44.0
