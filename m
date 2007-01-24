From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to pull only a few files from one branch to another?
Date: Tue, 23 Jan 2007 22:58:47 -0800
Message-ID: <7vac08j4go.fsf@assigned-by-dhcp.cox.net>
References: <17846.53626.895660.762096@lisa.zopyra.com>
	<Pine.LNX.4.64.0701240019250.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 07:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9c6G-0000el-5d
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 07:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbXAXG6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 01:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933177AbXAXG6t
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 01:58:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54781 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174AbXAXG6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 01:58:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124065848.NEVH25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 01:58:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Euz61W0061kojtg0000000; Wed, 24 Jan 2007 01:59:06 -0500
In-Reply-To: <Pine.LNX.4.64.0701240019250.20138@iabervon.org> (Daniel
	Barkalow's message of "Wed, 24 Jan 2007 00:29:00 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37608>

Daniel Barkalow <barkalow@iabervon.org> writes:

> You don't pull in a few files, you apply the changes made in a few 
> commits:
>
>   git diff HEX_OF_NIT_FIX^ HEX_OF_NIT_FIX | git apply
>
> If there's other stuff in the nit-fixing commit, shame on you, but you can 
> edit the patch before applying it to remove everything that's not what you 
> want.

Or just:

	git cherry-pick HEX_OF_NIT_FIX

possibly followed by tweaking the result and running:

	git commit --amend
