From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 21:57:23 -0400
Message-ID: <5D00E27D-5DB4-4F66-A4BB-752300F9D05E@silverinsanity.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org> <20070411235447.GO21701@admingilde.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 03:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HboZ2-0004EN-Vj
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 03:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbXDLB5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 21:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161461AbXDLB5a
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 21:57:30 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41704 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161451AbXDLB53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 21:57:29 -0400
Received: from [192.168.2.5] (cpe-66-67-139-52.rochester.res.rr.com [66.67.139.52])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 5DECF1FFC003;
	Thu, 12 Apr 2007 01:57:28 +0000 (UTC)
In-Reply-To: <20070411235447.GO21701@admingilde.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44306>


On Apr 11, 2007, at 7:54 PM, Martin Waitz wrote:

> Before submodules:
> tree <-> index <-> working file
>
> submodules always using HEAD:
> tree <-> index <-> submodule HEAD <-> submodule working dir
>
> submodules using some dedicated branch:
> tree <-> index <-> subm. "from-supermodule" <-> subm. HEAD <->  
> subm. wd

Why can't can't we extend checkout with an option to look for an  
enclosing git project, find the gitlink in the index, and check out  
that commit?  That allows you to return to the original state without  
needing to bother with new special branches.

And instead of recording the path in a .gitmodules file, why not a  
list of git directories we search for the commit?  Allows moving of  
subprojects without suddenly breaking configuration files.  When we  
find the appropriate git dir, we can use a .gitlink file or symlinks  
to attach the directory to it's repository.

I dislike moving git in the direction of enforcing more policy  
instead of less, and of making it less capable of handling content  
movement instead of more.

~~ Brian
