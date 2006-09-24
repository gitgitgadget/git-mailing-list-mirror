From: Peter Dyballa <Peter_Dyballa@Web.DE>
Subject: Git - Fast Version Control System
Date: Mon, 25 Sep 2006 01:19:17 +0200
Message-ID: <227D2788-334A-40E8-B840-317C04ED46FA@Web.DE>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 25 01:19:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRdFs-0001Qq-SP
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWIXXTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 19:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWIXXTU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:19:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40591 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1751212AbWIXXTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:19:19 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id C2F10228368A
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:19:18 +0200 (CEST)
Received: from [84.245.174.205] (helo=[192.168.1.2])
	by smtp07.web.de with asmtp (TLSv1:RC4-SHA:128)
	(WEB.DE 4.107 #114)
	id 1GRdFm-0005i6-00
	for git@vger.kernel.org; Mon, 25 Sep 2006 01:19:18 +0200
X-Image-Url: http://homepage.mac.com/sparifankal/.cv/thumbs/me.thumbnail
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
X-Sender: Peter_Dyballa@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27716>

Hello!

In git 1.4.2.1 there seems to be a problem with 'make doc' =96 at least=
 =20
on Mac OS X 10.4.7:

(from the *compilation* buffer)

	asciidoc -b xhtml11 git-tools.txt
	cat glossary.txt | \
	perl sort_glossary.pl | \
	asciidoc -b xhtml11 - > glossary.html
	rm -f howto/revert-branch-rebase.html+ howto/revert-branch-rebase.html
	sed -e '1,/^$/d' howto/revert-branch-rebase.txt asciidoc.conf | =20
asciidoc -b xhtml11 - >howto/revert-branch-rebase.html+
	WARNING: <stdin>: line 200: missing [paradef-default] attributes-=20
style entry
	WARNING: <stdin>: line 224: missing [paradef-default] gitlink-=20
inlinemacro-style entry
	mv howto/revert-branch-rebase.html+ howto/revert-branch-rebase.html
	asciidoc -b docbook -d manpage -f asciidoc.conf git-add.txt
	xmlto -m callouts.xsl man git-add.xml

and here an excerpt from a dired buffer:

	  /Users/pete/Quellen/git-1.4.2.1/Documentation:
	  insgesamt 2492
	  drwxr-xr-x 284 pete pete  9656 2006-09-24 23:52 .
	  -rw-r--r--   1 pete pete  4146 2006-09-24 23:52 git-add.xml
	  drwxr-xr-x  13 pete pete   442 2006-09-24 23:52 howto
	  -rw-r--r--   1 pete pete 28486 2006-09-24 23:52 glossary.html

Since more than one hour xmlto (0.0.18) is running and consuming up =20
to 100 % of CPU power ...

pstree -p 27354
-+=3D 00001 root /sbin/launchd -v
\-+=3D 00131 windowse /System/Library/Frameworks/=20
ApplicationServices.framework/F
    \-+- 11292 pete /Applications/Utilities/X11.app/Contents/MacOS/=20
X11 -psn_0_61
      \-+- 11294 pete sh /Users/pete/.xinitrc
        \-+- 11308 pete /usr/local/bin/emacs-23.0.0 -geometry 100x57=20
+666+44
          \-+=3D 27122 pete -bin/tcsh -c time nice +11 make -k doc
            \-+- 27128 pete make -k doc
              \-+- 27157 pete make -C Documentation all
                \--- 27354 pete /bin/bash /sw/bin/xmlto -m =20
callouts.xsl man git-

--
Greetings

   Pete

Sometimes I think the surest sign that intelligent life exists =20
elsewhere in the universe is that none of it has tried to contact us.
                     -- Bill Watterson, in his comic strip Calvin and =20
Hobbes
