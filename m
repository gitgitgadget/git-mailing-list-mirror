From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-applymbox broken?
Date: Sun, 11 Jun 2006 17:37:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
 <m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 02:38:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpaRJ-00076Z-Rv
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 02:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFLAhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 20:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWFLAhy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 20:37:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751132AbWFLAhx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 20:37:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5C0bmgt008505
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 17:37:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5C0bl8t003593;
	Sun, 11 Jun 2006 17:37:48 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21678>



On Sun, 11 Jun 2006, Eric W. Biederman wrote:
> 
> This doesn't look like the From: header was in the middle of the
> message until it was imported into git so it is probably a small
> logic error that is easily corrected.  But I need to see what
> we are parsing so I can understand what is happening.

No, it's at the top of the body, although there might have been an empty 
line or two (ie whitespace only) before it.

> Even if the header lines are in the middle of the body?

What do you mean by "middle"?

No, it should only look at From: and Subject: lines if they are at the 
very top, with no other non-whitespace lines above them. But when it looks 
at them and uses the data from them, it should then remove them from the 
body - they are "conceptually" just extended header lines that just 
happened to technically (from an rfc822 standpoint) be in the body of the 
email.

		Linus
