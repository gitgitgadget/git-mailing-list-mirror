From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking
 backwards
Date: Tue, 10 Feb 2009 15:30:07 -0800
Message-ID: <7vprhpkgzk.fsf@gitster.siamese.dyndns.org>
References: <200902091508.11460.trast@student.ethz.ch>
 <200902102342.29962.trast@student.ethz.ch>
 <7v7i3xlwz4.fsf@gitster.siamese.dyndns.org>
 <200902110012.34717.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:32:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX24v-0007VZ-UB
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbZBJXaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZBJXaQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:30:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbZBJXaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:30:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A567A2ADDD;
	Tue, 10 Feb 2009 18:30:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E01752ADBB; Tue,
 10 Feb 2009 18:30:08 -0500 (EST)
In-Reply-To: <200902110012.34717.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 11 Feb 2009 00:12:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2EAF1FA-F7CA-11DD-8B02-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109342>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> 
>> > I have imported all commits, and mails since roughly July 2008
>> > (starting with Gmane 89000).  In this timeframe there were 1802
>> > non-merge commits, and the mailnotes tree now holds 1122 annotations.
>> 
>> How do you match the mails to commits?
>> 
>> I am curious what the right balance for the matching algorithm should be,
>> between being forgiving about amending of commit log message and the patch
>> text to fix minor typos and obvious bugs, and being strict not to cause
>> false matches to a message that contains the second iteration of the
>> patch, when what was committed was the first iteration.
>
> Right now it's just the patch-id.  Maybe filtering (author,subject)
> and then picking the one that is the most similar could work.

Yeah, I actually was thinking about matching the (date, author) tuple and
nothing else, as it is unlikely you would have dups.

By the way, the note to f6b98e4 (git-web--browse: Fix check for
/bin/start, 2009-02-08) is interesting.

Ramsay's 104332 was the same as what ended up in the commit, but his
second patch that can be found by going to the thread from it is obviously
a better alternative.  In short, I screwed up, by not recalling the
previous round.  Sorry.

I find the "Extra-Notes:" tag a bit too loud, but I am probably a minority
who thinks everything but the Message-ID can be dropped, so please don't
take it as a feature request ;-)
