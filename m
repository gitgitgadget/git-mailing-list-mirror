From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Use struct tree in diff-tree
Date: Tue, 31 Jan 2006 13:20:47 -0800
Message-ID: <7virs0uma8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
	<Pine.LNX.4.64.0601291405250.25300@iabervon.org>
	<Pine.LNX.4.64.0601310846380.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 22:21:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42vn-0001Nb-6P
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWAaVUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWAaVUt
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:20:49 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26865 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751496AbWAaVUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 16:20:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131211753.SJOC17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 16:17:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601310846380.7301@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 31 Jan 2006 08:53:53 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15348>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 29 Jan 2006, Daniel Barkalow wrote:
>>
>> It had been open-coding a tree parser. This updates the programs that
>> call diff_tree() to send it the struct tree instead of a buffer and
>> size.
>
> Please don't.
> ...
> Junio, please don't apply this.
>
> 		Linus

I haven't, and I won't.  From my gut feeling I did not even
place it in "pu".  After timing it myself and then looking at
the code I agree with your analysis.

The one to git-tar-tree I've already applied, mostly because I
was not careful enough and especially I did not care enough
about performance of that program.  On my slow machine the tip
of kernel before you came back takes 9.2 seconds wallclock as
opposed to 8.7 seconds to tar up, so the patch degrades the
performance by about 5%.  Maybe we would want to revert that one
as well.
