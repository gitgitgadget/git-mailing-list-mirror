From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Thu, 01 Sep 2011 10:16:29 -0700
Message-ID: <7vwrdsw5ci.fsf@alter.siamese.dyndns.org>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
 <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
 <7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
 <20110831232201.GA29296@sigill.intra.peff.net>
 <20110901093450.57512480@pomiocik.lan>
 <7vbov4xnfc.fsf@alter.siamese.dyndns.org>
 <20110901162222.GC15018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:16:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAsZ-0007qa-Nl
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab1IARQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:16:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab1IARQc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 13:16:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB96500A;
	Thu,  1 Sep 2011 13:16:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wkZsyL7sDzaERpNRg1nCH2nzqgw=; b=MI9qkU
	HA/Cf9oudo06oZZq+IP1433zs0A3bQLsYjf+g1Vv7wZkjUy0ANd8ZufDFZRlUU7i
	Jn24+n0+FAA27BIG8EbyoFsrKrQqYScQ/eJSStGUn7MgehOfBul9K6vzf5z06UJs
	TXJaeGUzy4kagoHo6efmk9VsNL1HIMit8oCHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JILDrvrlGYU/BHc2ikrQ4vVrIcM1ushf
	rRDadiiU9v3iZ+y0U3M5En061kaN8RprLj1xOAZyFnjh5pZxFBXuSyeREgP582Dt
	m9gqq9IusbNW8j/wPnS53JwMvMCDMpqoWsUoNPfmjfn9UnU/sC8UHbWwC+fE/o7P
	/7kJmd/y/1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 166435009;
	Thu,  1 Sep 2011 13:16:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A162E5008; Thu,  1 Sep 2011
 13:16:31 -0400 (EDT)
In-Reply-To: <20110901162222.GC15018@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 1 Sep 2011 12:22:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22F8EA70-D4BE-11E0-A82F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180554>

Jeff King <peff@peff.net> writes:

> We could either leave %(subject) with its historical behavior, or fix it
> to handle multi-line subjects. Although it's technically a regression to
> change it, I tend to think it is simply a bug, as it doesn't match what
> the rest of git (like "git log --format=%s") does.

I think %(subject) should be updated to match %(contents:subject) as a
bugfix, so %(body) should be adjusted to prevent "%(subject)%(body)" from
duplicating lines.

Thanks.

Side note. We probably would want to borrow from pretty-formats to allow
us to say %(subject)%(+body) or something...
