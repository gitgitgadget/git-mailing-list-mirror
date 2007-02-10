From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 08:25:22 -0800
Message-ID: <7v1wkykmj1.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	<Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	<e5bfff550702100651j244e5a2flf02fb91dc71799b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:25:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFv2V-0007Hl-NZ
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXBJQZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbXBJQZY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:25:24 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46845 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXBJQZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:25:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210162523.HQWU21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 11:25:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id MsRN1W00M1kojtg0000000; Sat, 10 Feb 2007 11:25:23 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39236>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> That's a true point. Altough if git 1.5 ships _without_ '--refresh'
>> option in 'git runstatus' for a porcelain tool point of view it means
>> *do forget* that option until next major release. There's no point in
>> adding the feature one day after git 1.5 is out; qgit will not use
>> that feature anyway for next months.
>
> I could opt for shipping qgit 1.5.5 _without_ using '--refresh' and
> then ship, as example in a month, qgit 1.5.6 that uses the feaure. But
> I can do this _only_ if git 1.5 has it.

You can run it once when you start up to see if --refresh is
supported with the git the user has, and keep that result
throughout the life of the qgit process (so you have to do the
check only once).

What would you do when working with older git anyway?  You would
need to fall back on some code -- or would you require a certain
version of git to go with this version of qgit?

About "Cygwin and Linux NTFS seem to disagree with lstat(2)"
problem.  Is it really what is happening here?  It might be an
interesting exercise to printf(3) the struct stat members in
both environments and find out where they disagree.  It might
turn out to be something trivial to fix for the filesystem guys.
I am not personally interested in solving that problem myself
(nor I am equipped to -- I do not have ready access to dual
booting Windows setup), but still it is interesting to find out
what the issue is.
