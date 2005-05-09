From: Thomas Gleixner <tglx@linutronix.de>
Subject: History messup
Date: Mon, 09 May 2005 16:59:31 +0000
Organization: linutronix
Message-ID: <1115657971.19236.33.camel@tglx>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:11:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVBTn-0005lW-Ny
	for gcvg-git@gmane.org; Mon, 09 May 2005 18:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVEIQ6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 12:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVEIQ6y
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 12:58:54 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1410
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261158AbVEIQ6v
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 12:58:51 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id F029965C003;
	Mon,  9 May 2005 18:56:25 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 9EDB52829B;
	Mon,  9 May 2005 18:58:45 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I wrote a git repository tracker, which can track and coordinate
multiple git repositories. Before it goes public, I want to clarify a
problem which I encountered

The commit bfd4bda097f8758d28e632ff2035e25577f6b060 
by David Woodhouse (Thu May 5 12:59:37 2005 +100)  
Merge with
master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 

breaks the history.

David merged from Linus repository . Linus synced later with David.
Linus did not create a new commit for this update and just pointed his
"HEAD" to Davids "HEAD", which means he forked Davids repository at this
point.

Due to that the parent->parent history is not longer unique. This makes
it impossible to do file revision graphs over the various repositories
in the correct order.

Is this a unique problem or is the omission of a commit in cases like
that usual practice ? In the latter case proper history tracking is
almost impossible.

tglx


