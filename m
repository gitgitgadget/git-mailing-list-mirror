From: esr@thyrsus.com (Eric S. Raymond)
Subject: Re: CVS -> SVN -> Git
Date: Sun, 15 Jul 2007 09:36:55 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20070715133655.GA9302@thyrsus.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com> <46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com> <469A0D54.8010303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: dev-return-2057-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sun Jul 15 15:37:18 2007
Return-path: <dev-return-2057-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IA4Hl-0007wb-Ld
	for gcvscd-dev@gmane.org; Sun, 15 Jul 2007 15:37:18 +0200
Received: (qmail 10735 invoked by uid 5000); 15 Jul 2007 13:37:13 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 10721 invoked from network); 15 Jul 2007 13:37:13 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAABbAmUZHovMFemdsb2JhbACPPAEB
X-IronPort-AV: i="4.16,540,1175497200"; 
   d="scan'208"; a="77339700:sNHT18225396"
X-IRONPORT: SCANNED
Content-Disposition: inline
In-Reply-To: <469A0D54.8010303@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.12-2006-07-14
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52550>

Michael Haggerty <mhagger@alum.mit.edu>:
> For example, cvs2svn internally deduces which files should be added to a
> given branch in a given commit.  But the information cannot be output to
> SVN in that form.  Instead, cvs2svn has to figure out which
> *directories* to copy to the branch directory, then which files to
> remove from the copied directory (because they shouldn't have been
> tagged), and which other files to copy from other sources.  This extra
> work, which is quite time- and space-consuming, is worse than pointless
> when converting to git, because git has to invert the process to figure
> out which individual files have to be tagged!

OK, that's a fair point.  I might have known the showstopper would be
somewhere near Subversion's tags-are-directories assumption.  And this
also neatly explains why I didn't see any problems or poor performance
during my recent conversions; the projects I was lifting had no tags.

> The interface between the two halves does not necessarily need to be a
> serialized data stream; it could just as well be via the Python API that
> is used internally by cvs2svn to access the reconstructed commits and
> supporting databases.  This would require the second half to be written
> in Python, but otherwise would be very flexible and would avoid the need
> to find a be-all serialized format.

Or...wait for it...the generator for the serialized format could be one
of the back ends!   Probably a good idea to have for debugging reasons, 
if nothing else.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
