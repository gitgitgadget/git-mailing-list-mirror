From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed a translation error
Date: Mon, 04 May 2015 14:29:05 -0700
Message-ID: <xmqqlhh4owv2.fsf@gitster.dls.corp.google.com>
References: <554766e9.b30db50a.72e3.ffff8bbe@mx.google.com>
	<20150504211839.GX5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alangi Derick <alangiderick@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 23:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpNvO-0004aU-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbbEDV3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:29:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751015AbbEDV3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:29:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6D994F684;
	Mon,  4 May 2015 17:29:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aLLaVH3BR8ZxsgTOcdH1rtM7kD4=; b=snyF6h
	GY7HJ+vfpg2xy1mZI+Dc4o3T3CUNIKkL6S0zoTUlP64079u5W3/8JDEUipqgyteA
	AEyIQdULKP1G+QqWTRSz6STDYY+GxoHICjrHhAvnCdOoeOFC/cKL0oQyMUvyO9US
	M2TyUE06Bo2UNnd1YHUFRsAYfZOBYSQ8JcIrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1u7xKpLfnGOfXDHSRaVf2+DUPj1fPJH
	7jouzw3F8krCvNPiiX2Lg14r4e0j01QH6ZdZ4FDxVnqjrN1aM6prFrHFRGPzOTBL
	5Jkc1b52eCVJdHmbpeu+g30ndw7a0K2iRUjflK+p2HUUsCRufj9JKX3phFY9Ft6g
	G7gY7Rzwdd0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA41B4F682;
	Mon,  4 May 2015 17:29:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 218AB4F67E;
	Mon,  4 May 2015 17:29:07 -0400 (EDT)
In-Reply-To: <20150504211839.GX5467@google.com> (Jonathan Nieder's message of
	"Mon, 4 May 2015 14:18:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 984AC890-F2A4-11E4-B7F5-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268356>

Jonathan Nieder <jrnieder@gmail.com> writes:

> While we're here, start the error messages with a lowercase letter to
> match the usual typography of error messages.
>
> A quick web search and a code search at codesearch.debian.net finds no
> scripts trying to parse these error messages, so this change should be
> safe.

Very well thought through and nicely written.

I am tempted to pick this patch up and queue it on its own.  Alengi,
if you want to add _() markings to this file, perhaps it is a good
idea to base your patch relative to (i.e. on top of) Jonathan's
patch.

Thanks.

>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  builtin/config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index d32c532..89f3208 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -193,7 +193,7 @@ static int get_value(const char *key_, const char *regex_)
>  
>  		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
>  		if (regcomp(key_regexp, key, REG_EXTENDED)) {
> -			fprintf(stderr, "Invalid key pattern: %s\n", key_);
> +			error("invalid key pattern: %s", key_);
>  			free(key_regexp);
>  			key_regexp = NULL;
>  			ret = CONFIG_INVALID_PATTERN;
> @@ -214,7 +214,7 @@ static int get_value(const char *key_, const char *regex_)
>  
>  		regexp = (regex_t*)xmalloc(sizeof(regex_t));
>  		if (regcomp(regexp, regex_, REG_EXTENDED)) {
> -			fprintf(stderr, "Invalid pattern: %s\n", regex_);
> +			error("invalid pattern: %s", regex_);
>  			free(regexp);
>  			regexp = NULL;
>  			ret = CONFIG_INVALID_PATTERN;
