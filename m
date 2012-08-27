From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Mon, 27 Aug 2012 09:55:46 -0700
Message-ID: <7voblws299.fsf@alter.siamese.dyndns.org>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
 <20120823083918.GB6963@sigill.intra.peff.net>
 <7vvcg5v9hh.fsf@alter.siamese.dyndns.org> <503B3C5C.1020109@alum.mit.edu>
 <20120827092502.GA2428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T62bU-0000PB-BA
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 18:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab2H0Qzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 12:55:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab2H0Qzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 12:55:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD66679C;
	Mon, 27 Aug 2012 12:55:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jUFdiiupythWKIsVSjSJ2T0ID2o=; b=ftfYq5
	h2vLegRZyssZSa9PAVwg9dsVrx2evycgR+Jk2Cs6l0Uov/0SRtXi2cV9joSuxO86
	ufw7WoARaQUqYtu2eks/jUGMtZ/S+McIfRF3ggrUDNTh16kENnvVxgCPb1FcP9qT
	PMqwu2nNfNvIjGpa1ZVGhK/6RWLP5Ie/+bf8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5eQu2WQIPbZQAwm2jWHevGwZOUZo8aU
	GEsDFLzraimvbT/raLNyJXR+qytspQAGRCUtzvfOyCoj1XVCQZ+rq/Ew62kqEkl4
	nSuAxs3CxwMZxceZRpOKE0QPgRbfjfPTbhXWU8ZDmYtq34x2SjAgNDEbbF/hUWDE
	eTTq1DP+1b0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A8FD6792;
	Mon, 27 Aug 2012 12:55:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABC1B6791; Mon, 27 Aug 2012
 12:55:47 -0400 (EDT)
In-Reply-To: <20120827092502.GA2428@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 27 Aug 2012 05:25:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CA32F30-F068-11E1-BA8B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204356>

Jeff King <peff@peff.net> writes:

> Yeah, I agree that "refnames" would be better. I think something like
> "spec" or "refspec" would indicate better that they are to be matched
> against, but then you run afoul of confusing that with colon-delimited
> refspecs (which I do not think fetch-pack understands at all).

Correct.  It only takes the LHS of the refspecs, following the "one
tool does one specific thing" philosophy.  The arrangement was that
the calling script interpreted refspecs, split them into LHS and
RHS, fed the LHS of the refspecs to fetch-pack, and then read the
output to learn which local refs (i.e. RHS of the refspecs) to
update with what value.
