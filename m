From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 14:59:50 -0700
Message-ID: <7vmwsqns4p.fsf@alter.siamese.dyndns.org>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
	<CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
	<CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
	<87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOmE-000556-LT
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab3DVV7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:59:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753802Ab3DVV7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:59:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7AF318211;
	Mon, 22 Apr 2013 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ok7t28yRb6PUW2iI3EuNwbuRJzE=; b=FQbpu/
	G+Ql7f0qfc9PIbYRF3Q0z1QpJSwKadbL81+K5aeqwOxMbPcD3Wz679IWqix2KjEZ
	NQA4dKGownT7UYCXIt5zTdx/WvmcAcgRC7zIrMZBw9O/lgnY3uBtKN0vHw7ARVpI
	72J++YN/R/8Gn8eTdgUZcJwodBUaR0t1jprOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jNXrJriba772pNFcDNxelHQrSCiEZ7yt
	Yzu+3InCe+zVobCSSbQ3G6oCA2cVe0w55vD93UPQsJM+mbwuo//BVkd9AzLKqho6
	pKMSB5APewEPnWgQh+1rKyg4Qkt+eUZlpKGNdbQiPitMHl6A/hWYbSR3eWara+Hd
	vBfiNByLPvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF511820E;
	Mon, 22 Apr 2013 21:59:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 183811820D;
	Mon, 22 Apr 2013 21:59:52 +0000 (UTC)
In-Reply-To: <vpqr4i2z35n.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 22 Apr 2013 23:06:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F581EC7E-AB97-11E2-8CF9-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222109>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> So how can we fix that?  We could try to somehow figure out that M:sub/
>> refers to the same thing as M^2:/, by looking at them at the tree level.
>> Let's provisionally call this --follow-tree-rename.
>
> There was a patch serie long ago that implemented directory rename
> detection:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/163328
>
> I'm not sure why it hasn't been merged.

I have forgotten about this topic (and its numerous iterations in
the past), but it appears me that people mostly lost interest after
v7 review cycle where the series looked like a solution that is
looking for a problem.

I took another quick look at it now, but it tells me that the series
was a good platform to discuss the design and the goals but it was
far from ready with comments like this "// FIXME: leaks like sieve".

As to the design (not the implementation), I find what are in the
documentation updates in [v9 2/6] more or less reasonable, even
though I still doubt that foo/ => bar/, when the constituent files
are not moved a la "mv foo/* bar/." is useful.  The change in [v9
3/6] is distasteful and should just be killed.
