From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-clean fails to remove a file whose name contains \\, ", or  \n, TAB, etc.
Date: Tue, 08 May 2007 13:53:30 -0700
Message-ID: <7vbqgv2g1h.fsf@assigned-by-dhcp.cox.net>
References: <87ps5bhx8t.fsf@rho.meyering.net>
	<86k5vj9gzu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue May 08 22:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlWhO-0001Fc-FO
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031634AbXEHUxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031635AbXEHUxd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:53:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50333 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031634AbXEHUxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:53:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508205331.IZS22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 16:53:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wktW1W0021kojtg0000000; Tue, 08 May 2007 16:53:30 -0400
In-Reply-To: <86k5vj9gzu.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Tue, 08 May 2007 13:51:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46622>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Jim" == Jim Meyering <jim@meyering.net> writes:
>
> Jim> Not that it matters (or maybe this is a feature :-), because people
> Jim> who create such files in their working directory deserve what they
> Jim> get, Eh? :-)
>
> The problem is the newline in the string, since
>
>   git-ls-files --others --directory $excl ${excl_info:+"$excl_info"} -- "$@" |
>   while read -r file; do
>
> is using newline as a delimiter.  Any file with a newline would mess this up.
>
> Not being a shell programming expert, is there a way we could use -z and xargs
> -0 here instead?

Funny that we had this discussed on this list a few days ago
;-).
