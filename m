From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect run: "skip" current commit if script exit code is 125.
Date: Sat, 27 Oct 2007 07:02:31 +0200
Message-ID: <200710270702.31923.chriscool@tuxfamily.org>
References: <20071026053937.2831a89b.chriscool@tuxfamily.org> <A43880E9-E496-48AA-BC1C-2C98DFD12370@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Oct 27 06:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ildi8-0008Rp-JA
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 06:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbXJ0Ezg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 00:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbXJ0Ezg
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 00:55:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40381 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbXJ0Ezf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Oct 2007 00:55:35 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 65A5C1AB2BC;
	Sat, 27 Oct 2007 06:55:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 49F1F1AB2B0;
	Sat, 27 Oct 2007 06:55:33 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <A43880E9-E496-48AA-BC1C-2C98DFD12370@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62460>

Le vendredi 26 octobre 2007, Benoit SIGOURE a =E9crit :
> On Oct 26, 2007, at 5:39 AM, Christian Couder wrote:
> >
> > +The special exit code 125 should be used when the current source c=
ode
> > +cannot be tested. If the "run" script exits with this code, the
> > current
> > +revision will be "skip"ped, see `git bisect skip` above.
> > [...]
>
> Since exit 77 is already used by automake to mean "skip", wouldn't it
> be better to do the same thing here?

I don't think 77 is better, first because for automake this is to ignor=
e=20
some non portable test results "in environments where they don't make=20
sense", so if we "bisect run" the same test script and it returns 77 on=
ce,=20
it will probably returns 77 everytime because the environment will not =
have=20
changed after a new revision has been checked out.

Also there is:

$ grep 77 /usr/include/sysexits.h
#define EX_NOPERM       77      /* permission denied */

and a search for "include <sysexits.h>" in http://www.google.com/codese=
arch=20
returns a lot of results.

Christian.
