From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-init bug
Date: Sun, 5 Jun 2005 09:27:39 -0700
Message-ID: <20050605162739.GB15291@tumblerings.org>
References: <20050605153053.GA6890@tumblerings.org> <42A323F4.2010109@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:24:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DexvD-0003mF-5N
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVFEQ1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFEQ1w
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:27:52 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:36588 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261591AbVFEQ1r
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 12:27:47 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DexyN-0004tb-5I; Sun, 05 Jun 2005 09:27:39 -0700
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <42A323F4.2010109@gorzow.mm.pl>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2005 at 06:10:28PM +0200, Radoslaw Szkodzinski wrote:
> Zack Brown wrote:
> 
> >Hi,
> >
> >I've been tracking Cogito. This problem occurred with Cogito version
> >1e2673d606dd39dc44b4eed2204ba349a448bc4d
> >
> >I have a directory tree with several layers of subdirectories and about 1700
> >files. I tried to convert it to a git repository with 'cg-init'.
> >  
> >
> I think an ls -l of the repo would be useful... if it's not that big.

It's over 2000 lines, I'm not sure if that's considered big. But it's just
regular files and directories with regular-length names. Here's a sample:

-----------------------------------------------------------------------------
...
./kde/trans/german:
total 76
-rw-rw-r--  1 zbrown zbrown   230 Jan 19  2003 Makefile
-rw-rw-r--  1 zbrown zbrown    20 Jan 19  2003 Makefile.encoding
-rw-rw-r--  1 zbrown zbrown 15712 Jan 19  2003 kde20020522_37.xml
-rw-rw-r--  1 zbrown zbrown 15669 Jan 19  2003 kde20020522_37.xml.old
-rw-rw-r--  1 zbrown zbrown 12941 Jan 19  2003 kde20020605_38.xml
-rw-rw-r--  1 zbrown zbrown   464 Nov 16  2003 latest.txt
-rw-rw-r--  1 zbrown zbrown    32 Jan 19  2003 latest.xml
drwxrwxr-x  2 zbrown zbrown  4096 Nov 16  2003 quotes/
drwxrwxr-x  2 zbrown zbrown  4096 Nov 16  2003 raw/
drwxrwxr-x  2 zbrown zbrown  4096 Nov 16  2003 topics/

./kde/trans/german/quotes:
total 0

./kde/trans/german/raw:
total 0

./kde/trans/german/topics:
total 0

./kde/trans/spanish:
total 140
-rw-rw-r--  1 zbrown zbrown   230 Jan 19  2003 Makefile
-rw-rw-r--  1 zbrown zbrown    20 Jan 19  2003 Makefile.encoding
-rw-rw-r--  1 zbrown zbrown   198 Jan 19  2003 index.xml.bak
-rw-rw-r--  1 zbrown zbrown 24211 Jan 19  2003 kde20020118_31.xml
-rw-rw-r--  1 zbrown zbrown 12061 Jan 19  2003 kde20020215_32.xml
-rw-rw-r--  1 zbrown zbrown 12748 Jan 19  2003 kde20020222_33.xml
-rw-rw-r--  1 zbrown zbrown 12468 Jan 19  2003 kde20020605_38.xml
-rw-rw-r--  1 zbrown zbrown 18517 Jan 19  2003 kde20020619_39.xml
-rw-rw-r--  1 zbrown zbrown 17001 Jan 19  2003 kde20020710_40.xml
-rw-rw-r--  1 zbrown zbrown   464 Nov 16  2003 latest.txt
-rw-rw-r--  1 zbrown zbrown    32 Jan 19  2003 latest.xml
drwxrwxr-x  2 zbrown zbrown  4096 Nov 16  2003 quotes/
drwxrwxr-x  2 zbrown zbrown  4096 Nov 16  2003 raw/
drwxrwxr-x  2 zbrown zbrown  4096 Nov 16  2003 topics/

./kde/trans/spanish/quotes:
total 0
...
-----------------------------------------------------------------------------

> If it is, you may have hit the limitation of the length of command line.
> If it's so, repeat the commands.

I did that when I first saw the problem, and although it did seem to add a few
dozen files at a time, eventually it refused to add any more files, even though
cg-status reported many files still as '?'.

> 
> However, if I'd want to add everything to the repo, I'd do:
> cg-status | sed "s/? //" | xargs cg-add

But shouldn't cg-init take care of that for me automatically when I create the
repo?

Be well,
Zack

> 
> AstralStorm

-- 
Zack Brown
