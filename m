From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5541-http-push: make grep expression check for one line
 only
Date: Mon, 25 Jan 2010 09:47:12 -0800
Message-ID: <7v7hr63wm7.fsf@alter.siamese.dyndns.org>
References: <1264405343-2984-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 18:47:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZT2L-0005T7-FB
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 18:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0AYRrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 12:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754500Ab0AYRrY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 12:47:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab0AYRrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 12:47:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDBDD94B03;
	Mon, 25 Jan 2010 12:47:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LuWCFvuxSedx7e2vjG7Knv6fJbI=; b=b3nlyy
	eVU2AvdldM3qtKrLvlP1eLWVbJZgjqKyCYbYd02Aj/u/goGFZwPyuTEu83z/2y9R
	IKLt5e0RRtfLFt7T158TCEsQfCdSvlUOstfv33cvY+PI69jhlCJR3ssdRxoAybiF
	9xN16mGBHVtAfrqB45Sh0xZDIwp2JVY6iMWJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fabB1ySELxm50oBnLWBSavRtIf3AaGhd
	4k2EZnBUmPlEwWRyctvD3UTJEzX8sVbS5sBQTVBEzjMfRr2Vqq8FN+wTLpYVoY5E
	It4sid660xocMFZZWmwj2/p9B4xcprOBcKI7jQQvLO2T7qghk0WAfRGhKH3zWx3T
	vUgY4sEahXo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC25B94B02;
	Mon, 25 Jan 2010 12:47:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECB0294AFD; Mon, 25 Jan
 2010 12:47:13 -0500 (EST)
In-Reply-To: <1264405343-2984-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Mon\, 25 Jan 2010 15\:42\:23 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE17A7B0-09D9-11DF-8801-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137970>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Simplify the grep expressions in the non-fast-forward tests to check
> only for the first line of the non-fast-forward warning - having that
> line should be enough assurance that the full warning is printed.
>
> In the first place, grep can't deal with expressions for multiple
> lines.

This shows that nobody has ever run this test since January 8th, not even
the original author?

Hmmm.

Thanks.

>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  t/t5541-http-push.sh |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
> index 83a8e14..53f54a2 100755
> --- a/t/t5541-http-push.sh
> +++ b/t/t5541-http-push.sh
> @@ -105,10 +105,8 @@ test_expect_success 'non-fast-forward push show ref status' '
>  '
>  
>  test_expect_success 'non-fast-forward push shows help message' '
> -	grep \
> -"To prevent you from losing history, non-fast-forward updates were rejected
> -Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
> -section of '"'git push --help'"' for details." output
> +	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
> +		output
>  '
>  
>  test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
> @@ -126,10 +124,8 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
>  	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
>  	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output &&
>  
> -	grep \
> -"To prevent you from losing history, non-fast-forward updates were rejected
> -Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
> -section of '"'git push --help'"' for details." output
> +	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
> +		output
>  '
>  
>  stop_httpd
> -- 
> 1.6.6
