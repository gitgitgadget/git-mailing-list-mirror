From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Thu, 07 Jun 2012 10:23:08 -0700
Message-ID: <7vwr3jhw8z.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
 <d9e1235303c949849b9acfa37fc9e9a780d93873.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:23:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgQf-0002dL-63
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab2FGRXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:23:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761132Ab2FGRXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518A68A2E;
	Thu,  7 Jun 2012 13:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFvj3tC89PxNVHv/nCpd1hYVtYg=; b=fv46/O
	KaShtX9aQtbXlf30xQRJbYMEu1GAg90qS6FlRjrhNY24/7LAOwTHYgmCUe5+lSUV
	fxYl7sNQwTwmLEeDSDvYaVgNGwbNfvwDk3zW+M3K/oZne5TjeH8+OYyx+JRE90N7
	ylC8ibdlJ5tPrmhH/InplR47avAcZ0ksaqfEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jKv8ILmajnwNid7JdTdmz4otVu1vEuGQ
	9EWq3THjns6cNkxFCvnn+cJf/wms6v78EwRvrRHBVOIpxI/rzBsUvJog8VyJWMQU
	SoygvEJC4As0Mj8O1h/OOgfwzpk5Dg11aL2RJVR9dycJW+IrPwXdO0MWpNyrN2pi
	ZJsmMqMyy/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4706B8A2D;
	Thu,  7 Jun 2012 13:23:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFB9C8A2A; Thu,  7 Jun 2012
 13:23:10 -0400 (EDT)
In-Reply-To: <d9e1235303c949849b9acfa37fc9e9a780d93873.1339063659.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 7 Jun 2012 12:23:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7492564E-B0C5-11E1-98AA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199423>

Thomas Rast <trast@student.ethz.ch> writes:

> To save the user a lookup of the last line number, introduce $ as a
> shorthand for the last line.  This is mostly useful to spell "until
> the end of the file" as '-L<begin>,$'.

Hmph.  This is mostly useful not to error out when user (perhaps
mistakenly) expects that the end of file is spelled as "$"; both
"git blame -L<begin>" and "git blame L<begin>," have always meant
"til the end", IIRC.

Because I do not offhand think of other & better uses of "$" as a
special case that conflicts with "the end of file", I do not think
it is a bad patch that needs to be rejected, though.
