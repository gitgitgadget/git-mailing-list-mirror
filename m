From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] stgit branch renaming into new dir crashes
Date: Tue, 13 Jun 2006 23:40:53 +0200
Message-ID: <20060613214053.GD7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 13 23:40:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqGcw-00051X-Ld
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 23:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWFMVkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFMVkn
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 17:40:43 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:38116 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932335AbWFMVkm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 17:40:42 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id F3FA0263D0;
	Tue, 13 Jun 2006 23:40:39 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FqGd4-0005ma-2i; Tue, 13 Jun 2006 23:40:54 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21814>

When trying to rename a branch to a name including a slash, there is
no explicit creation of leading dirs, and stgit crashes:

$ stg branch -r multitag dev/multitag
Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in ?
    main()
  File "/usr/lib/python2.3/site-packages/stgit/main.py", line 187, in main
    command.func(parser, options, args)
  File "/usr/lib/python2.3/site-packages/stgit/commands/branch.py", line 214, in func
    stack.Series(args[0]).rename(args[1])
  File "/usr/lib/python2.3/site-packages/stgit/stack.py", line 497, in rename
    os.rename(self.__series_dir, to_stack.__series_dir)
OSError: [Errno 2] No such file or directory


-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
