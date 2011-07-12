From: Stephen Bash <bash@genarts.com>
Subject: Re: Tracking changes in git with a change number....
Date: Tue, 12 Jul 2011 08:54:05 -0400 (EDT)
Message-ID: <2077407.34684.1310475245616.JavaMail.root@mail.hq.genarts.com>
References: <20110712055008.GC11644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"James M CIV NSWCDD Rice, K73" <james.rice2@navy.mil>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 14:56:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgcVf-0003bn-Pl
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 14:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab1GLMyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 08:54:15 -0400
Received: from hq.genarts.com ([173.9.65.1]:54992 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553Ab1GLMyO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 08:54:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 13ABBEA236B;
	Tue, 12 Jul 2011 08:54:13 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1mw4vcYASdYd; Tue, 12 Jul 2011 08:54:06 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 13A6FEA2373;
	Tue, 12 Jul 2011 08:54:06 -0400 (EDT)
In-Reply-To: <20110712055008.GC11644@sigill.intra.peff.net>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176939>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Tuesday, July 12, 2011 1:50:08 AM
> Subject: Re: Tracking changes in git with a change number....
> 
> > Restating the problem. I wish for our developers to be able to
> > reference multiple commits with one number, and then find those
> > commits via that number. And I don't mind scripting to accomplish
> > this. I know, that CR # can be put in the commit message, then I can
> > grep and parse the log, that is the hard way.
> 
> There are two ways to approach this: tell the CM tool about some git
> commits, or tell some git commits about the CR number.
>
> ... snip ...
> 
> If you want to do the reverse and tell git about CR numbers, then I
> don't think you have much option besides putting them in the commit
> message. Which means you'll need to grep to get them out. You can do
> something like:
> 
> $ git log --grep='CR#' --pretty=format: --name-only

To add to what Jeff said, in our office we automate the 'grep' step using a git post-receive hook in our central/canonical repo.  We happen to be using Trac for issue tracking, so the post-receive hook enumerates the new commit ids, calls Trac to parse the commit messages, and Trac then updates the appropriate tickets.  But I've seen the same done with many different issue trackers.

Thanks,
Stephen
