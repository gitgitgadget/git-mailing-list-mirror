From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 8/6] Teach directory traversal about subprojects
Date: Wed, 11 Apr 2007 17:50:58 -0700
Message-ID: <7vfy76mn4d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704111439210.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnWh-0007FB-19
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbXDLAvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbXDLAvA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:51:00 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56287 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbXDLAu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:50:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412005059.MSHN1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 20:50:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m0qy1W00q1kojtg0000000; Wed, 11 Apr 2007 20:50:59 -0400
In-Reply-To: <Pine.LNX.4.64.0704111439210.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 11 Apr 2007 14:49:44 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44297>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yes, this adds many more lines than it removes, but 40 of the added lines 
> really are just added comments about what we're doing. And the end result 
> really is more readable too even if ignoring the comments, I think.

Much nicer to read.

> diff --git a/dir.h b/dir.h
> index 33c31f2..1931609 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -33,7 +33,8 @@ struct dir_struct {
>  	int nr, alloc;
>  	unsigned int show_ignored:1,
>  		     show_other_directories:1,
> -		     hide_empty_directories:1;
> +		     hide_empty_directories:1,
> +		     no_dirlinks;
>  	struct dir_entry **entries;
>  
>  	/* Exclude info */

Did you mean a bitfield here?
