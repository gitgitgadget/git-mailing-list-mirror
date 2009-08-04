From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag(1): Refer to git-check-ref-format(1) for <name>
Date: Mon, 03 Aug 2009 23:20:20 -0700
Message-ID: <7veirs6qxn.fsf@alter.siamese.dyndns.org>
References: <87ab2gsqst.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDO2-0000X9-QF
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbZHDGUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbZHDGU3
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:20:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbZHDGU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:20:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 57D7D1FB09;
	Tue,  4 Aug 2009 02:20:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C5441FB08; Tue, 
 4 Aug 2009 02:20:22 -0400 (EDT)
In-Reply-To: <87ab2gsqst.fsf@jondo.cante.net> (Jari Aalto's message of "Mon\,
 03 Aug 2009 21\:20\:02 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E648EBC0-80BE-11DE-AC24-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124753>

Jari Aalto <jari.aalto@cante.net> writes:

> Explain briefly what characters are prohibited in tag <name>
> and point to git-check-ref-format(1) manual page for
> more information.
> ---

Thanks.

I do not see a reason to reject this patch (other than lack of sign-off),
but at the same time, I wish if we can somehow teach people that the
branches and the tags are just two special cases of refs that follow
exactly the same set of rules, we would not have to apply another similar
patch to git-branch documentation and instead we can teach what the naming
rules are for refs in general.  Then the readers can learn the rule once,
and extend the knowledge to other types of refs (e.g. notes) in the
future.

I however do not think of a way to organize our documentations without too
many levels of indirections (e.g. repeating "X is just a ref and for
naming rules, see check-ref-format(1)" for all types X of refs).  Not
repeating the rules for documentation of each kind of ref will make the
maintenance a lot easier but hurts readability, but the set of rules is
not a large enough to justify the complexity to use a separate include
file at the source level.
