From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: git export to svn
Date: Sat, 25 Oct 2008 13:12:44 -0700
Message-ID: <1224965564.2874.49.camel@localhost.localdomain>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com>
	 <1224960205.2874.11.camel@localhost.localdomain>
	 <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Warren Harris <warrensomebody@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 22:14:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtpWJ-0007jp-Ua
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 22:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYJYUMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 16:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbYJYUMp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 16:12:45 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:36462 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYJYUMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 16:12:44 -0400
Received: from [192.168.144.248] ([216.239.45.19])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m9PKCgnM006500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Oct 2008 13:12:42 -0700
In-Reply-To: <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/8492/Sat Oct 25 09:02:04 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sat, 25 Oct 2008 13:12:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99124>

Even with init - your going to need to do a fetch so that you have a
copy of the svn in your tree - if the git tree you've already got has
the svn references (take a look at git-log if it seems to have an svn
line in the log then at some point someone pulled in the svn tree into
git) if not your going to effectively be pulling the entire svn tree
into your git tree.

The only other real way to get your changes / patches into svn is to
dump them out as patches and them individually apply / commit them to
your svn tree.

- John 'Warthog9' Hawley


On Sat, 2008-10-25 at 12:11 -0700, Warren Harris wrote:
> John,
> 
> Thanks for your quick reply. I tried that, but got the following error:
> 
> 
> $ git clone ../test2/
> Initialized empty Git repository in /Users/warren/projects/tmp/test2- 
> git-clone/test2/.git/
> # ...svn test2 dir already created with subdirs trunk, tags and  
> branches...
> $ git svn init https://svn/svn/SANDBOX/warren/test2 -T trunk -t tags - 
> b branches
> Using higher level of URL: https://svn/svn/SANDBOX/warren/test2 => https://svn/svn
> $ git svn dcommit
> Can't call method "full_url" on an undefined value at /opt/local/ 
> libexec/git-core/git-svn line 425.
> 
> I then tried the hints from here: http://www.basementcoders.com/2008/9/30/git-svn-gotcha 
> , but still no luck:
> 
> $ git merge --no-ff master
> Already up-to-date.
> $ git svn dcommit
> Can't call method "full_url" on an undefined value at /opt/local/ 
> libexec/git-core/git-svn line 425.
> 
> 
> Warren
> 
> 
> On Oct 25, 2008, at 11:43 AM, J.H. wrote:
> 
> > The basic way you would want to do it, it attach your git tree to SVN
> > and then git svn dcommit - which will replay the uncommitted changes
> > back into SVN - git svn init will do the attachment - assuming that  
> > your
> > git / svn repositories are at least based from the same place.
> >
> > - John 'Warthog9' Hawley
> >
> > On Sat, 2008-10-25 at 11:40 -0700, Warren Harris wrote:
> >> Is there a way to export a git repository along with its history to
> >> svn? (git svn init seems to want to go in the other direction.) I  
> >> know
> >> this is in some sense "going backwards" but I need to commit my work
> >> to a client. Thanks,
> >>
> >> Warren
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe git" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
