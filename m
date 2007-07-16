From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
 possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 10:07:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161004550.20061@woody.linux-foundation.org>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
 <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAU3g-0001ER-Md
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbXGPRIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbXGPRIZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:08:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42035 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbXGPRIY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:08:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GH7Eil004810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 10:07:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GH79vq020594;
	Mon, 16 Jul 2007 10:07:09 -0700
In-Reply-To: <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.624 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52689>



On Mon, 16 Jul 2007, Linus Torvalds wrote:
>
> Solaris is apparently a buggy piece of crap.
> 
> I'd suggest making a bug-report. ENOTEMPTY is not an optional error. Posix 
> says "Shall fail".

Oh, it was apparetly "unlink()" that corrupts filesystems. Which isn't 
against Posix, it's just stupid.

The "unlink directories" is so old-fashioned that it's not even funny. The 
whole reason "rmdir()" was created was to *not* have that behaviour in the 
OS. 

So I'll have to correct my statement. Please remove the "buggy" from 
"buggy piece of crap". The rest stands.

		Linus
