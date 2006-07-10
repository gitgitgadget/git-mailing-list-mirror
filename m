From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log to go forward instead of reverse?
Date: Mon, 10 Jul 2006 13:09:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101304210.5623@g5.osdl.org>
References: <86bqrxpai1.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
 <863bd9p9en.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
 <86mzbhntxu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 22:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0254-0008Dn-Kh
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWGJUKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWGJUKF
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:10:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422704AbWGJUKB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 16:10:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6AK9wnW001794
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 13:09:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6AK9vQ4017357;
	Mon, 10 Jul 2006 13:09:57 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86mzbhntxu.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23645>



On Mon, 10 Jul 2006, Randal L. Schwartz wrote:
>
>                     then git-log --pretty=short ORIG_HEAD..HEAD | cat

> The log is just so I can quickly eyeball the interesting changes.  The "cat"
> is to keep git-log from starting a pager.  (If there's a switch that does
> *that* that I've overlooked, that'd be good too.)

Just do

	PAGER= git log --pretty=short ORIG_HEAD..HEAD

instead.

And if you didn't know about "git shortlog" already, I personally actually 
find it easier to read

	git log --no-merges ORIG_HEAD.. | git shortlog

which orders things by author instead.  It also reverses the log messages 
as it does so, so each author will have the one-liners sorted oldest to 
newest the way you wanted to (so you do _not_ want to pass --reverse to 
that git-shortlog invocation).

		Linus
