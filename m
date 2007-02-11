From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sun, 11 Feb 2007 14:30:55 -0800
Message-ID: <7vsldcba3k.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	<Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	<e5bfff550702100651j244e5a2flf02fb91dc71799b3@mail.gmail.com>
	<7v1wkykmj1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702102135080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqk0cq7i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702112305580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNDo-0004AB-68
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXBKWa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbXBKWa5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:30:57 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42119 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932591AbXBKWa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:30:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211223057.YVHY21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 17:30:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NNWv1W00r1kojtg0000000; Sun, 11 Feb 2007 17:30:56 -0500
In-Reply-To: <Pine.LNX.4.63.0702112305580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 11 Feb 2007 23:09:20 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39317>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 11 Feb 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Sat, 10 Feb 2007, Junio C Hamano wrote:
>> >
>> >> About "Cygwin and Linux NTFS seem to disagree with lstat(2)"
>> >> problem.  Is it really what is happening here?
>> >
>> > Probably. AFAIR Windows lacks some important information, which is filled 
>> > with zeroes by Cygwin.
>> 
>> If NTFS driver in the Linux kernel is filling that with zeroes
>> the same way then there won't be differences, right?
>
> Maybe. Although I am quite certain that you'd break something by that.
>
> But after all, this is one really obscure corner case you have there, and 
> you are not really working on the repository on Linux either, since you 
> have it mounted readonly.
>
> I absolutely have no intention to "fix" performance or other issues for 
> that case.

Ah, you misread me.  What I was trying to drive at was if we
find the subtle difference between Cygwin's lstat(2) emulation
and lstat(2) result from the NTFS driver in the Linux kernel, we
could start and fuel flamewar on _other_ lists (namely, kernel
and Cygwin) saying "you guys are inconsistent which inconvenience
applications great deal".

And watching other people flame each other is a lot more fun
than flamewar raging close to home ;-).
