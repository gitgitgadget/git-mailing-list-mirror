From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 13:24:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
References: <59a6e583050914094777c4fe96@mail.gmail.com> 
 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net> <59a6e583050914114054b1564d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:25:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFdof-0007TL-An
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVINUZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVINUZG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:25:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932459AbVINUZF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 16:25:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EKOrBo015359
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 13:24:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EKOpV2023650;
	Wed, 14 Sep 2005 13:24:52 -0700
To: Wayne Scott <wsc9tt@gmail.com>
In-Reply-To: <59a6e583050914114054b1564d@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8559>



On Wed, 14 Sep 2005, Wayne Scott wrote:
> 
> However, I noticed a whole collection of errors from valgrind when I
> run this command line:

I get even more, including:

	==3234== Use of uninitialised value of size 4
	==3234==    at 0x80507C1: alloc_filespec (diff.c:224)
	==3234==    by 0x8052387: diff_addremove (diff.c:1144)
	==3234==    by 0x8049B74: show_file (diff-tree.c:97)
	==3234==    by 0x8049E17: diff_tree (diff-tree.c:118)

Damn, too bad valgrind doesn't work on ppc64, so I can't use it on my main 
machine. It seems to be in development on ppc32, so maybe some day.

I'll look at it on my other machines instead,

		Linus
