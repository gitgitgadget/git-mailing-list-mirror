From: Jeff King <peff@peff.net>
Subject: Re: git gc error - cannot lock ref 'RENAMED-REF..1'
Date: Sat, 3 Apr 2010 00:22:11 -0400
Message-ID: <20100403042211.GA22150@coredump.intra.peff.net>
References: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
 <g2x76c5b8581004011908r35cbaf3au545b7f11bd6db8fc@mail.gmail.com>
 <u2s76c5b8581004022038rf8aa0017l5dea55689c738fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 06:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxusc-0002C7-Ot
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 06:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab0DCEWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 00:22:25 -0400
Received: from peff.net ([208.65.91.99]:46404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab0DCEWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 00:22:24 -0400
Received: (qmail 23171 invoked by uid 107); 3 Apr 2010 04:23:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 03 Apr 2010 00:23:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Apr 2010 00:22:11 -0400
Content-Disposition: inline
In-Reply-To: <u2s76c5b8581004022038rf8aa0017l5dea55689c738fd9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143877>

On Fri, Apr 02, 2010 at 11:38:03PM -0400, Eugene Sajine wrote:

> On Thu, Apr 1, 2010 at 10:08 PM, Eugene Sajine <euguess@gmail.com> wr=
ote:
> > Hi,
> >
> > I was running git gc weekly on my machine and today for some reason=
 it
> > failed on one of my repos with an error saying
> >
> > Error: cannot lock ref =E2=80=98RENAMED-REF..1=E2=80=99
> > Error: failed to run ref-log
> >
> > The problem is I have no idea what it is talking about=E2=80=A6 =E2=
=80=9Cgit show-ref=E2=80=9D
> > doesn=E2=80=99t show anything even close to this name. Fools day jo=
ke?;)
> > Any advice?

If you look in the .git directory, is there a file named RENAMED-REF..1=
?
I have no idea how you would create such a ref, nor why it would fail t=
o
lock (perhaps because of the funny name?), but removing it should
probably clear up your problem at least.

The name "RENAMED-REF" is only used by git during ref renames, and thos=
e
only happen when renaming branches (via "git branch -m") or remotes (vi=
a
"git remote rename"). So presumably the source of the problem is relate=
d
to one of those operations.

-Peff
