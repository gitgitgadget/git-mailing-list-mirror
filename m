From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hooks/post-receive-email: do not truncate messages at a '.' line
Date: Thu, 17 Jul 2014 12:36:13 -0700
Message-ID: <xmqq38dzpykx.fsf@gitster.dls.corp.google.com>
References: <53b2ad7801889b49f04cb0ae7b0b37b@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 21:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7rTf-0004wb-GS
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 21:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbaGQTgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 15:36:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55522 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbaGQTgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 15:36:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AED5F299A6;
	Thu, 17 Jul 2014 15:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8TQ/ZHSBKjM+iznwlIkBSs6eFpg=; b=mr6Rl/
	rRANG+lR1QrNyID+88FBkZcHqp6AhlZ6uW0QOFZniJXq0OHsClPZ3gQVswDjb0k0
	pqjL5cuUt1VjOjk1PLf1ot9Fn9aEzFxjX0+WxqyxZjwIHf+bUBCmGcxUKjsKii4k
	N+AJvgMyLUn+ti3FAlv0Ae1+/ldCkB81fEH2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mnnSkCRoBAUAZfIOR6WlOSG31yKchbsk
	fhpmFIsr5RyZi6ewO1vm0z3jaZwXUAICUQcWuxljIKxbNOhoC1O0pCy6zaQKBTqf
	/8ltINzIgmRSiDDgtHTviX5aAa47+LFhJevOkScAB9z1FUEXL6ZyeS/8b7UkcCVU
	riSJg6TVikk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A43C0299A5;
	Thu, 17 Jul 2014 15:36:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6991F29995;
	Thu, 17 Jul 2014 15:36:15 -0400 (EDT)
In-Reply-To: <53b2ad7801889b49f04cb0ae7b0b37b@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Thu, 17 Jul 2014 12:26:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9DD438F0-0DE9-11E4-A29A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253775>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> There are two options to turn off this behavior, -i and -oi which
> are equivalent.
>
> The choice of which to use is based on the observation that -i
> appears to be the more commonly used option for this and that all
> current sendmail-compatible programs appear to accept both.

OK; I suspect some just accept but ignore, though.

> BTW, what is the status of post-receive-email?

I do not use either, but some people seem to consider multimail its
successor, so enhancements may have a wider audience there.
