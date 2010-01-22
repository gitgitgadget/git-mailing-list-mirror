From: Junio C Hamano <gitster@pobox.com>
Subject: 1.7.0 release plans
Date: Fri, 22 Jan 2010 00:08:54 -0800
Message-ID: <7vvdeuzhm1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 09:09:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYEZu-0005GZ-Pp
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 09:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab0AVIJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 03:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077Ab0AVIJB
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 03:09:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab0AVIJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 03:09:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C7A593373;
	Fri, 22 Jan 2010 03:08:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=O2MI
	O41LHr9AriVHGzX3c7xigHg=; b=IvLBiTxMKja1ovIx4jmUXjqLo7ga6zpu2HoW
	pSy5u9fAzzKJ7fRmtVB8gk3QRtyY+uqjNGPCh1+fugmogKsLfoSLHHhiBTEkPAD2
	ujpG1h6pjCm+xrsYBLOlVwyTll2sTL6G6gZT/6s99Z8Xc2OYwSrnqqATmM7jWZVB
	2EZNuHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pYJ
	u/nTSNa28wlzJQXYhghJO2OCZsCmNYVIbm+tVMuicD2v/2QyQ1UY9rspsTN+XWVd
	3f3vJt8zuLBUErHy4ewQ2wNrXBT+qhnjLMajPBfGGma9y8EDhPkCm3ub7jUTL0du
	o4dnjRHxy+IFxkl6zIPIwAZW5b3BE5MFB72w6q0Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5620693372;
	Fri, 22 Jan 2010 03:08:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A313393370; Fri, 22 Jan
 2010 03:08:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63BF324A-072D-11DF-BA1A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137745>

As I've been repeating lately, I'd like to tag 1.7.0-rc0 this weekend.

We don't have any written, official-looking rules for patch acceptance
during the -rc period, and have been playing by ear.  The rule of thumb is
that if a patch is not in 'master' by the time 1.7.0-rc0 is tagged, it
won't be in 'master' until 1.7.0 final is released, unless it is:

 (1) a fix to a regression caused by changes since 1.6.6;
 (2) an obvious fix to a new feature we added since 1.6.6; or
 (3) an obvious fix to a problem we had even before 1.6.6.

When you have a patch that adds yet another new feature that you think
complements what we already added since 1.6.6, you could argue that the
patch falls into the second category, by saying something like: "the new
option to do X is not complete without configuration variable that tells
git to do X by default, and another option to override the configuration".
We need to discuss and judge if the the argument has merit, which would
largely depend on what that X is.  So the above list is not completely
black-and-white.

We'll cook 1.7.0-rc0 for a week or so, accumulating fixes and then tag rc1
by the end of this month.  After that, only fixes in category (1) and
perhaps really obvious ones in category (2) will be applied for rc2, which
should happen around Feb 10th.  I am hoping that we can cut the final
release around mid February.

I don't know if I have enough bandwidth to review and queue patches that
fall outside of the above "meant for 1.7.0" criteria to 'next/pu' branches
during the feature freeze, but that doesn't mean I'd discourage people
from working on their own topics meant for post-1.7.0 cycle. Hopefully we
have enough qualified people to help reviewing them.

In any case, I'll be moving my focus to the 'master' branch from now on,
and I ask contributors to help hunting and fixing problems in 'master', so
that we can have a solid 1.7.0 release (on top of which you can build your
favorite shiny new toys ;-).

Thanks.
