From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [ANNOUNCE] Pyrite project.
Date: Sat, 26 Jan 2008 11:37:26 -0600
Message-ID: <5d46db230801260937w3a514842t3943d0bd7c8dfb70@mail.gmail.com>
References: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
	 <alpine.LSU.1.00.0801261311380.23907@racer.site>
	 <5d46db230801260842i89db074u29657c22f6dbedef@mail.gmail.com>
	 <alpine.LSU.1.00.0801261654410.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 18:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIoye-0005Cf-3W
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 18:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYAZRh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 12:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYAZRh3
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 12:37:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:54279 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbYAZRh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 12:37:28 -0500
Received: by wx-out-0506.google.com with SMTP id h31so779001wxd.4
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 09:37:27 -0800 (PST)
Received: by 10.150.136.6 with SMTP id j6mr1402517ybd.117.1201369046787;
        Sat, 26 Jan 2008 09:37:26 -0800 (PST)
Received: by 10.150.156.18 with HTTP; Sat, 26 Jan 2008 09:37:26 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801261654410.23907@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: 1ed4f83f364509ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71784>

On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> any particular reason you took this discussion off-list?
>
No, I am just an idiot.  GMail's defualt reply instead of reply-all
bites me every
friggin time.

re-adding the list.

> On Sat, 26 Jan 2008, Govind Salinas wrote:
>
> > On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > IIRC it was you who started the c# port of git?  What happened to it?
> >
> > Well, that was mostly so I could convince my co-workers to use git (and
> > to teach myself C#), but the idea was a non-starter at my company so I
> > abandoned it.
>
> I thought it was a GSoC project?
>
No, it was my own thing.

> > > >  2. Help the libification effort in git so that I can use git code straight
> > > >     from python.
> > >
> > > That should also be easy enough; there was a GSoC program, and you could
> > > just go there and help that effort, instead of reinventing the wheel.
> > >
> > > For your convenience:
> > >
> > >         http://repo.or.cz/w/git/libgit-gsoc.git
> > >
> >
> > Yeah, I was looking at that when I was doing Widgit.  But last I checked
> > there had not been an update in several months, I figured the project
> > was dead.
>
> I should hope that it would make more sense to pick it up than to start a
> new project.
>
Totally agree.
> > > >  3. Start stripping away non-performance-critical C code and convert
> > > >     it to python code to help interoperate with extensions and GUIs
> > >
> > > I am absolutely no fan of "extensions".  You keep breaking other
> > > people's code if your core introduces changes; see for example the
> > > libgit.a issue with cgit.
> >
> > The nice thing about extensions is that you don't have to use them if
> > you don't want to.
>
> I know what the nice thing about extensions is.  My point was that there
> is also a pretty nasty side.  One that I am not prepared to accept easily.
>
There is another benefit too.  Have a bit of code that might be dangerous?
Put it in an extension and it can be tested in isolation, without the need to
rebuild the project (for people that offer to test for you).  Once it is ready
and tested for general use, it can beincorporated into the standard.

> > > > There are 2 main benefits that I am looking for with git
> > > > libification. One is, if we can reduce the amount of code that has
> > > > to be compiled in C to a small enough subset, we should be able to
> > > > build without the need of Cygwin or Msys.
> > >
> > > This effort would be better helped by converting more scripts to
> > > builtins, _not_ by reintroducing the dependency on python.
> >
> > So a couple of different things here.  Firstly, you should not see this
> > as introducing a python dependency to git.
>
> Well, I should hope so.
>
> > A libified, unified version of git all in C would almost certainly be
> > faster than anything done in python, even with the good stuff done in C.
> > However, and I know it's a notion that some people don't agree with, I
> > believe a small amount of performance (such as overhead from using a
> > JITed language) can be sacrificed for ease of development and maintain-
> > ability.
>
> I have no problem with rapid prototyping in shell or perl.  But the final
> goal has to be C.
>
> Ciao,
> Dscho
>
>

Thanks for the feedback.
-Govind
