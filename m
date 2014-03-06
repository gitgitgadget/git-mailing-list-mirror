From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone
 menu.
Date: Thu, 6 Mar 2014 23:00:34 +0100
Message-ID: <20140306220034.GA30645@sandbox-ub>
References: <1393974076.7891.27.camel@Naugrim>
 <5317662C.6010404@web.de>
 <1394064956.7891.28.camel@Naugrim>
 <5318CE14.1090000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henri GEIST <geist.henri@laposte.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLgSJ-0007rK-5L
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 23:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaCFWHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 17:07:44 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:45201 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbaCFWHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 17:07:41 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Mar 2014 17:07:41 EST
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WLgLG-00076I-Pt; Thu, 06 Mar 2014 23:00:38 +0100
Content-Disposition: inline
In-Reply-To: <5318CE14.1090000@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243563>

On Thu, Mar 06, 2014 at 08:35:48PM +0100, Jens Lehmann wrote:
> Am 06.03.2014 01:15, schrieb Henri GEIST:
> > Le mercredi 05 mars 2014 =E0 19:00 +0100, Jens Lehmann a =E9crit :
> >> Am 05.03.2014 00:01, schrieb Henri GEIST:
> >> - Wouldn't it be easier to pass the '--recurse-submodules"
> >>   option to the "git clone" call for the superproject instead
> >>   of adding the _do_clone_submodules() function doing a
> >>   subsequent "git submodule update --init --recursive"? That
> >>   is also be more future proof with respect to the autoclone
> >>   config option we have in mind (which would add that behavior
> >>   for "git clone" itself, making the call you added redundant).
> >=20
> > That is what I planned to do at beginning.
> > But git-gui never call git clone anywhere.
> > It make the clone step by step with a long and complicated list of
> > commands just like a Tcl rewrite of git-clone.
> > Have a look on the function _do_clone2 in choose_repository.tcl.
>=20
> You're right, it does fetch followed by read-tree ... so my
> proposal doesn't make much sense here, sorry for bothering you
> without checking the source first.
>=20
> > As I suspect there should be a good reason for this that I did not
> > understand I have choose to not refactoring it.
>=20
> That makes sense. Shawn, could you shed some light on why clone
> is coded again using plumbing in git gui instead of just calling
> the clone command?

I think because git gui is using plumbing everywhere, it is supposed to
be just another porcelain. And I guess that was an intended decision
because porcelain might change its output and break git gui. At least
thats what I inferred.

Cheers Heiko
