From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Fri, 13 Oct 2006 14:38:59 -0700
Message-ID: <7vy7rjc2vg.fsf@assigned-by-dhcp.cox.net>
References: <20061013205418.5087.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 23:39:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYUkF-0006Iy-M5
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030177AbWJMVjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 17:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWJMVjD
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 17:39:03 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39928 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030177AbWJMVjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 17:39:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013213900.GBFD2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 17:39:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zxf31V0041kojtg0000000
	Fri, 13 Oct 2006 17:39:03 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061013205418.5087.qmail@web31803.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 13 Oct 2006 13:54:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28863>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>> > Junio, is it possible to also print the "previous" commit?
>> > I mean, is it tenable to print the commit such that
>> > a "git-diff C B -- A:file" will give a diff of the block of lines
>> > we're looking at?
>> 
>> There is no single "previous" in general.  Which side of the
>> merge would you take?
>
> The parent commit.

There is no single "the parent commit" in general.  Which side
of the merge would you take?

Also remeber, when we blame a line to a revision (unless we do
not limit the blame with v2.6.18.. and --since=2.weeks which
only git-pickaxe can do), the line is known to have been
introduced by _that_ commit.  If there were a corresponding line
in "the parent commit" for that line, we would not have assigned
the blame to the commit, but the blame would have been passed
down to "the parent commit" already.
