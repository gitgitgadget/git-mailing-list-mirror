Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B71E876
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456380; cv=none; b=avPqrcYFElg2MJSIlvpRcl6uJjvOSdaKDNkTUAe8EsW1vgWmrRG0dWd1WvijPfUeCSeAWucLFmefthFcdh5s7iNsxLVDT186tMAJ8aFLeozcEIcDCH8sGaYi+yvDSbLf6QdRl9Si2pBo5xjlPpFhAQOqfnX8R3qgxHEFq2cAZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456380; c=relaxed/simple;
	bh=U7tmvtlZAPekB/BaFqCRf3mlw/ACLzW1PwNJzGk/7mM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PV8tbGAhx3DwxeP9VyOd4HXVgP3ZXU3OkEkUkZPgeHh6yGmSGGjhp9VtAW65Sf9yWdZzAF/2y7vOHmLneZlHR66nT3uYg6acZnaAeeCPFZfo8ZJ3ojPIPuOkuzuuDpAZmnW2HVrqmjhd4Uva5han4eKeZgUEZ2+8VvPYEbGboLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pfSg/fgZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pfSg/fgZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A1F1134CF5;
	Mon,  8 Jul 2024 12:32:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=U7tmvtlZAPekB/BaFqCRf3mlw/ACLzW1PwNJzG
	k/7mM=; b=pfSg/fgZAJbvor8RcpbXtnF4vff8AJlRVlpI+Eo8vPExHmRwZI8u1+
	bo3ICvEYWu1nA+35FuF+xOSdJCgH+lDewyC5JJsV+hFYE5Zy45Nv3tUR9QmUrlqF
	HHGpG4VB+5ztyDEGyekUIUdo8xw1YOPhZsY4VBY1AGMlRPsG4cGBY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A46634CF4;
	Mon,  8 Jul 2024 12:32:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29FDA34CF0;
	Mon,  8 Jul 2024 12:32:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 3/8] clang-format: ensure files end with newlines
In-Reply-To: <20240708092317.267915-4-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:11 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-4-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 09:32:53 -0700
Message-ID: <xmqq1q43kfnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA72E0E0-3D47-11EF-AA48-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> All our source files end with a newline, let's formalize in
> '.clang-format'.

Makes sense.

>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.clang-format b/.clang-format
> index 803b274dd5..4c9751a9db 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -106,6 +106,9 @@ IndentCaseLabels: false
>  # #endif
>  IndentPPDirectives: AfterHash
>  
> +# Insert a newline at end of file if missing
> +InsertNewlineAtEOF: true
> +
>  # Don't indent a function definition or declaration if it is wrapped after the
>  # type
>  IndentWrappedFunctionNames: false
