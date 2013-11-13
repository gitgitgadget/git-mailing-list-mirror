From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] State correct usage of backticks for options in man pages in the coding guidelines
Date: Wed, 13 Nov 2013 09:21:38 -0800
Message-ID: <xmqq61rwfc9p.fsf@gitster.dls.corp.google.com>
References: <1384316501-27965-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 13 18:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vge8W-0003XV-5x
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 18:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516Ab3KMRVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 12:21:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab3KMRVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 12:21:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8794C50019;
	Wed, 13 Nov 2013 12:21:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTpE7Xov1wwX12FvbgHVLN+/TtU=; b=GZkz6a
	bQOYshclVS90QutMCg7E+2Ky9SH02vB8F/LK6I2WgwhG967peJ2ZyZ6+TujYtEeu
	Qz1QT1KcEAe6hyko6AxqVVb4/sXWE3trAEqac/XOhDVjVvXkOZ1OHq2EWnpSCq76
	IB4dg1U9Fjtgmni5fOWB9ABUAUjnQ9BVdXvLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bPL7HBOJQ1TBsNI88eH4awZ/DhdMdJ/8
	EUWnUt9uDLlcfZ7njD4Wv9xf9lHkttUIZLck14hujauuNhhCPTdriNnBLaKPMrVs
	CILWsTFpQzhCzfleYi0DFtVQwoZFmumTsBOKb+M3zi5Q1gTaliXCnWTo5xnQ+vIR
	5/h+KAzl5iM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7049350016;
	Wed, 13 Nov 2013 12:21:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBE645000F;
	Wed, 13 Nov 2013 12:21:40 -0500 (EST)
In-Reply-To: <1384316501-27965-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Tue, 12 Nov 2013 23:21:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F55AF28-4C88-11E3-AECF-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237794>

"Jason St. John" <jstjohn@purdue.edu> writes:

> + Backticks are used around options or commands:
> +   `--pretty=oneline`
> +   `git rev-list`

I'd prefer to see the objective stated before a particular means to
achieve it.  I.e. not "backticks around options and commands", but
"literal examples (e.g. use of command line options, command names
and configuration variables) are typeset monospaced, and if you can
use `backticks around word phrase`, do so.".

> + Options or commands should use unescaped AsciiDoc:
> +   Correct:
> +      `--pretty=oneline`
> +   Incorrect:
> +      `\--pretty=oneline`

I think it is wrong to single out "options or commands" here, and
also it is wrong to say "unescaped".  The "unescaped" is merely a
consequence of combination between:

http://www.methods.co.nz/asciidoc/asciidoc.css-embedded.html#_text_formatting

    Word phrases `enclosed in backtick characters` (grave accents)
    are also rendered in a monospaced font but in this case the
    enclosed text is rendered literally and is not subject to
    further expansion.

and the use of `backticks` to achieve "literal examples are typeset
monospaced" rule.

If some place in the documentation needs to typeset a command use
example with inline substitutions, it is fine to use +monospaced and
inline substituted text+ instead of `monospaced literal text`, and
with the former, we do need to quote the part we do not want to get
substituted.

Thanks.
