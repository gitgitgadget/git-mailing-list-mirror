X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 04:48:10 -0400
Message-ID: <20061025084810.GA26618@coredump.intra.peff.net>
References: <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 08:48:35 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30038>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GceQs-0006ew-Ue for gcvg-git@gmane.org; Wed, 25 Oct
 2006 10:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423122AbWJYIsO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 04:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423135AbWJYIsO
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 04:48:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8428 "HELO
 peff.net") by vger.kernel.org with SMTP id S1423122AbWJYIsN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 04:48:13 -0400
Received: (qmail 24968 invoked from network); 25 Oct 2006 04:47:16 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 25 Oct 2006 04:47:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Oct
 2006 04:48:10 -0400
To: David Rientjes <rientjes@cs.washington.edu>
Sender: git-owner@vger.kernel.org

On Tue, Oct 24, 2006 at 01:12:52PM -0700, David Rientjes wrote:

> And I would prefer the opposite because we're talking about git.  As an 
> information manager, it should be seen and not heard.  Nobody is going to 
> spend their time to become a git or CVS or perforce expert.  As an 
> individual primarily interested in development, I should not be required 
> to learn command lines for dozens of different git-specific commands to do 
> my job quickly and effectively.  I would opt for a much more simpler 
> approach and deal with shell scripting for many of these commands because 
> I'm familiar with them and I can pipe any command with the options I 
> already know and have used before to any other command.

I don't understand how converting shell scripts to C has any impact
whatsoever on the usage of git. The plumbing shell scripts didn't go
away; you can still call them and they behave identically.

Is there some specific change in functionality that you're lamenting?

> As a developer on Linux based systems, I should not need to deal with 
> code in a revision control system that is longer and less traceable 
> because the authors of that system decided they wanted to support Windows 
> too.  Moving away from the functionality that the shell provides is a 
> mistake for a system such as git where it could be so advantageous because 
> of the inherent nature of git as an information manager.

Some C->shell conversions may have made the code "longer and less
traceable." However, many of those conversions caused the code to be
shorter (because communication between C functions is simpler than going
over pipes, and because anything involving a data structure more complex
than a string is difficult in the shell) and more robust (fewer
opportunities for quoting/parsing errors, and none of the shell gotchas
like missing the error code in "foo | bar").

Do you have any specific reason to believe that the git code is of worse
quality now than it was before?

> This is the reason why I was a fan of git long ago and used it for my own 
> needs before tons of unnecessary features and unneeded complexity was 
> added on.

Is there something you used to do with git that you no longer can? Is
there a reason you can't ignore the newer commands?

