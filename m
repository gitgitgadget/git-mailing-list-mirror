From: Linus Torvalds <torvalds@osdl.org>
Subject: Signed char assumption..
Date: Mon, 20 Mar 2006 11:20:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603201119020.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Mar 20 20:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLPw8-0006vB-Rd
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 20:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCTTVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 14:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCTTVA
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 14:21:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbWCTTU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 14:20:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2KJKtDZ005086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 20 Mar 2006 11:20:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2KJKtBm001093;
	Mon, 20 Mar 2006 11:20:55 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.131 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17761>


On ppc, I now get:

  http-push.c: In function 'add_fetch_request':
  http-push.c:831: warning: comparison is always false due to limited range of data type
  http-push.c: In function 'add_send_request':
  http-push.c:864: warning: comparison is always false due to limited range of data type

because the code assumes that "char" is signed and can take a -1. 

		Linus
