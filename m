From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-merge-file: refuse to merge binary files
Date: Mon, 04 Jun 2007 22:16:52 -0700
Message-ID: <7vwsyjgeuz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706050337010.4046@racer.site>
	<alpine.LFD.0.98.0706042059420.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 07:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvRPh-0000gm-Go
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 07:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXFEFQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 01:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbXFEFQy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 01:16:54 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35721 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbXFEFQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 01:16:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605051654.QGGB12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Jun 2007 01:16:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7hGs1X00U1kojtg0000000; Tue, 05 Jun 2007 01:16:53 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49161>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I really think this would be better off using the crlf-like heuristics.
>
> It's entirely possible that the "NUL character in the first X bytes" 
> heuristic is wrong for some cases, so I find it a bit nasty to hardcoding 
> it as the only rule for "it must be binary"
>
> 		Linus

On the other hand that hardcoded fallback is consistent with
diff, which is closely related to xdl_merge().  Attributes can
be specified to override this anyway, so...
