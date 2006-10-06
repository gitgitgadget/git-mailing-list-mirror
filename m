From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Fri, 6 Oct 2006 13:21:01 -0700 (PDT)
Message-ID: <20061006202101.41031.qmail@web31804.mail.mud.yahoo.com>
References: <20061006190850.GA4827@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 06 22:21:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVwBw-0002Bh-B6
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 22:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWJFUVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJFUVE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 16:21:04 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:60280 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932565AbWJFUVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 16:21:02 -0400
Received: (qmail 41033 invoked by uid 60001); 6 Oct 2006 20:21:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mWoakbIop7HHJhR3nkYnnXfvkjfOLLj1o14Pv84/pmzia/7mUY6Yem/ydw0UvvsAIJ69GLHAuiyk6DFENwnGod4rdtopnQH3BcU5iSGgtW8FCPS3j+DOUhI35NP2xxbwrs2CHyXhsb5wHMlymhdcqczO9mOgqPYkNKmxa/zHMCQ=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 13:21:01 PDT
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006190850.GA4827@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28442>

--- Petr Baudis <pasky@suse.cz> wrote:
> (Trimmed cc list to people caring about gitweb.)
> 
> Dear diary, on Fri, Oct 06, 2006 at 08:55:29PM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
> > --- Petr Baudis <pasky@suse.cz> wrote:
> > > I will not mourn git-annotate disappearance (perhaps it could stay an
> > > alias to git-blame -c; I don't like this UI-wise but we already do this
> > > kind of thing with git-log / git-whatchanged). I still like gitweb blame
> > > better than blame2 but I'll just patch blame to look like blame2 (or
> > > better) and be happy with that.
> > 
> > That's exactly what I don't want to happen.  blame2 is much less
> > bloated than blame both in code and in visual appearance and in using
> > git.  And this was the whole point: quick, short, fast and straight
> > to the point.
> > 
> > I'd like to keep the blame interface as simple as possible, more
> > window estate given to the code lines, and as little as possible to
> > the commit id: a clickable commit-8 and now we also have clickable
> > line_no to show us the state of the file, is more than enough.
> > 
> > So far, blame2 has been by far the better "annotate" (as it is called
> > in the other SCMs) interface I've seen in four other SCMs (some proprietary).
> > Let's keep it like this.
> > 
> > When data-mining code, what I'm interested in is: where did this line
> > of code come from (commit-8), is it a part of a larger chunk (zebra
> > coloring) and how it relates to the surrounding code.  Blame2 is more
> > than efficient at this.
> 
> And _I_ like to have some general idea about who and when touched given
> line of code, without having to click on a bunch of commit ids or spend
> a minute hovering over them patiently. ;-)

Well understood.

Although, when I'm chasing after a problem, I care much about
tracing back through the commit history as opposed to who did
what and when, not until I've nailed the regressive commit (is when
I care who/what/when/how).

> If you really feel strongly about it, we should be able to make the
> individual columns hideable at view time, e.g. by a tiny bit of
> javascript just changing the display CSS property, which would be really
> comfortable. My idea about the output would be cg-log -s format, which
> is still reasonably tense. OTOH, there's still some space to burn in the
> Line column.

Point taken.

Now since I don't want to turn blame2 into a circus, and since the whole
point of blame2 (over blame) was to stay away from it being a circus,
and to be fast and to the point, can we just keep git_blame() around
which gives you this extra information right in the main screen?

    Luben
P.S. The alternative is to create a next git_blame{N+1}() each time
git_blameN() becomes git_blame{N-1}().
