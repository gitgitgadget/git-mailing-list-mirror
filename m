From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 04 Feb 2014 14:17:57 -0800
Message-ID: <xmqqiosu7ca2.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
	<20140121054927.GD5878@sigill.intra.peff.net>
	<xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
	<20140204221220.GA5457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoK1-0001w8-JE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934972AbaBDWSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934443AbaBDWSC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:18:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A6CD69B78;
	Tue,  4 Feb 2014 17:18:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DrhCFHbGMiIze5O9dMcq4u6W1KM=; b=umcuo+
	Epvt7CiCKp8/ofJByz581FzU7JEgIrDwjo5dbOCV9RtvO3xZNjlUwKRMhbEmqBNA
	dOLYwvcLxdt1Ro8ZM1lzUh7QkExsOjwl7dukP9ZWV6G+eoRINnFh2UDFWtiwPIKU
	3JA44+SISn9A16cF7QgEsLMzCOoc/Zxwa9aA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z10RIoAnpZHNYhfhkM3saCXlxMf4yiie
	lBn/WkronBfkZMBPFcRLaHUrBhzYCHC/fLLDhl9WyBPpAJAxkpyv7wMSPiUP0YaS
	mB88abcByRK6r1iGlfCkVMAz6YtmIn8qTbYDTjaJPsg95qllEElb+ksuMBkf+9uQ
	cKHOE3cgzyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4538E69B77;
	Tue,  4 Feb 2014 17:18:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8C9469B72;
	Tue,  4 Feb 2014 17:17:59 -0500 (EST)
In-Reply-To: <20140204221220.GA5457@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Feb 2014 17:12:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 34B9AED8-8DEA-11E3-B3BB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241572>

Jeff King <peff@peff.net> writes:

> But there's another set of people that I was intending to help with the
> patch, which is people that have set up LESS, and did not necessarily
> care about the "R" flag in the past (e.g., for many years before git
> came along, I set LESS=giM, and never even knew that "R" existed). Since
> git comes out of the box these days with color and the pager turned on,
> that means people with such a setup see broken output from day one.
>
> And I think it is Git's fault here, not the user or the packager.

I am not particularly itnterested in whose fault it is ;-)  If the
user sets LESS himself, he knows how to set it (and if he is setting
it automatically for all of his sessions, he knows where to do so),
and would know better than Git about "less", his pager of choice.

If he did not know about R and did not see color, that is even
better.  Now he knows and his update to his LESS settings will let
him view colors in outputs from programs that are not Git.

> So I think there is nothing to be done.  But I did want to mention it in
> case somebody else can come up with some clever solution. :)

Sure.
