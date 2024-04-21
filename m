Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D906111AD
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728002; cv=none; b=ltzN3QoXlWrGrwEwrt2918FKmNn06sdVBjTyRnsFKvvy8ndrfWgg9KKZna0jrCiRUTpjVOW6yJxB8qXu/zlRvTtp1Kjf922NqB+tlU81Z6CsLNBaSBa3eZYL5ftW3YO9J+teaZ/belPfwOTMelVykGXIxND3smHguNVRVGM5zLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728002; c=relaxed/simple;
	bh=MYed18tOkJpLxqKi+u27NEfUSeK021Sbha0qxEwqnsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8NvMYm0eDU0px8nOghFAeQ9pOljGPo3l9Z+DU5mELT5jPezIi4MtXx5P5L8CtoLSc9JI+n5AubT1MQx3JMXZSLqyOrIFx61SBsYg3PNI3wm0mL1fUSzDV0viGi0zv9z/crvtPN+EYwxPKBfNI+e5QZ/zq6wVNweHkjpc9aXEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DyXYy3Sj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DyXYy3Sj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36DFF1EFBF3;
	Sun, 21 Apr 2024 15:33:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MYed18tOkJpLxqKi+u27NEfUSeK021Sbha0qxE
	wqnsI=; b=DyXYy3SjCZJZQx33xIvfDO6XfiI6EV7Rs6aH/uQQtNL1Iqkq7AJhL/
	qSg2i2wuDRv2XKxXwRc9Ybi4s7izdw7Q4dV5x/zV0dS78VQyKSRi5TLp7N6GnEMu
	IncwwgWQUABMBhwKy6umyEppLGgvh3mcHWLWvsx3shx9ujA7JyIAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E8671EFBF1;
	Sun, 21 Apr 2024 15:33:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A4121EFBF0;
	Sun, 21 Apr 2024 15:33:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org,  worldhello.net@gmail.com
Subject: Re: [[PATCH] [RESUBMIT 2nd] Consistency for substitution hints
 (i18n) 1/1]  parse-options: use localized substitution hints
In-Reply-To: <20240421191458.5411-2-ash@kambanaria.org> (Alexander Shopov's
	message of "Sun, 21 Apr 2024 21:14:57 +0200")
References: <20240421191458.5411-1-ash@kambanaria.org>
	<20240421191458.5411-2-ash@kambanaria.org>
Date: Sun, 21 Apr 2024 12:33:18 -0700
Message-ID: <xmqq5xwa1pfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 021CB9E4-0016-11EF-B310-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Alexander Shopov <ash@kambanaria.org> writes:

> i18n: as translators choose substitution hints applicable
> to their writing system, expose the ones in parse-options
> for completeness

Please do not mark a patch whose contents has changed with "RESUBMIT"
and the like.  The earlier ones you had had unwanted "// Fixme" left
in the patch and I am guessing that this version has removed them?
Those who have read the earlier one, when the see the RESUBMIT in
the title, would probably have ignored the patch and wouldn't have
noticed that this one is improved over the previous attempts.

As to what the patch tries to achieve, I do not have a strong
opinion, but the title and the explanation of the patch in the
proposed log message looked somewhat strange, and the newly added
comments looked overly long, all of which you may want to correct
when you send out "[PATCH v2]".

Thanks.

> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  parse-options.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 63a99dea6e..2362ca83f3 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1061,11 +1061,20 @@ static int usage_argh(const struct option *opts, FILE *outfile)
>  		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
>  	if (opts->flags & PARSE_OPT_OPTARG)
>  		if (opts->long_name)
> -			s = literal ? "[=%s]" : "[=<%s>]";
> +			s = literal ? "[=%s]" :
> +			  /* TRANSLATORS: keep as is unless you use hints for substitution other than `<>'
> +			     in which case use those */
> +			  _("[=<%s>]");
>  		else
> -			s = literal ? "[%s]" : "[<%s>]";
> +			s = literal ? "[%s]" :
> +			  /* TRANSLATORS: keep as is unless you use hints for substitution other than `<>'
> +			     in which case use those */
> +			  _("[<%s>]");
>  	else
> -		s = literal ? " %s" : " <%s>";
> +		s = literal ? " %s" :
> +		  /* TRANSLATORS: keep as is unless you use hints for substitution other than `<>'
> +		     in which case use those */
> +		  _(" <%s>");
>  	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
>  }
