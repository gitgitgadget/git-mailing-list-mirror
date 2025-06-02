Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425E29B0
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748891115; cv=none; b=jUnRQKjpyPpGe7u2nUwBvpF4lBa87FJBlEqD8pKuP5GbHiN0DM0+CIUHwwUixHyrt6/tLc/IduKTPU8jeSY5nslfObvpP3ZfOVfzexSsukhnlfvH6uHUbcxQU8G4lGitfCVpmpb2AtxeHulx9VATiu8ewl/Lw3LkqbIsmMLFOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748891115; c=relaxed/simple;
	bh=anuJonbcJCEbwfG4jm6E0uXccgf/BlpISNJKqbdY/b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux7RsPU2gqFy20/QiPLrH538pydP5HnDN6v0g4AnIjaGQps8rIQCu0IJX43pwNIjg/Ra/UFNnxeyKCePKHDVTSemfxlh15By2vPaYAxXQ8iTZVoQdeW2cBDyTP4NnteBYBa+jOH93x/d/KcjjEgFWzBx1Uy/9nxq/5zYxv7DYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=cG0GTLRX; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="cG0GTLRX"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bB3FP1LZMz8PbP;
	Mon,  2 Jun 2025 15:05:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=anuJonbcJCEbwfG4jm6E0uXccgf/BlpISNJKqbdY/b8=; b=cG0GTLRXDa0b
	S15cN0Ee6fAFGzB117DjafAzYVaP+iLICIkk1ceE4ZjGh69DAqABm+urHQsHG1Om
	LJk6OFI0QZe6VudUIjkjNItull9TuzOWQwAp1oBgsK0ba10CBSNHDZvNMZDLwDxW
	L0kU4w+dC8b/7wsnCDJTP/0SabaKRXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=mOo
	SWEU0m+mOwZlKWo+Aj/iEXseRPQdS7nnFqG8JUXdZpe3KKS7GT5Bl9doX4wpEAdg
	BNYp3WqS/YirCdTyJAC5gKGppVsrBwQgWXAJizuAjzcWRmG0ozqfF34vvWcDEbB6
	q4iMgD+xiQZ8tKJCFdKfUXqUX722uQgFtyiQeSuk=
Received: from [IPV6:2001:470:b050:6:9ce2:364b:2e24:44cf] (unknown [IPv6:2001:470:b050:6:9ce2:364b:2e24:44cf])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bB3FN5ZMhz8PbN;
	Mon,  2 Jun 2025 15:05:12 -0400 (EDT)
Message-ID: <20913188-e706-45f2-82b8-9bf735b4f193@comstyle.com>
Date: Mon, 2 Jun 2025 15:05:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] completion: Make sed command that generates config-list.h
 portable.
To: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org
Cc: jn.avila@free.fr, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-02 2:41 p.m., Collin Funk wrote:
> The OpenBSD 'sed' command does not support '\n' to represent newlines in
> sed expressions. This leads to the follow compiler error:
>
>      In file included from builtin/help.c:15:
>      ./config-list.h:282:18: error: use of undeclared identifier 'n'
>              "gitcvs.dbUser",n       "gitcvs.dbPass",
>                              ^
>      1 error generated.
>      gmake: *** [Makefile:2821: builtin/help.o] Error 1
>
> We can use a variable that expands to a newline to do this portably.
>
> This portably issue was introduced in e1b81f54da (completion: take into
> account the formatting backticks for options, 2025-03-19)
>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>   generate-configlist.sh | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index b06da53c89..48ec8d9812 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -1,5 +1,8 @@
>   #!/bin/sh
>   
> +nl='
> +'
> +
>   SOURCE_DIR="$1"
>   OUTPUT="$2"
>   
> @@ -19,7 +22,7 @@ EOF
>   	s/::$//;
>   	s/`//g;
>   	s/^.*$/	"&",/;
> -	s/,  */",\n	"/g;
> +	s/,  */",''"$nl"''	"/g;
>   	p;};
>   d' \
>   	    "$SOURCE_DIR"/Documentation/*config.adoc \


Thanks. This was the last piece I was just going to look into, but you
have provided a solution.

