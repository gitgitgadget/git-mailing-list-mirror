From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 19:41:48 -0700
Message-ID: <7vwr2s5f9v.fsf@alter.siamese.dyndns.org>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
 <7vbok4785a.fsf@alter.siamese.dyndns.org>
 <20120627221106.GE2292@sigill.intra.peff.net>
 <20120627221938.GA1742@arachsys.com>
 <20120627225248.GB27566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 28 04:42:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk4gk-0003WB-RA
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 04:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab2F1Cl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 22:41:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757917Ab2F1Clv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 22:41:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6604C8085;
	Wed, 27 Jun 2012 22:41:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FBxw7NEsTp51g0GP/8kT0eORB2Y=; b=INP0qD
	LSsE7XSB3KYuuMs8xJFLQ+NBPzYRZkS/F78gzckoe5wSfqv/Ia/bPokWqymnpOi/
	YZhBxiZPReS8HjSAclsTxhp+M7Dj4Z8kVvMgXDMERF/CtFQx2DcPGKbghrGZa8iq
	E1egJXpkoDQ9sFPEcsN+7UE2XnTTJ9Hvwtmzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0DQRhDksqKCq5DaBHeWYqXlpZ+GIZIr
	LZKQIw9W6RhFJmVT+wAcZ/RH/2G/RzE1zySAM97SRbt2+/d4CEbrXGirujPL0Bbp
	S0MxLDgYpjFJ+eol3vZhSCJbjYGL0i2dZWivchuV95lK5fuVwjNp2znZLkyf3DOR
	C9cdaXT9ezs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E18B8084;
	Wed, 27 Jun 2012 22:41:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E616C8083; Wed, 27 Jun 2012
 22:41:49 -0400 (EDT)
In-Reply-To: <20120627225248.GB27566@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Jun 2012 18:52:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFC4FE76-C0CA-11E1-8C61-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200773>

Jeff King <peff@peff.net> writes:

> So one solution would be to simply remove the check entirely. It was a
> slight nicety in some situations, but expanding the definition of the
> HTML path to include full URLs means we can no longer accurately
> determine what exists and what does not. So we can just stop trying and
> let the browser handle it completely.

This, and "://", both sound sensible.

> Another option would be to introduce a new "net" type of help format
> which accepts a URL instead of a path. That would leave the existing
> code-path untouched. But it does seem needlessly complex, as it would do
> more or less the same thing as the "html" format.

Yeah, that does not sound like a good reason to have such a complex
scheme.

Thanks.
