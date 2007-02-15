From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT 1.5.0 binary installer available.
Date: Thu, 15 Feb 2007 20:11:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151954480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D44FD5.72299A3A@eudaptics.com> <45D48FF5.2060800@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Feb 15 20:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHm0r-0006vM-R4
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 20:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691AbXBOTLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 14:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030692AbXBOTLW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 14:11:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:51822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030691AbXBOTLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 14:11:21 -0500
Received: (qmail invoked by alias); 15 Feb 2007 19:11:20 -0000
X-Provags-ID: V01U2FsdGVkX1/ddqdVF3bdUlM2+aTHlNupSIHLbX0bS4q7RVELZg
	1Ezw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D48FF5.2060800@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39843>

Hi,

On Thu, 15 Feb 2007, Han-Wen Nienhuys wrote:

> Johannes Sixt escreveu:
> > I've merged GIT 1.5.0 into the MinGW port. It is available at the usual
> > location:
> > 
> > pull/clone: git://repo.or.cz/git/mingw.git
> > gitweb:     http://repo.or.cz/w/git/mingw.git
> > 
> > It contains an important fix (MinGW specific): Earlier versions could
> > sometimes create temporary files read-only instead of read-writable.
> 
> I've uploaded a binary installer to
> 
> http://lilypond.org/git/binaries/mingw/
> 
> (untested, and will need magic to get the bash scripts 
> working)

Yes, indeed. And not only the bash scripts: AFAICT the command line option 
parsing is borked: whatever I do, a

	sh -c "git-config -l"

from cmd does not pick up the option "-l". Which is funny, since a simple 
test program (outputting just the options passed to it) works. And so does 
"git-config -l" from "cmd".

Could you please try making an installer which includes an exe for this 
simple program?

-- snip --
#include <stdio.h>

int main(int argc, char **argv)
{
        int i;

        for (i = 0; i < argc; i++)
                printf("arg %d: %s\n", i, argv[i]);
        return 0;
}
-- snap --

Other than that, I'd go the git-gui way. For this, not only many of the 
tools in MinGW (such as cat, expr, etc., and maybe even perl) are needed, 
but also a wish. Happily, you can download that just fine:

http://prdownloads.sf.net/mingw/tcltk-8.4.1-1.exe?download

I already made a minimal change to git-gui so you can choose the directory 
to start from.

Ciao,
Dscho
