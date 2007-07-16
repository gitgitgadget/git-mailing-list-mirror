From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 14:19:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161414360.20061@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <alpine.LFD.0.999.0707161252330.20061@woody.linux-foundation.org>
 <20070716210612.GI19073@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXzh-0002Xj-W3
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbXGPVUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758933AbXGPVUe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:20:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33763 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759515AbXGPVUd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 17:20:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GLJhPu019247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 14:19:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GLJc3q003799;
	Mon, 16 Jul 2007 14:19:38 -0700
In-Reply-To: <20070716210612.GI19073@lavos.net>
X-Spam-Status: No, hits=-4.641 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52724>



On Mon, 16 Jul 2007, Brian Downing wrote:
> 
> Apparently "enterprise class" in this case really means "fully
> compatibility with all those wonderful userland implementations of
> rmdir."  :-)

I see the smiley, but it's actually not possible even for that.

The broken "unlink()" behaviour doesn't work on any other filesystem (eg 
NFS) at all anyway, and even on UFS would only work for root (or 
setuid-root) binaries. So any user-land that depended on it literally 
wouldn't work _anyway_, even on Solaris itself.

And we're talking about the same company that was *famous* for screwing 
people over when they converted from SunOS to Solaris and broke binaries 
_and_ source code in the process.

So no, "compatibility" can't realistically be the reason.

			Linus
