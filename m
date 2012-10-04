From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] log --grep: accept --basic-regexp and --perl-regexp
Date: Thu, 04 Oct 2012 09:44:42 -0700
Message-ID: <7vk3v6191h.fsf@alter.siamese.dyndns.org>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-5-git-send-email-gitster@pobox.com>
 <20121004081212.GC31305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtdi-00033L-7v
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933448Ab2JDQoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:44:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263Ab2JDQop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:44:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B7CC8A49;
	Thu,  4 Oct 2012 12:44:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkqQGAkEHUL7xVRwvUJIyXoVmjs=; b=XUqMvv
	ZIcYxkoO7vKv+RIn3LuNXmE3YpA/dRsBgpGEKj6kSNLkKo4kMn9i+HtXu0yWpP/T
	7m65zDPFWvzF3LHRIHG5+8rGIiBgLeuAJ3j6xCytKp3PbbgaXodJvwJuAlieaiV5
	9r8XwmIIrO9clHlQsSpFwU7B/NNdXDQ7he7es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQ9mMNX4lGNvgmQNhQkzwcHnnQORgkvx
	TXM+SEiYHR6Xa1g4rws6ovvtLR9cFKjZKGWDHhL9/UgnIZ9PFetWdbg0FSLm22Es
	XzWSxIkERopyv4D6VedAPQnLSTHEibncbIMk1a+rc0t0ka+zE1/X90MI61z0ozl9
	CZAvs1+wU6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06AAE8A48;
	Thu,  4 Oct 2012 12:44:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 838488A42; Thu,  4 Oct 2012
 12:44:43 -0400 (EDT)
In-Reply-To: <20121004081212.GC31305@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 04:12:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC762E82-0E42-11E2-B15A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207021>

Jeff King <peff@peff.net> writes:

>> +	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
>> +		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
>
> Do we want to yield short-and-sweet "-P" to perl-regexp? git-grep does
> so to match GNU grep, but we are not matching anything here (except
> ourselves in git-grep). I'd think most people who use it regularly would
> just set grep.patternType.

My instinct always is that we should not to add short-and-sweet one
letter option until it is known to be necessary and useful; the
above was me typing without thinkng.  And I agree grep.patternType
should be sufficient.
