From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a basic idea section for git-blame.
Date: Thu, 08 Apr 2010 09:51:21 -0700
Message-ID: <7v8w8x7ura.fsf@alter.siamese.dyndns.org>
References: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
 <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com>
 <7vmxxe74s2.fsf@alter.siamese.dyndns.org>
 <201004081827.22706.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 08 18:51:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzuxH-0006w3-6h
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286Ab0DHQvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 12:51:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0DHQvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 12:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63228A9EBE;
	Thu,  8 Apr 2010 12:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t1HAGkacp0+uvDgotgwQyzd9tRw=; b=iY8lXh
	5ezNcVt0bAlEw3sncRY6xZagneczrgOjPS6DzdDJx1iaL90keyA41q1k3/PNGZTE
	1hoRbOz5WeFPk92Miup/X0dwCnem6V24NRc+F2aFQrzyjSmINnBjONmA6IblnYQS
	jzOS0bMEKyL1WBsput7Jz1Hxfzpq9Wjql1k2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GGpjkqoeuiOMVcDao+G+3upTPI7nqWC0
	srEeCYDL1ObwYea421gv+fH85Rakc35y8ZJRFFZqwSMNA4rPy8o6Ti2HCnAYDpoC
	fhoh+Hf/BOTLppvqLrYn1XDvQaAMeb88nEacEcgeaQV4yv24j4rnRMMLVcQu4+2x
	5+7BAS7vIfs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFECA9EBB;
	Thu,  8 Apr 2010 12:51:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28841A9EB8; Thu,  8 Apr
 2010 12:51:30 -0400 (EDT)
In-Reply-To: <201004081827.22706.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 8 Apr 2010 18\:27\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE7E9BB2-432E-11DF-8FDE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144361>

Thomas Rast <trast@student.ethz.ch> writes:

> "Horrifying" seems a fairly harsh word for another way to describe the
> process *in linear history* and with default settings, doesn't it?

No, even in a linear setting, if you start from "We discard "-" and take
blame for +", you can never get to -M/-C.

Suppose you had "a/b/c/" in the parent and "1/b/c/2/a/3/4/a/5/" in the
child ("/" stands for LF).  Your "b/c/" would match and you say "I added
1/, 2/a/3/4/a/5/".  How would you fix that so that you can say that "a/"
after "2/" was actually moved from the first line, and possibly the second
"a/" was also copied from the same line, if you discard all "-"?

You can say "in linear history and no -M nor -C, you could annotate things
this way", but then you are not describing "blame" anymore; you are
describing something else that may work very well in much simpler setting
and it might even be how some other SCMs would do it.

But it _is_ horrifying to see that in a section that begins with "blame
works as follows".
