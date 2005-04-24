From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sat, 23 Apr 2005 20:58:47 -0700
Organization: SGI
Message-ID: <20050423205847.7758bfaa.pj@sgi.com>
References: <20050424005923.GA8859@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 05:54:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPYCJ-0004UE-0s
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVDXD7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVDXD7F
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:59:05 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34954 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262244AbVDXD7B (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 23:59:01 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3O4NPKi030673;
	Sat, 23 Apr 2005 21:23:31 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3O3wplU17734784;
	Sat, 23 Apr 2005 20:58:51 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050424005923.GA8859@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm missing something here (well, missing alot, but ...).

What are the exact steps, given that I have an empty chunk
of diskspace, to get Linux 2.6.12-rc3 to appear there, using
git.

Actually, I got part way.  Perhaps someone can complete
the following:

    mkdir git
    cd git
    curl -O ftp://ftp.kernel.org/pub/software/scm/cogito/git-pasky-0.6.3.tar.bz2
    tar xvfj git-pasky-0.6.3.tar.bz2
    cd git-pasky-0.6.3
    ls -l /usr/local/include/openssl/sha.h	 # yup - I have openssl header
    make
    ./git init rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
    make install
    git addremote pasky rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
    git pull pasky
    git addremote linus rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    git pull linus

And I have the SHA1 for Linus's 2.6.12-rc3:

    a2755a80f40e5794ddc20e00f781af9d6320fafb

And I've set DB_ENVIRONMENT=<this-git-directory>/.git/objects

Now I'd like to get 2.6.12-rc3 working kernel files to appear
in a separate directory.

Now what ... how do I do that?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
