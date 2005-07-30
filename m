From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 13:56:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507301354000.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <m31x5gob8k.fsf@telia.com>
 <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org> <m3fytwm313.fsf@telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 23:01:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyySv-00080w-Q4
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 23:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVG3VB1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 17:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbVG3U6v
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 16:58:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263165AbVG3U4X (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 16:56:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6UKuHjA008751
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 13:56:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6UKuGVh012173;
	Sat, 30 Jul 2005 13:56:16 -0700
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3fytwm313.fsf@telia.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Peter Osterlund wrote:
> 
> OK, but note that I didn't do any editing of any local files myself.
> Both commit ids are from your public linux kernel git tree. What I did
> was equivalent to:
> 
> 1. rsync from rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> 2. waited a day or so.
> 3. git-pull-script from the same kernel.org repository.
> 
> Is it expected that you end up with merge conflicts in this case?

Nope. Something went wrong.

> I think it should be possible to just fast forward to the new HEAD in
> this situation.

Indeed.

Can you send me your HEAD and MERGE_HEAD (don't do the merge).

Sounds like maybe "git-merge-base" is confused, and thinks HEAD is not
reachable from FETCH_HEAD. It could have a similar bug git-rev-list had.

			Linus
