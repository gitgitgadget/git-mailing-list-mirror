From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] git-commit: Add --no-status option
Date: Fri, 7 Sep 2007 00:15:57 +0200
Message-ID: <20070906221557.GA20575@steel.home>
References: <20070905234953.GB643@nomad.office.altlinux.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITPdw-0007j3-Mi
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbXIFWQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 18:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbXIFWQB
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:16:01 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:41068 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbXIFWQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 18:16:00 -0400
Received: from tigra.home (Fcaf2.f.strato-dslnet.de [195.4.202.242])
	by post.webmailer.de (fruni mo62) (RZmta 12.7)
	with ESMTP id v023ccj86K7w6V ; Fri, 7 Sep 2007 00:15:58 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 42AC8277BD;
	Fri,  7 Sep 2007 00:15:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BD27DBEB6; Fri,  7 Sep 2007 00:15:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070905234953.GB643@nomad.office.altlinux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj5dag=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57936>

Dmitry V. Levin, Thu, Sep 06, 2007 01:49:53 +0200:
> By default, git-commit runs git-runstatus to print changes between
> the index and the working tree.  This operation is very costly and
> is not always necessary.  New option allows user to commit without
> running git-runstatus when appropriate.

Not a very good name for the option. Noone, except for a few, knows
that git-commit runs runstatus. The name makes no sense.

"git-commit --index", perhaps (the current state of index to be
commited). Or "git-commit --prepared" (the commit is prepared and
there can be stored immediately). Even a dumb "--fast" would be
better (because it is the purpose of the patch).

Besides, now when you disabled runstatus, you better check for changes
in the index with something like "git diff --quiet --cached".
