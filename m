From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fsck: add --lost-found option
Date: Tue, 3 Jul 2007 00:26:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707030018120.4071@racer.site>
References: <Pine.LNX.4.64.0707021751380.4071@racer.site>
 <7vabuewgdb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:26:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5VI4-00021m-S8
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbXGBX0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756650AbXGBX0m
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:26:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:59982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756493AbXGBX0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:26:41 -0400
Received: (qmail invoked by alias); 02 Jul 2007 23:26:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 03 Jul 2007 01:26:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SWddNmgTSQcxSp8cTwc0q9XKnpoWnX2dloib+EO
	SSUkyilQXcIZAd
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabuewgdb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51429>

Hi,

On Mon, 2 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With this option, dangling objects are not only reported, but also 
> > written to .git/lost-found/commit/ or .git/lost-found/other/.
> >
> > This obsoletes git-lost-found.
> 
> [...]
> 
> Please do not do that in a single patch.  This patch is at least
> talking about three timeframes.

Right. My fault.

>  1. git-fsck learns --lost-found
>     The patch adds that to the code and the documentation.
>     Then it is commented on, perhaps updated, and matures.
> 
>  2. git-lost-found is marked as "deprecated"
>     This patch adds "deprecated" warning to the documentation.

How about combining these two, and give a big

	WARNING: 'git lost-found' is deprecated.
	WARNING: Use 'git fsck --lost-found' instead

whenever lost-found is called?

>  3. git-lost-found is removed.

Yes, that can wait.

What is more important before doing 1&2 for real is this: lost-found ATM 
calls 'git-fsck --full --no-reflogs'. The patch does not force these two 
options when called with '--lost-found'. I would really appreciate 
opinions on this issue, and will gladly re-prepare a patch accordingly.

Ciao,
Dscho
