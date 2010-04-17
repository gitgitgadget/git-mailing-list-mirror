From: Sebastian Bober <sbober@servercare.de>
Subject: Re: [spf:guess] Re: [spf:guess] Re: Git import of the recent full
	enwiki dump
Date: Sat, 17 Apr 2010 09:48:53 +0200
Message-ID: <20100417074853.GE32053@post.servercare.de>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com> <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com> <20100417004852.GA32053@post.servercare.de> <20100417005342.GA8475@spearce.org> <20100417010147.GB32053@post.servercare.de> <1271468696.3302.35.camel@denix> <20100417015857.GD32053@post.servercare.de> <1271475292.3506.53.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 09:49:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O32mG-0006Va-Bu
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 09:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab0DQHtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 03:49:00 -0400
Received: from tix64.net ([81.169.172.224]:35176 "EHLO
	h4945.serverkompetenz.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0DQHs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 03:48:59 -0400
Received: from bob by h4945.serverkompetenz.net with local (Exim 4.69)
	(envelope-from <sbober@servercare.de>)
	id 1O32lp-0007rs-IM; Sat, 17 Apr 2010 09:48:53 +0200
Mail-Followup-To: Sebastian Bober <sbober@servercare.de>,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
Content-Disposition: inline
In-Reply-To: <1271475292.3506.53.camel@denix>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-bounce-key: tix64.net-1;sbober@servercare.de;1271490539;08179fb5;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145121>

On Sat, Apr 17, 2010 at 03:34:52PM +1200, Sam Vilain wrote:
> On Sat, 2010-04-17 at 03:58 +0200, Sebastian Bober wrote:
> > > Without good data set partitioning I don't think I see the above
> > > workflow being as possible.  I was approaching the problem by first
> > > trying to back a SQL RDBMS to git, eg MySQL or SQLite (postgres would be
> > > nice, but probably much harder) - so I first set out by designing a
> > > table store.  But the representation of the data is not important, just
> > > the distributed version of it.
> > 
> > Yep, we had many ideas how to partition the data. All that was not tried
> > up to now, because we had the hope to get it done the "straight" way.
> > But that may not be possible.
> 
> I just don't think it's a practical aim or even useful.  Who really
> wants the complete history of all wikipedia pages?  Only a very few -
> libraries, national archives, and some collectors.

Heh, exactly. And I just want to see, if it can be done.

> > We have tried checkpointing (even stopping/starting fast-import) every
> > 10,000 - 100,000 commits. That does mitigate some speed and memory
> > issues of fast-import. But in the end fast-import lost time at every
> > restart / checkpoint.
> 
> One more thought - fast-import really does work better if you send it
> all the versions of a blob in sequence so that it can write out deltas
> the first time around.

This is already done thah way.

> Another advantage of the per-page partitioning is that they can
> checkpoint/gc independently, allowing for more parallelization of the
> job.
> 
> > > Actually this raises the question - what is it that you are trying to
> > > achieve with this wikipedia import?
> > 
> > Ultimately, having a distributed Wikipedia. Having the possibility to
> > fork or branch Wikipedia, to have an inclusionist and exclusionist
> > Wikipedia all in one.
> 
> This sounds like far too much fun for me to miss out on, now downloading
> enwiki-20100312-pages-meta-history.xml.7z :-) and I will give this a
> crack!


Please have a look at a smaller wiki for testing, and the project at

  git://github.com/sbober/levitation-perl.git

provides several ways to parse the XML and to generate the fast-import
input in its branches.


bye,
  Sebastian
