From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 22:22:03 -0400
Message-ID: <20070715022203.GW4436@spearce.org>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <EC3B307E-EA83-4128-BABD-D9BDB78F987E@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Simon Hausmann <simon@lst.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	dev <dev@cvs2svn.tigris.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: dev-return-2051-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sun Jul 15 04:22:21 2007
Return-path: <dev-return-2051-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9tkY-0008LO-5o
	for gcvscd-dev@gmane.org; Sun, 15 Jul 2007 04:22:18 +0200
Received: (qmail 9865 invoked by uid 5000); 15 Jul 2007 02:22:14 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 9852 invoked from network); 15 Jul 2007 02:22:14 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAC4hmUZAJhTik2dsb2JhbACPOwEBAgcEBgcGGg
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="62162682:sNHT109714899"
X-IRONPORT: SCANNED
Content-Disposition: inline
In-Reply-To: <EC3B307E-EA83-4128-BABD-D9BDB78F987E@zib.de>
Sender: spearce@spearce.org
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - cvs2svn.tigris.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52522>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Jul 14, 2007, at 7:09 PM, Michael Haggerty wrote:
> >Martin Langhoff wrote:
> >>On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >>>Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking  
> >>>about
> >>>what it would take to write some other back ends for cvs2svn-- 
> >>>turning
> >>>it, essentially, into cvs2xxx.  Most of the work that cvs2svn  
...
> >>
> >>Great to hear that. I'm game if we can do something in this direction
> >>- surely we can make it talk to fastimport ;-)
> >
> >We added some hooks to cvs2svn 2.0 to start working in this direction.
> >But I don't really know what information is needed for a git import.
> >One quick-and-dirty idea that I had was to have cvs2svn output
> >information compatible with cvsps's output, as I believe that several
> >tools rely on cvsps to do the dirty work and so could perhaps be
> >persuaded to use cvs2svn out of the box.
> 
> From my understanding, piping data to git fast-import would be
> a sane gateway to git. The input format of fast-import is document
> in [1].
> 
> Maybe Shaw Pearce has some comments on that. Shawn did most
> (maybe all) of the work on git-fast-import.

You must be new to this discussion.  ;-)

git-fast-import started as a backend for a hacked up version of
cvs2svn that Jon Smirl was working on to convert the massive Mozilla
CVS repository into Git.  Jon started from the cvs2svn codebase
because it best handled the damaged RCS files that exist in the
Mozilla repository.  Many emails have been exchanged between myself,
Michael and Jon on this subject.

So yes, git-fast-import was designed to act as a backend behind
something like cvs2xxx.  Some of the "oddities" of the fast-import
input language are the way they are partly because of the way
the (older) cvs2svn code generated output in SVN dump format.
Certain data was available at certain times and not at others,
so Jon wanted to feed it to git-fast-import when he had it, rather
than needing to buffer it or rearrange code.

I'm staying far away from writing fast-import frontends.  Anyone that
wants/needs a CVS frontend is welcome to implement one, but it
won't written be me.  I gave up CVS a long time ago and will never
return to it.  My only VCS is Git, and converting Git->Git is sort
of stupid.  So I have no need for a fast-import frontend.

But I do maintain fast-import.  Well over 99% of it was written
by me.  ;-)

-- 
Shawn.
