From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Fri, 06 Jul 2007 19:00:36 -0700
Message-ID: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
	<7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051223520.9789@racer.site>
	<7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 04:00:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6zbE-0000Sd-Fu
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 04:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbXGGCAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 22:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbXGGCAi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 22:00:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41891 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbXGGCAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 22:00:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707020036.BJFS22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Jul 2007 22:00:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LS0b1X00C1kojtg0000000; Fri, 06 Jul 2007 22:00:36 -0400
In-Reply-To: <alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 6 Jul 2007 10:59:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51798>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> In .gitattributes:
>
> 	*.java diff=java
> 	*.perl diff=perl
> 	*.doc diff=doc
>
> In .git/config
>
> 	[diff "java"]
> 		command = internal
> 		funcname = ... # ugly and complicated regexp to override the built-in one.
>
> 	[diff "perl"]
> 		command = internal
> 		funcname = ...
>
> 	[diff "doc"]
> 		command = ms-doc-diff
>
> Doesn't this make more sense and mesh much better with the already 
> existing custom diff driver?
>
> (And yeah, maybe we could instead of "command=internal" just have the rule 
> that "internal" is the default, and you'd not have a command at all when 
> you want to run the internal diff.
>
> Just an idea. I don't have any code.

Yeah, I'd be lying if I said that this did not cross my mind
when I saw existing diff.*.command handling.

About the comment from Johannes regarding hunk_header vs
funcname, I would actually prefer hunk_header, since that is
what this is about ("funcname" and "find_func" were misnomer
from the beginning), but I'd rename hunk_header to funcname for
the sake of consistency and minimizing the diff.

Will find time to look at this over the weekend.
