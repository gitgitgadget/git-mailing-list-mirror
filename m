From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 01 May 2007 10:11:50 -0700
Message-ID: <7vps5k5uzt.fsf@assigned-by-dhcp.cox.net>
References: <463678B7.70409@gmail.com>
	<7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
	<200705010926.35265.andyparkins@gmail.com>
	<7virbc7vue.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705011044210.6574@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 01 19:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HivtN-0001Bs-Qb
	for gcvg-git@gmane.org; Tue, 01 May 2007 19:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbXEARLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbXEARLw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 13:11:52 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57513 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbXEARLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 13:11:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501171149.TJWC1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 13:11:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ttBq1W0011kojtg0000000; Tue, 01 May 2007 13:11:50 -0400
In-Reply-To: <alpine.LFD.0.98.0705011044210.6574@xanadu.home> (Nicolas Pitre's
	message of "Tue, 01 May 2007 10:46:20 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45959>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 1 May 2007, Junio C Hamano wrote:
>
>> I was not sure if that is even a good idea, and I am now
>> inclined to think that keeping the failed attempt history is
>> probably better than potentially causing confusion to people who
>> follow 'next'.  But it _is_ a possibility to reset 'next' to
>> 'master'.
>
> And what is the advantage of doing that, exactly?

Not much and that is why I am not sure if that is a good idea,
but one thing is:

	$ git log master..next
	$ git log --no-merges master..next

would start showing what are still pending in next without
noise.

With the current 'next', the output of the former is almost
useless, and the latter is useful only until 'next' starts
diverging again from the master and if you are interested in
what will never merged to 'master'.  Once 'next' starts growing
again, you will get mixture of what's cooking and what's killed;
the output from the latter would become useless again.
