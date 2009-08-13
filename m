From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 23:51:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908132350190.8306@pacific.mpi-cbg.de>
References: <20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> <20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302>
 <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> <20090813172508.GO1033@spearce.org> <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com> <20090813174119.GP1033@spearce.org> <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com>
 <20090813175211.GQ1033@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:51:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiCg-0001ul-V1
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbZHMVvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbZHMVvO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:51:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:57779 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752123AbZHMVvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:51:13 -0400
Received: (qmail invoked by alias); 13 Aug 2009 21:51:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 13 Aug 2009 23:51:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182fXJSWYY2dc4OGQwhWzmKlI7WD1yH6FjF4NGhQp
	Mw9amHBV/1XTss
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090813175211.GQ1033@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125880>

Hi,

On Thu, 13 Aug 2009, Shawn O. Pearce wrote:

> Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > On Thu, Aug 13, 2009 at 10:41, Shawn O. Pearce<spearce@spearce.org> wrote:
> > > Uh, no, if we have "option import-marks=..." and we can't find the
> > > file "..." and we have no --import-marks command line flag that
> > > would have overridden it, we need to abort with an error.
> > 
> > Ah, then how about in option_import_marks() we only store the name of
> > the file, like in option_export_marks, and at the end, when we reach
> > the first non-option command (and we've parsed argv), we read the
> > file. That way it's only read once, and it deals with the above
> > scenario.
> 
> That's better.  :-)

Sorry if I spoil the party, but maybe if things get so complicated, it may 
be a sign that the original version (stream overrides command line, since 
it knows better) is to be preferred?  After all, if hg fast-export says 
that the marks should be imported from a certain file, it may be for a 
_very good_ reason...

Ciao,
Dscho
