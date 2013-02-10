From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/15] user-manual: Give 'git push -f' as an
 alternative to +master
Date: Sun, 10 Feb 2013 14:00:50 -0800
Message-ID: <7vsj53sub1.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <f0f8b77a3487be30ee4c492899fe73af05e20413.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4exk-0000Tr-MD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab3BJWBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:01:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415Ab3BJWBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:01:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977C1CB15;
	Sun, 10 Feb 2013 17:01:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E5SwIa75lNn9aEgvegi0dJ2xs9c=; b=WxVKu9
	Kle+WRA2NMyFDC9tMPmXLHG72hEw03FyX6StWEHmaAcS3BWLUCenZHPd+gD2e9iw
	C52shWAn29JYuksWUd6pg4qNtQqMAQYaG5lB7vzHNWUHjQouofxMa8PPQMYw2D1i
	GveAReB4hVupXTffXxxlahEzQe248shwU9qLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jts+uFL+UuSVouxapsP2SbGcMeRotuSy
	e3kBL1X2QHoKduwuQIrSMolW5P448FM5EI6WX7Hfh0hsFoNQR5ovwlLNB0mxA1kt
	PxUjFnEiqXlRMCpfjHifSDalt4s4LR2WVgGxyjPa2bIKbgLj33+qFeOHantKsSiG
	pUyRRxX986U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19D26CAE2;
	Sun, 10 Feb 2013 17:00:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64E43CA9F; Sun, 10 Feb 2013
 17:00:52 -0500 (EST)
In-Reply-To: <f0f8b77a3487be30ee4c492899fe73af05e20413.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58E96056-73CD-11E2-8BAA-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215945>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This mirrors existing language in the description of 'git fetch'.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 5d80b40..a68d6b9 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2045,6 +2045,13 @@ branch name with a plus sign:
>  $ git push ssh://yourserver.com/~you/proj.git +master
>  -------------------------------------------------
>  
> +Note the addition of the `+` sign.  Alternatively, you can use the
> +`-f` flag to force the remote update, as in:
> +
> +-------------------------------------------------
> +$ git push -f ssh://yourserver.com/~you/proj.git master
> +-------------------------------------------------
> +

I didn't check the surrounding examples but would it make it a bit
too advanced to make the example flow push out more than one
branches here (perhaps he is also updating the 'maint' branch)?
Then use of "--force" can be explained as "Instead of adding + to
each and every refs to be pushed, you can use a single -f to force
everything."

The mistake I would want to avoid teaching the readers is to replace

	push $there +master maint

with

	push -f $there master maint

or even worse

	push -f $there
        push -f
