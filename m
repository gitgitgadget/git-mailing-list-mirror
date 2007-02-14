From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 11:43:25 -0800
Message-ID: <7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQ2V-0001xE-8s
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXBNTn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbXBNTn2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:43:28 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43217 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbXBNTn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:43:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214194327.IZSM22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 14:43:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PXjR1W0111kojtg0000000; Wed, 14 Feb 2007 14:43:26 -0500
In-Reply-To: <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Feb 2007 20:25:52 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39732>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Stupid probably is too strong a word, but I think I'd agree we
>> should default it to $(prefix)/etc and have distros override it
>> in the Makefile.
>
> Fair enough. And my patch was not really complete. Please amend to spare 
> me eternal shame:
> --
> [BROWN PAPERBAG PATCH ON TOP OF OTHER PATCH] 
>
> It is $prefix/etc/gitconfig now, and works also if you do not
> `git config -l`. D'oh.

How would we run our tests without getting screwed by whatever
non-standard values system-wide configuration may have?
Currently we disable tester's ~/.gitconfig by exporting HOME
from t/test-lib.sh, but that will not work for this.

I think we need to have a way to disable this setting, perhaps
via an environment variable.

I do not think we need to support 'git config --system --set foo.bar baz'
but some people might have twisted minds ;-).
