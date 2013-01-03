From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Thu, 03 Jan 2013 16:37:51 +0100
Message-ID: <50E5A5CF.2070009@alum.mit.edu>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@free.fr>, Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 16:38:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqms7-00083x-HK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 16:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3ACPh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 10:37:59 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60769 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167Ab3ACPh5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 10:37:57 -0500
X-AuditID: 12074413-b7f786d0000008bb-16-50e5a5d43b5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 41.AE.02235.4D5A5E05; Thu,  3 Jan 2013 10:37:56 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r03Fbqtv009887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 Jan 2013 10:37:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121222173649.04C5B44119@snark.thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsUixO6iqHtl6dMAg6MTVS1+nd3FYtH49x6T
	xc72G6wWV7f4WHRd6WayWPn4LrPFkm+z2S12zF3F5sDhcezsY2aP16unsXr0r/vM6rFz1l12
	j/b375g9bn38yuax7Gsni8fnTXIBHFHcNkmJJWXBmel5+nYJ3Bl3V79kK5jtVjGn7wRLA+NW
	iy5GTg4JAROJpjdrWCFsMYkL99azdTFycQgJXGaUeLlsCTOEc4xJ4sYeiCpeAW2Jkwcfs4PY
	LAKqEqc63oDZbAK6Eot6mplAbFGBAInFS86xQ9QLSpyc+YQFxBYRUJf4cOQo2FBmgX+MErf2
	3QVrEBawl+ho/A/WICRgKfHx5CSwOKeAlcSpnxALmAV0JN71PWCGsOUltr+dwzyBUWAWkh2z
	kJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIjAjvYNx1Uu4Q
	owAHoxIP75qaJwFCrIllxZW5hxglOZiURHnfzn0aIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d3Y+UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJME7YQlQo2BRanpq
	RVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoWuOLgfEKkuIB2tsO0s5bXJCYCxSFaD3FaMzR
	8PLGU0aOWw03nzIKseTl56VKifO2gJQKgJRmlObBLYIlx1eM4kB/C/POA6niASZWuHmvgFYx
	Aa169eYxyKqSRISUVANj2YGE814cnIqOG7mdjj/WObIkvzvpbqPusfm/Ofd+afm8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212591>

On 12/22/2012 06:36 PM, Eric S. Raymond wrote:
> * One is Michael Haggerty's cvs2git.  I had bad experiences with the
> cvs2svn code it's derived from in the past, but Michael believes those
> problems have been fixed and I will accept that - at least until I can
> test for myself.  Its documented interface is not quite good enough
> yet; as the documentation says, "The data that should be fed to git
> fast-import are written to two files, which have to be loaded into git
> fast-import manually."

There are two good reasons that the output is written to two separate files:

1. The files are generated during different passes of cvs2git, and since
the cvs2git conversion is restartable pass-by-pass, the first file might
only need to be generated once even while the user is iterating on
adjustments to other conversion options.

2. The first ("blobfile") contains blob definitions for file revisions,
which are read out of the RCS files in the order they are held in the
RCS file.  This is vastly faster than reading the file revisions in the
order that they are needed for git commits because (1) all revisions for
a file can be computed from one serial read of the RCS file; (2) there
is no need to jump around from rcsfile to rcsfile.  The second
("dumpfile") stitches the blobs together into git commits by referring
to the blobs that are needed.  This file is smaller because it doesn't
contain the actual file contents.  Another advantage of this approach is
that a blob need only appear once in the blobfile even if it is used
multiple times in the git history.

Anyway, surely cat'ing two output files together is not such a difficult
problem?

