From: "Wink Saville" <wink@saville.com>
Subject: Re: Best practices for developing multiple related branches simultaneously
Date: Sun, 8 Apr 2007 12:36:46 -0700
Message-ID: <d4cf37a60704081236yb2b83d6wfe02a10962967ddb@mail.gmail.com>
References: <d4cf37a60704071957r7bb907eg84180097a4594f43@mail.gmail.com>
	 <7v7isnbh40.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 21:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HadBz-0005Xf-D0
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 21:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXDHTgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 15:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbXDHTgs
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 15:36:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:58842 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXDHTgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 15:36:47 -0400
Received: by nz-out-0506.google.com with SMTP id s1so891863nze
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 12:36:47 -0700 (PDT)
Received: by 10.114.211.1 with SMTP id j1mr2021093wag.1176061007002;
        Sun, 08 Apr 2007 12:36:47 -0700 (PDT)
Received: by 10.115.92.20 with HTTP; Sun, 8 Apr 2007 12:36:46 -0700 (PDT)
In-Reply-To: <7v7isnbh40.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44007>

> > Also, I'd like to checkout and work on all three branches
> > simultaneously.
>
> Julian Phillips's git-new-workdir script in contrib/workdir may
> suit your needs.
>
> Having said all that, the first advice is to avoid second
> generation topic that depends on another topic when possible.
> Is your branchB absolutely need to depend on branchA?
>

By design they depend upon each other, the other option would
be to work on  them in one branch but submit them separately.
But I don't know of a good way to segregate them for submission
as there are modifications to the same files.

Actually, even now using separate topics, its not as easy as I'd
like if I want to make a "perfect" patch. If I want to make an "imperfect"
patch of a particular topic its very easy, for example:

*) git-checkout branchC
*) git-format-patch -s -n -o patches/branchC branchB

But this will have all my random commits in the patch, to make a
"perfect" patch for branchC I make another branch, branchC1, off
of branchB and use git-am to apply the imperfect patch to branchC1.
and then do another series of commits on branchC1 to make a
perfect patch by choosing the order I commit the files in the final series
of commits.

As you can see my approach to the perfect patch isn't very easy.
I was looking at stgit as a possible solution, but haven't tried it yet
and I've never used quilt so I'm not sure its right either.

Anyway, thanks for the help and if you've got any other suggestions
they would be much appreciated.

Regards,

Wink
