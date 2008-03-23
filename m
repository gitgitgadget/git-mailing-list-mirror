From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sun, 23 Mar 2008 15:28:52 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231523110.4353@racer.site>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>  <7vmyospgz7.fsf@gitster.siamese.dyndns.org>  <7v3aqik0nz.fsf@gitster.siamese.dyndns.org> <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: alturin marlinon <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdRCb-0003T9-UG
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759210AbYCWO24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759297AbYCWO2z
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:28:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:49727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757119AbYCWO2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:28:55 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:28:53 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp027) with SMTP; 23 Mar 2008 15:28:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180HSAMCKs0iR3+skEkliRoEa6TfDjgBBQcSe/xE4
	jPKkfLMzpSJueW
X-X-Sender: gene099@racer.site
In-Reply-To: <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77908>

Hi,

On Sun, 23 Mar 2008, alturin marlinon wrote:

> On Sat, Mar 22, 2008 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >  * Figure out which blocs of lines (not necessarily the whole files) relate
> >   to each other by noticing that they are often modified in the same
> >   commit.
> 
> I've worked with directed graphs before (including writing my own
> implementation) and have written an algorithm to detect cycles in a
> graph.
> I think that this could be done by creating an undirected weighted
> graph of all files in a commit.

I think you will have to go to the line level to achieve what Junio 
suggested.

> >  * Who are early birds and who are late night owls?  Who are day-job
> >   contributors and who are weekenders?
> 
> Sounds like a 'fun feature', but how about timezones?
> I'm not sure how commit times are recorded, in UTC, if so, does it
> also record their timezone?

Timezones are recorded as epoch (seconds since Jan 1, 1970) and timezone.  
So yes, you have that, _provided_ you trust the users to set up that thing 
correctly.

I, for one, do not change the timezone on my laptop, just because I happen 
to be travelling through the air at high altitude...

> >  * Identify "buggy commits" from history, without testing.  Zeroth order
> >   approximation is that the lines it introduced were later rewritten by
> >   other later commits, but the later ones are not necessarily fixes but
> >   can be enhancements, so you would need a way to tell which ones are
> >   "fixing commits" and which ones are not.  You may want to use project
> >   specific hints to help you doing this:
> 
> A feature like this would fit well with the other "buggy
> commit/maintainer detection" but would require a lot of customization.
> However, considering git already comes with a good customization
> system it should still be feasible.

Yes.  And it would be really interesting for me.  Until it shows that I am 
the biggest offender, of course.

> >   * For the integrator, can you spot a pattern like "what he accepts
> >     during weekdays tend to be buggier than what he applies during
> >     weekends"?
> 
> That would be interesting data, I think a nice graph could be made
> easily, showing a column for weekdays (or one for each day) and a
> column for weekends (or one for each day). Each column could then
> represent the amount of buggy commits / day, or perhaps the ration
> buggy/enhancements. This histogram could then go back several weeks to
> give a better picture.
> Perhaps a line style graph with two lines could be made, one for the
> weekends and one for the weekdays, or seven lines, one for each day.
> That way it would be easy to track if the integrator is getting better
> at his job, or that he is perhaps having a bad/good period lately.

I think the bigger problem is not visualising it, but finding what is 
buggy, and what not.

> The question now though, is which of these features are feasible to do 
> in one GSoC project? That is, which one should be done first, as I want 
> to finishing this feature even if I can't finish it all in three months. 
> Should this be something that is decided in the application already, or 
> should I list all the features and then later on decide (with the aid of 
> the community) which ones to implement first.

I think it can be vague about the order in which things will be 
implemented.  And the features which you think might be too complicated 
should be marked as such: "possible extension (which might not be finished 
within this project): <blabla>".

Ciao,
Dscho
