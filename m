From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] Documentation/diff-config: fix description of diff.renames
Date: Thu, 25 Feb 2016 09:53:18 -0800
Message-ID: <xmqq1t80ptgx.fsf@gitster.mtv.corp.google.com>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456390761-27015-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:53:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ06P-0005dM-D4
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbcBYRxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 12:53:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932381AbcBYRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:53:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E940D47E38;
	Thu, 25 Feb 2016 12:53:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MnX5LqZ/sGQNcgArFWVm8SK/+nI=; b=qD81TB
	n5Zq1Uxn6kqP0DnjOxTTW4Mm/q8UJzmSELN8QMh2bHGII3ZSKjROQMD5gJ/bgrNT
	NM3f1QSoJXSROozIOuMD+mWRubRANmUpkYXR95ZP0PuIDEZg2kwXy1dwyVldq9rn
	r8DNZGU3F1lVE0qeUOJAvfNCAntayPs5kfqGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PJ9mqtJ3/nb/DmZGs07bU+vUVUtkcFwU
	XA+OPCiOO3tC3CdJU8g8luJtWVqwxpwK1TGsquqYr/6rLrFagF2lcIxaI+l4WIOl
	O0aTii2QnK+bd3ripvUhCEPrthVS/vat8c52/7TFEgJRujQOZljZKPT4frswv24t
	I4RtPfZ8/Oo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1B1347E37;
	Thu, 25 Feb 2016 12:53:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2068447E36;
	Thu, 25 Feb 2016 12:53:19 -0500 (EST)
In-Reply-To: <1456390761-27015-2-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 25 Feb 2016 09:59:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A75CE6C8-DBE8-11E5-96F5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287407>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The description was misleading, since "set to any boolean value" include
> "set to false", and diff.renames=false does not enable basic detection,
> but actually disables it. Also, document that diff.renames only affects
> Porcelain.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/diff-config.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 6eaa452..40e5de9 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -108,9 +108,13 @@ diff.renameLimit::
>  	detection; equivalent to the 'git diff' option '-l'.
>  
>  diff.renames::
> -	Tells Git to detect renames.  If set to any boolean value, it
> -	will enable basic rename detection.  If set to "copies" or
> -	"copy", it will detect copies, as well.
> +	Whether and how Git detects renames.  If set to "false",
> +	rename detection is disabled. If set to "true", basic rename
> +	detection is enable.  If set to "copies" or "copy", Git will

Ahh, I earlier said "Not a new issue", but it is introduced here ;-)

I'll patch them up.  Thanks.


> +	detect copies, as well.  Defaults to false.  Note that this
> +	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
> +	linkgit:git-log[1], and not lower level commands such as
> +	linkgit:git-diff-files[1].
>  
>  diff.suppressBlankEmpty::
>  	A boolean to inhibit the standard behavior of printing a space
