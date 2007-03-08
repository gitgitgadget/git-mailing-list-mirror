From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: Make thin packs
Date: Thu, 8 Mar 2007 01:56:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703080149320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com>  <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com>  <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com>  <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  <45EE36A1.30001@gmail.com>  <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
 <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703071516330.5963@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703071632140.5963@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 01:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP6wX-0006tU-0C
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 01:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXCHA4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbXCHA4c
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 19:56:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:44300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932166AbXCHA4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 19:56:30 -0500
Received: (qmail invoked by alias); 08 Mar 2007 00:56:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 08 Mar 2007 01:56:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8u+NBAEr842Zpvehwh/YfQesQgHp+4fR6KKrRuJ
	H2SLS9SfnmqzVd
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703071632140.5963@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41709>

Hi,

On Wed, 7 Mar 2007, Linus Torvalds wrote:

> Does anybody actually use shallow clones in real life?

I don't. That's why I work on push/fetch from/via/into shallow repos.

> When I did the numbers a long time ago, the shallow clone didn't 
> actually help much, because it meant that there were no deltas. Which 
> meant that you got 1% of the history for 60% of the price of all 
> history, and the shallow thing didn't really seem to make much sense.
> 
> I guess that for something with a really long history, you'd get 0.001% 
> of the history for 10% of the price, and maybe it makes sense then.

You -- being blessed by not having to work with anything closed -- miss an 
important fact of commercial software development. Most, if not all, 
projects in a commercial setting contain binary blobs. For example, a DLL, 
or a PNG, or a Firmware blob. These are updated regularly. And they delta 
really awfully bad.

Also, for something as OpenOffice or Mozilla, I guess that if you really 
only want to work on the newest revision, the _initial_ fetch will be way 
cheaper than a full clone. Of course I have no numbers here, but that is 
what my gut feeling says.

Naturally, over time, the shallow clone will fetch in more and more 
objects from the upstream, eventually being almost as large as if having 
the complete history, but the user's experience is different: the amount 
of time needed to get that amount of data is much more widely spread.

Ciao,
Dscho
