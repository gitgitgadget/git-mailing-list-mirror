From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: how does git svn work
Date: Mon, 30 Jun 2008 16:57:07 -0400
Message-ID: <02EDA057-6DE9-4038-ACDA-8763BE0A0D0C@silverinsanity.com>
References: <200806302157.32828.thomas@koch.ro>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Mon Jun 30 22:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDQRv-0004EF-N6
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 22:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbYF3U5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757000AbYF3U5L
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 16:57:11 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35815 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbYF3U5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 16:57:10 -0400
Received: from [172.24.32.186] (dfpub107.digitalfocus.com [65.120.79.7])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id AAD021FFC023;
	Mon, 30 Jun 2008 20:57:01 +0000 (UTC)
In-Reply-To: <200806302157.32828.thomas@koch.ro>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86938>


On Jun 30, 2008, at 3:57 PM, Thomas Koch wrote:

> In particular I want to follow the repository at:
> http://pubsvn.ez.no/nextgen/
>
> The layout is like
> /trunk
> /stable
>  |- 4.0
>  |- 3.9
>  |- 3.8
>  ...
> /releases
>  |- 4.0
>  |- 4.0r1
>  |- 3.9
>  |- 3.9r1
>  |- 3.9r2
>
>
> I do not know, whether git-svn can create branches automatically for
> each directory under /stable and one main branch for trunk or  
> whether I
> need to create one svn-remote definition for every svn directory I  
> want
> to track.

I'm not sure what commands git-svn uses, but it looks like the  
following command should work:

git svn clone --trunk=trunk --tags=releases --branches=stable http://pubsvn.ez.no/nextgen/ 
  nextgen

That should create a nextgen git repository with a master branch  
following SVN stable, and automatically grabbing anything under stable  
or releases as a new branch.  (I actually marked releases as a tag but  
I think git-svn treats them as branches, since they can change on the  
SVN side.)

~~ Brian
