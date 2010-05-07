From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 12:40:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071235070.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri May 07 21:43:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATS9-0004d0-Aa
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab0EGTnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:43:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37100 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932088Ab0EGTnK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:43:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47JgIrZ015783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 12:42:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47JgHWg007785;
	Fri, 7 May 2010 12:42:18 -0700
In-Reply-To: <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146571>



On Fri, 7 May 2010, Nicolas Pitre wrote:
> 
> Given that only a subset of gitconfig could make sense to have 
> distributed, I think the file should be named .gitparams to make the 
> distinction clear.

I went through the options listed in "man gitconfig", and quite frankly, I 
didn't find any new ones. I didn't grep the source, and I'm sure they're 
not all documented, but if it really is just two options, I doubt it's 
worth it at all.

Hopefully nobody sane uses any non-utf8 encoding for commit messages 
anyway (but what do I know - I have no idea about Asian usage, where it 
may make more sense than in US/Western Europe). So i18n.commitEnconfig is 
not likely to be a big deal.

And just making the crlf attribute work regardless of core.autocrlf sounds 
like it wouldn't be a bad idea. Just _maybe_ we could actually make an 
_explicit_ "core.autocrlf = off/false" actually disable any .gitattribute 
crlf settings, but I'm not sure even that is a good idea.

So I'd suggest relegating "core.autocrlf" to just files that are _not_ 
covered by some explicit .gitattribute setting. After all, that just more 
solidly puts the "auto" in autocrlf.

		Linus
