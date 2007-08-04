From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sat, 04 Aug 2007 10:48:29 -0700
Message-ID: <7vwswbgphu.fsf@assigned-by-dhcp.cox.net>
References: <20070804070308.GA6493@coredump.intra.peff.net>
	<Pine.LNX.4.64.0708041636290.14781@racer.site>
	<20070804160409.GA16326@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNjt-0004yp-S6
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761630AbXHDRsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764832AbXHDRsb
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:48:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50647 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758276AbXHDRsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 13:48:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804174829.ZNQH14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 13:48:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XtoV1X0081kojtg0000000; Sat, 04 Aug 2007 13:48:29 -0400
In-Reply-To: <20070804160409.GA16326@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 4 Aug 2007 12:04:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54887>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 04, 2007 at 04:36:59PM +0100, Johannes Schindelin wrote:
>
>> > $ git-clone foo bar
>> > Initialized empty Git repository in ...
>> > 0 blocks
>> 
>> According to http://www.opengroup.org/onlinepubs/7990989775/xcu/cpio.html, 
>> cpio does not know about --quiet.  I think this is another GNUism...
>
> Ugh, I didn't even think to check the spec, thanks for looking (I should
> have been tipped off by the presence only of a long option).
>
> I'm not sure what the best solution is...adding --quiet makes it totally
> unportable, but that message almost looks like an error. We can redirect
> stderr, but then we potentially miss real errors.

I was hoping that we can say that the output is analogous to the
native transport reporting "Conting objects: XXXX" and stuff...
