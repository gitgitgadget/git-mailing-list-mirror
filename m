From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fatal errors on git rm (Operation not permitted)
Date: Wed, 23 Dec 2009 10:33:22 -0800
Message-ID: <7v8wctr159.fsf@alter.siamese.dyndns.org>
References: <m2oclp36zl.wl%xiaolong.snake@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xiaolong Tang <xiaolong.snake@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 19:34:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNW1h-0000Dd-88
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 19:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbZLWSdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 13:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZLWSdb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 13:33:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbZLWSdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 13:33:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8428AC3C;
	Wed, 23 Dec 2009 13:33:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xwECyhbLOx9ad2hw0EA4hEF8Jl4=; b=A33KaC
	pt+cdBkMMS6usK33jZwDDdNwdSQbiO9SejcxCR1f4V/5Iccd2y40M037RMFNFlyF
	hUGIYB11UnMeeBr29j+MOwH7Y9wi0pVDVsRkm4685i5D3BrrPbsqW2P1VxYeslTn
	PJ9W0Z8CtStJ2a/9opV69Ee5NLZx9zslvCMZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qwHwWnNEfw4Yfd6W2gbWAgUYUepkspu3
	H+d0XlqD2H2LShkwLfWvItV+oA2fmcRvOxrVs95TOUzrMwqpdf+wz7jQftUvGDjF
	tH0fOW/TxNPt/SB7WQC6vzcsru9NKoC/4wajv3yaDlduuTC26Eux1obY0ke40AuJ
	Ut1d3tiuBeU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F37F98AC37;
	Wed, 23 Dec 2009 13:33:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C63E8AC30; Wed, 23 Dec
 2009 13:33:24 -0500 (EST)
In-Reply-To: <m2oclp36zl.wl%xiaolong.snake@gmail.com> (Xiaolong Tang's
 message of "Wed\, 23 Dec 2009 12\:01\:02 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9059D74-EFF1-11DE-8CDA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135629>

Xiaolong Tang <xiaolong.snake@gmail.com> writes:

> Finally, I decide to remove this package from my laptop repository, but
> end up with the following errors:
>
> git rm -rf git-emacs
> rm 'lib/emacs/lisp/git-emacs'
> fatal: git rm: 'lib/emacs/lisp/git-emacs': Operation not permitted

We don't say "Operation not permitted" ourselves; it is coming from your C
library's strerror(3) when we got EPERM error back.  The reason you get
EPERM can vary depending on your platform and what you did to your
directories yourself, but googling for "Operation not permitted" and
randomly reading a few might give you hints.
