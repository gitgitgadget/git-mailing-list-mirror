From: Linus Torvalds <torvalds@osdl.org>
Subject: git-stripspace breakage
Date: Fri, 14 Apr 2006 09:40:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604140936520.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Apr 14 18:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FURLP-0003Qu-6n
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 18:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWDNQkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDNQkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 12:40:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751268AbWDNQkO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 12:40:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3EGeAtH016872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 09:40:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3EGe4cA031986;
	Fri, 14 Apr 2006 09:40:07 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18691>


Junio,
 the current git-stripspace leaves extra newlines at the end, causing ugly 
commit logs in "git log". I assume/suspect that it's the recent 
"incomplete line" handling (that I acked, bad me), but I didn't actually 
test.

Trivially tested thus:

	[torvalds@g5 git]$ git-stripspace <<EOF
	> a
	> 
	> EOF
	a
	
	[torvalds@g5 git]$ 

note the extra unnecessary newline..

		Linus
