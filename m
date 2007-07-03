From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Quilt-dev] Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 09:15:39 -0700
Message-ID: <20070703091539.5b44203d.akpm@linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<200707031534.47004.agruen@suse.de>
	<20070703084926.2e834aa5.akpm@linux-foundation.org>
	<200707031803.15633.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: quilt-dev@nongnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:15:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5l2h-0000Gu-RG
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 18:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbXGCQPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 12:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbXGCQPw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 12:15:52 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45625 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755293AbXGCQPv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 12:15:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63GFjM8017996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 09:15:46 -0700
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l63GFeBs000854;
	Tue, 3 Jul 2007 09:15:40 -0700
In-Reply-To: <200707031803.15633.agruen@suse.de>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
X-Spam-Status: No, hits=-3.21 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51513>

On Tue, 3 Jul 2007 18:03:15 +0200 Andreas Gruenbacher <agruen@suse.de> wrote:

> On Tuesday 03 July 2007 17:49, Andrew Morton wrote:
> > I guess one could try `patch -p1' and if that failed, `patch -p1 -u'.
> 
> Hmm, I'll think about that, thanks.
> 
> > But the problem is that patch will get stuck in interactive mode prompting
> > for a filename.  I've never actually worked how to make patch(1) just fail
> > rather than going interactive, not that I've tried terribly hard.  Any
> > hints there?
> 
> Patch -f will turn off those questions.
> 

darnit, both `-f' and `-t' work.  Sigh.  I blame the manpage: too long ;)

Incidentally, the offending patch
(http://userweb.kernel.org/~akpm/git-scsi-misc.patch) sends patch(1) into
an infinite loop with `patch -p1 -f' and `patch -p1 -t'.  Presumably
it will do the same when that patch is offered to quilt...
