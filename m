From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Fri, 4 May 2007 23:30:39 -0400
Message-ID: <20070505033039.GD16538@spearce.org>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 05 05:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkAyv-00037n-VG
	for gcvg-git@gmane.org; Sat, 05 May 2007 05:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031727AbXEEDaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 23:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031729AbXEEDaq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 23:30:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52599 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031727AbXEEDap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 23:30:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HkAyb-0002cI-N5; Fri, 04 May 2007 23:30:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D294420FBAE; Fri,  4 May 2007 23:30:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705050324580.4015@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46238>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 4 May 2007, Dana How wrote:
> 
> > Most commands accept relative paths,  but this is
> > not true of arguments in ent:path format.  This
> > patch makes all of the following git-show commands
> > work in the git source tree (not just the first):
> >  % cd xdiff
> >  % git-show v1.5.2-rc0:xdiff/xemit.h
> >  % git-show v1.5.2-rc0:./xemit.h
> >  % git-show v1.5.2-rc0:../sha1_name.c
> 
> ACK.

Double ACK.  I'm in complete agreement with every point Dscho has
made in this thread, even if I haven't quoted it.  ;-)

I *really* do not want to see "<tree-ish>:<path>" to mean include
the current prefix, *especially* when a bare repository is involved.

I often either do ad-hoc git-show lines against bare repositories,
or have scripts that depend on this existing absolute path behavior.
I'd like to see those not break.  ;-)

Since "." and ".." should not be valid names in any tree of a Git
repository I think we're OK to say that ":./" and ":../" are to
imply relative to current prefix.  But if we do ":../" then we also
have to do ":../../../../../../.." ;-)

-- 
Shawn.