A potentially bigger problem is that if you want to handle such
blob/dump output, you have to deal with git-fast-import format's "blob"
command as opposed to only handling inline blobs.  However, if that is a
problem, it is possible to configure cvs2git to write the blobs inline
with the rest of the dumpfile (this mode is supported because "hg
fast-import" doesn't support detached blobs).  You would have to create
an options file that uses GitRevisionInlineWriter, similar to what is
done in cvs2hg-example.options.

> [...]
> Having three different tools for this job seems to me duplicative and
> pointless; two of them should probably be let die an honorable death.
> I don't actually care which of the three survives - and, in
> particular, if I determine that cvs2git is doing the best job of the
> three I am quite willing to declare end-of-life for cvsps and
> parsecvs.  It's not like I don't have plenty of other projects to work
> on.

cvs2git does not currently support incremental conversions; therefore, a
cvsps-based option (if it would actually work, that is) would have at
least one advantage over cvs2git.

> I presently know of three test suites other than mine. One was built
> by Heiko to test cvsps, another lives in the git t/ directory, and the
> third is cvs2git's. I haven't looked at cv2git's yet, but the others
> are not in their present form suited to where I am taking cvsps and
> parsecvs.  Heiko's relies on the default human-readable cvsps format,
> which I consider obsolete and uninteresting.  The git tests are
> dependent on details of porcelain behavior.  I think it would be
> better to test import-stream output.

cvs2svn has an extensive test suite which includes tests derived from
bug reports that we have received over the years.  I adapted a few of
its test repositories to create the git test suite additions that I made
in Feb 2009, but there are many more in our project.

A lot of our test suite deals with additional conversion features, like:

* Re-encoding filenames, usernames, and log messages from whatever
happens to have been used in the CVS repository into UTF-8

* Fixing CVS branches, tags, and mixed branch/tag messes according to
user wishes; renaming branches and tags

* Allowing the user to influence the choice of which branch should serve
as the source for another branch/tag (CVS records this information very
ambiguously)

* Fixing binary vs. text files, expanding/contracting CVS keywords, etc.

* Removing lots of synthetic revisions and other cruft generated by CVS
to fit within the RCS file format

* Dealing with vendor branches in a sensible way, especially considering
that very many users misuse vendor branches for initial imports

* Dealing with various common types of CVS repository corruption

See our list of features [1] for more details.  Presumably many of these
features would not be covered by your test framework, and are not
supported by the other conversion tools.

Unfortunately, our tests are mostly based on cvs2svn (i.e., not 2git);
that is, the conversion is done with cvs2svn and checked by verifying
the contents of the resulting Subversion repository.

The script contrib/verify-cvs2svn.py is another kind of test; it checks
every branch and tag out of CVS and the destination repository and
verifies that their contents are identical.  This script is intended to
be used by users to check their own conversion.  Please note that it
doesn't check the history, only the branch/tag tips.  But this script
works with both Subversion and git (at least it should; it probably
doesn't get tested much).

> Here is what I propose.  Let's build a common test suite that cvs2git,
> git-cvsimport, cvsps, and parsecvs can all use, apply it rigorously,
> and let the best tool win.  (This would mean, among other things, that
> git can stop carrying things that are essentially cvsps tests in its
> tree.)

I think it would be great to have a way to test across tools, though
please realize that the inference of the most plausible "true" CVS
history is partly objective but also often a matter of heuristics and
taste.  Moreover, the choice of how to represent the inferred history in
git, which has rather a different model than CVS/Subversion, is also
non-obvious and somewhat controversial.  I expect that there will be a
number of simple CVS repositories for which we can all agree about the
correct git output, but not far away will be a vast number for which the
"correct" answer is unclear.  Many of the interesting tests would fall
into the latter category.

> The two people I most need to sign off on this are, I guess, Michael
> Haggerty and either Junio Hamano or whoever specifically owns
> git-cvsimport and its tests.  [...]

It's not clear what you want me to sign off on.  I guess you want to
replace (or augment?) the cvs2svn test suite with one based on your
framework?  Right off the top of my head I can think of a few
considerations from the point of view of the cvs2svn project:

* We definitely want to continue testing the Subversion output of
cvs2svn.  A test suite that only tests the git output could at best be
an addition to the current test suite, not a replacement for it.  (That
being said, the addition of good tests of the 2git output would be great.)

* A test suite that tests only the easy cases wouldn't really be
interesting, because the difficult cases are where the potential
problems lie.

* It would be unfortunate if the cvs2svn test suite would grow another
run-time dependency or if we would have to invest a lot of time
synchronizing with another project, though if the gain were big enough
we could consider it.

* The licenses obviously have to be compatible to the extent required by
the level of coupling.

* I don't have a lot of time to work on the integration.  cvs2svn has
long been at a level of maturity where it doesn't need much care and
feeding, and I would like to keep it that way :-)  Nowadays I am far
more interested in working on the git project with my little available
open-sourcin' time.


Rereading this email, I realize that it is not clear to me why your new
testing project needs the "signoff" or cooperation from any of the
conversions tool projects (git-cvsimport or cvs2svn or parsecvs or ...)
in the first place.  The essence of your project will be a collection of
CVS test repositories, and code that can read the conversion output
(whether via git or as fast-input data) and verify that it matches
expectations (right?).  Presumably it will have a place where any of the
conversion tools could be plugged into it, and perhaps a bit of code
that knows how to configure and run the best-known tools (and perhaps
even to download and build them).

It would seem natural to me that your project stops there, and stays at
arms-length from the conversion projects.  If your test suite proves
itself to be obviously better than the cvs2svn test suite, then we might
try to integrate it *then* (or not; even then it wouldn't really be
obligatory).

Michael

[1] http://cvs2svn.tigris.org/features.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
