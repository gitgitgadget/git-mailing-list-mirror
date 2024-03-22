Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53EE78297
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147264; cv=none; b=ZdAKDFv2ZvT3fi037nPDnguPSU5mPgAEyGSqHHTHxfvq1kGcF6QX9LbFQnH6hSLHzw2A4NKCa4U70FG91lsMj+dVnvZD2i7kgKhuoIbRW45Wi0VVZTk/jCB9siE6nVOl9KfPDGnOlbOcbz2tQ6Wjj/LotHmno33jO28ovj3+3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147264; c=relaxed/simple;
	bh=841B2BJRcB7UIGRvWFJ8yrNqGcojAVnoEUEqAm1uIo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRNtDDkXX+9WcLljcl4s7YkUQ9EeGzIA34QRcEddUcb9bh65aryy3rsQWUziWuc0X7nI1GmtWRuHlfLLuWw6rdT7/3RxeKLNp8HvuyvhzaRkQ8Rvjv2wLE3DbjBj/lYhDSy72ToFeVxrRJJ3RaItPh29GMIHNLy4cfdH3H8Ps+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RgRrTnJE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RgRrTnJE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B81A41F7300;
	Fri, 22 Mar 2024 18:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=841B2BJRcB7UIGRvWFJ8yrNqGcojAVnoEUEqAm
	1uIo4=; b=RgRrTnJE+SuBaFgSL4T6IBCo0f/xMwT+/PE6hqeUOsCEfwyHek+p6Z
	ek1O1h4UjEO5PChRkPW7ORj9ZFn/GYn964S1u4xa1EgstnfvEFTYN0ma7TX7b8VN
	waufnTcEHprmDbNBmqYU8wCwfY/K3yVvYwSWzVAXRwzv7W7hY0Tws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F04E1F72FF;
	Fri, 22 Mar 2024 18:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B57A11F72FE;
	Fri, 22 Mar 2024 18:41:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org,  Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] editorconfig: add Makefiles to "text files"
In-Reply-To: <20240322221813.13019-1-mg@max.gautier.name> (Max Gautier's
	message of "Fri, 22 Mar 2024 23:17:58 +0100")
References: <20240322221813.13019-1-mg@max.gautier.name>
Date: Fri, 22 Mar 2024 15:40:59 -0700
Message-ID: <xmqqo7b5zy84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41DE4B28-E89D-11EE-AFB9-25B3960A682E-77302942!pb-smtp2.pobox.com

Max Gautier <mg@max.gautier.name> writes:

> The Makefile and makefile fragments use the same indent style than the
> rest of the code (with some inconsistencies).
>
> Add them to the relevant .editorconfig section to make life easier for
> editors and reviewers.
>
> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
>  .editorconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.editorconfig b/.editorconfig
> index f9d819623d..15d6cbeab1 100644
> --- a/.editorconfig
> +++ b/.editorconfig
> @@ -4,7 +4,7 @@ insert_final_newline = true
>  
>  # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
>  # them in sync.
> -[*.{c,h,sh,perl,pl,pm,txt}]
> +[{*.{c,h,sh,perl,pl,pm,txt},config.mak.*,Makefile}]
>  indent_style = tab
>  tab_width = 8

A question out of curiosity (because the answer does not affect any
conclusion): Does editorconfig attempt to cover any non-text files?

Two more questions that do affect the conclusions are:

 * Among the files we ship (i.e. "git ls-tree -r HEAD") and edit
   with editors that honor .editorconfig settings, are there any
   file that we do not want tab indentation other than *.py?

 * Does .editorconfig file allow possibly conflicting setting, with
   a reliable conflict resolution rules?

What I am trying to get at is if it is possible to make something
along this line to work:

    [*]
	charset = utf-8
	insert_final_newline = true
	indent_style = tab
	tab_width = 8
    [*.py]
	indent_style = space
	indet_size = 4

I am assuming, without knowing, that the conflict resolution rule
may be "for the same setting, the last match wins" so by default we
always use "indent_style = tab", but if we are talking about a Python
script, it is overruled with "indent_style = space".

If that is possible, we do not have to keep adding "ah, files that
match this pattern are also text", i.e., everything is text and
indented by tab, unless specified otherwise.

Thanks.
