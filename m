From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 22:30:35 -0400
Message-ID: <20070715023035.GX4436@spearce.org>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com> <46994BDF.6050803@alum.mit.edu> <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, esr@thyrsus.com,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	dev <dev@cvs2svn.tigris.org>
To: David Frech <david@nimblemachines.com>
X-From: dev-return-2052-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sun Jul 15 04:30:46 2007
Return-path: <dev-return-2052-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9tsi-00018c-DV
	for gcvscd-dev@gmane.org; Sun, 15 Jul 2007 04:30:44 +0200
Received: (qmail 22105 invoked by uid 5000); 15 Jul 2007 02:30:42 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 22094 invoked from network); 15 Jul 2007 02:30:42 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAP4jmUZAJhTik2dsb2JhbACPOwEBAgcEBgcGGg
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="62162868:sNHT23014775"
X-IRONPORT: SCANNED
Content-Disposition: inline
In-Reply-To: <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
Sender: spearce@spearce.org
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - cvs2svn.tigris.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52523>

David Frech <david@nimblemachines.com> wrote:
> Now I want to switch to git. I've since added enough to svn that there
> is no option but to use th svn repo as my source. git-svnimport
> doesn't work for me because its idea of the structure of my repo is
> too limited. I looked around, stumbled over fast-import, and got
> hooked on the idea of using it. It seemed simple enough... I wrote a
> 350-line Lua (!!) program that parses the svn dump file and creates a
> commit stream for fast-import.
> 
> It took a day and half to get the svn dump parsing right (it's an
> egregiously bad format) but only a couple of hours to write the
> fast-import backend.

With the 'C' (copy) and 'R' (rename) operators in fast-import I was
starting to suspect that an SVN dump->fast-import stream translator
wasn't going to be that complex.

I wouldn't want to attempt to parse the SVN dump format directly
in fast-import.  As you said the format is horribly difficult
to read.  The entire fast-import stream parser is only 624 lines
of C (the other 1,636 lines of fast-import are for documentation,
the in memory tree/branch management and packfile generation).
I doubt the SVN dump file can be parsed in as few lines of C code.

-- 
Shawn.
