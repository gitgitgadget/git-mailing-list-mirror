From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Fri, 3 Jun 2005 07:46:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506030737050.1876@ppc970.osdl.org>
References: <20050602185046.GA3717@lsrfire.ath.cx>
 <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org> <42A03E1E.5060204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 16:45:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDMW-0004GY-J7
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 16:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFCOoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 10:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVFCOoa
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 10:44:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:22455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261301AbVFCOoO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 10:44:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53Ei5jA029489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 07:44:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53Ei4Mc026456;
	Fri, 3 Jun 2005 07:44:05 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <42A03E1E.5060204@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Rene Scharfe wrote:
> 
> Here's a patch.

This one fixes failure 6 for me, but 7, 8, 11 and 12 still fail.

Doing a

	sh t5000-tar-tree.sh -i -v

ends with

	* expecting success: (cd b/a && find .) | sort >b.lst &&
	     diff a.lst b.lst
	3,5d2
	< ./1.......10........20........30........40......481.......10........20........30........40........50x
	< ./1.......10........20........30........40......481.......10........20........30........40........50xx
	< ./1.......10........20........30........40......481.......10........20........30........40........50xxx
	10d6
	< ./l1.......10........20........30........40......481.......10........20........30........40........50
	12d7
	< ./l101
	* FAIL 7: validate filenames (cd b/a && find .) | sort >b.lst &&
	     diff a.lst b.lst

and you already saw my output from "tar tvf b.tar", so you already know 
that this is probably due to not understanding extended headers.

		Linus
