From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 14:30:35 -0800
Message-ID: <7v4o9bnmno.fsf@alter.siamese.dyndns.org>
References: <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net>
 <7vhbdbnxud.fsf@alter.siamese.dyndns.org>
 <20110114200705.GA3316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 23:30:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdsAd-0003QW-45
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 23:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab1ANWay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 17:30:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab1ANWax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 17:30:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90D134E9E;
	Fri, 14 Jan 2011 17:31:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c0ObE+/oh0tFA3fsayoS9iU4ljA=; b=m3dn8j
	/4fgdZbmQFxSlCSs6ccpNLavlhugy1cfxSHdZ9LgK0q7qAs4v21RRRyUJhMLPjT5
	DtKjJULBrGHt/FN0nd72t1PfffJTntuw9iAy0aDvOFuht55r806sBA3WP4kuslAe
	o9X/zLuBlXXLO1wk0sPBd3gi9J+Kg9kW/k6ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wdi3Q2IGTWRjTyZkAqvNa6wFwgT9joPk
	d+3IBpOFYKIy47O/mgWj8MNdT5BGkugrrwovc8u9Femt92NUfh+lM+KNSCxZCLjn
	m/nr696zWVH/CjwGmYMYS/ZGM9JFwjUy9s+mPSrM8yZ6qjaiipl/l1B/7xa69gUc
	t5x1NRSFpfQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E63B64E9D;
	Fri, 14 Jan 2011 17:31:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F8A14E9C; Fri, 14 Jan 2011
 17:31:20 -0500 (EST)
In-Reply-To: <20110114200705.GA3316@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 14 Jan 2011 15\:07\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0796F280-202E-11E0-97F3-C83E909A2CA0-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165127>

Jeff King <peff@peff.net> writes:

> More or less. You would still have some lossiness when emailing your
> patch. Do we want to warn about that?

Probably not.

There will only be less than hundred people with a single letter name in
the world (I was tempted to say 26 but decided to be generous ;-) like
that, and you will much more likely to see an overly short "name" part
from a misconfiguration or misparsing than from receiving a real patch
from people with such a name.

But I haven't thought the issues, possible improvements and pros-and-cons
through.
