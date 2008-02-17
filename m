From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 10:23:25 -0800
Message-ID: <7vr6fbzbky.fsf@gitster.siamese.dyndns.org>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
 <20080217144854.56fcb98d.froese@gmx.de>
 <7vd4qv1n78.fsf@gitster.siamese.dyndns.org>
 <20080217181523.GA4818@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoBS-0001iY-IX
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYBQSXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbYBQSXl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:23:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYBQSXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:23:40 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DF616CF6;
	Sun, 17 Feb 2008 13:23:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7F0D96CF5; Sun, 17 Feb 2008 13:23:33 -0500 (EST)
In-Reply-To: <20080217181523.GA4818@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 17 Feb 2008 13:15:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74154>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 17, 2008 at 09:56:27AM -0800, Junio C Hamano wrote:
>
>> > Wouldn't it be better/safer to redirect stderr to the pager
>> > in the first place?
>> >
>> > So, instead of the current
>> >
>> > 	foo | less
>> > use
>> > 	foo 2>&1 | less
>> 
>> I like it.  Much nicer.  Thanks.
>
> This will also put the stderr of any sub-programs into the pager, which
> is probably worse if you have, e.g., a chatty external diff program. I
> don't know if we care enough about that.

We'll soon find out and the change would be a single liner that
is very easy to back out, so let's put it in and see what
happens ;-).
