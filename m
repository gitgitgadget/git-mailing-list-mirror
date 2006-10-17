From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 09:41:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> 
 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> 
 <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 18:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZs0U-0006xt-Jk
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 18:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWJQQla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 12:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWJQQla
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 12:41:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751295AbWJQQla (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 12:41:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HGfEaX017011
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 09:41:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HGfCc7027938;
	Tue, 17 Oct 2006 09:41:13 -0700
To: Robert Collins <robertc@robertcollins.net>
In-Reply-To: <1161078035.9020.73.camel@localhost.localdomain>
X-Spam-Status: No, hits=-0.476 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29092>



On Tue, 17 Oct 2006, Robert Collins wrote:

> On Tue, 2006-10-17 at 11:20 +0200, Jakub Narebski wrote:
> > 
> >           ---- time --->
> > 
> >     --*--*--*--*--*--*--*--*--*-- <branch>
> >           \            /
> >            \-*--X--*--/
> > 
> > The branch it used to be on is gone...
> 
> In bzr 0.12 this is :
> 2.1.2
> 
> (assuming the first * is numbered '1'.)
> 
> These numbers are fairly stable

And here, by "fairly stable", you really mean "totally idiotic", don't 
you?

Guys, let's be blunt here, and just say you're wrong. The fact is, I've 
used a system that uses the same naming bzr does, and I've used it likely 
longer and with a bigger project than anybody has likely _ever_ used bzr 
for.

It sounds like bzr is doing _exactly_ what bitkeeper did. 

Those "simple" numbers are totally idiotic. And when I say "totally 
idiotic", please go back up a few sentences, and read those again. I know 
what I'm talking about. I know probably better than anybody in the bzr 
camp.

Those "simple" numbers are anything but. They may be short, most of the 
time, but when you bandy things like "-r 56" around, what you're ignoring 
is that for a _real_ project you actually get numbers like "1.517.3.57", 
which isn't really any simpler or shorter than saying "7786ce19". You 
still want to cut-and-paste it.

And the "simple" numbers have a real downside, which is that THEY CHANGE.

What happens is that somebody else started _another_ branch at revision 2, 
and did important work, and and they also had a "2.1.2" revision, and then 
they merged your work, and you merged their merge back, that "simple" 
revision number changed, didn't it? Suddenly "2.1.2" means something 
different for one of the users.

We had people in the bitkeeper world that _never_ actually understood that 
the numbers changed. The "simple" numbers were stable enough that a lot of 
people thought they were real revisions, and then they were really 
_really_ confused when a number like "1.517.3.57" suddenly went away after 
a merge, and became something else instead.

And yes, bitkeeper had a "real key" internally too. If you actually wanted 
to give a real revision, you had to give something that looked a lot like 
what the bzr internal revision numbers look like.

Of course, most users didn't even _know_ or understand those revision 
numbers, so as a result, you had tons of people who used the "simple" 
thing (which was what "bk log" and all other tools would show), and since 
it worked quite often, they thought it was ok. And then sometimes it 
didn't work at all, or it "worked" by giving the wrong commit, and it was 
just a total disaster.

Something that works "most of the time" is not simple to use. It's just a 
way to make people _believe_ it is simple, and then be really confused 
when it doesn't work.

So trust me, naming things so that the name depend on the local shape of 
the history is idiotic. I _know_. Been there, done that.

The thing is, when I designed git, I actually had years of experience 
working with a big project in a truly distributed manner. I _knew_ that 
handling renames specially is a bad idea (not that you should even need to 
have used BK to know that).

And I _knew_ that the simple revision numbers aren't real and just cause 
confusion.

			Linus
