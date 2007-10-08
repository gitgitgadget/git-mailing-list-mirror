From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 7 Oct 2007 19:17:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710071916510.23684@woody.linux-foundation.org>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
 <20071008020435.GA20050@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 04:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeiCP-0000vv-CM
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 04:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbXJHCSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 22:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbXJHCSM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 22:18:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34406 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119AbXJHCSL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2007 22:18:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l982HpLG027433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 7 Oct 2007 19:17:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l982HoRK001541;
	Sun, 7 Oct 2007 19:17:50 -0700
In-Reply-To: <20071008020435.GA20050@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.738 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60277>



On Sun, 7 Oct 2007, Jeff King wrote:
> 
>   fd = open(".", O_RDONLY);
>   chdir(path);
>   ...
>   fchdir(fd);

fchdir() is not portable.

I think it would be better to not chdir() at all. Yes, that means having 
to prepend the prefix to the names, but that is what git generally does 
(for that - and other - reasons).

		Linus
