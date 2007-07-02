From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fsck: add --lost-found option
Date: Mon, 02 Jul 2007 16:11:28 -0700
Message-ID: <7vabuewgdb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707021751380.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:11:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3P-00086c-Sx
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140AbXGBXLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757082AbXGBXLb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50314 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046AbXGBXL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231128.VMXA1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBU1X00C1kojtg0000000; Mon, 02 Jul 2007 19:11:28 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51421>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this option, dangling objects are not only reported, but also
> written to .git/lost-found/commit/ or .git/lost-found/other/.
>
> This obsoletes git-lost-found.

I haven't had chance to look at the code yet; this is only about
the design.

I think adding --lost-found to fsck is a wonderful idea.  I also
think deprecating lost-found and removing it in the longer term
is a good idea.

Please do not do that in a single patch.  This patch is at least
talking about three timeframes.

 1. git-fsck learns --lost-found
    The patch adds that to the code and the documentation.
    Then it is commented on, perhaps updated, and matures.

 2. git-lost-found is marked as "deprecated"
    This patch adds "deprecated" warning to the documentation.

 3. git-lost-found is removed.
