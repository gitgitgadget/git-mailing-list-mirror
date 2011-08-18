From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 15:54:46 -0700
Message-ID: <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818215909.GA7799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:54:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBUE-0006TD-T7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab1HRWyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:54:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab1HRWyt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:54:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E3A0486B;
	Thu, 18 Aug 2011 18:54:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d/139LDS2JcqipmP7f0W13mVnuc=; b=xBxvvt
	sC7hAEzQoXcIJQAtcdChrGYHDRyPwWzrDs90PJiQwJV2SWc6eDaJ8u2CDn65taNP
	b+BTjc6TON0xgYcDvJ1YULGvINNHecWq9+ZexsBzExAKxcPQLwwaBdQzon2ez4Ei
	ul/eNhrNYB+JwY/KNd32H8xKEXgC8t4OjBR88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJFQ1Jo517kS07zTK/tbubpbuVsjNyWS
	3zE5HLQYHjs+Vv3q3wPGMAt5fwHRMaeUMeUmjLwXFTE+In1gEX4vXzwRXLmtGt3A
	DlPgB4j1IKYnfSLzHh8DYSnzocaFAww1P1tg0AOdWaZLGUh3exFo7HXEVr3jQtrQ
	Ax+rWD4KOTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44E49486A;
	Thu, 18 Aug 2011 18:54:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D08F54868; Thu, 18 Aug 2011
 18:54:47 -0400 (EDT)
In-Reply-To: <20110818215909.GA7799@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 18 Aug 2011 14:59:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12A99BC8-C9ED-11E0-B721-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179653>

Jeff King <peff@peff.net> writes:

> Until this patch, doing something like:
>
>   git config alias.foo log
>   git config pager.foo /some/specific/pager
>
> would not respect pager.foo at all.

Is it a good thing? Looks too confusing and I am having a hard time to
decide if this is "just because we could" or "because we need to be able
to do this for such and such reasons".
