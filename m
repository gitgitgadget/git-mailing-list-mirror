From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: import Term::ReadKey with 'require'
Date: Fri, 06 Feb 2009 23:50:00 -0800
Message-ID: <7v8woiznx3.fsf@gitster.siamese.dyndns.org>
References: <20090206140126.GA18364@coredump.intra.peff.net>
 <1233948601-4828-1-git-send-email-trast@student.ethz.ch>
 <20090206203037.GB19959@coredump.intra.peff.net>
 <200902070021.18928.trast@student.ethz.ch>
 <20090207045401.GA21135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:51:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhya-0007LS-4s
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbZBGHuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZBGHuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:50:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbZBGHuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:50:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3074D97249;
	Sat,  7 Feb 2009 02:50:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4774A97248; Sat,
  7 Feb 2009 02:50:05 -0500 (EST)
In-Reply-To: <20090207045401.GA21135@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Feb 2009 23:54:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F2E7CB6C-F4EB-11DD-937E-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108825>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 07, 2009 at 12:21:13AM +0100, Thomas Rast wrote:
>
>> > (note that you could also skip the import and just call
>> > Term::ReadKey::ReadKey by its full name).
>> 
>> I tried that but couldn't get either Term::ReadKey::ReadKey or
>> Term::ReadKey->ReadKey to work.  In retrospect, I suppose it requires
>> parentheses too.
>
> Right, you would still need the parentheses. But note that the second
> syntax (with the "->") would always be wrong. The "::" syntax just says
> "find this name not in the current namespace, but in this absolute
> namespace I am giving you". But "X->Y" is actually a syntactic shorthand
> for "look up X::Y (or Z::Y, where Z is the blessed package of X), and
> then call X::Y(X, @_)".
>
> Which makes sense for object-oriented stuff. You get the object or the
> classname as the first parameter to a method. But for a regular package
> function, you would be calling
>
>   Term::ReadKey::ReadKey('Term::ReadKey', 0)
>
> which of course makes no sense.
>
> But I think doing the import makes more sense (and is how Term::ReadKey
> is intended to be used), so the patch you posted is best.

Ok, will queue.
