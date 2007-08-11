From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 13:10:31 -0700
Message-ID: <7vveblltmw.fsf@assigned-by-dhcp.cox.net>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
	<85r6mawedp.fsf@lola.goethe.zz> <858x8iw9q1.fsf@lola.goethe.zz>
	<46BDB0E7.3020506@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxIC-0001ym-2c
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbXHKUKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbXHKUKd
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:10:33 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50845 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbXHKUKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:10:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811201033.HNMD7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 16:10:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id akAX1X00H1kojtg0000000; Sat, 11 Aug 2007 16:10:32 -0400
In-Reply-To: <46BDB0E7.3020506@midwinter.com> (Steven Grimm's message of "Sat,
	11 Aug 2007 20:51:51 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55628>

Steven Grimm <koreth@midwinter.com> writes:

> David Kastrup wrote:
>> Actually, wouldn't by far the most straightforward thing be if
>> git-rev-parse --git-dir always returned an absolute path (even when
>> being passed a relative path in GIT_DIR)?
>>
>
> That might also help get rid of an annoying failure mode where some
> git commands (the shell script ones) fail if you cd into a git
> repository via a symlink, while others (the builtins) work just fine.

It might be the easiest workaround for this issue to unset PWD
in git-sh-setup.sh (and git-clone.sh) where we unset CDPATH.
Anybody wants to try to come up with additional test scripts to
expose the problem and a patch to these two files?
