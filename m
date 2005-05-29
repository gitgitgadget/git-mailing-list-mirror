From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sun, 29 May 2005 11:56:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505291154030.10545@ppc970.osdl.org>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 20:52:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSt6-0003a2-BY
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVE2SyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVE2SyP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:54:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:24208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261403AbVE2SyL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:54:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4TIs6jA017607
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 29 May 2005 11:54:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4TIs5t6027721;
	Sun, 29 May 2005 11:54:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 28 May 2005, Junio C Hamano wrote:
>
> A new diffcore filter diffcore-order is introduced.  This takes
> a text file each of whose line is a shell glob pattern.  Patches
> matching the glob pattern on an earlier line in the file are
> output before patches matching the glob pattern on a later line,
> and patches not matching any glob pattern is output last.

This smells to me like a "cool feature, because we can" rather than a
"this is useful because of xxx".

You could equally well do it with 

	git-diff-cache .. | sort-filenames | git-diff-helper

in porcelain, if somebody really wants this (but I can't see people 
clamoring for it, since nobody else has ever done soemthing like this, 
afaik).

In other words: what is the problem this is trying to solve?

		Linus
