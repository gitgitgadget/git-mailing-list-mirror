From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 02 May 2007 10:26:08 -0700
Message-ID: <7vodl33znz.fsf@assigned-by-dhcp.cox.net>
References: <200705012346.14997.jnareb@gmail.com>
	<200705020955.04582.andyparkins@gmail.com>
	<Pine.LNX.4.64.0705021046230.2425@reaper.quantumfyre.co.uk>
	<200705021158.04481.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 19:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjIbL-0006E8-N9
	for gcvg-git@gmane.org; Wed, 02 May 2007 19:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbXEBR0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 13:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766536AbXEBR0N
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 13:26:13 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50800 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbXEBR0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 13:26:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070502172608.ONVQ1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 2 May 2007 13:26:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uHS81W00K1kojtg0000000; Wed, 02 May 2007 13:26:09 -0400
In-Reply-To: <200705021158.04481.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 2 May 2007 11:58:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46041>

Andy Parkins <andyparkins@gmail.com> writes:

>     - SVN checkout overhead is always _at least_ the size of the source tree 
>       because it keeps a pristine copy of HEAD.  If the source tree is 1.5G,
>       then this figure should be at least 3G.

Could it be that there is a mode in svn checkout that allows
pristine to be hardlinked to the working tree copies?  It
requires an editor that can be told to break hardlinks when
making modifications (and the user obviously needs to know about
it), but to save 1.5G it is worth it and if _I_ were hacking on
SVN that would be an obvious optimization to add.
