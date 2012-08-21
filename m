From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Tue, 21 Aug 2012 10:56:45 -0700
Message-ID: <7v4nnwdt7m.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
 <20120821082719.GA13252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:57:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3shC-0002Lh-9J
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238Ab2HUR4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:56:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39292 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab2HUR4s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:56:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A06A37916;
	Tue, 21 Aug 2012 13:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qMAfBKgGOv0WCzKMl5X3kCRM6W4=; b=bkjwhr
	1clXgKCUBlNxAIleOgoO4XbReG0+N0i63mnhIYbrHhDz3bzNJsYxXyIanAKBnuvb
	oy5IXvPsqeJmaNDorLhwibbRzLhFMymicYWqetWXhPSp0yqxmG39TKRxRdp9IG7w
	U0khfNfNqeA5Z0pTpgu5jBbfzFZ/9+enjjrl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JcXyQfiknCvucScIhQrIWR+GnhCQF9uQ
	jxzxpKcndE4zXbMfpshskNz8GpK8b1R+aykvCij4kRIGhba5tdVf+3my8ufYfqg4
	023ebIbzOnFbbmtoVnY62EowvBHbEiJI1prKMICVhStb94b8XdJdq5XuJAgtqOHx
	yuGXm02+gQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DEFB7915;
	Tue, 21 Aug 2012 13:56:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 132757914; Tue, 21 Aug 2012
 13:56:47 -0400 (EDT)
In-Reply-To: <20120821082719.GA13252@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 21 Aug 2012 04:27:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9354E3B0-EBB9-11E1-B27A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203978>

Jeff King <peff@peff.net> writes:

> So in other words, I do not think any ultimate destination that I find
> palatable would be achievable without making the full format jump
> anyway. If all things were equal, I'd say there is no reason not to get
> as close as we can. But I find some of the proposals significantly less
> readable (in particular, the directory-munging is IMHO much harder to
> read). And it is not as if it is buying us anything; you still have to
> make a magic translation between a dead log and a live one.

Yes, that is where the earlier comment of mine on this topic came from.

> Another option I've considered is simply holding back the graveyard
> topic, working on the d/f tolerant storage, and then implementing the
> graveyards on top (which is basically free at that point). But as you
> note, it is not really a commonly-requested feature. If it were easy,
> I'd say let's do it. But the idea of bumping repositoryformatversion for
> the first time in git's history just to add a feature nobody wants is
> not very appealing to me.

Amen.
