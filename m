From: David Brown <git@davidb.org>
Subject: Re: git-svn: .git/svn disk usage
Date: Sun, 2 Dec 2007 22:46:03 -0800
Message-ID: <20071203064603.GA18583@old.davidb.org>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com> <4753A43F.9060303@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Ollie Wild <aaw@google.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz55J-0004Qz-2M
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbXLCGqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXLCGqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:46:09 -0500
Received: from mail.davidb.org ([66.93.32.219]:58951 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbXLCGqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:46:08 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1Iz547-0004tL-Ha; Sun, 02 Dec 2007 22:46:03 -0800
Mail-Followup-To: Pascal Obry <pascal@obry.net>,
	Ollie Wild <aaw@google.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4753A43F.9060303@obry.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66877>

On Mon, Dec 03, 2007 at 07:37:51AM +0100, Pascal Obry wrote:
>Ollie,
>
>> I'm curious if other developers have run into this issue.  If so, are
>> there any proposals / plans for improving the storage of git-svn
>> metadata?
>
>Did you run "git gc" after importing code form the subversion
>repository? On my side I found that it has reduced drastically the size
>of the local Git repository.

I think the original poster is probably finding the space in the .git/svn
directory.  'git-svn' keeps an index file for every branch in SVN.

I suspect it does this for speed, at least on a large import, since the SVN
commits will come across numerically, affecting the branches out of order.

However, the index could fairly easily be extracted from git (since that is
what it normally does).  In this case, where all of the indexes take
significant space if this is worth it.

Ollie, if you look in these svn branch directories, is most of the space
taken up with files called 'index'?

Browsing through the few svn clones that I have, the space seems to be
roughly split between 'index' files and 'unhandled.log' files.

Dave
