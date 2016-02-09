From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update_linked_gitdir writes relative path to .git/worktrees/<id>/gitdir
Date: Tue, 09 Feb 2016 13:02:11 -0800
Message-ID: <xmqqoabp38do.fsf@gitster.mtv.corp.google.com>
References: <1454789548.23898.223.camel@mattmccutchen.net>
	<xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
	<1454893478.2511.5.camel@mattmccutchen.net>
	<20160208135607.GB27054@sigill.intra.peff.net>
	<xmqqziva6e6e.fsf@gitster.mtv.corp.google.com>
	<1455048354.2511.199.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:02:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFQP-0000qe-TW
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbcBIVCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:02:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932360AbcBIVCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:02:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3BF442EF6;
	Tue,  9 Feb 2016 16:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F7KaA7SuMpeRQ7+O4lYpzHlxTls=; b=RFpYLv
	MwsVZ+upD+Gf7vHvTckI48DqekX4+1WiJVGKagQWJU3fXhBpYV3wKKJ5z7buoFBA
	jP4+HEhSkuPWdQgAgSgqszWHLaOZfuQYKcKWqVFezqBILsKiiRhKXOTzW5dz558e
	zwp1b+aJBcLrcJUMvLcXpel/mlOe+wbg19wfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KXe6gTqI/yAOWyYxQtqKOx539uIrnJDB
	N3/qO+EmEOARQVZb3Vgh35I7q6BstvR7IYPukXovU3ti8B5lTme6O2nnS1ie4F+J
	9jK08+so6S8URRjMi3+fYDvqk4NKls4BTCAaamVf/yrnrdPSYbMuFTrriWkVGirI
	khiT2/CoNt0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C869D42EF5;
	Tue,  9 Feb 2016 16:02:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3D3F842EF4;
	Tue,  9 Feb 2016 16:02:12 -0500 (EST)
In-Reply-To: <1455048354.2511.199.camel@mattmccutchen.net> (Matt McCutchen's
	message of "Tue, 09 Feb 2016 15:05:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63D1A760-CF70-11E5-AD8E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285866>

Matt McCutchen <matt@mattmccutchen.net> writes:

> See my revised proposed text here:
>
> https://github.com/git/git-scm.com/pull/676/files

If somebody says "The ancient version I use has this bug, it does
not reproduce with 'next'", the first thing we would ask would be
"Does it still happen on 'master'?"  Even though it is often clear
from the context and the nature of the bug which topic in 'next' is
likely to have fixed it, if the reporter skipped 'master', we would
end up scratching our head which topic in 'next' that is not
'master' fixed it as a side effect.  And because not everything on
'next' is ready for 'master', we cannot just merge everything ;-)

On the other hand, if somebody says "The ancient version I use has
this bug, it does not reproduce with 'master'", we would likely not
to say anything other than "Oh, that's good for you.".

If somebody says "The ancient version I use has this bug, it still
reproduces with 'master'", then we would ask 'next' to be tried.

For these reasons, I'd say "try the 'master' branch".  Trying 'next'
is highly appreciated, but not without trying 'master'.

> I left a mention of providing feedback on pending fixes but thought it
> would be too much to go into the details of how to identify whether
> there is a pending fix.

What is in 'master' relative to the version of Git the bug reporter
has can be seen by reading through RelNotes of the released versions
since the version reporter used, and RelNotes in the 'master'.
Every time an updated 'master' is pushed out, the changes made by
the topics merged to it are added to update RelNotes.

"What's cooking" report, issued once or twice a week, summarizes the
topics that are still not in 'master' (the description in there are
used to update RelNotes when topics graduate to 'master').

Also "Git Rev News" may cover recent efforts on tackling interesting
bugs.

Thanks.
