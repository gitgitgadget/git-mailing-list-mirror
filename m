From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Tue, 28 Mar 2006 15:03:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603281500280.15714@g5.osdl.org>
References: <15693.1143575188@lotus.CS.Berkeley.EDU>
 <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 01:03:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FONDi-0001VU-9d
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 01:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWC1XDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 18:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWC1XDQ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 18:03:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964792AbWC1XDO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 18:03:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2SN35Co030605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Mar 2006 15:03:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2SN352Y030714;
	Tue, 28 Mar 2006 15:03:05 -0800
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18138>



On Tue, 28 Mar 2006, Mark Wooding wrote:

> Jason Riedy <ejr@EECS.Berkeley.EDU> wrote:
> 
> > P.S. For the whole finding-a-function-name business, some of 
> > us are using git on fixed-format Fortran.  Every non-comment
> > line begins with whitespace...  ;)  And in free format, many
> > people don't add that first indentation within subroutines.
> 
> Urgh.  So, which regex library do people want to use? ;-)  (My vote's
> for pcre.)

I'd really just prefer to make the "-p" switch configurable, the way it 
was before. No regexps, just the same rules as for GNU diff, perhaps with 
the difference being that it would be on by default.

Another possible approach is to say
 - if the first line of the real diff matches the rules, do NOT add 
   another line that matches the rule at the @@-line.

since the simple @@-line rule really doesn't make sense for any file that 
is "dense" (ie where most lines start with non-whitespace).

		Linus
