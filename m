From: Junio C Hamano <junkio@cox.net>
Subject: Re: index manipulation -- how?
Date: Mon, 21 Nov 2005 23:05:48 -0800
Message-ID: <7vbr0dgo1f.fsf@assigned-by-dhcp.cox.net>
References: <20051122062048.8891.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 08:28:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeSDx-0007nJ-5j
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 08:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVKVHFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 02:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVKVHFu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 02:05:50 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33211 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932143AbVKVHFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 02:05:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122070550.UCEQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 02:05:50 -0500
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12532>

Luben Tuikov <ltuikov@yahoo.com> writes:

> (There is a very similar construct in git-checkout.sh.
> So if you apply the patch below, please make sure
> git-checkout.sh doesn't break.)

Thanks.

> Question: so in effect, more generally:
>   git checkout <tree-ish> <file>
>
> would do the right thing: update index and the working
> tree as the file <file> looked as it was at <tree-ish>?

Yes that is correct.  Also by omitting <tree-ish> you can
checkout from the index.

I thought what you originally wanted to do was revert only index
without losing your changes from the working tree, so just to
make sure, the above does _not_ do it --- the named file in the
working tree is also reverted to the one from <tree-ish>.
