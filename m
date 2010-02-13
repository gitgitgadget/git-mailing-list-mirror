From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-for-each-ref: add new field name "symbolic"
Date: Fri, 12 Feb 2010 23:45:50 -0800
Message-ID: <7v4ollshn5.fsf@alter.siamese.dyndns.org>
References: <1266040518-11748-1-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Feb 13 08:46:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgChV-0003ut-VJ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 08:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab0BMHp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 02:45:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0BMHp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 02:45:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F9EE99290;
	Sat, 13 Feb 2010 02:45:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=KnWXH/+0xZGzGG7vudDfAHqwUjU=; b=fTjaOj3iscW5jlrxfXuXFkH
	W797jVsXW9pe1xl8kjH21QRggEtaYWz/7GKzoS9QFyunT8paV1s6cypDuVbgcVlg
	B2NzpSlscQenkHjidIy6VfuVqjbtlANOVmCK/HyeetVkLW7dxTDl+bCxr2jnolSt
	ZOgEnuYgRReEXfGaTCFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=u9oHZwRZZRhlsP3DHj3Xo172zWWCoA6VUgvkK3rl/1qhFgD6u
	Mredm0hzLHeK2+vSR1HF8liRIZM4GdOkutpsiC+2o9+wV/sfaG7nXx5gn5AqFtX0
	+3dJuhYAMG52AIb3vlleMEIr3SvhjrD7EGhBJF2TBxZ2FTzMjuL1J5KaGs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 085449928F;
	Sat, 13 Feb 2010 02:45:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65CB29928E; Sat, 13 Feb
 2010 02:45:51 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D055A3B0-1873-11DF-8CD6-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139780>

Larry D'Anna <larry@elder-gods.org> writes:

> %(symbolic) will expand to "true" for symbolic refs, and "false" otherwise.
> This is a lot faster than calling git-symbolic-ref on every single ref from your
> shell script.

I think this is a good idea, but I suspect that much more than half of
people who iterate over for-each-ref output and run symbolic-ref would
actually want to learn what actual ref a symbolic one points at.  So you
may not be helping as much people as you could by going in this direction.

Instead of expanding to "true", why not make it show the expansion if it
is symbolic, and to empty if it is not?
