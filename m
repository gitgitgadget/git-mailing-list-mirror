From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 10:26:20 -0500
Message-ID: <20070118152620.GB15428@spearce.org>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net> <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net> <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com> <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com> <45AF7FE8.5060003@op5.se> <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Josh Boyer <jwboyer@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 16:26:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Z9q-00023V-2B
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXARP02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXARP02
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:26:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52144 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbXARP01 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:26:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7Z9d-0000wA-EO; Thu, 18 Jan 2007 10:26:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BB86320FBAE; Thu, 18 Jan 2007 10:26:20 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37107>

Alex Riesen <raa.lkml@gmail.com> wrote:
> don't think so. I _would_ cry seeing how fork(2) gets ported to Windows,
> and you will, probably... after seeing how it is done in cygwin.

AFAIK there's not a strong reason to keep fork() in Git.

Currently anytime we fork a process its to perform a small amount
of file descriptor redirection and then immediately exec some other
executable, or a hook script.  In other words we probably could
convert all current uses of fork to something like in run-command.c,
which a Windows port could then easily replace using CreateProcess().

But removing fork isn't worth doing until someone is seriously
trying to port Git onto Windows without Cygwin.  The current code
works on sane OSes and isn't broken, so why fix it?
 
-- 
Shawn.
