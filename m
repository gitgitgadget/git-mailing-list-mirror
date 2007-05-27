From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 02:39:02 -0400
Message-ID: <20070527063902.GB28023@spearce.org>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <Pine.LNX.4.64.0705262318190.4648@racer.site> <4658BA64.2050904@xs4all.nl> <f3agkk$bhn$1@sea.gmane.org> <4659259D.4000803@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 08:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsCPL-0006wV-T3
	for gcvg-git@gmane.org; Sun, 27 May 2007 08:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbXE0GjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 02:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXE0GjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 02:39:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39546 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbXE0GjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 02:39:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HsCP9-0000yf-Td; Sun, 27 May 2007 02:39:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A9D5120FBAE; Sun, 27 May 2007 02:39:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4659259D.4000803@xs4all.nl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48521>

Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> Jakub Narebski escreveu:
> 
> >> Instead, we have a Makefile that relies on an esoteric combination of
> >> perl and shell scripting inside Makefiles.
> > 
> > The idea is to be able to get reasonable defaults (depending on system of
> 
> This saves the user on Linux or similar platform one ./configure call. For
> the rest it means editing makefiles. I'm not sure if that is an improvement
> over the standard 
> 
>   configure ; make ; make install

[side note: can you please not send both To the list and CC the
list on the same message?  Pick one, we're all getting two copies
of messages from you.]

On systems like Cygwin the fork+exec overheads are very high;
running a "simple" configure script can take longer than it
takes me to compile Git from scratch.  Editing config.mak is
quite easy; so is passing your choices on the command line to
`make install`.

Personally I find:

	make NO_CURL=1 install

easier than:

	./configure --without-curl && make install

-- 
Shawn.
