From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-applymbox broken?
Date: Mon, 12 Jun 2006 20:41:54 -0700
Message-ID: <20060613034153.GU32457@h4x0r5.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org> <m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 13 05:42:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpznS-0006lp-CW
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 05:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWFMDmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 23:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbWFMDmT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 23:42:19 -0400
Received: from h4x0r5.com ([70.85.31.202]:18701 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932824AbWFMDmT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 23:42:19 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Fpzmt-0003ar-6b; Mon, 12 Jun 2006 20:41:55 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21760>

On Sun, Jun 11, 2006 at 05:33:59PM -0600, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > It looks like something has broken git-applymbox lately.
> >
> > The "From: authorname" lines are no longer removed from the message, and 
> > are duplicated in the commit log. This has resulted in several recent 
> > kernel commits looking like this:
> 
> Agreed.  That isn't terribly desirable.
> Do you have the original email message some place?
> 
> There is an odd case where if someone put the From: header
> in the middle of the text that we now notice and process and I
> didn't feel right about removing a line from the middle of the
> text.
> 
> I was fixing a nasty corner case that happens if there aren't any
> mail headers at all passed to git-mailinfo.  Where we could drop
> lines without processing them at all.
> 
> This doesn't look like the From: header was in the middle of the
> message until it was imported into git so it is probably a small
> logic error that is easily corrected.  But I need to see what
> we are parsing so I can understand what is happening.

I hate to say this, because I'm bad about it, too, but we should
probably have a few tests for applymbox, to cover the various scenarios
discussed in this thread.

-- 

Ryan Anderson
  sometimes Pug Majere
