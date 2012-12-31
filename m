From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: Re: [RFC/PATCH] gitk: Visualize a merge commit with a right-click in
 gitk
Date: Mon, 31 Dec 2012 13:46:11 -0500
Message-ID: <20121231184611.GB8665@gmail.com>
References: <1356826576-24334-1-git-send-email-jason.k.holden.swdev@gmail.com>
 <20121231042736.GA14921@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 19:46:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpkNi-00019y-1f
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 19:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab2LaSqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 13:46:16 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:44566 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab2LaSqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 13:46:15 -0500
Received: by mail-vc0-f181.google.com with SMTP id gb30so12806010vcb.26
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=I5wBYgfIwMkZVX/pQZgRk+m5ySEHjUsNy5huGZn6qN8=;
        b=kgqZH+Dp/NvtOQn98npfL4bL2A+MKPBIZ9Dq7m3Ocg5nn7lNwx0KhMnLw+1cFK0h3E
         9fXuN9ZWV+mTV4dK+IobuSXDOdLspJN0fLK85bguGEcC+kI6ueXbc5/4kt0kBa11BfBX
         r3QGM4Noy94L5rNIc89kwa0u+gozLxSxztcmERTQ9pslMulZl9oHK09CrAufRsWsKMZL
         dbvi839hJvpGYZkeqWD6t3IWTDQmJU6Q1RjxkMDPq1zFt6jEdoJo7cbenm3rqAy7BJeT
         L7uTGI0OR+yw0Y28s2btyfOQzCUti9NzADG94oCtXSKKweiUEPneMe2CxkSoEM4FaQtl
         LnvQ==
X-Received: by 10.52.17.177 with SMTP id p17mr56534017vdd.87.1356979574332;
        Mon, 31 Dec 2012 10:46:14 -0800 (PST)
Received: from gmail.com (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id cd16sm14624075vdb.0.2012.12.31.10.46.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 10:46:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121231042736.GA14921@iris.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212360>

On Mon, Dec 31, 2012 at 03:27:36PM +1100, Paul Mackerras wrote:
> 
> Thanks for the patch.  I have a couple of comments about it.  First,
> the exec command waits for the process to complete, which means that
> the initial gitk GUI will be unresponsive until the user quits the
> gitk window showing the merge, which could be quite confusing for the
> user.

Good catch.  Adding an ampersand on to the exec looks like it fixes
the unresponsiveness.  Any issues with that approach?

> 
> Secondly, gitk already has support for showing multiple views of a
> repository, that is, different subsets of the commits.  Wouldn't it be
> much better to have your new menu item simply create a new view
> showing the merge, rather than creating a whole new window?

I've found when using this feature that I tend to use it in a stack-like
fashion.  I tend to  want to "push" a merge-view onto the stack, investigate
that view of history for a bit, then "pop" back to my old view.  But 
you're correct that you can end up with a lot of windows pretty quick.  
Any support for stack-like views in the current gui that I missed?

I've got another feature brewing, similiar to the merge-view, where you can 
right-click on a file and a new window pops up with the history of just that 
file.  I tend to use that feature in a stack-like fashion as well.

Maybe the seperate-window/new-view-in-same-window should be a new user
preference?
