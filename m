From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sat, 24 Jan 2009 14:42:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901241438370.13232@racer>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>  <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>  <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>  <831vuvfh7t.fsf@kalahari.s2.org>  <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
  <83wscndv57.fsf@kalahari.s2.org> <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hannu Koivisto <azure@iki.fi>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 14:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQipD-0001qp-Up
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 14:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZAXNl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 08:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbZAXNl5
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 08:41:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:40957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbZAXNl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 08:41:56 -0500
Received: (qmail invoked by alias); 24 Jan 2009 13:41:54 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp049) with SMTP; 24 Jan 2009 14:41:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2jz9tafS2A5d1H1xNIfB3TTPOpTxafP89qJo97a
	gf40BlKe21Da7E
X-X-Sender: gene099@racer
In-Reply-To: <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106965>

Hi,

On Sat, 24 Jan 2009, Felipe Contreras wrote:

> On Thu, Jan 22, 2009 at 8:59 PM, Hannu Koivisto <azure@iki.fi> wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
> >>> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>>
> >>>> This brings back my previous question: where is the home directory in
> >>>> a Windows system?
> >>>
> >>> It's where %HOMEDRIVE%%HOMEPATH% points to.
> >>
> >> I thought it was something like that. Do we want something like that
> >> in the manual, or should we assume Windows users know that?
> >
> > I should have added that Unix programs (i.e. Cygwin programs and
> > even some native ports) probably use %HOME% which may be different
> > from %HOMEDRIVE%%HOMEPATH%.  I recall that if you haven't
> > explicitly set up HOME in Windows environment, Cygwin sets it up
> > magically from passwd or falls back to %HOMEDRIVE%%HOMEPATH%.  I
> > have no idea if msysgit respects %HOME% if it is set or always uses
> > %HOMEDRIVE%%HOMEPATH% or something completely different (user
> > profile, most likely).
> >
> > It certainly may be that "home directory" is a foreign concept to
> > some Windows users.  Some might know it as a user profile or a
> > personal folder (just guessing, I'm pretty isolated from less
> > experienced Windows users), even though user profile is a separate
> > concept from "home directory" (note that there is %USERPROFILE%
> > which by default is the same as %HOMEDRIVE%%HOMEPATH% at least in
> > XP).
> >
> > In any case, what Cygwin git does should be expected by Cygwin
> > users.  If msysgit wanted to be a really native Windows application
> > and store the configuration where Microsoft thinks it should be
> > stored, it probably shouldn't store the config under "home
> > directory" to begin with (I'm guessing that's what it does) but
> > under %USERPROFILE\Application Data\Git (...FILE\Local
> > Settings\... in case non-roaming storage is wanted).  And in that
> > case the manual might be misleading for msysgit users.  See
> > e.g. <http://msdn.microsoft.com/en-us/library/ms995853.aspx>.
> 
> Isn't that enough argument to stop assuming the user knows where is
> the "home directory"?

Why does it appear as if we always have to bend over for Windows?  That is 
really frustrating.

In any case, the only thing the user would need to know the location of 
$HOME for is for .gitconfig.  And for Windows users I suggest using the 
dialog in git gui (for the variables that are editable there), which 
should cover most of what the user needs.  For everything else, they 
should use "git config".

Because if you really start with explaining where the home can be on 
Windows, you would also have to cover why "%USERPROFILE%" does not work in 
Git bash.  And before you know what is happening, you have a big ass 
Windows chapter in the user manual that revolves around anything except 
Git.

Ciao,
Dscho
