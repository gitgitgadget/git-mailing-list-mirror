From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 11:07:08 -0500
Message-ID: <20100518160708.GB20842@unpythonic.net>
References: <20100517160208.GA20842@unpythonic.net> <AANLkTikK9LAd_pwTwB56Vpq19i00X5apy6qT-ZOpnLEp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 18:07:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEPK8-0003nN-G6
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 18:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0ERQHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 12:07:11 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:50054 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753209Ab0ERQHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 12:07:10 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 8883911469D; Tue, 18 May 2010 11:07:08 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikK9LAd_pwTwB56Vpq19i00X5apy6qT-ZOpnLEp@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147286>

Is it possible that you don't have is_IS language support?  On Ubuntu
this comes from a package like language-pack-is-base.

I tried your po entries in a file named po/is.po, and it didn't work.
When I installed language-pack-is-base, it did.

$ unset LANGUAGE LC_MESSAGES; export LANG=is_IS.UTF-8
$ /usr/local/jepler/git/bin/git status | head -1
# A greininni master

Comparing the bad strace with the good, and excluding ENOENT opens, it's
the presence of the is_IS language pack that is the first difference.
@@ -1,4 +1,8 @@
 open("/usr/share/locale/locale.alias", O_RDONLY) = 3
+open("/usr/lib/locale/is_IS.utf8/LC_MESSAGES", O_RDONLY) = 3
+open("/usr/lib/locale/is_IS.utf8/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
+open("/usr/lib/locale/is_IS.utf8/LC_CTYPE", O_RDONLY) = 3
 open("share/locale/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 14
 open("share/locale/is/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 15
 open("share/locale/is/LC_MESSAGES/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 16
+open("/usr/local/jepler/git/share/locale/is/LC_MESSAGES/git.mo", O_RDONLY) = 12

Jeff
