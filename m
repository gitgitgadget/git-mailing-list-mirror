From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate() 
 instead of unsigned
Date: Sat, 24 Jan 2009 17:58:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901241757140.13232@racer>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>  <alpine.DEB.1.00.0901240726070.13232@racer> <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 17:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQlqa-0004an-O9
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 17:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbZAXQ5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 11:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755457AbZAXQ5k
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 11:57:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:60946 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755440AbZAXQ5j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 11:57:39 -0500
Received: (qmail invoked by alias); 24 Jan 2009 16:57:37 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp037) with SMTP; 24 Jan 2009 17:57:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qs7JlFCdqC8mKcRWqg/+Z5oukJ1lQAewASnMkHo
	rBB7ArqrmR+5n7
X-X-Sender: gene099@racer
In-Reply-To: <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106976>

Hi,

On Sat, 24 Jan 2009, Tim Henigan wrote:

> On Sat, Jan 24, 2009 at 1:27 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 22 Jan 2009, Tim Henigan wrote:
> >
> > > Use time_t for timestamps returned by approxidate() instead of 
> > > unsigned long.  All references to approxidate were checked as well 
> > > as references to OPT_DATE.
> >
> > Hmm.  I vaguely remember Linus mentioning recently that unsigned long 
> > is the appropriate data type for the Unix Epoch...
> 
> You are correct. I just found a post on this list where Linus 
> specifically rejected a similar patch from another contributor.  A quote 
> from https://kerneltrap.org/mailarchive/git/2008/11/6/4014124:
> 
>     " "time_t" is one of those totally broken unix types. The standards 
>     say that it's an "arithmetic" type, but leaves it open to be just 
>     about anything. Traditionally, it's a signed integer (bad), and in 
>     theory it could even be a floating point value, I think.
> 
>     And in _all_ such cases, it's actually better to cast it to 
>     "unsigned long" than keep time in a system-dependent format that is 
>     most likely either _already_ "unsigned long", or alternatively 
>     broken."

Thanks.  I should have searched that post myself, but I was too tired...

> Should I update the GitWiki page to remove this Janitor task or do you
> keep it as a test to see if people are properly searching the mail
> archives?

Yes, please!

> Sorry to waste your time on the patch review.

Sorry that we wasted your time by letting that page go stale...

Ciao,
Dscho
