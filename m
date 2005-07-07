From: Tony Luck <tony.luck@gmail.com>
Subject: Where'd my GIT tree go?
Date: Wed, 6 Jul 2005 20:23:11 -0700
Message-ID: <12c511ca0507062023291a098e@mail.gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jul 07 05:28:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqN3Y-0001ot-3N
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 05:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVGGD1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 23:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVGGDYn
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 23:24:43 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:26986 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262205AbVGGDXM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 23:23:12 -0400
Received: by zproxy.gmail.com with SMTP id l1so45132nzf
        for <git@vger.kernel.org>; Wed, 06 Jul 2005 20:23:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Weadbmnf6CttzGa+F5Rf4OY6EcQIJb08Dx3JfSbW3iAerXFfQxuWwKi3+xjKudwj0zTKc5cB16W7eINKhlez0pXbR+6FHtHAFRivg1WakXnNr/WNyQPxpyBh6GLQKvNlCvItVMVDvEjDBeFWwsmIy+5Z5ZhQWG6B2F20JIHoI7E=
Received: by 10.36.222.60 with SMTP id u60mr155217nzg;
        Wed, 06 Jul 2005 20:23:11 -0700 (PDT)
Received: by 10.36.59.4 with HTTP; Wed, 6 Jul 2005 20:23:11 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

http://www.kernel.org/git has stopped showing my linux-2.6 tree (the
"to Linus" one, my "test-2.6" tree is still there).

This is probably my fault ... but I'm not sure exactly why.

Here's what I did.  Last Thursday I applied a set of patches ... and my "apply"
script choked on one of them.  Some casual inspection convinced me that the
changes had been applied, and I pushed the tree up to kernel.org.

But I was wrong, the 2nd out od a series of six was all messed up.  And I'd
applied a couple more patches on top of that.  Since none of this had been
pulled by Linus, I thought I'd clean it up and apologise to anyone who had
pulled from my tree.

So I backed HEAD up to the last good commit.  Re-applied the changes with
a fixed version of the script, and then expected to find some detritus from
the first application in .git/objects.  But "git-fsck-cache --unreachable ..."
only complained about the 2.6.11 tag/tree.  Odd.

Then I pushed up to master.kernel.org ... and an hour later when the mirrors
did their thing, git-web stopped showing my tree.

HEAD is still a symlink to refs/heads/master.  And that has the SHA1 of my
most recent commit ... which is present in .git/objects.

So what's wrong???

-Tony
