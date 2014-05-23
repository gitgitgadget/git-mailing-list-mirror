From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 10:11:03 -0700
Message-ID: <xmqqr43kju8o.fsf@gitster.dls.corp.google.com>
References: <87ha4golck.fsf@osv.gnss.ru> <20140523105047.GA2249@serenity.lan>
	<87k39ck9r9.fsf@osv.gnss.ru>
	<20140523123503.GB726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 19:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnt00-00082o-Ly
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 19:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaEWRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 13:11:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59310 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaEWRLL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 13:11:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B890918762;
	Fri, 23 May 2014 13:11:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MAoST8kdw4VVsIrdh6LEy3iw1rI=; b=Ki8T2o
	8Um8Vs4ex0pas5npFAUbqPeIT1v41C5njkvF+KEmUZeo4atdof9nTXAQ0ARcPLhU
	Pcbe+Th0PAoZalIKyzgls5hzklPP9m0CEOUKLqoV09bGHtdL87mfOUtabMl3wUZS
	l03g7vW62F7EfqX8bTgrUlcBD+Zq7WKnmx9rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OyFi9FMSXgiANIkbZ8eQ01UHz6OqyKJZ
	O5Vfbv6cZR0RGHFTJG7iMbqbTWxbumDXnmdMmRf9lK50lc4LMXxw4Uslpo3JRrhX
	IMRKUV9g3Wa26LyXbKt8YCTsZBHSIyTXtwPAwJSUl6A/dgtNQnzpiK57809rc+AK
	Ikx2TkiP+J4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E70718761;
	Fri, 23 May 2014 13:11:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97B901875A;
	Fri, 23 May 2014 13:11:05 -0400 (EDT)
In-Reply-To: <20140523123503.GB726@sigill.intra.peff.net> (Jeff King's message
	of "Fri, 23 May 2014 08:35:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 39A850E0-E29D-11E3-948A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250003>

Jeff King <peff@peff.net> writes:

> One thing that this misses (as does your original script) is the
> reflogs. Doing "branch -m" to rename a branch will actually move the
> reflogs, too, but there is otherwise no way to access that
> functionality.
>
> It does not seem unreasonable to teach "git update-ref" to do renames to
> take advantage of this (it would be fairly simple; the logic is already
> encapsulated internally in a rename_ref function).

Sounds sensible.
