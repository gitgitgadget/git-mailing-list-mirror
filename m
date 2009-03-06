From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch and pull
Date: Fri, 06 Mar 2009 12:49:56 -0800
Message-ID: <7vd4cus7ez.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
 <m3iqmmidlf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John Dlugosz" <JDlugosz@TradeStation.com>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfh14-0001Cw-Vt
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 21:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbZCFUuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 15:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbZCFUuG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 15:50:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbZCFUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 15:50:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B704245F;
	Fri,  6 Mar 2009 15:50:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4F371245E; Fri, 
 6 Mar 2009 15:49:58 -0500 (EST)
In-Reply-To: <m3iqmmidlf.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 06 Mar 2009 12:44:49 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DA52404-0A90-11DE-A8B2-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112479>

Jakub Narebski <jnareb@gmail.com> writes:

> "John Dlugosz" <JDlugosz@TradeStation.com> writes:
>
>> So, after inspecting the changes, how do you fast-forward your local dev
>> to sync up with origin/dev?
>> 
>> I'm worried that
>> 
>> 	git pull origin dev
>> 
>> will try to merge into the current head.  The documentation indicates
>> "The remote ref that matches <src> is fetched, and if <dst> is not empty
>> string, the local ref that matches it is fast forwarded using <src>."
>> which is what I want, but it does NOT say that the normal behavior of
>> merging origin/dev into the =current= HEAD, if it happens to not be the
>> local dev.
>> 
>> So, does it indeed suppress that behavior if you give it an explicit
>> destination?  Or will I have to checkout dev first before doing the
>> pull, to prevent strange things from happening?  Hmm, or perhaps I
>> should be using merge, not pull?  After all, pull is really just a
>> wrapper around fetch and then merge, right?  So is it OK to call merge
>> when I really want to fast-forward, and is there an option to give an
>> error if it isn't ff?
>
> There was patch series adding support --ff=only, but I think it didn't
> made into git...  Hmmm...

I do not think it has much to do with the main point of what John wants to
do which is to muck with local branch without checking it out, which is
only possible when it happens to fast forward to the new tip of the
corresponding branch obtained from the the remote.
