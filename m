From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] CE_REMOVE conversion
Date: Thu, 21 Feb 2008 08:43:56 -0800
Message-ID: <7vodaauunn.fsf@gitster.siamese.dyndns.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802210746410.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEXR-0002Wi-6F
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758537AbYBUQoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757615AbYBUQoL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:44:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbYBUQoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:44:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4367E21AA;
	Thu, 21 Feb 2008 11:44:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 82E6021A8; Thu, 21 Feb 2008 11:43:59 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802210746410.7833@woody.linux-foundation.org>
 (Linus Torvalds's message of "Thu, 21 Feb 2008 08:05:42 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74631>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 21 Feb 2008, Junio C Hamano wrote:
>> 
>> but I am wondering if we should instead really _remove_ entries
>> from the index instead, just like the attached patch.
> ...
> So your patch looks very good to me. Basically, the merge code absolutely 
> does not want to be called with some entries already marked as CE_REMOVE 
> (it's supposed to *add* those markers as part of resolving the merge, but 
> it is not able to handle them in the source).
>
> So ack, ack, ack.

And we probably should unhash the entry instead of just removing
it?  Come to think of it, I am starting to wonder if the
entries unpack-trees add to and drop from the index are hashed
and unhashed correctly...
