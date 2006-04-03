From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 07:36:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 16:37:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQBE-0007pb-Q7
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWDCOg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWDCOg6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:36:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751590AbWDCOg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:36:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k33EasEX028630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Apr 2006 07:36:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k33Earl1019494;
	Mon, 3 Apr 2006 07:36:53 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18333>



On Mon, 3 Apr 2006, Linus Torvalds wrote:
> 
> That said, I think git _does_ have problems with large pack-files. We have 
> some 32-bit issues etc

I should clarify that. git _itself_ shouldn't have any 32-bit issues, but 
the packfile data structure does. The index has 32-bit offsets into 
individual pack-files. 

That's not hugely fundamental, but I didn't expect people to hit it this 
quickly. What kind of project has a 1.5GB pack-file _already_? I hope it's 
fifteen years of history (so that we'll have another fifteen years before 
we'll have to worry about 4GB pack-files ;)

			Linus
