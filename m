From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 02 Sep 2011 09:47:07 -0700
Message-ID: <7vsjoelwms.fsf@alter.siamese.dyndns.org>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 18:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWtj-00050E-If
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab1IBQrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 12:47:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab1IBQrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:47:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0714509;
	Fri,  2 Sep 2011 12:47:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HiE9+pwqtgJYtiOICr7x6NkJh9k=; b=KdZK1U
	l3nKFvv2QyRxEvZf6Nrw0tZEmcEgYFviM1q5lA6U9wSFMXAUMO8cBmrtFp3Bo5om
	3Wkj/nGHj8WgDkG+QkqFtGMOOrcpSjq+oD6yMr5HddCn2Skw413qNxR81Yph0zKY
	//YpYZBi862pcy4UOhSDE+N5moPJw7DCQxKXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xM5+LBLiMnHENXo0d/5Rr2M7LzIatDbh
	2ZtaArb+n3j2oh5njLwL4uM6FWPM7LYn8iZ4EHuIisradxX5/kpsNCr1lxZnMDDi
	HFMriho/4mdoDiVJ1IOrm8LyhtUnAM4wchVWyDAyipuqpsHxuv5rnFwqCzzriCap
	Zh3KxNoJ6Lg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9614B4508;
	Fri,  2 Sep 2011 12:47:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 290C14506; Fri,  2 Sep 2011
 12:47:10 -0400 (EDT)
In-Reply-To: <20110902162524.GC19690@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 Sep 2011 12:25:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33740022-D583-11E0-8D76-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180623>

Jeff King <peff@peff.net> writes:

>> It coincides with my idea too, but it might be a very limited set. For
>> example, there may be a good "suggested by upstream" default for LHS of
>> fetch refspecs (e.g. somebody may have 47 topics published but majority of
>> people are expected to follow only his "master" branch), but it is up to
>> the user of that suggestion what the RHS would be.
>
> Yeah. That leads to synthesizing local keys based on what remote keys
> say. Which is pretty straightforward if you are just fetching the
> remote's config during clone, and then copying or creating local keys
> based on that in your own .git/config (e.g., by creating full refspecs
> with upstream's idea of the LHS, and our idea of the RHS).
> ...
> I do worry that could quickly get complex, and people would start
> wanting a Turing-complete config language. :)

My real point was that more often than not the settings of configuration
variables are inherently per repository not per project, and even though
we may hear people want shared configs, possibly in-tree, distributed as
part of the projects, such a set-up would not be very useful, before you
even consider merging updates but just taking them as suggested initial
values. The choice to take, ignore, or tweak the suggestions all depend
on the semantics of each variable, and it becomes more so once you start
talking about merging updates.
