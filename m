From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history
 simplification with paths
Date: Sun, 10 Aug 2008 14:58:05 -0700
Message-ID: <7v63q8353m.fsf@gitster.siamese.dyndns.org>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch>
 <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808101226130.3462@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 23:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSIwX-00017h-7F
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 23:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYHJV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 17:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbYHJV6N
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 17:58:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbYHJV6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 17:58:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EF0054ABF;
	Sun, 10 Aug 2008 17:58:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 27B3154ABE; Sun, 10 Aug 2008 17:58:07 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808101226130.3462@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sun, 10 Aug 2008 12:27:58 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6CF740AC-6727-11DD-94A8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91889>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 10 Aug 2008, Junio C Hamano wrote:
>> 
>> Personally I do not think --full-history without --parents is of much
>> usefulness (I'd let Linus or somebody else defend this usage, or make it
>> imply revs.rewrite_parents otherwise).  If you remove that case from your
>> set of experiments in the equation, do the rest of the results make sense?
>
> Oh, it's _very_ useful.
>
> The most common case is "git whatchanged". It's useful to find a commit 
> that did some change _without_ any graphical front-end. 
>
> And then the merges and parenthood are totally pointless - no human can 
> try to tie things together in their head _anyway_, so why show them? You 
> just want to find the change.

Oh, I was not talking about revs.print_parents part, but about
revs.rewrite_parents part.  What got Thomas puzzled about was exactly how
the set of commits _shown_ are different with and without --parents, which
sets both of these internal flags.  Your "pointless" argument applies to
"print_parents" part, but "rewrite_parents" affects the resulting set.
