Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C9CA7A
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402916; cv=none; b=UBoyo90N7o0RYxnyYd60V+dS9IT4RWNFWKl6tGiWHtUxY3NTqiHjVILX2XkQYzXPj5XTgmM2UZCrizyvaT6ChOCmOL2V/kZrboALFMTyipgeCNs+rRIQxqQ5ACwmtT/1WDQRkTzSaNvcY0fVHh/2x0eVLoH82m9bdVatkdwX31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402916; c=relaxed/simple;
	bh=JFirfkR7rcoH+cpnGKkRDgxVqq57zZsP6cFmwRWpBNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BzGV1Z8cI71Zjui8sUpiN6X2xY2AQmGDW/HpiEsuqjqTdJ1kyhp2QAnhMzwkCIWH/v1vlmWIkkRdvSCrmDDARPv4e3AhwGE7dY57trScK7v5pBqv4waSI18AGYZ1P4CW3S4IH71dp3KY9Dq5WAxTEB4LsgAA/P605zEmYVTXwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DRLcEIWV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DRLcEIWV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2820C26718;
	Sat,  2 Mar 2024 13:08:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JFirfkR7rcoH
	+cpnGKkRDgxVqq57zZsP6cFmwRWpBNI=; b=DRLcEIWVs8P1pYh8Ej8wporX1ppc
	7SBtQTn8urHn8/IWWYCt/mzQWvVH1snWLPR5ZIxPapc5CVyJgSepytEQTvSzzlHn
	9QuMDOMCdPIsHg1Q6JeXu2EG+UzqmN6k8n8RvgiSXAdKmYnobRU3WcZnSgCqbuKg
	0clMSyNqreipKmA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2076426717;
	Sat,  2 Mar 2024 13:08:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B71CB26716;
	Sat,  2 Mar 2024 13:08:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,  Aryan
 Gupta <garyan447@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
In-Reply-To: <cf978790-4885-4103-946d-10f807048441@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sat, 2 Mar 2024 17:38:57 +0100")
References: <20240301204922.40304-1-ericsunshine@charter.net>
	<cf978790-4885-4103-946d-10f807048441@gmail.com>
Date: Sat, 02 Mar 2024 10:08:30 -0800
Message-ID: <xmqq1q8sy09t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E0D7620C-D8BF-11EE-ABB3-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> To improve the accuracy of the message, I wonder if it is worth doing
> ...
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b5eaf7fdc1..5b5ee0dc1d 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -989,9 +989,10 @@ test_dir_is_empty () {
>  # Check if the file exists and has a size greater than zero
>  test_file_not_empty () {
>         test "$#" =3D 2 && BUG "2 param"
> +       test_path_is_file "$1" &&
>         if ! test -s "$1"
>         then
> -               echo "'$1' is not a non-empty file."
> +		echo "'$1' is empty but should not be"
>                 false
>         fi
>  }

Simple and effective to remove the need to have to worry about the
"missing" case.  The "but should not be" part may still be subject
to discussion, but I do not have a strong opinion there.
