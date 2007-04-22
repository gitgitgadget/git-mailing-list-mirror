From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver definition.
Date: Sat, 21 Apr 2007 23:00:38 -0400
Message-ID: <20070422030038.GF17480@spearce.org>
References: <11771520591529-git-send-email-junkio@cox.net> <11771520591703-git-send-email-junkio@cox.net> <20070422003929.GD17480@spearce.org> <7vbqhhrw7m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 05:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfSJs-0001EN-9Z
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 05:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXDVDAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 23:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050AbXDVDAn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 23:00:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38119 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbXDVDAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 23:00:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfSJR-0007vF-DS; Sat, 21 Apr 2007 23:00:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6295E20FBAE; Sat, 21 Apr 2007 23:00:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vbqhhrw7m.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45211>

Junio C Hamano <junkio@cox.net> wrote:
> Well, I did not like start_command() that wanted to always
> perform the full exec of something else for its inflexibility,
> and this piles a specific hack on top of it...  Why not a
> callback with void * pointer?

Well, that's because its always used to execute some external
program.  And some operating system designers once upon a time
thought that was the only way anyone would ever need to start a
new parallel thread of execution.  ;-)

But why do you want a callback here in start_command() given
that all you are doing is running a filter command anyway?
Is that so you could start a "thread" to handle the stdin
pipe?

-- 
Shawn.
