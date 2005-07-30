From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 7/2] Support for NO_OPENSSL
Date: Fri, 29 Jul 2005 20:39:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507292038160.29650@g5.osdl.org>
References: <20050729085819.GL24895@pasky.ji.cz> <20050729155051.GJ21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 05:40:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyiDF-0006QM-N5
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 05:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVG3DkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 23:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVG3DkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 23:40:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261617AbVG3DkO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 23:40:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6U3dvjA008681
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Jul 2005 20:39:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6U3duoJ007720;
	Fri, 29 Jul 2005 20:39:56 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729155051.GJ21909@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This doesn't work at least in the form that Junio merged it (and from 
what I can tell, he merged your patch as-is):

  torvalds@shell0:~/src/git> make NO_OPENSSL=1
  cc -g -O2 -Wall '-DNO_OPENSSL' '-DSHA1_HEADER="mozilla-sha1/sha1.h"' -o git-rev-list rev-list.o libgit.a -lz -lssl
  /usr/lib/gcc-lib/i586-suse-linux/3.3.4/../../../../i586-suse-linux/bin/ld: cannot find -lssl

it needs to disable the -lssl too..

		Linus
