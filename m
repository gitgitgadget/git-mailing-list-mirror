From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Mon, 22 Apr 2013 14:13:00 -0700
Message-ID: <7vr4i2nuar.fsf@alter.siamese.dyndns.org>
References: <20130413152257.GB16040@pvv.ntnu.no>
	<20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
	<20130415095339.GA28480@pvv.ntnu.no>
	<20130422210229.GE5650@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 23:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUO2v-0003Ru-K6
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab3DVVNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:13:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab3DVVND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:13:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D94183E1;
	Mon, 22 Apr 2013 21:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2oHZ0nqFkL90JmZIhSHRTptzCyo=; b=te6AUP
	zKSaSvPsIq4pyJ4sxN8o1D4kPqPipkOs+qEe8vlvNJdzfILC7cOCyAzOhTtcAQ0X
	nk5nzFS0UhdlGE29NSj1lmucyz0loPXrFuOytn8LRNEUc5Y/ri1nS5LhDmO73jcu
	127dIcNLbSZ65aCuiwtqMUPL7fBKPyyhFS1P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQb3QgFjcY1R3WKGgJlahigMzZd/5O08
	IXt0kI105oolzqcKA1heXC/FyHKKX4OswPE5jw4lONk6uWz/ArBiBObUWPnOtikg
	mjeqI0OS6k06Z+ctF+zHg4AiwXt1+IHzhH3uPbY/2fM2M3YSRiuD3xzWRSJk/FSL
	3xB8jcVNh+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 257CD183E0;
	Mon, 22 Apr 2013 21:13:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F82E183DC;
	Mon, 22 Apr 2013 21:13:01 +0000 (UTC)
In-Reply-To: <20130422210229.GE5650@pvv.ntnu.no> (Torstein Hegge's message of
	"Mon, 22 Apr 2013 23:02:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A4DB65C-AB91-11E2-9177-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222094>

Torstein Hegge <hegge@resisty.net> writes:

> I took another look at this. I wasn't able to come up with anything
> useful for the "The merge base $rev is bad" case, but for the "only
> skipped commits left to test" case one could do something like this.

We skipped them because we can gain _no_ information from testing
these commits. They are not even "possibly bad", but are "unknown".

So it feels to me that by definition listing them would not be
useful. What am I missing?
