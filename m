From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Fri, 24 Jul 2009 17:54:15 -0700
Message-ID: <7v1vo537m0.fsf@alter.siamese.dyndns.org>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
 <20090724170622.GA20247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:54:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUVX2-0003C3-Pi
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbZGYAy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbZGYAy2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:54:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbZGYAy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:54:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E9F5E126E1;
	Fri, 24 Jul 2009 20:54:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1FDA6126E0; Fri,
 24 Jul 2009 20:54:21 -0400 (EDT)
In-Reply-To: <20090724170622.GA20247@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 24 Jul 2009 13\:06\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B471D0AA-78B5-11DE-BF62-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123988>

Jeff King <peff@peff.net> writes:

> Perhaps it makes sense to have an interactive stash rather than an
> interactive revert? Then the reverts that you make are still being saved
> somewhere, and you can recover from an error by applying the stash. Not
> to mention that interactive stash is useful in its own right.
>
> The downside is that if you are the sort of person who keeps a clean
> stash list (and I am not such a person), then you have this
> "to-be-deleted" cruft on the top of your stash (whereas with a true
> revert, it just goes away).

Yeah, such a stash entry would be more like "trash can".  It is not
"to-be-deleted" but "have been deleted, but you _could_ resurrect".

It may not be a bad idea to do it that way, or perhaps "git checkout -p"
can automatically create such a trash can while undoing the local changes
in the work tree.
