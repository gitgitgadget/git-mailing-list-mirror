From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Tue, 11 Feb 2014 10:57:22 -0800
Message-ID: <xmqq1tz9qxyl.fsf@gitster.dls.corp.google.com>
References: <20140205225702.GA12589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 11 19:57:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDIWU-0005Hi-LW
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 19:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaBKS53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 13:57:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbaBKS51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 13:57:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4579C6AFF8;
	Tue, 11 Feb 2014 13:57:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kMw/JcGN7M5VAQtrUncqPZlUlUs=; b=nbD6Bz
	gT9V+5WbEdWLliNP28DS6kIDNgh/ysvssqpiJHR2qjKcjRCEWV0gMSKr5FY0ygdG
	ys44kcfRvJnD2bbHLNcuO8GMdX4jYvodolVM7du6RCrx1TsT7Uu63UIHj6jayM9L
	I1pZfm2iS21eMmcS8kttg9UvSyqRaDpmrFCTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JneocvK+BdASZc8iMEd+7P0MTP3XYmOG
	5mHCtjL8l+xw1hcyoPytk0lr0VlTOhcLflfUfQhXE3g3PoeMOdUZd1bUJmrL5bFr
	rdBnbPxPKTtm1NB1boVH/e83mVC06UIL8d9HqpSuu/lNVt4ffbeh7zVI9h4Ca4ur
	UC5DoeIkPFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3048C6AFF7;
	Tue, 11 Feb 2014 13:57:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A6586AFF6;
	Tue, 11 Feb 2014 13:57:26 -0500 (EST)
In-Reply-To: <20140205225702.GA12589@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 17:57:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 593257B0-934E-11E3-9D1B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241953>

Jeff King <peff@peff.net> writes:

>  - Branch rename breaks local downstream branches
>    http://article.gmane.org/gmane.comp.version-control.git/241228

If you have a branch B that builds on A, if you are renaming A to C,
you may want B to automatically set to build on C in some cases, and
in other cases your renaming A is done explicitly in order to severe
the tie between A and B and setting the latter to build on C can be
a bad thing---after all, the user's intention may be to create a
branch A starting at some commit immediately after this rename so
that B will keep building on that updated A.

So I am not sure if this is a bug.

>  - git stash doesn't use --index as default
>    http://article.gmane.org/gmane.comp.version-control.git/235892

I tend to think "git stash" was designed to work this way from day
one.

>  - using git commit-tree with "-F -" adds trailing newlines
>    http://article.gmane.org/gmane.comp.version-control.git/236583

According to the initial commit that introduced this option, it
deliberately calls strbuf_complete_line() to make sure we do not
leave an incomplete line at the end.


Many of the other items in your "bugs" section seem to be worth
fixing.

Thanks.
