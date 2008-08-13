From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated logging by
Date: Wed, 13 Aug 2008 10:23:42 +0200
Message-ID: <20080813082342.GC12628@cuci.nl>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> <7vzlnhq48b.fsf@gitster.siamese.dyndns.org> <20080812225642.GA15265@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 10:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTBfB-0002xj-Qa
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbYHMIXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 04:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYHMIXp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:23:45 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34014 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYHMIXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 04:23:43 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BE15D5465; Wed, 13 Aug 2008 10:23:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812225642.GA15265@cuci.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92191>

Stephen R. van den Berg wrote:
>Junio C Hamano wrote:
>> - Taking advantage of poll() getting interrupted by SIGCHLD, so that you
>>   do not have to do anything in the signal handler, is so obvious that I
>>   am actually ashamed of not having to think of it the last time we
>>   touched this code.  Is there a poll() that does not return EINTR but
>>   just call the handler and restart after that as if nothing has
>>   happened, I have to wonder...

>Only if the signal is set to SIG_IGN on all systems I worked with since
>1987.

And even if it doesn't get interrupted and restarts, it means that it
merely leaves some zombies uncollected until the next new connection to
the daemon; nothing to get worried about.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
