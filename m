From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --pretty/--oneline: ignore log.decorate
Date: Thu, 08 Apr 2010 14:13:18 -0700
Message-ID: <7vtyrl4pht.fsf@alter.siamese.dyndns.org>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
 <7vmxxggsl4.fsf@alter.siamese.dyndns.org>
 <20100408073014.GA15474@coredump.intra.peff.net>
 <7vljcx6f4f.fsf@alter.siamese.dyndns.org>
 <20100408194237.GA4222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steven Drake <sdrake@xnet.co.nz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 23:13:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzz2f-0008E9-2q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 23:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933401Ab0DHVNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 17:13:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933038Ab0DHVNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 17:13:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBFADA9454;
	Thu,  8 Apr 2010 17:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JcaX06dnA6x3UJQ3qt/rlZcQ7QE=; b=KyOvdx
	yBldyErKvDPSMkIQj+vStTClxnOY1Avn+4RbXS4ZIZ1HbeAPJRCoVbqcXBgmIp3Q
	nXFegAMSuoAQ5R/tQmDlQdJX5gSlOMdtb4rlDc8rduggEnhb5jE5abd+c0Cn4txr
	eROWeH3W9+iPrPCb0azUr+qm5zGlqLC8jykt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ke1e7S5Z+kjW4jwiW6BgO3k8edgkWUWU
	Hcs8z69Rak17aH/WOIjFqGWId6K9F2dOGAqUqKbK9Uh6Bysd+guJgAdT6/yuoq5I
	L/P1ytAwdUJ5ZmHn2WKZb+LuZggz3/w2P2MuPZbJ8jBRJgoj1jR6mOYcE7uAXXmX
	SXpUlNCOcO8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7527A9453;
	Thu,  8 Apr 2010 17:13:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4ADA2A944F; Thu,  8 Apr
 2010 17:13:20 -0400 (EDT)
In-Reply-To: <20100408194237.GA4222@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 8 Apr 2010 15\:42\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 921E7CE2-4353-11DF-B140-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144383>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] script with rev-list instead of log
>
> Because log.decorate now shows decorations for --pretty=oneline,
> we must explicitly turn it off when scripting. Otherwise,
> users with log.decorate set will get cruft like:
>
>   $ git stash
>   Saved working directory and index state WIP on master:
>     2c1f7f5 (HEAD, master) commit subject
>
> Instead of adding --no-decorate to the log command line,
> let's just use the rev-list plumbing interface instead,
> which does the right thing.
>
> git-submodule has a similar call. Since it just counts the
> commit lines, nothing is broken, but let's switch it, too,
> for the sake of consistency and cleanliness.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think these changes are Obviously Correct (tm)

Looks good; thanks.
