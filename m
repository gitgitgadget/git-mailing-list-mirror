From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 11:35:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705011057130.29859@racer.site>
References: <200704300120.42576.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 11:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiomP-0004BV-FB
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031628AbXEAJgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 05:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031627AbXEAJgO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:36:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:56162 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031625AbXEAJgM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 05:36:12 -0400
Received: (qmail invoked by alias); 01 May 2007 09:36:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 01 May 2007 11:36:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vNqsD8Zgvnml6CvgjXmzwfPJmY6LmsLVmvxRyHs
	LxTWroLCjyj5am
X-X-Sender: gene099@racer.site
In-Reply-To: <200704300120.42576.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45933>

Hi,

On Mon, 30 Apr 2007, Jakub Narebski wrote:

> I have read lately classic book "Producing Open Source Software. How to 
> Run a Successful Free Software Project" by Karl Fogel (2005).
> 
> Among others, author advocates using version control system as a basis 
> for running a project. In "Choosing a Version Contol System" he writes:
> 
>   As of this writing, the version control system of choice in the free
>   software world is the Concurrent Versions System or CVS.

Back then, it was. I ran all my projects on CVS. Then came along Git. I 
tried to keep up with it, but had to quit for day-job reasons. When I came 
back, Git was already so good that I switched almost everything over.

> The distributed SCM is mentioned in footnote in section "Comitters" in 
> Chapter 8, Managing Volunteers:
> 
>  http://producingoss.com/producingoss.html#ftn.id284130
> 
>   [22] Note that the commit access means something a bit different in
>   decentralized version control systems, where anyone can set up a
>   repository that is linked into the project, and give themselves commit
>   access to that repository. Nevertheless, the concept of commit access
>   still applies: "commit access" is shorthand for "the right to make
>   changes to the code that will ship in the group's next release of the
>   software." In centralized version control systems, this means having
>   direct commit access; in decentralized ones, it means having one's
>   changes pulled into the main distribution by default. It is the same
>   idea either way; the mechanics by which it is realized are not
>   terribly important.
> 
> 
> I'm interested in your experience with managing projects using 
> distributed SCM, or even better first centralized then distributed SCM: 
> is the above difference the only one?

In my experience, the offline mode has been a huge advantage. For example, 
in one project I work together with people from three different countries, 
some of them traveling quite a bit. I sold Git solely on the 
transportability. One of them was so happy that he switched over most of 
his projects, too.

BTW that is the common way I see: once people get hooked, they not only 
convert their existing projects to Git, but they use cvsimport a lot more, 
and they start to manage configuration settings, documents, pictures, etc. 
with Git, because it gives rise an easy backup mechanism.

Another difference between central and distributed operation I see is the 
workflow. With Git, you can commit much more often. For example, when 
working with Sourceforge's CVS (which _was_ comparable with the speed of 
corporate SourceSafe repos), I would always think about committing (and 
having a coffee), or rather combine these changes with the next ones.

Obviously, committing more often leads to a much nicer repository 
structure, making it much easier to get into the code for new developers. 
It also makes it easier to get at bugs. And because it is so much faster, 
you can actually do a "git diff" before committing, to make sure that you 
did not leave in that stupid debug statement.

> Linus has said that fully distributed SCM improves forkability:
>
> [...] 
> 
>   I think that "forking" is what keeps people honest. The _biggest_
>   downside with CVS is actually that a central repository gets so much
>   _political_ clout, that it's effectively impossible to fork the
>   project: [...]
> 
> According to "Producting Open Source Software" it is very important 
> feature for an OSS project.
>
> [...]
> 
>   Because a fork is bad for everyone (for reasons examined in detail in 
>   the section called "Forks" in Chapter 8, Managing Volunteers, 
>   http://producingoss.com/producingoss.html#forks), the more serious the 
>   threat of a fork becomes, the more willing people are to compromise to 
>   avoid it.

This is a lousy argument, IMHO.

Why are forks bad? They are not. But if you "learnt" that merges are hard, 
they are.

It is a pity that so many people were trained in CVS, and keep thinking 
some of the lectures were true, when they are no longer.

Forks are good. In fact, we all "forked" with CVS as soon as we began 
hacking. Everybody who claims to never have started over from a fresh 
checkout, or from an "update -C"ed state, is probably lying, or a bad 
developer. Thinking about it, I believe that the difference between 
forking and branching is philosophical, not technical. You can always 
merge a fork.

And the thing is, you would not start hacking on some obscure feature, if 
that happened completely in the open, for fear of being accused a complete 
moron.

With CVS, that meant that you tried to get at a stage where others could 
see that it was worth doing, before committing. Which makes for monster 
commits. ("The number of bugs is the _square_ of the number of changed 
lines.") With Git, that problem is virtually not there.

> Besides that, what are the differences between managing project using 
> centralized SCM and one using distributed SCM? What is equivalent of 
> committers, giving full and partial commit access, revoking commit 
> access?

I have to admit that I drive one of my projects "CVS" style, with SSH 
accounts for all developers, who push into the same repo.

But that worked quite well up to now.

If I _had_ to restrict them, I'd probably do that by (temporarily) 
assigning a release engineer, and setting up some hook scripts in all 
repos. But I don't believe in restriction when it comes to creativity.

> How good support for tagging and branching influences creating 
> code and build procedure?

> Is distributed SCM better geared towards "benovolent dictator" model 
> than "consensus-based democracy" model, as described in OSSbook?

Not at all. I think the best example is kernel.org, where you find tons of 
forks. IMHO it is really helping the benevolent dictator cave into the 
consensus-based model, since forks can be preferred at any time. Hey, even 
switching from one to another upstream is just a git-pull away!

Ciao,
Dscho
