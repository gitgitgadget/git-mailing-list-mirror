From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3-wip] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 15:36:21 -0700
Message-ID: <7v63qly93u.fsf@gitster.siamese.dyndns.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
 <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
 <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
 <7vabfxyacx.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807311513020.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgm5-0001Iv-VQ
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828AbYGaWgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758784AbYGaWgc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:36:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758738AbYGaWgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:36:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D03545B08;
	Thu, 31 Jul 2008 18:36:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0F81145B07; Thu, 31 Jul 2008 18:36:22 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807311513020.3277@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Thu, 31 Jul 2008 15:26:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E10F272-5F51-11DD-B342-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91011>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 31 Jul 2008, Junio C Hamano wrote:
>> 
>> The same query with 's/| head -n 1/>/dev/null' is more expensive.  In fact
>> it is much more expensive than the non-incremental one (v2), and about
>> three times more expensive than non-limiting --full-history for explaining
>> the history of kernel/printk.c.
>
> Hmm? Why is that, exactly? Does it walk over the same commit over and over 
> and over again or something?
>
> Can you combine --simplify-merges and --topo-order to get a fast version 
> again (since --topo-order will force a non-incrmental walk)?

Heh, nice try to make my head explode ;-)  Not today, no, really, no...
