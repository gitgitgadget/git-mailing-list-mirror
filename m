From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 15:37:59 -0700
Message-ID: <7vveck2cvs.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	<7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
	<81b0412b0707160531mad35ed4x4c89b2d6c6f5f707@mail.gmail.com>
	<7v4pk444rd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707161055i2f12b858n7be155765fb664@mail.gmail.com>
	<e5bfff550707161102n3b6da174i7bbff64e1739a1b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 00:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAZD2-0000MT-P7
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 00:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765979AbXGPWiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 18:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbXGPWiD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 18:38:03 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56465 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765666AbXGPWiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 18:38:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716223800.PYBD1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 18:38:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QNdz1X00e1kojtg0000000; Mon, 16 Jul 2007 18:38:00 -0400
In-Reply-To: <e5bfff550707161102n3b6da174i7bbff64e1739a1b2@mail.gmail.com>
	(Marco Costalba's message of "Mon, 16 Jul 2007 20:02:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52730>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 7/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
>> On 7/16/07, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > I'd say making --show-message-size option incompatible with diff output
>> > would be good enough futureproofing for now.
>> >
>> Oooops, I didn't see your post.
>>
>> I agree 100%, please tell me if doc it's clear enough or it would be
>> better to clarify that "message log" it means only message and no diff
>> content.
>>
>
> Sorry to bother you again, but my English is very bad and I would like
> to be clear.
>
> When i say no diff content I mean that git log --log-size -p it's a
> perfect valid command but --log-size will make git print the size of
> _only_ the log part, it means from the line after "log size xxx\n"
> until the end of log message that can be '\0' (if no diff) or the
> beginning of diff part.

What I originally meant with my comment was to _error_ out if
the user says "git log --log-size -p" (or "git show --log-size"
without "-s").

But I guess it is probably fine, as long as it is crystal clear
to the users that we do not do size for non log part.  I still
have this nagging feeling that this is an ugly workaround for Qt
library's programming interface, though...
