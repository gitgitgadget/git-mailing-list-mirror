From: Junio C Hamano <gitster@pobox.com>
Subject: Re: teach git diff -v/--invert-match?
Date: Fri, 22 Aug 2008 14:44:34 -0700
Message-ID: <7vmyj47mil.fsf@gitster.siamese.dyndns.org>
References: <48AED264.60600@visi.com>
 <20080822193947.GA31322@coredump.intra.peff.net> <48AF2FBB.2080401@visi.com>
 <20080822214208.GA4498@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Ericson <bme@visi.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:45:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWeS2-0001r4-ET
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbYHVVon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755693AbYHVVom
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:44:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbYHVVom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:44:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1167D69304;
	Fri, 22 Aug 2008 17:44:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5BA4069303; Fri, 22 Aug 2008 17:44:36 -0400 (EDT)
In-Reply-To: <20080822214208.GA4498@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 22 Aug 2008 17:42:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85EFE080-7093-11DD-B532-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93379>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 22, 2008 at 04:29:31PM -0500, Brian Ericson wrote:
>
>> I was just working on a reply to my own email as I realized it was
>> only  dumb-luck that converted 1200 noisy changes into a couple of
>> dozen.  "-S" matches only  the string itself, not the line the string
>> resides on.  So, -Sxyz will match if  "xyz" itself was added or
>> deleted in the diff (if "xyz" is on a line that's changed but  did not
>> itself change, it won't match).  Funny that I actually knew this -- I
>> use it to look for System.out.println additions among other things.
>
> Yes (though I couldn't have told you that without experimenting -- I
> always assumed it checked whole lines).

The -Sstring counts the number of 'string' in preimage and postimage and
skips the commit if they are the same.  Nothing more.
