From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git version statistics
Date: Fri, 01 Jun 2012 07:49:17 -0700
Message-ID: <7vzk8n3x5e.fsf@alter.siamese.dyndns.org>
References: <20120531114801.GA21367@sigill.intra.peff.net>
 <20120531120018.GA24986@sigill.intra.peff.net>
 <7v396g6t53.fsf@alter.siamese.dyndns.org>
 <20120601090337.GC32340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 16:49:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaTAQ-0003uD-7w
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 16:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933384Ab2FAOtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 10:49:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933368Ab2FAOtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 10:49:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AF318EBD;
	Fri,  1 Jun 2012 10:49:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YsTbNUMPiW8UG2ZBqOw7+Z6G66c=; b=qhnQNH
	gQz2V+ta0Ixw8deFInK6UT8m1+eFX+v0+MJljcEFEkwSCqcW1+A97jweJlg9ahGJ
	/ZNu9CJl4DjJNGDuaHdID6wJ8J/4ZBj5CmaWZTeeSPwJHC24JVmUaxpN8AG3foMy
	VM5dpU/pxawMe8CsslO1LCa7hGqeO6Jx80QNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RDMEe8g2v+wn/uzjqE/qiZ0ENdLfe3tr
	n53qPOL7F0i2G7YhYRPajN70jwIt0troEMXZmjLSL8nyisX2g6sFLMv6yLzJNOYl
	n3LNw6YDaQgx7fk4RffuNw3ymN4374AWh5CLBQEDwEgtAa2h8gR+cZRVac1iXRrn
	DsgKADu1Aqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 624438EBC;
	Fri,  1 Jun 2012 10:49:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB4678EBB; Fri,  1 Jun 2012
 10:49:18 -0400 (EDT)
In-Reply-To: <20120601090337.GC32340@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Jun 2012 05:03:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F77577E8-ABF8-11E1-82CD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198993>

Jeff King <peff@peff.net> writes:

> I don't know if anybody cares about the security or privacy implications
> of advertising your client version. Maybe it should be configurable?

I do not think it is worth it.

My initial reaction to the patch was a bit of trouble with the word
"agent", as we do not call Git acting on behalf of the end user "an
agent" in general. But it could be used as an excuse for not giving
an extra knob to tweak, as you generally do not muck with User-Agent
strings, either ;-).

>> Do we want a similar identifier string on the other side of the
>> connection?
>
> We could. I don't see much point, unless you were going to conduct a
> similar survey by hitting random IPs looking for git ports (but even
> then, you're not likely to turn up much, because you have to know a repo
> name before you can convince git to show a capability string). I suppose
> it could also help with debugging if your client is having trouble
> talking to a server that is not under your control.

The latter use case was exactly what I had in mind.

> Some traditional security advice I have heard is that servers should not
> advertise their versions, as it makes it more obvious what holes they
> have. Personally, I find that argument to be mostly security through
> obscurity.

I do, too, but shipping with a configuration knob to optionally turn
it off would be sufficient.
