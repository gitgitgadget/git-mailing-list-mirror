From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Customizable error handlers
Date: Sat, 24 Jun 2006 01:18:08 +0200
Message-ID: <20060623231807.GO21864@pasky.or.cz>
References: <20060623133227.27854.65567.stgit@machine.or.cz> <20060623133847.GN21864@pasky.or.cz> <7vsllv8ny8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 01:38:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtvEh-0006Ow-01
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 01:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWFWXir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 19:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWFWXir
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 19:38:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63415 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751671AbWFWXir (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 19:38:47 -0400
Received: (qmail 24004 invoked by uid 2001); 24 Jun 2006 01:18:08 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsllv8ny8.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22456>

Dear diary, on Sat, Jun 24, 2006 at 01:14:07AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Fri, Jun 23, 2006 at 03:32:27PM CEST, I got a letter
> > where Petr Baudis <pasky@suse.cz> said that...
> >> diff --git a/git-compat-util.h b/git-compat-util.h
> >> index 5d543d2..e954002 100644
> >> --- a/git-compat-util.h
> >> +++ b/git-compat-util.h
> >> @@ -36,9 +36,13 @@ #endif
> >>  #endif
> >>  
> >>  /* General helper functions */
> >> -extern void usage(const char *err) NORETURN;
> >> -extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
> >> -extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
> >> +void usage(const char *err) NORETURN;
> >> +void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
> >> +int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
> >
> > Wah, this kind of slipped through. Below is a patch without the
> > externs removed.
> 
> Oh, I first thought you did that on purpose as a cleanup.  After
> all don't they mean the same thing?

AFAIK they do, but we use extern everywhere and I personally consider
it good style to externize declarations of, well, external functions.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
