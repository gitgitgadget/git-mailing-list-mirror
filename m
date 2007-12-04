From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Mon, 3 Dec 2007 20:55:11 -0500
Message-ID: <20071204015511.GX14735@spearce.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203040108.GS14735@spearce.org> <7vmyssqrhk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzN0b-0006q7-1I
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbXLDBzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbXLDBzQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:55:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49008 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXLDBzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:55:15 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IzN02-0003kN-KU; Mon, 03 Dec 2007 20:55:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C6C4420FBAE; Mon,  3 Dec 2007 20:55:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmyssqrhk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66990>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This probably requires exporting the name of the ref we currently
> > have locked in an environment variable (and teach lockfile.c it)
> > so we can effectively do recursive locking.  That way the update
> > hook can still use git-update-ref to change the ref safely.
> 
> Heh, I like that, although I suspect getting this right would mean the
> topic should be post 1.5.4 (which I do not mind).  

Yea, most likely.

Also I won't have any time in the near future to work on this
implementation myself.  I threw the idea out there in case someone
else can find the time.  I'm willing to do the work myself as I think
its the right approach to use here for this update hook change, but
I just don't see myself getting to it anytime before say Christmas...

Its slightly more involved then what Steven originally proposed,
but I think it solves the problem better and gives us more room
for future improvements where we may want/need something such as
a recursive ref locking.

-- 
Shawn.
