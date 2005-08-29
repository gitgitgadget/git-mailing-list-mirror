From: Dave Hansen <haveblue@us.ibm.com>
Subject: compile problem with gcc 2.95
Date: Mon, 29 Aug 2005 11:28:36 -0700
Message-ID: <1125340116.26108.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 29 20:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9oOT-0006bJ-Bk
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVH2S3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVH2S3x
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:29:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59313 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751283AbVH2S3w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:29:52 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7TITp0G017894
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 14:29:51 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7TITp8q225052
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 14:29:51 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7TISg3I031306
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 14:28:42 -0400
Received: from [9.12.233.254] ([9.12.233.254])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7TISfTa031247
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 14:28:42 -0400
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7914>

I know it's an ancient compiler, but last time I checked it is still
faster at runtime than the 3.x versions.  If it's not going to be
supported, it would probably be nice to at least detect that in the
build system.  I've confirmed that it works just fine with gcc 3.3.

dave@spirit:~/bin/git$ make
gcc -o rev-cache.o -c -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'
rev-cache.c
In file included from rev-cache.c:2:
cache.h:107: field `name' has incomplete type
cache.h:290: field `base' has incomplete type
cache.h:303: field `pack_name' has incomplete type
cache.h:318: field `name' has incomplete type
make: *** [rev-cache.o] Error 1
dave@spirit:~/bin/git$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

> struct cache_entry {
...
>         char name[]; <--- cache.h:107
> };


-- Dave
