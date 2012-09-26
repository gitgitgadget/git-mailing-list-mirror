From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git blame
Date: Wed, 26 Sep 2012 12:11:02 -0700
Message-ID: <7vfw64txa1.fsf@alter.siamese.dyndns.org>
References: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
 <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley>
 <7vsja5vh2z.fsf@alter.siamese.dyndns.org>
 <72fc15c78ddb6b5c9e95f6b0cd925a26.squirrel@webmail.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philip Oakley" <philipoakley@iee.org>, git@vger.kernel.org
To: xmeng@cs.wisc.edu
X-From: git-owner@vger.kernel.org Wed Sep 26 21:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGx10-0000LM-HN
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676Ab2IZTLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:11:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756979Ab2IZTLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 15:11:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E41D8A37;
	Wed, 26 Sep 2012 15:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eVcM0G18i0W9yC1Lb7s60WQDM8U=; b=bIhWws
	pq1FLAYIRzK/BvSHkomC+3SRipymC8oIRIngnXOvL54y8q7tKM5FnfpbdFeuwDgh
	8Jvg1V2ge3ozzPeeSf9VlJct83pLi7Atgsr1pqWHewoRHuKSe6PPRTcj36KQnB9v
	EFoJc4joXp3dY6CZ+zcsfogHzA6LlzbxL2rHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hK2xUvbFjvWWtS1moacu0Ncr4pOCMu9s
	0MXhDz3oZMx2qGShV+2YGVwMQrguKO0BdnKIIjVoHQ8tvag9cPE7ogZWaSGyWg7H
	Nfu0k9qfGZOwFyS0iJfkzTY6Qc551oL93L8a9mlMxWQasNbjXynt0qpDIovCt5E1
	A7RyPaQhDL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFFD8A36;
	Wed, 26 Sep 2012 15:11:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 730BD8A35; Wed, 26 Sep 2012
 15:11:08 -0400 (EDT)
In-Reply-To: <72fc15c78ddb6b5c9e95f6b0cd925a26.squirrel@webmail.cs.wisc.edu>
 (xmeng@cs.wisc.edu's message of "Wed, 26 Sep 2012 10:36:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED629454-080D-11E2-8462-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206428>

xmeng@cs.wisc.edu writes:

> Another question is that is it possible to include my tool as a git
> built-in tool in the future?

It largely depends on how the user would interact with your program,
which is totally unclear as we haven't seen any part of it.  I do
not think we have enough information to answer the question at this
point.

> I know that my tool is still not good for any release. But I would
> like to share my work with other people if other people are
> interested.

If it is a trivial script that largely depends on what we already
ship, I would not mind carrying it in contrib/.  If it is anything
substantial and substantially useful, however, I would suspect that
you are better off not be in in my tree, but rather want to be
independent.  Finishing it to be useful for your purpose, publishing
it somewhere people can take a look at and adding a pointer to
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools is
probably where you would want to start.

> And if it is possible, I think I will have a stronger motivation
> to make my tool more robust and useful.

I've seen from time to time people ask "I am thinking of doing this;
will a patch be accepted?  If so, I'll work on it." before showing
any work, and my response always has been:

 (1) We won't know how useful and interesting your contribution be
     for our audience, until we see it; and

 (2) If you truly believe in your work (find it useful, find writing
     it fun, etc.), that would be incentive enough for you to work
     on it, whether or not the result will land in my tree.  You
     should instead aim for something so brilliant that we would
     come to you begging for your permission to include it in our
     project.

I think it applies to your inquiry as well.
