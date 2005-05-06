From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [ISSUE RESOLVED] Problems with threeway diff, checkout-cache and permissions of two blobs
Date: Fri, 6 May 2005 13:17:46 +0200
Message-ID: <20050506111746.GE11506@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 13:11:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU0jj-0003EM-L9
	for gcvg-git@gmane.org; Fri, 06 May 2005 13:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEFLRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 07:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEFLRy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 07:17:54 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42446 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261218AbVEFLRr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 07:17:47 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j46BHkS8028722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 11:17:46 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j46BHkkP028721
	for git@vger.kernel.org; Fri, 6 May 2005 13:17:46 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

	[ *** ISSUE RESOLVED: Doesn't happen with GIT HEAD *** ]

The following issue is resolved. Just if someone hits the same problem:

I did a merge with two conflicts, which can AFAIK automatically be
resolved. However if I call 'git-checkout-cache -f -a' it fails on me:

	(faui01) [~/work/mutt/git/mutt-tg] git pull ../mutt-cstatus
	head => 8aa9f8e95f17213a583d28bbc80d15bba01a375d
	remote => b54cf35a50e50a8e1bf09f79b714d0f18c8f3c92
	base => e8f4a291a81f0a8fb24555f0e36e4b75e2d3f4c8
	curs_main.c: unmerged (ff55f1869b953acb2ec816569470e4adb3421c1d)
	curs_main.c: unmerged (b5c5275ead8882ed37205b92b2bc88f7799c2ac8)
	curs_main.c: unmerged (335c5c978ac580b95168916deb297fb254592079)
	protos.h: unmerged (3cda50538b733826e37cd35734e68755173f080c)
	protos.h: unmerged (011d63023a7f1d718f90d87a4933c6f50d0fb1de)
	protos.h: unmerged (66324e580002ebd6c9d974c4873cc215b6478029)
	fatal: write-tree: not able to write tree
	Threewaydiff invloved.
	<<
This is the error I get from git-checkout-cache the first time:

	fatal: internal error: ce_mode is 644
	git-checkout-cache failed: child exit value: 1 at /home/cip/adm/sithglan/work/git/yagf/git line 942.
	(faui01) [~/work/mutt/git/mutt-tg] git-ls-tree HEAD | grep ^0 | grep blob
	000644 blob d43160b921f037dc45dba6cf80dd22520ac17c7e curs_main.c
	000644 blob 210fe03ed3004c45b9548c7f7d1e011bb216c468 protos.h
Note    ^ while every else this is '1' for files.

	(faui01) [~/work/mutt/git/mutt-tg] rm -rf *
	(faui01) [~/work/mutt/git/mutt-tg] git-read-tree HEAD
	(faui01) [~/work/mutt/git/mutt-tg] git-checkout-cache -f -a
	error: checkout-cache: unknown file mode for curs_main.c

	Thomas
