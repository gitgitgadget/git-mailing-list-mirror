From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: hot to fix git svn import or just discard 'branches' folder
Date: Wed, 4 Feb 2009 13:39:59 -0500
Message-ID: <D92EB2AE-392D-4F05-8DF3-999BE78C80FF@silverinsanity.com>
References: <7E976223-6794-4E87-94A5-DEA224759700@decodeideas.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marius Seritan <mseritan@decodeideas.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmhj-00064g-4u
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759399AbZBDSkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758902AbZBDSkQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:40:16 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41070 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759393AbZBDSkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:40:14 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id BAA571FFC27F; Wed,  4 Feb 2009 18:40:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A6C441FFC271;
	Wed,  4 Feb 2009 18:39:55 +0000 (UTC)
In-Reply-To: <7E976223-6794-4E87-94A5-DEA224759700@decodeideas.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108408>


On Feb 4, 2009, at 12:03 PM, Marius Seritan wrote:

> I imported over night an svn repository with the command:
>
> git svn clone --prefix svn/ -r 860  http://svn.some.com/svn/ 
> someproject
>
> The svn repository uses the usual trunk, branches, tag so I  
> (wrongly?) assumed I do not need to pass any command switches  
> regarding the structure of the repo.

"git svn clone URL" attempts to act like "svn co URL", but with  
history.  If you only want to download the trunk, then you should add  
"/trunk" to the end of the URL.  If you want to capture all the  
branches, tags, etc you should use "--stdlayout" (also spelled "-s").

> I obviously did something wrong because now I have a git repository  
> with just one remote branch and it contains the folders trunk,  
> branches and tag. I do not want to reimport because it is taking  
> lots of time and bandwidth.

I believe fixing this without reimporting requires using "git filter- 
branch".  I'm unfamiliar with it, so I can't help you with that part.

However, I'm curious as to why this took a lot of time because the "-r  
860" on the command line should tell git-svn to only download a single  
revision.  Is it a particularly repository?

~~ Brian
