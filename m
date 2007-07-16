From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
 possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 10:03:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
 <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATzk-0008AB-55
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbXGPRER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756121AbXGPRER
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:04:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52172 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754130AbXGPRER (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:04:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GH3cAB004515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 10:03:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GH3W0U020354;
	Mon, 16 Jul 2007 10:03:33 -0700
In-Reply-To: <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=-2.625 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52688>



On Mon, 16 Jul 2007, Thomas Glanzmann wrote:
>
> I think it is. Damn it. What seems to hapen here is that git does:
> 
>         - create a subdirectory
>         - puts a file in
>         - deletes a subdirectory (by call unlink - that would normally fail,
>           but with solaris as root it does not fail)

Solaris is apparently a buggy piece of crap.

I'd suggest making a bug-report. ENOTEMPTY is not an optional error. Posix 
says "Shall fail".

			Linus
