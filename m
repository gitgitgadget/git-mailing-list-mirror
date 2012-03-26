From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 26 Mar 2012 13:05:52 -0700
Message-ID: <7vk427nn4v.fsf@alter.siamese.dyndns.org>
References: <20120320043133.GA2755@gmail.com>
 <20120323214114.GB18198@sigill.intra.peff.net>
 <20120326192001.GB32387@gmail.com>
 <20120326195150.GA13098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org,
	zbyszek@in.waw.pl, Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCGAy-00088o-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 22:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab2CZUFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 16:05:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab2CZUFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 16:05:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 739C86C65;
	Mon, 26 Mar 2012 16:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IIzyKBCRfRsX0z+PCDwxpFNYJY0=; b=mf6tc6
	l5jwmUM+yxWn2xhCcIpuJoYlfbCxdZi5AsdzZIK8QIw5p1/+UlYPs3rA8Th99IOs
	GLO/7H6jMaf8EfjE/tN1Z+62w+YWSaeXUVLufq6m9mUoMVOsp/Tfbwvzr1nlzNpe
	eHOLX1qrAMGFT51m715tyMPbf2UuHzrXuNh4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sM4D17bBqSwNeEM/8BFKXl2/pQw30v4W
	lPjEgyAmpRboir7ydrSuBdSFZnCd38EhM5g7YvnwmuNauNw4xvstRTcO96Q9LkvS
	Q9nEARuy6ytGUj0UPuf/4jCOzDHBJNhw1kGBBPYAEWmybILmwaxl0111vicHiU1g
	SJG3U92a360=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 695566C64;
	Mon, 26 Mar 2012 16:05:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6CFA6C63; Mon, 26 Mar 2012
 16:05:53 -0400 (EDT)
In-Reply-To: <20120326195150.GA13098@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 26 Mar 2012 15:51:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17ACC34E-777F-11E1-AD59-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193971>

Jeff King <peff@peff.net> writes:

> Generally I would try to keep their definition near the function
> interface which uses them (i.e., transport_push). But I don't feel that
> strongly about it.

I think that advice makes sense.

> Your patch is already in 'next', so we will have to build on top rather
> than squashing. So here it is with an actual commit message:

If the patch were already in 'next', we would have to build on top, but I
thought I kept it out of 'next' because I knew this deserved a bit more
review time.  Perhaps I screwed up, or you are reading the history
incorrectly?

	... goes and looks ...

> -- >8 --
> Subject: [PATCH] clean up struct ref's nonfastforward field
>
> Each ref structure contains a "nonfastforward" field which
> is set during push to show whether the ref rewound history.
> Originally this was a single bit, but it was changed in
> f25950f (push: Provide situational hints for non-fast-forward

Whew. "git log remotes/ko/next..f25950f" says we are OK.

I'm however tempted to keep this follow-up patch as separate without
squashing.
