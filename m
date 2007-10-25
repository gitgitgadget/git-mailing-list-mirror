From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] walk PATH to generate list of commands for "help
	-a"
Date: Thu, 25 Oct 2007 00:07:45 -0700
Message-ID: <20071025070744.GH759@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net> <1193283437-1706-2-git-send-email-srp@srparish.net> <1193283437-1706-3-git-send-email-srp@srparish.net> <1193283437-1706-4-git-send-email-srp@srparish.net> <1193283437-1706-5-git-send-email-srp@srparish.net> <1193283437-1706-6-git-send-email-srp@srparish.net> <7vve8v24al.fsf@gitster.siamese.dyndns.org> <20071025050736.GG759@srparish.net> <7vk5pb21xv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikwow-0002d1-Lk
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 09:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbXJYHHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 03:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbXJYHHq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 03:07:46 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:48059 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbXJYHHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 03:07:45 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1Ikwoh-0004ka-KN; Thu, 25 Oct 2007 02:07:44 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Thu, 25 Oct 2007 00:07:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk5pb21xv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62280>

On Wed, Oct 24, 2007 at 10:33:32PM -0700, Junio C Hamano wrote:

> > Well, the ultimate reason that i've been working on all of this is
> > i'd like to push git as a viable development tool where i work. To
> > give an effective idea, lets say that shared tools get placed on
> > nfs servers, which can be mounted to different paths depending on
> > which nfs server is up or down or which system is the nfs client.
> 
> It sounds to me that your nfs client systems might find what
> people usually expect in /usr/local/bin not there but on
> /mnt/random47/bin depending on the system, without a reasonable
> system administration effort that places stable symlinks to give
> end users a consistent view of the world regardless from which
> client, which sounds insane.  I personally do not think we
> should support lazy system administrators by making git unsafe.

Well, the exact details are completely fictitious, made up to
illustrate the situation without breaking confidential agreements.
I'm not sure i completely agree with the design, but there are good
reasons for it, and at this point i have little or no control over
it.

> >> It may be nicer if the user can somehow tell from the output if
> >> each of the command is from the standard set (i.e. on
> >> GIT_EXEC_PATH or built-in), or from a non standard place (either
> >> custom command as intended, or an unintended obsolete leftover).
> >
> > What if git marked commands that weren't found in the location where
> > it thinks that it is running from?
> 
> Currently "git help -a" says "available in $where" at the top.
> Perhaps make a separate list that is listed as "available from
> elsewhere" and show the ones that are on PATH but not masked by
> the ones on GIT_EXEC_PATH?
> 
>     git commands available in '/home/junio/git-next/bin'
>     ----------------------------------------------------
>       add                 gui                 rebase--interactive
>       add--interactive    hash-object         receive-pack
>       ...
> 
>     git commands available from elsewhere on your $PATH
>     ----------------------------------------------------
>       frotz               nitfol

Nice! I'll try doing that, probably won't have time to finish until
later tomorrow.

sRp

-- 
Scott Parish
http://srparish.net/
