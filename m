From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 3 Jul 2006 15:56:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232958.GC2513@lsrfire.ath.cx> <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 03 15:56:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxOuy-0001I0-BR
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 15:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWGCN4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 09:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWGCN4t
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 09:56:49 -0400
Received: from mail.gmx.de ([213.165.64.21]:29887 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750835AbWGCN4s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 09:56:48 -0400
Received: (qmail invoked by alias); 03 Jul 2006 13:56:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 03 Jul 2006 15:56:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23177>

Hi,

On Mon, 3 Jul 2006, Junio C Hamano wrote:

> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> 
> > Don't care if objects have been parsed or not and don't stop when we
> > reach a commit that is already clean -- its parents could be dirty.
> 
> There is something quite wrong with this patch.

I always had the feeling that it was wrong to traverse not-yet-parsed 
parents: How could a revision walk possibly come to a certain commit 
without at least one continuous history of now-parsed objects?

Also, AFAIK the revision walk sets flags for each commit it touched, and 
we should not try to be smart-asses about the flags, but just unset these 
flags.

BTW some very quick tests showed that the clear_commit_marks() thing that 
I sent to the list was much faster than traversing all objects (which was 
in my original version).

Ciao,
Dscho
