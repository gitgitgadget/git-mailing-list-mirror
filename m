From: David Greaves <david@dgreaves.com>
Subject: Re: update-cache ./test.c
Date: Sun, 01 May 2005 10:43:34 +0100
Message-ID: <4274A4C6.3000400@dgreaves.com>
References: <20050501084145.GA30692@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 01 11:38:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSAtg-0002Jc-T6
	for gcvg-git@gmane.org; Sun, 01 May 2005 11:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVEAJnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 05:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVEAJnt
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 05:43:49 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:59043 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261415AbVEAJnr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 05:43:47 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 11A1CE6D99; Sun,  1 May 2005 10:43:35 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21721-01; Sun,  1 May 2005 10:43:34 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.200.138])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 58864E6A83; Sun,  1 May 2005 10:43:34 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DSAz9-0007a1-26; Sun, 01 May 2005 10:43:35 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Lennert Buytenhek <buytenh@wantstofly.org>
In-Reply-To: <20050501084145.GA30692@xi.wantstofly.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Lennert Buytenhek wrote:

>Hi,
>
>update-cache seems to ignore paths containing path components
>starting with a dot:
>
>	pi% update-cache --add ./test.c
>	Ignoring path ./test.c
>	pi% update-cache --add test.c
>	pi%
>
>This is slightly annoying as 'find -type f | xargs update-cache --add'
>doesn't work because of this.  ('find * -type f | ...` does.)  Instead
>of ignoring the file, can we just strip off the leading "./"
>  
>

This is documented behaviour:
<file>
    Files to act on.
    Note that files begining with '.' are discarded. This includes
    "./file" and "dir/./file". If you don't want this, then use   
    cleaner names.
    The same applies to directories ending '/' and paths with '//'


"Where?" you ask...

Well, Linus hasn't accepted the docs for some reason - you have to
search the archives...

Sorry about that...

David
PS Changing this behaviour was discussed and dismissed for the core tools.
If the problem appears in Cogito however, then it's worth patching...


