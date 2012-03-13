From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/diff-options: reword description of
 --submodule option
Date: Tue, 13 Mar 2012 13:04:57 -0700
Message-ID: <7vipi8uv12.fsf@alter.siamese.dyndns.org>
References: <1331665251-11147-1-git-send-email-tim.henigan@gmail.com>
 <1331665251-11147-2-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:05:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Xy0-0007CS-4m
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 21:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377Ab2CMUFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 16:05:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab2CMUFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 16:05:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7ACC5692;
	Tue, 13 Mar 2012 16:04:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eH3q7Vwedn1l/g8tcgI3sN9klC8=; b=IJslez
	760vVAdmaHHHjxcsVCYRqmyhP8j6C/UUEdfPJBcPUVviipTgWF+vr8YmaSIVSg0I
	+pHJjsPOcz35V7aPtA69yO5Q5EiXvOuVm8X5Z3RVBrYtQMfSDRCvgZrKNrSAfs1E
	Jp5jTHUmCky2VjJXU2Iwqcr39dIJgiDTB7kyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bFqlRQTJfl3N3RQwkS4hXUtQzYmXKcAa
	uXPZ+9AVNU9fDvnSz0Zi5CPUNCBn9wLIg2RofCPvIIzYxxx0UsUcRBxjxUd+54uU
	A4P3EPwBiLzlyut+0tvOUaEigbvKCmHf8cK4pDWoxVmR767wZUhNd/yjPtQ74GPS
	7co8UcW8jQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8B25691;
	Tue, 13 Mar 2012 16:04:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 703775690; Tue, 13 Mar 2012
 16:04:58 -0400 (EDT)
In-Reply-To: <1331665251-11147-2-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Tue, 13 Mar 2012 15:00:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF3B5206-6D47-11E1-A7FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193063>

Tim Henigan <tim.henigan@gmail.com> writes:

> The previous description was a bit confusing.  This rewrite makes it
> easier to understand.

I can understand the confusion.  We are trying to say too many things at
the same time:

 * There are two formats, log and short.

 * The log format is like "git submodule --summary A..B" for the range.

 * The short format just shows A and B for the range.

 * The log format is obtained by giving --submodule or --submodule=log.

 * The short format is obtained by not giving this option at all, or
   giving --submodule=short.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index f44f3fc..0e1c753 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -165,11 +165,10 @@ any of those replacements occurred.
>  	of the `--diff-filter` option on what the status letters mean.
>  
>  --submodule[=<format>]::
> -	Choose the output format for submodule differences. <format> can be one of
> -	'short' and 'log'. 'short' just shows pairs of commit names, this format
> -	is used when this option is not given. 'log' is the default value for this
> -	option and lists the commits in that commit range like the 'summary'
> -	option of linkgit:git-submodule[1] does.
> +	Choose the output format for submodule differences. <format> can be one
> +	of 'short' or 'log'. The default value is 'log'.
> +	'log' lists commits in the commit range like linkgit:git-submodule[1] `--summary`.
> +	'short' shows only the SHA1 of the source and destination.

Does it risk being unclear to say src/dst here without defining, or is it
sufficiently clear from the context (the previous line says "range")?

You lost "not giving this option at all is the same as --submodule=short".

Here is my attempt, but I do not think I particularly did a good job at
this.

        Specify how differences in submodules are shown.  A `--submodule`
        or `--submodule=log` option uses the long format, which lists the
        commits in the range like linkgit:git-submodule[1] `--summary` does.
	Omitting the `--submodule` option, or a `--submodule=short` option,
	uses the short format, which just shows the names of the commits
	at the beginning and the end of the range.
