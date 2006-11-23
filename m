X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Calling all bash completion experts..
Date: Thu, 23 Nov 2006 09:45:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611230935520.27596@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 23 Nov 2006 17:46:22 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32151>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnIeL-0003QF-Qn for gcvg-git@gmane.org; Thu, 23 Nov
 2006 18:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756194AbWKWRqI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756288AbWKWRqI
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 12:46:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33423 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1756194AbWKWRqF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 12:46:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kANHjUix022077
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 23
 Nov 2006 09:45:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kANHjTxm011903; Thu, 23 Nov
 2006 09:45:29 -0800
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org


So, I'm a happy but clueless user of the bash completion, and one thing 
drives me wild: when it has found an exclusive completion, it doesn't add 
the final space at the end, but just beeps at you when you <tab> again.

So I do "git repa<tab>" and get "git repack", which is fine, but I really 
_wanted_ to get "git repack " (with the space at the end), since I've now 
got a unique command, and that's the normal completion behaviour (ie I 
want it to act the same way that "git-repa<tab>" would have acted).

The same is true of filename arguments, btw:

	git commit cont<tab>com<tab><tab>

gives me

	git commit contrib/completion/git-completion.bash

but again, it doesn't seem to do the right thing about the fact that it 
was the unique choice, so it didn't add the final space, and when you 
press <tab> more to get what the other choices are, it doesn't show you 
any other choices (because there are none).

Now, without knowing the completion syntax, I assume it's the "-o nospace" 
things in the completion file. So I'm wondering _why_ that "nospace" is 
there, and whether this could be fixed?

