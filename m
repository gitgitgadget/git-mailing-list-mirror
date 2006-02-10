From: Brian Smith <linuxfood@linuxfood.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Thu, 9 Feb 2006 23:01:20 -0800
Message-ID: <200602092301.21098.linuxfood@linuxfood.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz> <200602091650.55370.linuxfood@linuxfood.net> <43EC162E.9090905@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 08:01:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7SHb-00042q-Jv
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 08:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWBJHBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 02:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBJHBY
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 02:01:24 -0500
Received: from [67.124.82.122] ([67.124.82.122]:24903 "EHLO linuxfood.net")
	by vger.kernel.org with ESMTP id S1751167AbWBJHBX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 02:01:23 -0500
Received: (qmail 22539 invoked from network); 9 Feb 2006 23:01:22 -0800
Received: from unknown (HELO borealis.linuxfood.net) (192.168.1.2)
  by 192.168.1.6 with AES256-SHA encrypted SMTP; 9 Feb 2006 23:01:22 -0800
To: Sam Vilain <sam@vilain.net>
User-Agent: KMail/1.9
In-Reply-To: <43EC162E.9090905@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15867>

On Thursday 09 February 2006 20:27, Sam Vilain wrote:
>>> [snip]
> >
> > While that is an admirable goal, unless you can point me to something
> > that will allow you to actually commit back to SVN without a working
> > copy,
>
> Such as SVK
>
>    http://svk.elixus.org/
>    (svn url: http://svn.openfoundry.org/svk/)

Well, after reading through a number of pages I discovered something:

"The repository created is actually a Subversion repository. In other words, 
you could use any subversion commands with that repository." [*1*]

So, while it is a technicality, there is an SVN Repo, which is what I'm trying 
to avoid (the point being to have a git repo after all, for the purpose of 
using git commands), perhaps it would be worth looking into to see if I could 
somehow utilize the svk svn repo (since there are space savings) for the SVN 
working copy. [*2*]

>
> > [snip]
>
> Your solution may ultimately be the most pragmatic approach.  Issues
> surrounding the C (SWIG) bindings between Perl and the Subversion RA
> (remote access) API were "the hard part" in making SVK work, according
> to the lead author.
>
> That being said, I am unaware of any drastic outstanding issues, so
> perhaps there are useful components there.

There are useful things in there. I have considered rewriting in perl so that 
I don't have to use my kludge of a rewrite of Getopt::Long (yes, I did. No, 
not everything is supported.) but have decided against it mostly because it 
would take weeks, and Kosek (my program) isn't even complete yet.

(Incidentally, the allure of the SVN perl bindings had me for awhile, but 
after trying to decipher the horrid PODs for it decided that Bash was just 
easier. )

>
> > Sure, you can actually pick up the current development straight from
> > git://linuxfood.net/pub/git/kosek.git
>
> I will take a look.
>
Awesome let me know what you think. Please try to ignore the massive lack of 
documentation, up until someone in the kopete irc channel showed interest I 
had been writing it for my own purposes. Though, since I posted the link here 
I did go ahead and fixup the readme with a little howto. If you like it, feel 
free to email me with questions and suggestions.

[*1*] http://svk.elixus.org/?SingleUserSVK (under Mapping Repositories)

[*2*] 
While writing this, I had an absolutely insane idea, which I may or may not 
persue.  The idea being that it may be possible to remove 99% of the actual 
SVN working copy (except for perhaps the base directory at the root of the 
project), and just use symlinks for the rest of the hierarchy. This would 
require careful management though, since every .svn directory contains 
specific and distinct information.
