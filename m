From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] allow pathspec to end with a slash
Date: Tue, 31 May 2005 08:32:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 17:28:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd8em-0003J0-M6
	for gcvg-git@gmane.org; Tue, 31 May 2005 17:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVEaPa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVEaPa3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 11:30:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:13194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261903AbVEaPaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 11:30:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VFUBjA007769
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 08:30:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VFUAX0022827;
	Tue, 31 May 2005 08:30:10 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Junio, 
 pathspec is still subtly broken.

Just removing the slash at the end is not the right thing to do, since 
that means that

	git-diff-files drivers/char/

will trigger on a _file_ "drivers/char", even though the spec makes it 
unambiguous that the user only wants to see stuff under that directory.

Again, git-diff-tree gets this right (not to say that it always did - I
had to fix "interesting()" several times, exactly because it's not that 
simple).

		Linus
