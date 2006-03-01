From: Greg KH <greg@kroah.com>
Subject: git doesn't like big files when pushing
Date: Wed, 1 Mar 2006 14:08:02 -0800
Message-ID: <20060301220802.GA18250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 23:08:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEZUK-00076R-Bs
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 23:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWCAWH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCAWH7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 17:07:59 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:13514
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751309AbWCAWH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 17:07:58 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FEZU5-0004uH-Tj
	for git@vger.kernel.org; Wed, 01 Mar 2006 14:07:49 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17018>

I have a mail archive stored with git, in mbox form, and I made some
changes to a few of the files and checked them back in.

That worked fine, but when I went to push the stuff to my server, I got
the following errors:

$ git push origin
updating 'refs/heads/master'
  from 490badd9bec9ada3a21be275c97fb2a3a390f49e
  to   16be8985abc8a9c89ad2cc8f46a0d8e9786e832f
Generating pack...
Done counting 8 objects.
Deltifying 8 objects.
fatal: Out of memory, malloc failed
fatal: early EOF
unpack unpacker exited with error code
ng refs/heads/master n/a (unpacker error)


And here are the file sizes of the files that were changed:
$ ls -lh linux-usb-devel.save.200*
-rw-r--r-- 1 greg users 41M Jan  6 14:30 linux-usb-devel.save.2001
-rw-r--r-- 1 greg users 80M Jan  6 14:30 linux-usb-devel.save.2002
-rw-r--r-- 1 greg users 74M Jan  6 14:30 linux-usb-devel.save.2003
-rw-r--r-- 1 greg users 99M Jan  6 14:30 linux-usb-devel.save.2004
-rw-r--r-- 1 greg users 89M Jan  6 14:30 linux-usb-devel.save.2005

So, am I just foolish for trying to use git for this?  Should I just go
back to using rsync to back stuff like this up with?

thanks,

greg k-h
