From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 16:53:07 -0700
Message-ID: <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	<7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdHR-0002u7-W2
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbXCNXxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933382AbXCNXxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:53:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46973 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933380AbXCNXxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:53:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314235307.YJWS321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 19:53:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ant71W00T1kojtg0000000; Wed, 14 Mar 2007 19:53:07 -0400
In-Reply-To: <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	(Alex Riesen's message of "Thu, 15 Mar 2007 00:14:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42253>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Now I'm happy :)
>
> ~/linux$ time git diff-tree -r -s v2.6.16 v2.6.20
>
> real    0m0.137s
> user    0m0.117s
> sys     0m0.020s
> ~/linux$ time ~/projects/git-diff/git-diff-tree -r --quiet v2.6.16 v2.6.20
>
> real    0m0.006s
> user    0m0.000s
> sys     0m0.007s

You do not need diff-tree --quiet to do that!

	$ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}
