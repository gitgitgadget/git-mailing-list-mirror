From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 11:04:15 -0800
Message-ID: <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
References: <20130118180639.GD31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHF1-0004th-8b
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3ARTES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 14:04:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab3ARTES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 14:04:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3755AABC2;
	Fri, 18 Jan 2013 14:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fl75y7HXPxgljx3tYTfqBzw1wSI=; b=Pif4jS
	zJ8h4L2NSQ0CAP9X7fYIqh+iSLSt0JO0IzxayY7tz/Iagqmu2TudVRQmg+Qtcnqt
	GxVi0djMbv7Kg27ZT9shurLw/8vpw5V6++8ps08l+P1A98zvKWyuVINj6eEsnPKg
	fst9WXuHSpC2xWd9S92DVWO0M7AFbRoXXMDsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2Rm1opa+bi2WJ0r01U2zFeTJevCbrg9
	4z+8HTK4pBYcdNfvAvHqy+8XbL2uR/F1AjwETQVnpvYqbCDex4vbIXbZJTXukLbt
	+/iAAWSCsMFxk76ftIkIiCK2++8q5TsRPW04LGab678wtTGBCzW/Tpx/8gEEEs83
	LNMFVmMmkyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 285A3ABC0;
	Fri, 18 Jan 2013 14:04:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A851BABBF; Fri, 18 Jan 2013
 14:04:16 -0500 (EST)
In-Reply-To: <20130118180639.GD31172@serenity.lan> (John Keeping's message of
 "Fri, 18 Jan 2013 18:06:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB0BCDBE-61A1-11E2-811C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213926>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 69f7e9b..baf3b41 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -179,6 +179,22 @@ For C programs:
>   - Use Git's gettext wrappers to make the user interface
>     translatable. See "Marking strings for translation" in po/README.
>  
> +For Python scripts:
> +
> + - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
> +
> + - As a minimum, we aim to be compatible with Python 2.6 and 2.7.
> +
> + - Where required libraries do not restrict us to Python 2, we try to
> +   also be compatible with Python 3.  In this case we use
> +   `from __future__ import unicode_literals` if we need to differentiate
> +   Unicode string literals, rather than prefixing Unicode strings with
> +   'u' since the latter is not supported in Python versions 3.0 - 3.2.

"In this case"?  In what case?  This document will stay effective
long after you settle one particular backward incompatibility Python
3 introduced, namely, the unicode literal issues.  It is just one
"example".

That example somehow tells me that early versions of Python 3.x
series may be too buggy and not worth worrying about, and we may
want to set a floor for Python 3.x series, too, with something
like:

    - The code should be compatible with 2.6 and newer versions of
      Python 2.x series; 2.5 and older are not supported anymore.

    - The code should also be comptabile with 3.2 and newer versions
      of Python 3.x series; 3.1 and older are not mature enough and
      have too many problems to write scripts that work on it and
      solid 2.x at the same time.

I am not actively advocating to disqualify early 3.x; I am just
suggesting that doing so may be a viable escape hatch for us that
does not harm real users.  If you and others who know Python better
think there isn't any problem that makes it too cumbersome to
support both late 2.x and 3.0/3.1, there is no reason to set the
floor at 3.2.

I just have this feeling that we might be better off treating them
as 0.x releases of a new software called Python3, that happens to be
similar to the Python we know.
