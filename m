From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and file name case on cygwin
Date: Sat, 03 Feb 2007 17:44:41 -0800
Message-ID: <7v8xfezofq.fsf@assigned-by-dhcp.cox.net>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
	<Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
	<7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDWQv-0004MD-6G
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbXBDBon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbXBDBon
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:44:43 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:65460 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751896AbXBDBom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:44:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204014442.XBXY1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 20:44:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KDkh1W00y1kojtg0000000; Sat, 03 Feb 2007 20:44:42 -0500
In-Reply-To: <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 3 Feb 2007 17:38:16 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38634>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 3 Feb 2007, Junio C Hamano wrote:
>> 
>> Are there plans to "fix" the confusion by renaming them to
>> reduce chances of name clashes on such suboptimal filesystems?
>
> I don't think so. Nobody really does development on such broken 
> filesystems, and I kind of have this nagging suspicion that Niklas noticed 
> just because he wanted to test git, not because he really wanted to do 
> Linux development under Windows ;)
>
> That said, it might not be horrible to do. Doing
>
> 	git ls-files | sort -f | uniq -ic | grep -v ' 1 '
>
> shows that we only have 19 names so afflicted, and they're all in 
> netfilter. Maybe the netfilter people could be convinced not to do it.
>
> But really, do we actually expect anybody to really *care*?

Not really, I was just fishing for an ammunition to use in a
different thread, concerning another filesystem whose readdir()
returns something different from what the user fed creat() to
create the file.
