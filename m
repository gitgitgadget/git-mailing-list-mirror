From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document bash style we prefer for if and functions
Date: Tue, 14 Aug 2012 14:09:35 -0700
Message-ID: <7vipcl89kg.fsf@alter.siamese.dyndns.org>
References: <20120814203931.GB33843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 23:09:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1OMz-0004cm-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 23:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab2HNVJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 17:09:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab2HNVJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 17:09:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25F1C8B1B;
	Tue, 14 Aug 2012 17:09:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzxMhnghEXAbU2/7WqwhqlBcqRQ=; b=wYWf1i
	3eZtDTVkh3r7FEk2wKI7E1/uDfDNG10cTtcavnjvSTUyqqUFlHX19hLo13pemi31
	GQWpaUQe7Ql8r/l2f4wFbgqTA2cNR2zTfbA4VnxfZR/z2+k1MrHspiPl++uSRBGr
	cvqTB2Tevz+gx5zOwb3y7Cu3LXAfAxhxMwDW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HRtLRKhXoUQ3ysrWp4rSULNs5TfFYySz
	4JArEhVdyCWYXQGMsMQDa0cUddLG44H5HHa4O5YoEaMFG1y353Dtw2YxSFOimie0
	+PaHjdFdGVsc/mR08pialDuVZAjp89SI9eF9S55x9FKvkRc/5y4qTpoS9jhVK3Zm
	Ndvaueo8TSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13CC98B1A;
	Tue, 14 Aug 2012 17:09:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DF1D8B19; Tue, 14 Aug 2012
 17:09:37 -0400 (EDT)
In-Reply-To: <20120814203931.GB33843@book.hvoigt.net> (Heiko Voigt's message
 of "Tue, 14 Aug 2012 22:39:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AE764CC-E654-11E1-8B6F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203453>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> During discussion of other patches these preferences have been revealed.
> Lets add them to the guidelines.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  Documentation/CodingGuidelines | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 4557711..0a07990 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -76,11 +76,16 @@ For shell scripts specifically (not exhaustive):
>  
>   - We do not use Process Substitution <(list) or >(list).
>  
> + - We prefer "then" on the next line for if statements.
> +

This is not limited to "if".  An easy rule of thumb is to write the
control structure _without_ using semicolon.

That is:

	if test ...
        then
            ...
	else
	    ...
	fi

	while test ...
        do
        	...
	done

not

	if test ...; then
            ...
	else ...;
        fi

        while test ...; do
	    ...
	done

>   - We prefer "test" over "[ ... ]".
>  
>   - We do not write the noiseword "function" in front of shell
>     functions.
>  
> + - We prefer a space between the function name and the parentheses.
> +   E.g.: my_function ()
> +

Also opening "{" on the same line, i.e.

	myfunc () {

>   - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
>     [::], [==], nor [..]) for portability.
>  


> @@ -97,6 +102,7 @@ For shell scripts specifically (not exhaustive):
>     interface translatable. See "Marking strings for translation" in
>     po/README.
>  
> +
>  For C programs:

Probably not needed, as there is no such double space between C
and Documentation sections.

>  
>   - We use tabs to indent, and interpret tabs as taking up to
