From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 03:14:13 -0700
Message-ID: <7v8x96glca.fsf@assigned-by-dhcp.cox.net>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
	<200707241033.36509.robin.rosenberg.lists@dewire.com>
	<46A5BA87.50105@fs.ei.tum.de>
	<200707241134.31950.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHPG-00007Z-E4
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764740AbXGXKOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762386AbXGXKOP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:14:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44104 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761947AbXGXKOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:14:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724101414.KJPT1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 06:14:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TNED1X0091kojtg0000000; Tue, 24 Jul 2007 06:14:14 -0400
In-Reply-To: <200707241134.31950.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Tue, 24 Jul 2007 11:34:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53553>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> Tail of the first cvsexportcommit invocation (trash/cvswork/a) from the place where it writes the last file
> into the CVS repo.
>  
> 27778 write(7, "/with spaces.png/1.1/Tue Jul 24 "..., 99) = 99
> 27778 close(7)                          = 0
> 27778 munmap(0xb7f15000, 4096)          = 0
> 27778 rename("CVS/Entries.Backup", "CVS/Entries") = 0
> 27778 unlink("CVS/Entries.Log")         = 0
> 27778 fchdir(6)                         = 0
> 27778 close(6)                          = 0
> ...
> 27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> 27778 time(NULL)                        = 1185268822
> 27778 gettimeofday({1185268822, 953340}, NULL) = 0
>
> Here CVS sleeps. The amount varies between invocations since it
> only sleeps enough for the seconds to wrap.

Makes one wonder what it would do if you are on a filesystem
with coarser-than-a-second timestamp resolution.
