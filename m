From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] revert: libify pick
Date: Fri, 21 Aug 2009 00:50:14 -0700
Message-ID: <7v8whdip1l.fsf@alter.siamese.dyndns.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org>
 <20090821055001.3726.15854.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 09:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeOtV-0005gy-JU
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbZHUHuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbZHUHuc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 03:50:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050AbZHUHuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 03:50:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E093831619;
	Fri, 21 Aug 2009 03:50:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BscYWDivL58mrAF3XVVjdklHedQ=; b=fdMGB2Bjcq3+n3yRu6hUN1Q
	+u76PlB8v8QhUr1BVEX2QO6S7zE8lowuOPcGQUqMFg4a1hBHOybHcofKhpT2PWJp
	mPZ50w+7sUyq4t2Mv8bN4xx5M6gQ7PtUpt0hPrJqHgZ49PB10yN7/6kQQ3OWRCFS
	gUTHr4JvT9C6R0asIYYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lKQIW9+qzTsyXkgI23c+X2jfCS7tDJQYbuOWxeOKrg1preXMi
	eDFOdF2Hs/jdNCCeuj02YWZH2XEONRulSeuZXPZKvfLcY6Z6QZM6+2c0ZI8Pmz4N
	TgjZZqmDRdV01gmM4AlqUagLe54tjkcOaNXrKuAjLR7y3OLZZvFgZ844X0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90FD831618;
	Fri, 21 Aug 2009 03:50:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F25431616; Fri, 21 Aug 2009
 03:50:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4AADFE6E-8E27-11DE-8702-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126693>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Stephan Beyer <s-beyer@gmx.net>
>
> This commit is made of code from the sequencer GSoC project:
>
> git://repo.or.cz/git/sbeyer.git
>
> (commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)
>
> The goal of this commit is to abstract out pick functionnality
> into a new pick() function made of code from "builtin-revert.c".
>
> The new pick() function is in a new "pick.c" file with an
> associated "pick.h".

Is it pick() or pick_commit()?

By the way, this comment applies to other messages in the series, but do
these original commits by Stephan lack any meaningful messages?  I would
actually have expected to see a commit log message that looks more like:

	From: Stephan Beyer <...>

        Meaningful log message Stephan describes what this commit does in
        sufficient detail, perhaps with clarification and rewording by
        Christian.

	Second and subsequent paragraph to explain it as necessary.

	[cc: this is based on 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079
        from Stephan's git://repo.or.cz/git/sbeyer.git]

        Signed-off-by: ...

The point is that the "origin info" would be a side-note, not the first
and the most important thing in the message.
