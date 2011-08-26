From: Shaun Ruffell <sruffell@digium.com>
Subject: Re: Files that cannot be added to the index
Date: Fri, 26 Aug 2011 16:12:33 -0500
Message-ID: <20110826211233.GB3093@digium.com>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 23:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx3hi-0004JY-3e
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 23:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab1HZVMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 17:12:36 -0400
Received: from mail.digium.com ([216.207.245.2]:45437 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab1HZVMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 17:12:36 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <sruffell@digium.com>)
	id 1Qx3hb-0004LF-8b
	for git@vger.kernel.org; Fri, 26 Aug 2011 16:12:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 42023D82AC
	for <git@vger.kernel.org>; Fri, 26 Aug 2011 16:12:35 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYdPzh+yqcnW; Fri, 26 Aug 2011 16:12:34 -0500 (CDT)
Received: from digium.com (sruffell.digium.internal [10.19.134.249])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id B6365D8024;
	Fri, 26 Aug 2011 16:12:34 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20110826205919.GB8107@sooty-2.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180200>

On Fri, Aug 26, 2011 at 10:59:19PM +0200, seanh wrote:
> I'm using git version 1.7.4.4 on OSX Lion, from macports. (I was
> having the problem on Snow Leopard too.)

Not sure if this is your problem exactly but awhile back I ran into
something similar to what you describe and tracked it down to the
fact that my filesystem was case insensitive. i.e.

  $ git clone git://github.com/sruffell/dahdi-linux
  Cloning into dahdi-linux...
  done.

  $ cd dahdi-linux/
  $ ls
  LICENSE      Makefile     UPGRADE.txt  drivers
  LICENSE.LGPL README       build_tools  include

  $ git ls-files -m
  $ rm Makefile 
  $ touch makefile
  $ git add makefile 
  $ git ls-files -m
  Makefile

  $ git commit
  # On branch master
  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   Makefile
  #
  no changes added to commit (use "git add" and/or "git commit -a")

  $ git add makefile 
  $ git commit
  # On branch master
  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   Makefile
  #
  no changes added to commit (use "git add" and/or "git commit -a")
