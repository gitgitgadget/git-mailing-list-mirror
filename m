From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Introducing git-run-with-user-path program.
Date: Mon, 16 May 2005 16:21:35 -0700
Message-ID: <7v8y2en4e8.fsf@assigned-by-dhcp.cox.net>
References: <7vu0l3puzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:22:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXotf-0003oA-QH
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVEPXVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEPXVj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:21:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42381 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261309AbVEPXVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 19:21:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516232135.KSIL550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 19:21:35 -0400
To: pasky@ucw.cz, torvalds@osdl.org
In-Reply-To: <7vu0l3puzg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 15 May 2005 23:04:19 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've polished the driver part a bit more, so that it can do
something similar to "git-ls-files --others" can do, but with
the (to-be-defined) "ignore rules Porcelain layers would agree
upon". 

 [PATCH 1/2] Introduce git-run-with-user-path helper program.
 [PATCH 2/2] Add sample ignore logic to git-run-with-user-path command.

The first one adds a path canonicalization helper with path
ignore hooks but no ignore logic implementation (it passes
everything that passes verify_path()).  The second one adds a
sample ignore logic implementation using PCRE.

Although the second one is done primarily as an example and to
start a mailing list discussion, it should be also safe to merge
if you decide to take patch 1, because the logic is used only by
git-run-with-user-path which is a new program. no Porcelain uses
right now.

