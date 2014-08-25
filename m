From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t0026: Add missing &&
Date: Mon, 25 Aug 2014 10:38:23 -0700
Message-ID: <xmqqmwasmpv4.fsf@gitster.dls.corp.google.com>
References: <53F797B3.3070107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLyLM-0004p5-QN
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933086AbaHYRqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2014 13:46:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64995 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbaHYRqG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2014 13:46:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 803E5334F2;
	Mon, 25 Aug 2014 13:46:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zWD4aWHTitYL
	3JbG/8qDjl98rjY=; b=Ep3DDaDcu2vFsQyJ/gA+Xl1/ll5QwX0QWYGKB2H8jaTu
	vBlsP+dpPahWCD/jA6rIrZE9DXUUxoqrZpi6pxyUQ1FGZ1Dp7e+Rk6NSF5sd2J/S
	O+Tcxdz3fNbsfUjkc5sSDEP69ZENGfGphYw82fm/72ZLWBpxZtXjKxgaBxByJ+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kdu3sd
	uNh7uUDBxn2xkONn2Oun+B9z1Zy+lS3bjagenhY33iziyMQoL/RQDKi0jbRe4YLl
	XFBITL1p7I7vup2k5G5c+vOhVY9y3nZnx+pfEMv+E487HAi7pmsuJWYvDFwRYYp7
	8VqSM/viAnt5BFMUFWGXVfjeCouWk7AEP7PWI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75C67334F1;
	Mon, 25 Aug 2014 13:46:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E076331BE;
	Mon, 25 Aug 2014 13:38:25 -0400 (EDT)
In-Reply-To: <53F797B3.3070107@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 22 Aug 2014 21:19:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9DFABD00-2C7E-11E4-AB4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255844>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Fix the broken && chain
>
> Reported-By: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Please fold this kind of "oops fix breakages discovered in the
version that hasn't been reached 'next'" to the patch that
introduces the breakage, with "Helped-by: whom".

Thanks.

>  t/t0026-eol-config.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
> index 43a580a..4806969 100755
> --- a/t/t0026-eol-config.sh
> +++ b/t/t0026-eol-config.sh
> @@ -84,9 +84,9 @@ test_expect_success NATIVE_CRLF 'eol native is crlf=
' '
> =20
>  	rm -rf native_eol && mkdir native_eol &&
>  	( cd native_eol &&
> -	printf "*.txt text\n" > .gitattributes
> -	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt
> -	printf "one\ntwo\nthree\n" > fileunix.txt
> +	printf "*.txt text\n" > .gitattributes &&
> +	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt &&
> +	printf "one\ntwo\nthree\n" > fileunix.txt &&
>  	git init &&
>  	git config core.autocrlf false &&
>  	git config core.eol native &&
