From: Junio C Hamano <junkio@cox.net>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Thu, 07 Jul 2005 18:24:45 -0700
Message-ID: <7vk6k2dr8i.fsf@assigned-by-dhcp.cox.net>
References: <1119994003.9631.6.camel@localhost.localdomain>
	<m31x6acdcl.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 03:26:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqhdU-0007Kz-4C
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 03:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGHB0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 21:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGHB0D
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 21:26:03 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33990 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261393AbVGHBYr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 21:24:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708012445.CRGI8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 21:24:45 -0400
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m31x6acdcl.fsf@telia.com> (Peter Osterlund's message of "08 Jul 2005 03:10:02 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PO" == Peter Osterlund <petero2@telia.com> writes:

PO> I think it would be good if it was possible to include diffstat output
PO> in exported patches, something like this:

PO> Added possibility to include diffstat output in exported patches.

And you wuold want to do things similarly to what others have
already done.  git-resolve-script uses "git-apply --stat" there,
instead of "diffstat", so people without diffstat installed can
still get the same information.

Even if you want to stick to "diffstat", at least I would
suggest giving -p1, not -p0, to it; otherwise you would see b/
like what you have there.

PO>  b/stgit/git.py  |   22 ++++++++++++++++++++++
PO>  b/stgit/main.py |    2 ++
PO>  2 files changed, 24 insertions(+)

Further, using "git-apply --stat --summary" would be nicer; this
is something you cannot do with plain "diffstat".
