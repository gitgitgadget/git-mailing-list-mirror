From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] perl/Git.pm: add rev_parse method
Date: Fri, 30 May 2008 11:59:38 +0200
Message-ID: <20080530095938.GE18781@machine.or.cz>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com> <483FA6B3.4070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 12:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21PW-0004yg-Dj
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 12:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYE3J7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 05:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbYE3J7l
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 05:59:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45327 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbYE3J7l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 05:59:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AAAA61E4C02B; Fri, 30 May 2008 11:59:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <483FA6B3.4070607@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83283>

On Fri, May 30, 2008 at 09:03:15AM +0200, Lea Wiemann wrote:
> I wrote:
>> [Commit:] The rev_parse method translates a revision name to a SHA1 hash, 
>> like
>> the git-rev-parse command.
>
> Oh, here's one problem: I'll probably do a lot of changes to Git.pm, and it 
> might be handy for me to be able to change my own methods later.   I 
> definitely wouldn't like to see Git.pm end up in some release while I'm in 
> the middle of a major refactoring.
>
> Should I perhaps stay on my branch with these changes, and then merge when 
> it has stabilized (in 1-3 months)?

I have two proposals:

(i) Tell Junio you would like the changes to stay in pu or next for now.
But he will probably do that by default anyway. :-) Thus, you do not
need to worry about them getting into a release any soon, but you will
still see some real-life testing (in theory).

(ii) When introducing new interface, introduce a user to it right away.
So, if I were you, my roadmap would be something like:

	(a) Make Git.pm use gitweb's config parser
	(b) Add 'use Git' to gitweb and convert all Git calls possible
	(c) For the rest, introduce the necessary methods to Git.pm,
	    one patch per method (I would even bundle the Git.pm
	    addition with the gitweb changes)

I'm not saying you _have_ to do it this way, but I believe it's one of
the smoothest paths. Me and I think many others of the Git project are
huge believers in "small steps" instead of "grand designs"; you will be
getting immediate feedback about your changes as you go and your work
will be useful at any point of time.

> One thing I'd be concerned about is that I might introduce fundamental 
> issues in my API, since I'm neither a Git nor a Perl expert (yet ^^). 
> What's the best way to avoid discovering such issues only at the Big Merge? 
> Is there anyone who'd be willing to monitor my commits and give me 
> feedback on a semi-continuous basis?

(I would love to provide feedback and review your patches, but please
note that at the same time I cannot promise I will be able to do it all
the time; I have failed these hopes in the past already, and again
likely will in the future.  But hopefully there's plenty of other Perl
hackers on the list.)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
