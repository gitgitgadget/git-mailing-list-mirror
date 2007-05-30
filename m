From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 22:57:05 -0400
Message-ID: <20070530025705.GN7044@spearce.org>
References: <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com> <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com> <Pine.LNX.4.64.0705291446170.4648@racer.site> <465C3502.BE134BC9@eudaptics.com> <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com> <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl> <Pine.LNX.4.64.0705300337510.4011@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 30 04:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtENE-0007QM-E2
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXE3C5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXE3C5P
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:57:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42450 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbXE3C5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:57:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtEMq-0004V1-IE; Tue, 29 May 2007 22:56:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 699CD20FBAE; Tue, 29 May 2007 22:57:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705300337510.4011@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48727>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> BTW Almost any operation I run in git-gui fails, because cat is
> not found.

That's the stuff that goes into a console and dumps both to
stdout and stderr.  E.g. fetch, push, "compress database".

The issue is Tcl doesn't give me a way to get a pipe to both stdout
and stderr.  I cannot get two pipes, nor can I get a single pipe
with both stdout+stderr redirected to that pipe.  Unless I pipe
it into another process.  Enter `cat`.

Would we consider a "--stderr-to-stdout" long option to git itself?
Then I could have git-gui do:

	git --stderr-to-stdout fetch

and bypass the pipe into cat.  Yes, I know, its crap.  Welcome to
Tcl.

-- 
Shawn.
