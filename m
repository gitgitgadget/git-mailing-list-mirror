From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: gitk problems: can't unset "idinlist(...)"
Date: Fri, 20 Jul 2007 16:05:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 01:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC1Y7-0007bz-8c
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 01:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139AbXGTXGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbXGTXGI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 19:06:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41735 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758273AbXGTXGG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 19:06:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KN60k9008593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 16:06:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KN5sld021189;
	Fri, 20 Jul 2007 16:05:54 -0700
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53126>


Ok, color me stumped, but gitk is unhappy.

Ingo and Thomas have just announced that they  have a unified x86 tree for 
both i386/x86-64, so I did

	gitk arch/i386 arch/x86_64

to look at what has happened recently in the kernel in that area.

I get the gitk history view, but no actual diffs, and I get an application 
error window saying

	can't unset "idinlist(57d1c91fa6d9146b309b7511f6432dea2a24858b)": no such element in array
	can't unset "idinlist(57d1c91fa6d9146b309b7511f6432dea2a24858b)": no such element in array
	    while executing
	"unset idinlist($id)"
	    (procedure "layouttail" line 11)
	    invoked from within
	"layouttail"
	    (procedure "layoutmore" line 35)
	    invoked from within
	"layoutmore $tlimit $allread"
	    (procedure "chewcommits" line 9)
	    invoked from within
	"chewcommits 1"
	    ("eval" body line 1)
	    invoked from within
	"eval $script"
	    (procedure "dorunq" line 9)
	    invoked from within
	"dorunq"
	    ("after" script)

which really doesn't tell me much.

It doesn't seem to happen without path limiting, and it also doesn't seem 
to happen for all paths (doing "gitk drivers/scsi" doesn't show it), but 
somehow that "arch/i386" part seems to bring it out.

I'm not seeing anything interesting or special about that named commit, or 
anything else that would make gitk unhappy. But it is.

Current kernel tree. Anybody else has any ideas? Somebody who knows 
tcl/tk, and gitk?

			Linus
