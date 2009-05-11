From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JGIT PATCH 2/2] Decrease the fetch pack client buffer to the lower minimum
Date: Sun, 10 May 2009 20:51:01 -0700
Message-ID: <7vr5yws3fe.fsf@alter.siamese.dyndns.org>
References: <1241995685-13260-1-git-send-email-spearce@spearce.org>
	<1241995685-13260-2-git-send-email-spearce@spearce.org>
	<7vfxfctqon.fsf@alter.siamese.dyndns.org>
	<20090511005526.GI30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 11 05:51:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3MXo-0006lp-Ba
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 05:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbZEKDvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 23:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZEKDvD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 23:51:03 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:65191 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbZEKDvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 23:51:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511035102.JJXJ17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 May 2009 23:51:02 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id q3r11b00E4aMwMQ033r1pR; Sun, 10 May 2009 23:51:01 -0400
X-Authority-Analysis: v=1.0 c=1 a=68f4PgtGCZ0A:10 a=wvpHRPnWvyEA:10
 a=oAYF_C9AAAAA:8 a=1phqnl2m7T0vJiWvRMgA:9 a=VMfrbIzHmLHmPvVXFu0A:7
 a=tr_oAN0uHeWPtXJ7HkbuRRqLKbIA:4 a=R0wQ3QzoQ0IA:10
X-CM-Score: 0.00
In-Reply-To: <20090511005526.GI30527@spearce.org> (Shawn O. Pearce's message of "Sun\, 10 May 2009 17\:55\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118771>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In step 3 during the first round the client can send up to 2 blocks
> worth of data, with 32 haves per block.  This means the client
> writes 2952 bytes of data before it reads.

Sorry, perhaps I am being extremely slow, but even if the client writes
millions of bytes before it starts reading, I do not see how it would be a
problem as long as the other side reads these millions of bytes before
saying "Ok, I've heard about them and my response so far is Ack-continue
(or NAK)", which the client needs to read.
