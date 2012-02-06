From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 05 Feb 2012 21:34:26 -0800
Message-ID: <7vfweoa5jx.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <7vty34a6fd.fsf@alter.siamese.dyndns.org>
 <20120206051834.GA5062@sigill.intra.peff.net>
 <7vk440a5qw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHDm-0007rp-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764Ab2BFFea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:34:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab2BFFea (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:34:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B27023240;
	Mon,  6 Feb 2012 00:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2xoMq6ka3RPD5aIxDq7Bu9ke/uo=; b=nzCpaT
	ByIQKXI8MEz+O0cwkuR4FsZaM5hw2z4SFbYcmIy+2KB8TwttRpd1f1QmPJr99ryL
	puTgu9J4lcBWTNXNjePy18k822W4nohBY+LnaVsP9pVXcnneZaJBb3Uf/f2JmzJ9
	Fe4V+xj/xf4Gor9APSY+544o+SP5brFENLupU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W3v1NkObbEVqqrQE4hFr445e4LCRFqVG
	EmWLgjaG23KGj3+86G942d+NEu/P7bcm3g/FYyTdMihH8eMlqREJRjRR/sy0swIZ
	UYSf07OEQLah5rpND91OI0gZUxspLzhkPkP0kChv+PEQcV/ijdpvtCmNdSKHzXkG
	wWM0OqrtLvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB39E323F;
	Mon,  6 Feb 2012 00:34:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 406B0323E; Mon,  6 Feb 2012
 00:34:28 -0500 (EST)
In-Reply-To: <7vk440a5qw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 05 Feb 2012 21:30:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CBCF95A-5084-11E1-8626-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190015>

Junio C Hamano <gitster@pobox.com> writes:

> But the last one has no chance of working if you think about it, because
> "git branch foo $start" is a way to start a branch at $start and you need
> to have something to point at with refs/heads/foo.

... which brings us back to your earlier point ...

>> I like your patch better than trying to pass around "0{40}", but:

which is why my conclusion was that "checkout -b" is shifting the
confusion around to different parts.

> So we are breaking the equivalence between these three only when HEAD
> points at an unborn branch.
