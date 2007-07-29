From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Sun, 29 Jul 2007 19:44:28 -0400
Message-ID: <ADE1034F-2454-4249-8DCF-872C52CD471F@silverinsanity.com>
References: <85lkcyvr4f.fsf@lola.goethe.zz> <7vk5sin9g0.fsf@assigned-by-dhcp.cox.net> <85bqduvo5r.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 01:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFIRD-00064h-Tv
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764660AbXG2Xoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbXG2Xoc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:44:32 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50891 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764555AbXG2Xob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:44:31 -0400
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 201141FFC245;
	Sun, 29 Jul 2007 23:44:30 +0000 (UTC)
In-Reply-To: <85bqduvo5r.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54162>


On Jul 29, 2007, at 6:30 PM, David Kastrup wrote:

> a) this required the installation of additional software for a simple
>    task.

I would think it's preferable to have a single piece of software to  
manage these links than attempt to craft a custom solution for every  
package you install.

> b) if the software worked using symbolic links, it would not know at
>    what level to make the links (namely create
>    /usr/local/share/man/man1 and link every file from
>    /opt/git/share/man/man1, but link the directory
>    /usr/local/share/git-core directly to /opt/git/share/git-core).

What stow does is to create a directory for every level where  
multiple packages have files or non-stow files exists.  It would  
create a link at /usr/local/share/git-core because nobody else uses  
that directory.  If there are other /usr/local/share/man/man1/*  
files, it would make a link for every file in the git version.

> Since the stuff is strictly an additional convenience not impacting
> any of the existing targets, I would not have thought it terribly
> controversial.

It's additional maintenance, mostly.  I don't have an objection to  
it, although I also don't see a reason to include it.

> Is there a place other than the git list where one can provide patches
> that are not likely to end up in git.git?

You could make a repo at repo.or.cz, I think.  Have different  
branches to maintain features and rebase them on top of master  
periodically.  Or just any random web-page to publish raw patches.

My $0.02,
~~ Brian
