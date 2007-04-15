From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sat, 14 Apr 2007 19:04:00 -0700
Message-ID: <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	<7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 04:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcu62-0006hT-V6
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 04:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbXDOCEE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 22:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbXDOCED
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 22:04:03 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47885 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbXDOCEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 22:04:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415020400.ZAAF1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Apr 2007 22:04:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nE401W00M1kojtg0000000; Sat, 14 Apr 2007 22:04:00 -0400
In-Reply-To: <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 14 Apr 2007 18:41:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44483>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 14 Apr 2007, Junio C Hamano wrote:
>>
>> This adds an obviously sane pair of default attribute rules as built-ins.
>
> I'm not sure.
>
>> +	"[attr]binary !diff !crlf",
>> +	"* diff crlf",
>
> Why would 
>
> 	* diff crlf
>
> be "obviously sane"?
>
> In fact, I'd call it obviously insane.
>
> We do *not* want to default crlf to all files. We want the default to be 
> "automatic crlf depending on content". 

You do not have to worry.

That's how "crlf" is defined.  Paths you explicitly say !crlf
will _not_ go through the existing core.autocrlf mechanism.

"* crlf" just says, by default everybody is subject to core.autocrlf,
and on sane platforms, core.autocrlf is by default off, hence you will
not get LF <-> CRLF applied.
