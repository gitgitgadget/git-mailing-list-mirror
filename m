From: Andrew Morton <akpm@linux-foundation.org>
Subject: Untracked working tree files
Date: Wed, 15 Oct 2008 11:56:54 -0700
Message-ID: <20081015115654.fb34438f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 20:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBZS-0004XO-1T
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 20:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbYJOS45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbYJOS45
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 14:56:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54999 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752181AbYJOS45 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 14:56:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FIutaf003279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 11:56:56 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9FIutmg022746
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 11:56:55 -0700
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.869 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often get this (running git 1.5.6.rc0 presently):

y:/usr/src/git26> git-checkout linux-next
error: Untracked working tree file 'arch/x86/kernel/apic.c' would be overwritten by merge.

which screws things up.  I fix it by removing the offending file, which
gets irritating because git bails out after the first such instance, so
I need to rerun git-checkout once per file (there are sometimes tens of them).

Should this be happening?  I don't know what causes it, really.  All
I've been doing in that directory is running `git-checkout' against
various maintainers' trees.  95% of the time this works OK but
eventually git seems to get all confused and the above happens.

Is there some way in which I can work around this with a single command
rather than having to run git-checkout once per offending file?  I
suppose a good old `rm -rf *' would do it...

Thanks.
