From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: StGIT-0.11: Python exception when removing branch
Date: Mon, 1 Jan 2007 15:49:11 +0300
Message-ID: <200701011549.16942.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 13:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Mbt-0000in-9N
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 13:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbXAAMtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 07:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbXAAMte
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 07:49:34 -0500
Received: from mx28.mail.ru ([194.67.23.67]:2743 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbXAAMte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 07:49:34 -0500
Received: from mx1.mail.ru (mx1-2.mail.ru [194.67.23.121])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 35D606C62C2
	for <git@vger.kernel.org>; Mon,  1 Jan 2007 15:49:32 +0300 (MSK)
Received: from [85.140.148.153] (port=41632 helo=cooker.local)
	by mx1.mail.ru with asmtp 
	id 1H1MbP-000Hhf-00; Mon, 01 Jan 2007 15:49:20 +0300
To: catalin.marinas@gmail.com
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35736>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Every time I try to remove a branch I get:

{pts/0}% stg branch --delete stable
Deleting branch "stable"...
Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in <module>
    main()
  File "/usr/lib/python2.5/site-packages/stgit/main.py", line 261, in main
    command.func(parser, options, args)
  File "/usr/lib/python2.5/site-packages/stgit/commands/branch.py", line 167, 
in func
    __delete_branch(args[0], options.force)
  File "/usr/lib/python2.5/site-packages/stgit/commands/branch.py", line 107, 
in __delete_branch
    doomed.delete(force)
  File "/usr/lib/python2.5/site-packages/stgit/stack.py", line 583, in delete
    if not os.listdir(self.__series_dir):
OSError: [Errno 2] No such file or directory: '.git/patches/stable'

Well, it is correct, stable has never had any patches, but why stg is so upset 
about it? :)

The state after this command is

{pts/2}% stg branch -l
Available branches:
> s     cooker  |
  s     origin  |
        stable  |

It did not happen before; I am not sure whether it was introdied by StGIT or 
Pythn update.

Regards and happy new year

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFmQNMR6LMutpd94wRAuWCAKDQmc5xTW/0okN+MMx5Y8GUBSiqQgCggpUY
fWPjyHx/usyneWVaRl61lZM=
=vnEW
-----END PGP SIGNATURE-----
