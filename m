From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 02:27:00 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121127072700.GA23169@thyrsus.com>
References: <20121115212818.GA21558@thyrsus.com>
 <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
 <20121126220108.GB1713@thyrsus.com>
 <CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
 <20121126234359.GA8042@thyrsus.com>
 <CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 08:27:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdFZq-0007lN-3q
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 08:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264Ab2K0H1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 02:27:12 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54757
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab2K0H1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 02:27:11 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C4B9340665; Tue, 27 Nov 2012 02:27:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210536>

=46elipe Contreras <felipe.contreras@gmail.com>:
> I believe that log file is much more human readable. Yet I still fail
> to see why would anybody want so much detail only to import tarballs.

The first time I needed such a tool (and I really should have built it =
then)=20
was during the events I wrote up in 2010 the INTERCAL Reconstruction Ma=
ssacree;
full story at <http://esr.ibiblio.org/?p=3D2491>  Note in particular th=
e
following paragraphs:

    Reconstructing the history of C-INTERCAL turned out to be something=
 of
    an epic in itself. 1990 was back in the Dark Ages as far as version
    control and release-management practices go; our tools were
    paleolithic and our procedures likewise. The earliest versions of
    C-INTERCAL were so old that even CVS wasn=E2=80=99t generally avail=
able yet
    (CVS 1.0 didn=E2=80=99t even ship until six months after C-INTERCAL=
 0.3, my
    first public release). SCCS had existed since the early 1980s but w=
as
    proprietary; the only game in town was RCS. Primitive, file-oriente=
d
    RCS.

    I was a very early adopter of version control; when I wrote
    Emacs=E2=80=99s VC mode in 1992 the idea of integrating version con=
trol
    into normal workflow that closely was way out in front of current
    practice. Today=E2=80=99s routine use of such tools wasn=E2=80=99t =
even a gleam in
    anyone=E2=80=99s eye then, if only because disks were orders of mag=
nitude
    smaller and there was a lot of implied pressure to actually throw
    away old versions of stuff. So I only RCSed some of the files in
    the project at the time, and didn=E2=80=99t think much about that.

    As a result, reconstructing C-INTERCAL=E2=80=99s history turned int=
o about two
    weeks of work. A good deal of it was painstaking digital archeology=
,
    digging into obscure corners of the net for ancient release tarball=
s
    Alex and I didn=E2=80=99t have on hand any more. I ended up stitchi=
ng together
    material from 18 different release tarballs, 11 unreleased snapshot
    tarballs, one release tarball I could reconstruct, one release tarb=
all
    mined out of an obsolete Red Hat source RPM, two shar archives, a p=
ax
    archive, five published patches, two zip files, a darcs archive, an=
d
    my partial RCS history, and that=E2=80=99s before we got to the aer=
ial
    photography. To perform the surgery needed to integrate this, I wro=
te
    a custom Python program assisted by two shellscripts, topping out a=
t a
    hair over 1200 lines of code.

The second time was much more recent and concerned a project called
(seriously) robotfindskitten.  This code existed as a partial CVS=20
repository created by someone other than the original author,
and some disconnected tarballs from before the repo.  The author
has requested that I knit the tarballs and the CVS history (which
is now in git) into one repository.

In both cases the object was to assemble a coherent history=20
from all the available metadata as if the projects had been using
version control all along.

I know of at least one other group of disconnected tarballs, of a
program called xlife, that is likely to need similar treatment. It's
not an uncommon situation for projects over a certain age, and there is
lots of code like xlife dating from before the mid-1990s waiting for
someone to pick up the pieces.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
