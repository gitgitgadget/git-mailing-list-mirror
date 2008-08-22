From: Junio C Hamano <gitster@pobox.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 14:23:33 -0700
Message-ID: <7vvdxs7nhm.fsf@gitster.siamese.dyndns.org>
References: <20080822174655.GP23334@one.firstfloor.org>
 <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
 <20080822182718.GQ23334@one.firstfloor.org>
 <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWe7h-00028Y-FL
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835AbYHVVXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758751AbYHVVXk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:23:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758648AbYHVVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:23:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF348690E9;
	Fri, 22 Aug 2008 17:23:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1ACD5690E8; Fri, 22 Aug 2008 17:23:34 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 22 Aug 2008 12:36:58 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 962679BC-7090-11DD-8800-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93374>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 22 Aug 2008, Andi Kleen wrote:
>> 
>> Well git fetch does nothing by itself.
>
> Git fetch does exactly what it should do by itself. 
>
> If you think it does "nothing", you're really confused.
>
> It updates the "remote" branches - the ones you are downlaoding.
>
>> Sorry that's what I though initially too. But that's wrong.  Just clone
>> e.g. linux-next and then try to update it with pull a day later.  
>
> You SHOULD NOT DO THAT!
>
> linux-next is not a tree that you can track. It's a tree that you can 
> fetch _once_ and then throw away.
>
> So what you can do is to "fetch" linux-next, and test it. But you MUST 
> NEVER EVER use it for anything else. You can't do development on it, you 
> cannot rebase onto it, you can't do _anything_ with it.

Except perhaps if you are maintaining your own set of patches on top of
"last official release from Linus", you can test merge your changes into
the tip of linux-next of the day and make sure you are in good shape.

Of course you need to discard the test merge after doing so. 

An obvious question I can foresee is "What if I had conflicts in the test
merge, and have to resolve it to see if my changes still work?  I'd
want to rebase so that I do not have to resolve the conflict again when
linux-next matures and gets into Linus's tree.  Now you tell me not to
rebase onto it.  What should I do?"

My tentative answer is "don't worry, rerere will help you next time", but
there may be better options.
