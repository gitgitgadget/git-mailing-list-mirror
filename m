Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7515DBD6
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861590; cv=none; b=H5auPE/ySP6CzDEEn15YWS0BAldpqes55hij3STGGTzI66UMBLEPPKw0spQhAo2m/21xbsF6d7mjuHe4/a4kDVCG91kK7wZ8ugWL0/2inkMVTt4DPiWXWod97V8tjRxXJqdyakVoXHIp0DdSpiSp2RCJMmygncTHQcDGApXTPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861590; c=relaxed/simple;
	bh=nGlWMexDO4YhOSPV1MLx1c1nZjv/JCpFNfOwoigSZM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqmUdVM2px98uiwNw2W4qXAzCAMgyW7WIEpq9KqAVBiOVY4ygwKWIEFFrHZWh52p+7NVizCty6u9Hvb+LpV+iyfY6uzpT6NhcnV4lY2CeqapsUTfSI4EdRUjfGbDXU/kXIvHhOvtFqjur9Ke3aMg6Tf2va/YAoM3uanNdrMsGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0mdhODK; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0mdhODK"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 117931DF28;
	Mon,  1 Jul 2024 15:19:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nGlWMexDO4YhOSPV1MLx1c1nZjv/JCpFNfOwoi
	gSZM8=; b=e0mdhODK4hEW9GpR200/FP64NU3CzPwfEBqgxmX2Kk51UbrBoV4UEb
	C6RnCxxJR4lw3OkomKK1lyfu1rx98Csrzi1oamYvJZ8F+/f7RX4jgl4+Ql87gDZq
	BBK6Jr4TKiR/JXm2blXA/gT+Hk8pNstZuM2KBho69i/Gh43HJCAgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A0EA1DF27;
	Mon,  1 Jul 2024 15:19:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82F351DF26;
	Mon,  1 Jul 2024 15:19:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] pathspec: fix typo "glossary-context.txt" ->
 "glossary-content.txt"
In-Reply-To: <20240629193137.54037-1-abhijeet.nkt@gmail.com> (Abhijeet Sonar's
	message of "Sun, 30 Jun 2024 01:01:37 +0530")
References: <20240629193137.54037-1-abhijeet.nkt@gmail.com>
Date: Mon, 01 Jul 2024 12:19:43 -0700
Message-ID: <xmqqa5j0x6ls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E033A33C-37DE-11EF-B976-C38742FD603B-77302942!pb-smtp20.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> The pathspec syntax is explained in the file "glossary-content.txt".

Obviously correct.  Thanks, will queue.

> Moreover, no file named "glossary-context.txt" exists in the repository.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  pathspec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pathspec.h b/pathspec.h
> index fec4399bbc..de537cff3c 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -23,7 +23,7 @@ struct index_state;
>  #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
>  
>  /**
> - * See glossary-context.txt for the syntax of pathspec.
> + * See glossary-content.txt for the syntax of pathspec.
>   * In memory, a pathspec set is represented by "struct pathspec" and is
>   * prepared by parse_pathspec().
>   */
