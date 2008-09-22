From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do not perform cross-directory renames when creating
 packs
Date: Mon, 22 Sep 2008 10:31:47 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809221029240.3265@nehalem.linux-foundation.org>
References: <1222104021-28277-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhpIM-0003vM-QE
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 19:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYIVRct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 13:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbYIVRct
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:32:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40244 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100AbYIVRcs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 13:32:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8MHVmCl027284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Sep 2008 10:31:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8MHVmJa020900;
	Mon, 22 Sep 2008 10:31:48 -0700
In-Reply-To: <1222104021-28277-1-git-send-email-pasky@suse.cz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.434 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96499>



On Mon, 22 Sep 2008, Petr Baudis wrote:
>
> A comment on top of create_tmpfile() describes caveats ('can have
> problems on various systems (FAT, NFS, Coda)') that should apply
> in this situation as well.  This in the end did not end up solving
> any of my personal problems, but it might be a useful cleanup patch
> nevertheless.

Side note: the cross-directory avoidance for loose object creation _did_ 
seem to clear up the original problems reported on NFS, so yes, this is 
worth doing. Even if pack-file creation is such a heavy event that I 
suspect that none of the timing/caching/whatever issues that were present 
for loose objects really ever trigger in practice.

> Signed-off-by: Petr Baudis <pasky@suse.cz>

Looks obvious enough. So:

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

		Linus
