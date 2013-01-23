From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 8/8] reflog: use parse_config_key in config callback
Date: Tue, 22 Jan 2013 23:04:45 -0800
Message-ID: <7vpq0widma.fsf@alter.siamese.dyndns.org>
References: <20130123062132.GA2038@sigill.intra.peff.net>
 <20130123062737.GH5036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 08:06:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxuPz-00039E-Sp
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 08:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab3AWHEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 02:04:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab3AWHEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 02:04:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A01918B;
	Wed, 23 Jan 2013 02:04:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ZSohkKBCKNyrzpIR49WL5ENUQ0=; b=jcLIr0
	hiD27sB9SmNjoVf5d6Yc+54pvoUjZknlC2mLh9FZ+8nDKw8sywpLq6dnha4bDY/s
	OJvI48G+zvUJWLnUWeBrHysuFxxHFji0LAPD0Q/QpKG6QggF8JPp+/SOPm2wFjZz
	IiP14+Udaf8TCSvRNBEuzsz1T9FT/Bw9z/Fjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wIf61TM96S+8md8BgIeCqzpJM7DCTlPm
	jPBJjAxlFWhRM7Mjs6mdfBE2kvMQcHnLegBVMDvB/eMNDQg0oZSYqnQU4JY5L52m
	S2/u8reKIsZV+VBjMwPJsMpbH2nTfVoyztI+YmbeaJYqoMgWb3OZrLlz9PJSDota
	2oyeV8n7vG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F2D918A;
	Wed, 23 Jan 2013 02:04:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 464B19189; Wed, 23 Jan 2013
 02:04:47 -0500 (EST)
In-Reply-To: <20130123062737.GH5036@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Jan 2013 01:27:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C222F9A-652B-11E2-94B0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214294>

Jeff King <peff@peff.net> writes:

> This doesn't save any lines, but does keep us from doing
> error-prone pointer arithmetic with constants.

Yeah, this and 7/8 shows that the true value of the new parse
function is not line number reduction but clarity of the calling
code.  There is really no point making everybody implement "last_dot
is there, so the subsection name must be between the section name
and that last_dot" like the original before this patch.

Thanks.  Will read it over again and then apply.
