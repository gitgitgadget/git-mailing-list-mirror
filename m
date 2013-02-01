From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 21:37:51 -0800
Message-ID: <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <20130201050343.GA29973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 06:38:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U19KL-0006hD-DF
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 06:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab3BAFhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 00:37:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab3BAFhy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 00:37:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D429BECE;
	Fri,  1 Feb 2013 00:37:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=efBoiwvnDsXMAgXZAT/Fz9tFBFA=; b=INB0R3
	7TW8mzbKVQQcXVvm4EYQiS03Ijw7ANd5/bQXwJisMOfwKMhEnniwzi3UQeoQuHyV
	wlHXZ4mORuvkmIZEcLkWI9h9vr9N6q1WpysLI5uggb22USR0T/C3VUxZ261vQhQi
	ulceCGL8fePc4lkBVq00sgyjyqtQ8OOgRUi38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MBOjZ0zx7qdF66agrXLPldZdmy5W/W9R
	ixuc/n+Vryqg2gNVDcPk5Qh/99RTulqEIGMh6G4BvPaIRjc8kXUqp4LEuLMtkQS4
	KIo7DyMu/5VNtYiAqLql7f81xtAVwMGXfCxHqOWbvzVem7hZN1M/rcV9xofMJXYW
	aAqCyzxAcNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA85BECD;
	Fri,  1 Feb 2013 00:37:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC374BECC; Fri,  1 Feb 2013
 00:37:52 -0500 (EST)
In-Reply-To: <20130201050343.GA29973@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Feb 2013 00:03:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85E34DCC-6C31-11E2-9313-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215205>

Jeff King <peff@peff.net> writes:

> What was the original rationale for the "gitfoo" form? Was it just to
> visually distinguish command manpages from non-command manpages? I can't
> remember the origins now.

b27a23e (Documentation: convert tutorials to man pages, 2008-05-24)
turns "tutorial.txt" into "gittutorial.txt".  Before that, there
were git{attributes,cli,ignore,hooks,modules}.txt.  They were added
in this order, which reveals the true reason:

    hooks.txt
    gitignore.txt
    gitmodules.txt
    gitcli.txt
    hooks.txt => githooks.txt
    gitatributes.txt

Originally, we did not intend to name them as "git$concept.txt";
instead, we just said "$concept.txt".  Hooks are "hooks", and we
know we are discussing hooks in the context of Git, there was no
reason to say "githooks".  "gitignore" was about the file format,
and it would have been insane to call it "ignore.txt".  The same
applies to "gitmodules.txt".

Things start to go in a strange direction when "cli" was added.  We
know that is about the command line interface in the context of Git,
and it should have been "cli.txt".  To make things worse, later
"hooks.txt" took an example of "gitcli.txt" in the wrong way at
a5af0e2 (Documentation: rename "hooks.txt" to "githooks.txt" and
make it a man page, 2008-05-02).

In other way, I think this wasn't designed, but organically grown.
