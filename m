From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 13:34:56 -0800
Message-ID: <7vhayc55a7.fsf@alter.siamese.dyndns.org>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
 <20120227191846.GB1600@sigill.intra.peff.net>
 <7vr4xg6pn2.fsf@alter.siamese.dyndns.org> <20120227211316.GA29081@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:35:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28Dq-0006Op-1l
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab2B0Ve7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:34:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532Ab2B0Ve7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:34:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 249377263;
	Mon, 27 Feb 2012 16:34:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6T1jDbMzq/yHnGa1DxmOEh63o2A=; b=EIn5eG
	6sJF393vXha9nq8R6+Z4MRiqWhDL3q8poUw6Frrd+Yd5rVDGsHwWWC2QqXLRTnmT
	fkq058w1K9XxbbpIkbzrIMLZTAjlikYT+mRLkLsshqaKriHz5nerQ8pZQD0qN06/
	p358I6JPCLac6R8OMAxTbZwmZ74b461LNi0P4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvWlQtupx71HXQgYOfC0hFF5YOU7hshn
	MhN8KzBsIeiLHOpAkElgDts6uwcAsXcEBqmmvGvWtnUGPZTL0HutfKkmHRCvJ78Z
	7ke9hnXycECAu+dkxlWuNBki2i/LFfzMnMcwKEnUiN9P6C+cToIIsqv2CPlXGsuH
	2K2YXNxSkR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF277262;
	Mon, 27 Feb 2012 16:34:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5EEA7261; Mon, 27 Feb 2012
 16:34:57 -0500 (EST)
In-Reply-To: <20120227211316.GA29081@ecki> (Clemens Buchacher's message of
 "Mon, 27 Feb 2012 22:13:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E538C5FC-618A-11E1-B5A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191677>

Clemens Buchacher <drizzd@aon.at> writes:

> There is something wrong with weighting a UI improvement against
> convenient use in scripts. If that were the issue, then ...

But that is not the issue.  Nobody said anything about convenience for
script writers.

I am talking about regressions to already written long time ago and used
by many people _without_ them having to worry about how it internally
works.  By switching the default, you are suddenly making them worry about
it again.
