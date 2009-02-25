From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 12:06:12 -0800
Message-ID: <7vk57e1du3.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
 <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain>
 <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0902251106070.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ2o-0000Yh-Mp
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454AbZBYUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 15:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbZBYUGX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:06:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbZBYUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:06:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B3A2C9C713;
	Wed, 25 Feb 2009 15:06:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F38EB9C711; Wed,
 25 Feb 2009 15:06:14 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0902251106070.3111@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 25 Feb 2009 11:12:47 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C44DE990-0377-11DE-A205-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111493>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> You, I and experienced users know what to do.  Deal *only* with the last
>> kind, mark them with "git add" after you are done with each of them, and
>> make sure you do not say "-a" when committing the result, to exclude the
>> first kind from the merge result.
>> 
>> I've been wondering if we can make this safer for others.
>
> You're right. We could decide to have a mode (maybe default to it, so that 
> people like me can just use a config option to enable "expert" mode) that
> simply refuses to do the merge if it doesn't succeed cleanly if there were 
> dirty files in the tree.

"git merge" has always had this "stash away local changes before starting,
and unstash once done" safety when we try to run multiple strategies.
A patch to trigger it even for a single strategy case may be trivial.
