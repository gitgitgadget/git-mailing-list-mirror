Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A816C858
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338988; cv=none; b=NwsMsUMZQBUnhO1ElLvmyEvpI5uH4rPdYiTzObcyTwYiA3DwMsnB1PfQZgfhmMgeGIZ7QKVvsgP5UzLttJOfNrVb3reNVNprBFgNkxFlLM8hp1PQDw/tVgZ2fvoUBHBdPG8V/HELsNALEqE2UgDAAtbNcbaVCuuZfpsfVw0HzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338988; c=relaxed/simple;
	bh=lnrDbWp+uS1tgNg04DU7lJnWKvHRAdaNnLpSHjiKIwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVG+jahZpNLVaZoqkcaLSD5l9ksfbtauGCyeQx55FkMUUfldgKioJ04AeMY8ovRJ6ZasYVyAyGgPrDelQOfl/XihbOTBh5XZCoeB+QNRhBr7/e18R0RIGv9CktWma9p2o5/ff6KvbGuCJ8Kmo8a4R9CPxhUwVjk4D7L3jdwlqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rCmI4yiY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rCmI4yiY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E42EC21A49;
	Fri,  5 Apr 2024 13:43:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lnrDbWp+uS1tgNg04DU7lJnWKvHRAdaNnLpSHj
	iKIwU=; b=rCmI4yiY7JXWmRC6jG2N6Wxjg4LfEirFXdzdtLNwSe8RB5jGpcKWO0
	NwgD1CUl5tDRnJV+UWhCveV7Cm7yB2JHzNTNTjkhieLmbCjyaXdbgpdKDh0YYGEF
	CnH+Sz9kCewmcMYowWG0KMnsj7UUqJuqzlzIkUB5yClkqLw8j0D3k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CADBE21A48;
	Fri,  5 Apr 2024 13:43:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5598021A47;
	Fri,  5 Apr 2024 13:43:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] userdiff: add builtin driver for typescript language
In-Reply-To: <20240404163827.5855-1-utsavp0213@gmail.com> (Utsav Parmar's
	message of "Thu, 4 Apr 2024 22:08:27 +0530")
References: <20240324174423.55508-1-utsavp0213@gmail.com>
	<20240404163827.5855-1-utsavp0213@gmail.com>
Date: Fri, 05 Apr 2024 10:43:01 -0700
Message-ID: <xmqqedbjvh7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F3E4279E-F373-11EE-961B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Utsav Parmar <utsavp0213@gmail.com> writes:

> Subject: Re: [PATCH v2] userdiff: add builtin driver for typescript language

"builtin driver" -> "patterns", probably, as the "userdiff"
customization does not allow adding any new code.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4338d023d9..4461c41054 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -902,6 +902,8 @@ patterns are available:
>  
>  - `tex` suitable for source code for LaTeX documents.
>  
> +- `typescript` suitable for source code for TypeScript language.
> +

Good that you did not forget to add an entry to this list (and to
the right place).

> diff --git a/t/t4018/typescript-function-assignment b/t/t4018/typescript-function-assignment
> new file mode 100644
> index 0000000000..49c528713e
> --- /dev/null
> +++ b/t/t4018/typescript-function-assignment
> @@ -0,0 +1,4 @@
> +const RIGHT = function(one: number): Type {
> +    someMethodCall();
> +    return ChangeMe;
> +}
> diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
> new file mode 100644
> index 0000000000..6f3665c2af
> --- /dev/null
> +++ b/t/t4018/typescript-interface
> @@ -0,0 +1,4 @@
> +interface RIGHT {
> +  one?: string;
> +  [propName: ChangeMe]: any;
> +}
> \ No newline at end of file

I do not speak typescript, but is it important for the language that
the sources can be stored with an incomplete line at the end of the
file?  IOW, I am wondering if it is deliberate *and* matters to the
tests that some sample files end with an incomplete line while
others do not.

If that is not the case, please fix this and the next file; we do
not generally want a file with an incomplete line at the end unless
there is a compelling reason to (i.e., we do test that our tools
work with such files, and it may be convenient to ship sample input
with incomplete lines to run such tests).

As to the actual pattern and the words the patterns catch, I have no
idea if they are sensible for typescript language---folks with more
experience than myself should lend their eyeballs to review.

Thanks.
