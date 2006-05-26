From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Fri, 26 May 2006 06:32:59 +0200
Message-ID: <20060526043258.GA4508@c165.ib.student.liu.se>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com> <20060526011153.GA27720@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 26 06:33:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjU0b-00015S-Ba
	for gcvg-git@gmane.org; Fri, 26 May 2006 06:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWEZEdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 00:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWEZEdF
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 00:33:05 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:30908 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1030397AbWEZEdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 00:33:04 -0400
Received: from c165 ([213.114.27.111] [213.114.27.111])
          by mxfep01.bredband.com with ESMTP
          id <20060526043302.LNLR19930.mxfep01.bredband.com@c165>;
          Fri, 26 May 2006 06:33:02 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FjU0S-0001rb-00; Fri, 26 May 2006 06:33:00 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060526011153.GA27720@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20792>

On Thu, May 25, 2006 at 09:11:53PM -0400, Shawn Pearce wrote:
> Stefan Pfetzing <stefan.pfetzing@gmail.com> wrote:
> > Hi,
> > 
> > for some reason I could not yet figure out, t8001-annotate.sh fails at test 
> > 18.
> > 
> > --- snip ---
> > *   ok 17: some edit
> > * expecting success: check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
> > Author A (expected 1, attributed 1) good
> > Author B1 (expected 1, attributed 1) good
> > Author D (expected 1, attributed 2) bad
> > Author A U Thor (expected 1, attributed 1) good
> > Author B2 (expected 1, attributed 1) good
> > Author B (expected 1, attributed 1) good
> > * FAIL 18: some edit
> >        check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
> > * failed 1 among 18 test(s)
> 
> I've been seeing the same failed test case for a long time now on
> my own Mac OS X system.  I think it has to do with the "git blame"
> vs. "git annotate" war which never really happened.
> 
> I think we had hoped that one of the two tools would prove to be
> _the_ annotation/blame tool and would get used but thus far that
> hasn't happened.  Since they are two different implementations
> they also differ slightly over how they attribute a change across
> a merge, and in this case annotate is producing a different result
> from blame - but that different result isn't considered to be wrong
> so it hasn't been changed in annotate.  Meanwhile the test has stayed
> broken as a reminder that these two generate different results.
>

I have planned to come up with a nice test suite for blame/annotate,
but I haven't got around to it yet.

I don't see this test failure on my Debian system. But it is true that
for some cases different blame/annotate outputs are equally correct,
however not in this case. Note that the incomplete line is attributed
to the commit with author D, but this commit did clearly not introduce
that line. The only correct answer, for that particular line, is the
commit with author C.

- Fredrik
