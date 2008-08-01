From: Junio C Hamano <gitster@pobox.com>
Subject: Re: email address handling
Date: Fri, 01 Aug 2008 13:07:59 -0700
Message-ID: <7vej58sdls.fsf@gitster.siamese.dyndns.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
 <20080801124550.26b9efc0.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0w5-0002gp-6t
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbYHAUIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYHAUIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:08:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbYHAUIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:08:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 36062461AF;
	Fri,  1 Aug 2008 16:08:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 00CB9461AE; Fri,  1 Aug 2008 16:08:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 1 Aug 2008 12:56:44 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DDA9A68-6005-11DD-9C3E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91085>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 1 Aug 2008, Andrew Morton wrote:
>> 
>> That's how I noticed it - copied, pasted, MTA barfed.
>> 
>> Converting a usable name+email-address into an unusable one seems ... unuseful.
>
> Umm. Those signed-off ones weren't even _converted_ They were written by 
> people.
>
> Also, you seemed to miss the point that it's not a name+email-address. 
>
> It's a name. Oh, and there's an email address too. But they aren't 
> connected. We often just print out the name *without* the email address. 
> Why should those things have to know about some totally irrelevant email 
> quoting rules? They weren't emails, didn't know about it, and didn't care.

One place that can matter is git-send-email.perl; IIRC, it reads from the
S-o-b:, Cc: and From: lines people write, and these follow "name next to
address, that does not care irrelevant email quoting rules" format.  I do
not think send-email currently does much about quoting them, but I think
it should be the right place to do so.
