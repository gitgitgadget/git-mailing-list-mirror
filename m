From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] gitweb: Create special from-file/to-file header for combined diff
Date: Sun, 27 May 2007 18:43:55 -0700
Message-ID: <7v1wh1en8k.fsf@assigned-by-dhcp.cox.net>
References: <11803077771867-git-send-email-jnareb@gmail.com>
	<11803077792064-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 03:44:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsUHD-0003cw-AX
	for gcvg-git@gmane.org; Mon, 28 May 2007 03:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbXE1Bn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 21:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758164AbXE1Bn7
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 21:43:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61388 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbXE1Bn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 21:43:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070528014357.WTEU22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 27 May 2007 21:43:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4Rjv1X0051kojtg0000000; Sun, 27 May 2007 21:43:55 -0400
In-Reply-To: <11803077792064-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Mon, 28 May 2007 01:16:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48606>

Jakub Narebski <jnareb@gmail.com> writes:

> Instead of using default, diff(1) like from-file/to-file header for
> combined diff (for a merge commit), which looks like:
>
>   --- a/git-gui/git-gui.sh
>   +++ b/_git-gui/git-gui.sh_
>
> (where _link_ denotes [hidden] hyperlink), create from-file(n)/to-file
> header, using n/file for each or parents, e.g.:
>
>   --- 1/_git-gui/git-gui.sh_
>   --- 2/_git-gui.sh_
>   +++ b/_git-gui/git-gui.sh_

Sounds quite straightforward to implement, and diff with 1/
would be useful to recreate what the person who did the merge
pulled in, for most of the time.  I suspect diff with 2/ is
almost always uninteresting, though.
