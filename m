From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Allow cherry-picking root commits
Date: Fri, 4 Jul 2008 18:41:41 +0200
Message-ID: <20080704164141.GA28515@leksak.fem-net>
References: <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness> <20080704015326.GI6677@leksak.fem-net> <alpine.DEB.1.00.0807041617320.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 18:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEoMz-0001gD-7P
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 18:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYGDQlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYGDQlw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 12:41:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:51404 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754007AbYGDQlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 12:41:51 -0400
Received: (qmail invoked by alias); 04 Jul 2008 16:41:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp012) with SMTP; 04 Jul 2008 18:41:49 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/slxo80D7sz4yuGYrVUWeOfwIBXN76wWBIo36wpQ
	NQGIkp+rYBSQtd
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEoLt-0004Oh-TI; Fri, 04 Jul 2008 18:41:41 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807041617320.9925@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87401>

On Fri, Jul 04, 2008 at 04:19:52PM +0100, Johannes Schindelin wrote:
> 	Anyhow, I give up on trying to convince you.

Great :)
Big thanks for the patch!

It also works with my rebase-i variant with just an unimportant "fatal"
which can be shut up by
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -211,7 +211,7 @@ pick_one () {
 		;;
 	cherry-pick,*)
 		# fast forward
-		if test "$(git rev-parse --verify "$1^")" = \
+		if test "$(git rev-parse --verify "$1^" 2>/dev/null)" = \
 			"$(git rev-parse --verify HEAD)"
 		then
 			perform git reset --hard "$1"
###

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
