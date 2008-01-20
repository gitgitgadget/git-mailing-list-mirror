From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sat, 19 Jan 2008 18:02:21 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191801170.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 03:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGPYG-0000Se-9D
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 03:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbYATCEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 21:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYATCED
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 21:04:03 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42166 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304AbYATCEB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 21:04:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K22M51014984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 18:02:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K22L0a030863;
	Sat, 19 Jan 2008 18:02:21 -0800
In-Reply-To: <alpine.LSU.1.00.0801200142170.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.72 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71152>



On Sun, 20 Jan 2008, Johannes Schindelin wrote:
> 
> If I'm not mistaken, you removed all four call sites of wt_read_cache(), 
> and it is static anyway, so it should be removed, no?

Yes.

The wt_read_cache() changes are really independent, and while removing 
them was my original goal, that didn't end up being the interesting part 
of the patch, which is why I then left that part half-way..

		Linus
