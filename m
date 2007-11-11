From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui messes up the diff view on non ASCII characters
Date: Sun, 11 Nov 2007 11:20:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111120120.4362@racer.site>
References: <20071109154935.GC28800@xp.machine.xx> <200711092230.37905.barra_cuda@katamail.com>
 <20071111055959.GW14735@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1524843730-1194780043=:4362"
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	Peter Baumann <waste.manager@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 12:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrAso-00062j-LM
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 12:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXKKLV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 06:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbXKKLV1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 06:21:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:43567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752937AbXKKLVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 06:21:25 -0500
Received: (qmail invoked by alias); 11 Nov 2007 11:21:24 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 11 Nov 2007 12:21:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19o2k0ZI8BoemAEfzmyC30K5fs5EsI574Ihy36H4m
	AcjZ02Gnnxs0t1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071111055959.GW14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64447>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1524843730-1194780043=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 11 Nov 2007, Shawn O. Pearce wrote:

> Michele Ballabio <barra_cuda@katamail.com> wrote:
> > On Friday 09 November 2007, Peter Baumann wrote:
> > > I'm managing some UTF-8 encoded LaTeX files in git, which include some
> > > non ASCII characters like the german ä,ö and ü. If I view the diff with
> > > git-diff on an UTF8 enabled terminal, all looks nice. So does the diff
> > > view in gitk after I commited my changes. Only git-gui shows some
> > > "strange" characters, so I assume it is an encoding problem.
> > > 
> > > I have to admit that I'm totally unaware how this should work, but at
> > > least I think my configuration is correct here, because otherwise git-diff
> > > or gitk would show the same behaviour. Is there anything which could be
> > > done to make git-gui happy, too?
> > 
> > It's a known issue, and already on Shawn's ToDo list. I have to add that
> > viewing untracked UTF8 files in git-gui works just fine. Weird.
> 
> Cute.  That's because in the untracked case we open the file and
> let the platform's chosen encoding be used to convert it into the
> text viewer.  In the tracked diff case we force the encoding to
> be in binary.
> 
> Now gitk works because it assumes the diff is in the same character
> encoding as the commit message itself.  Since commit messages are
> typically in UTF-8 (as that is the Git default encoding) then a
> UTF-8 encoded file shows correctly in gitk.
> 
> What's the right behavior here?  Just assume the platform encoding
> is correct for the file we are showing and show it?  Assume the
> commit encoding configured in i18n.commitencoding is the correct
> one for the file content?  Something else?

My twopence: assume utf-8, but make it a _git-gui_ config variable.

Ciao,
Dscho

--8323584-1524843730-1194780043=:4362--
