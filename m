From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Quilt-dev] Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 08:49:26 -0700
Message-ID: <20070703084926.2e834aa5.akpm@linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<20070702145601.a0dcef0f.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	<200707031534.47004.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: quilt-dev@nongnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 17:50:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5keD-0002OQ-RW
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 17:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbXGCPuK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 11:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757468AbXGCPuK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 11:50:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56577 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757451AbXGCPuH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 11:50:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63FnWEW017051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 08:49:33 -0700
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l63FnQF1031990;
	Tue, 3 Jul 2007 08:49:26 -0700
In-Reply-To: <200707031534.47004.agruen@suse.de>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
X-Spam-Status: No, hits=-3.21 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51509>

On Tue, 3 Jul 2007 15:34:46 +0200 Andreas Gruenbacher <agruen@suse.de> wrote:

> On Tuesday 03 July 2007 02:28, Linus Torvalds wrote:
> > So I would suggest that in quilt and other systems, you either:
> >
> >  - strip all headers manually
> >
> >  - forget about "patch", and use "git-apply" instead that does things
> >    right and doesn't screw up like this (and can do rename diffs etc too).
> >
> > I guess the second choice generally isn't an option, but dammit,
> > "git-apply" really is the better program here.
> 
> I'm in bit of a conflict with choice one: when applying patches in an 
> automated build process or similar, the likely way to do so is a simple loop 
> over the series file. So the less magic when applying patches with quilt, the 
> better.
> 
> Turning off the insane heuristic with patch -u will do well enough I hope. 
> Quilt does not use that option by default because it also supports context 
> diffs (some people / projects prefer them), but that can easily be customized 
> in .quiltrc:
> 
>     QUILT_PATCH_OPTS=-u
> 

I guess one could try `patch -p1' and if that failed, `patch -p1 -u'.

But the problem is that patch will get stuck in interactive mode prompting
for a filename.  I've never actually worked how to make patch(1) just fail
rather than going interactive, not that I've tried terribly hard.  Any
hints there?

Thanks.
