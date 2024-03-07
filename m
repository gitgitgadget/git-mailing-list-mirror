Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398F64CDC
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843521; cv=none; b=rsMwiu0grE9F/EhB60Nr1JCKSnK2+6KPsvoz/u5C3w4FZfSSabTtp2xFeQJ/aiCR+/Z1RuE5xVrem0BVCQF526rfZPUCTwDO8Yvt9ScQ12KO+zUixxYxtdUIvB4D7AsgAOZXRT2Q/c4d+RdVOh+pl/kzNLN+eahF3h0pmeVQg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843521; c=relaxed/simple;
	bh=CRLqVmr5Gp0+m8gxTQCFdqqGEuFJbLDPQdmZFW4KgGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dbXETV2yH2SUi+0fYYGPHdrRmENbIgcYGL8ZQleowUUmzr0qT1pFVUTghpSIqUDLEaJCFNnSyiVNQZEGF88WfAlJnKoKhf74K361h6Vs/ECadf/vbZW6zrP19edo9h1Ug7eypSPqDR21UFecFwz17bMHwilVQqFriX9rX/qwKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qDHFxklM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qDHFxklM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7900F31A8F;
	Thu,  7 Mar 2024 15:31:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CRLqVmr5Gp0+m8gxTQCFdqqGEuFJbLDPQdmZFW
	4KgGE=; b=qDHFxklM4UNvFf6CyJypFATh4/BzZYlFefgESld/kI/f3sB7/1CtTO
	2McZSHbGgMjici5zYQJTH06XHR3Gb7+Y4jItX2+DtcZhNbwvfoj9DXEreBWuYPY4
	gWBh7ZL8O0o4agasH+nKySeeDNCY7oGTMiG4XDyWSHDGmeOMAbTd8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FDC131A8E;
	Thu,  7 Mar 2024 15:31:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 083E731A8B;
	Thu,  7 Mar 2024 15:31:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix missing single-quote
In-Reply-To: <20240307084313.GA2072022@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 7 Mar 2024 03:43:13 -0500")
References: <20240307084313.GA2072022@coredump.intra.peff.net>
Date: Thu, 07 Mar 2024 12:31:49 -0800
Message-ID: <xmqqo7bplr62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA7AEBD2-DCC1-11EE-9C49-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> The formatting around "option push-option" was missing its closing
> quote, leading to the output having a stray opening quote, rather than
> rendering the item in italics (as we do for all of the other options in
> the list).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just happened to notice this while looking at the rendered manpage for a
> different option.

Thanks. This looks like an ancient typo.  Applied.


>
>  Documentation/gitremote-helpers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index ed8da428c9..07c8439a6f 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -526,7 +526,7 @@ set by Git if the remote helper has the 'option' capability.
>  'option pushcert' {'true'|'false'}::
>  	GPG sign pushes.
>  
> -'option push-option <string>::
> +'option push-option' <string>::
>  	Transmit <string> as a push option. As the push option
>  	must not contain LF or NUL characters, the string is not encoded.
