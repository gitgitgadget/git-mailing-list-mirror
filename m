From: Alexander Litvinov <lan@ac-sw.com>
Subject: How to clone faster via ssh ?
Date: Tue, 25 Oct 2005 14:49:15 +0700
Organization: AcademSoft Ltd.
Message-ID: <200510251449.15302.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 09:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUJYm-0006Ul-Kv
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 09:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVJYHt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 03:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVJYHt0
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 03:49:26 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:48005 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932071AbVJYHtZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 03:49:25 -0400
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 61ECEBD35
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 14:49:18 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 1D95C8C3AB; Tue, 25 Oct 2005 14:49:17 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 1D6898C3A2
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 14:49:16 +0700 (NOVST)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, hits=-4.7 required=5.0 tests=AWL,BAYES_00,
	NORMAL_HTTP_TO_IP autolearn=no version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10571>

Hello,

I have cvs project imported into git. When unpacked it contains about 205000 
objects. I have made one pack and daily rerun cvsimport to get new changes.

When I do cloning via http it takes less than 3 minutes:
time git-clone -n http://127.0.0.1:8080/git/r/.git r2
real    2m31.062s
user    1m33.562s
sys     0m5.462s

When I do cloning via ssh it takes more than 10 minutes and horde of unpacked 
objects:
Packing 204607 objects
Unpacking 204607 objects
 100% (204607/204607) done

real    13m41.510s
user    1m52.655s
sys     1m5.057s

There are no packs in cloned repo:
ls -la r3/.git/objects/pack/
total 6
drwxr-xr-x    2 lan users   48 Oct 25 13:51 .
drwxr-xr-x  260 lan users 6240 Oct 25 14:05 ..
lan@lan:~/tmp/git/billing

We can't share our project via http - we need authorization for it. Is is 
possible to clone this repo via ssh as http clone does ? Its will be much 
faster and will simplify work with such directory - it is hard to delete it 
after cloning - takes from 5 up to 10 minutes ! Filesystem is reiserfs.

Thanks for help,
Alexander Litvinov.
