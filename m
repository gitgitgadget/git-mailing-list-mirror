From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (resend)] gitweb: Fix bug in "blobdiff" view for split (e.g. file to symlink) patches
Date: Thu, 05 Apr 2007 13:47:01 -0700
Message-ID: <7v3b3epn0a.fsf@assigned-by-dhcp.cox.net>
References: <1175773541251-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZYrM-00016Y-Qu
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 22:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767306AbXDEUrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767136AbXDEUrF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 16:47:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60567 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767306AbXDEUrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 16:47:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405204702.LVZS27119.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 16:47:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jYn11W00L1kojtg0000000; Thu, 05 Apr 2007 16:47:01 -0400
In-Reply-To: <1175773541251-git-send-email-jnareb@gmail.com> (Jakub Narebski's
	message of "Thu, 5 Apr 2007 13:45:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43853>

Jakub Narebski <jnareb@gmail.com> writes:

> git_patchset_body needs patch generated with --full-index option to
> detect split patches,...
> ...
> This patch fixes this bug in git_blobdiff (in "blobdiff" view).
>
> Junio, you probably have missed this patch in the noise...

Probably.  Although I do remember seeing the patch, it was
unclear why --full-index is needed (and it still is unclear to
me).  Do you have a parser that expects/depends on full
40-hexdigit hash on the index line?

Not a complaint but a question -- I do not mind (actually prefer,
probably) if gitweb worked on full 40-hexdigit internally to
avoid possible ambiguity issues, although the output may need to
be truncated to save people from having to see unneeded precision.
