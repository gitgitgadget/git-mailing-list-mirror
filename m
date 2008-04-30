From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Broken commit 72269ad9564b700e6aab30338e35b4e6ffea854d
Date: Wed, 30 Apr 2008 11:04:08 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804301101130.2980@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:05:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrGgG-0003Qt-SW
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYD3SEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 14:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbYD3SEg
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 14:04:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47678 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222AbYD3SEf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2008 14:04:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3UI49Qx026676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Apr 2008 11:04:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3UI48f2027351;
	Wed, 30 Apr 2008 11:04:08 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80861>


.. and more embarrassingly, it's attributed to me, although I'm pretty 
sure it wasn't buggy when I sent it out.

The code in builtin-fetch-pack.c now reads

	if (commit->object.parsed)
		parse_commit(commit);

which is obviously totally insane. There's a '!' missing.

		Linus
