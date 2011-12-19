From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't pass back fake refs
Date: Mon, 19 Dec 2011 11:28:14 -0800
Message-ID: <7vty4wmkdt.fsf@alter.siamese.dyndns.org>
References: <20111217104539.GA23844@sigill.intra.peff.net>
 <20111219171055.GA21227@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 20:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcisp-0003U5-Dj
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 20:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab1LST2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 14:28:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab1LST2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 14:28:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C97F26F8F;
	Mon, 19 Dec 2011 14:28:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zhc5zUphDda7JIWdDzeHfj9fipQ=; b=UXSpx/
	3zisAyJb/hcMBMJAEeXpOrQrbuCq3C8ZSnFr/Ipl+bFGq/oVG/QASzktPaOY8HE5
	QNnqdjSPw6V+84tIuS6g9Erno5CVh1hZe9v2jneHYGX7dEQaGSWQNFqx1obInUkR
	+LKQGYpXwNXv0XvKQG16gdgDoZnHMBkZpDztg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kv5gnmmNW330JtOJKXoF2lWoKw3s835R
	eBSGvLRygXt9RB1oyc/IapFKjIMVLkKklT7Sv0gWY7RyPo0Obe0lFw/aRhJ+v3LQ
	CknLrIUaOORvvWjiqDqZ0tZcnKu1TxA+scLebm1dHqiaE9Kf+mAGoPgEMyFXNNYL
	7ModYUB807A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEA886F8E;
	Mon, 19 Dec 2011 14:28:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3540C6F8D; Mon, 19 Dec 2011
 14:28:16 -0500 (EST)
In-Reply-To: <20111219171055.GA21227@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Dec 2011 12:10:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 997B4922-2A77-11E1-8C50-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187465>

Jeff King <peff@peff.net> writes:

> Perhaps we should squash in the test below, which demonstrates the
> breakage. I also wonder if this is maint-worthy.

Thanks for a thorough analysis. I agree that this should go to maint even
more so, as it fixes a case to push to a non-empty repository.
