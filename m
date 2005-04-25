From: tony.luck@intel.com
Subject: mod-times (was: keyword expansion)
Date: Mon, 25 Apr 2005 10:56:28 -0700
Message-ID: <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
References: <20050425002343.GF10806@cip.informatik.uni-erlangen.de>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 19:52:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7k4-00033t-Ks
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVDYR4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDYR4e
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:56:34 -0400
Received: from fmr22.intel.com ([143.183.121.14]:38846 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262648AbVDYR4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:56:31 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3PHuSof005945;
	Mon, 25 Apr 2005 17:56:28 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3PHvs6Z018442;
	Mon, 25 Apr 2005 17:57:54 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3PHuSh01362;
	Mon, 25 Apr 2005 10:56:28 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050425002343.GF10806@cip.informatik.uni-erlangen.de>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I am aware that keyword expansion is at the moment at the very bottom of
> the todo list. However I need it. Has someone something ready to use? I
> am looking for the following informations:
> 
> 	- Time stamp of the last modification of a file

One way to do this would be to rip on some of the core fundamentals of GIT
and store the time that an object was created inside the object. E.g.

   blob size secs-since-1970 ...

Then "read-tree" could fill this into the cache, and checkout-cache could
set the mod-time on the file when it creates it, which would mean that you
could see the timestamp for a file simply by using "ls -l file".

I think we'd need some other justifications before this would stand any
hope of getting in though, since it makes such a huge incompatible change
to the basic GIT format :-)  Maybe queue the idea for GIT2.0?

-Tony
