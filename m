Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422E13E8AE
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456368; cv=none; b=TmUCSRn+8nUzJXx/xRxudBlSFkA1noAd9zHkcL59eodA1vRxXaooL+Fr+cdb1ivVQZf/VoDyuNhm/otFbD/BjQyBhbZ56bdlztnlHdqHwz5b02zfx2BrzcqsXrGN+oUd9ZNi0e2liz8TuIcGBhwQy4rMQ+bMb1Bw8gVC3celi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456368; c=relaxed/simple;
	bh=NTEX+GXcE7+bk3wVQeUjBL4dvOhczrx7yu3q7bn4gyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHa1D4UOgSAWpPu1qw++BiwhQ3dbhWUBimVtD/sc+4yOtIVb7kB9w8xLNK2QGLV1WFQNFL7aTjeANWdGgzro8QgoFIkcK7Mz/Le11Hwem6WTVPQReQIswXaMWbcaCx27529F7DZ3M3+WRMDMTxfQAzJLP7jFr2DsOdTpgr505JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=owd73C6n; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="owd73C6n"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3ECD334CEE;
	Mon,  8 Jul 2024 12:32:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NTEX+GXcE7+bk3wVQeUjBL4dvOhczrx7yu3q7b
	n4gyM=; b=owd73C6nbydFMH22FsY8KnINvvIVdc87vLtBjn7HGhS/kcMOuvSGwD
	yMQyGo92WhHiTg1SBYX9Io1BRVJ9pgx4kKVGuDm7CCF8lr739wNqSBn/NsUy3dmY
	V03tQQPCNMKF33CF3CTqfkHd/C+M3DLqzX5D8bkqblbKHcEBHbY3M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 388F934CED;
	Mon,  8 Jul 2024 12:32:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8AD534CEC;
	Mon,  8 Jul 2024 12:32:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 4/8] clang-format: replace deprecated option with
 'SpacesInParens'
In-Reply-To: <20240708092317.267915-5-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:12 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-5-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 09:32:41 -0700
Message-ID: <xmqq5xtfkfo6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B30CBD6C-3D47-11EF-9F5F-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Replace the deprecated options 'SpacesInParentheses' and
> 'SpaceInEmptyParentheses' with the newer 'SpacesInParens' option. The
> usage is the same.

I do not follow clang and clang-format development; updating to
avoid deprecated features is a welcome change, as long as the
replacing feature isn't too new (like, "introduced only 3 years
ago").

Thanks.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/.clang-format b/.clang-format
> index 4c9751a9db..914254a29b 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -134,8 +134,6 @@ SpaceBeforeAssignmentOperators: true
>  # }
>  SpaceBeforeParens: ControlStatements
>  
> -# Don't insert spaces inside empty '()'
> -SpaceInEmptyParentheses: false
>  
>  # The number of spaces before trailing line comments (// - comments).
>  # This does not affect trailing block comments (/* - comments).
> @@ -149,9 +147,10 @@ SpacesInCStyleCastParentheses: false
>  # var arr = [1, 2, 3];    not    var arr = [ 1, 2, 3 ];
>  SpacesInContainerLiterals: false
>  
> -# Don't insert spaces after '(' or before ')'
> -# f(arg);    not    f( arg );
> -SpacesInParentheses: false
> +SpacesInParens: Custom
> +SpacesInParensOptions:
> +  # Don't insert spaces inside empty '()'
> +  InEmptyParentheses: false
>  
>  # Don't insert spaces after '[' or before ']'
>  # int a[5];    not    int a[ 5 ];
