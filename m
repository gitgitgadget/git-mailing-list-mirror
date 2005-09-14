From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 13:53:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509141352010.26803@g5.osdl.org>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
 <7v3bo7jxdn.fsf@assigned-by-dhcp.cox.net> <59a6e5830509141208282166c8@mail.gmail.com>
 <7vmzmfh2y1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: wsc9tt@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFeGS-0006dv-7K
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVINUxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbVINUxy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:53:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932706AbVINUxw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 16:53:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EKrfBo017676
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 13:53:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EKrYh6025292;
	Wed, 14 Sep 2005 13:53:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzmfh2y1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8565>



On Wed, 14 Sep 2005, Junio C Hamano wrote:
>
> Could you revert one or both of these commits and try the same
> test on the 64-bit box you saw problems with please?
> 
> Commit: 90a734dc7f37a7bd1f3beec4d33acad559360f6c
> Author: Yasushi SHOJI <yashi@atmark-techno.com>
> Date:   Sun Aug 21 16:14:16 2005 +0900
> 
>     [PATCH] possible memory leak in diff.c::diff_free_filepair()
> 
> Commit: 068eac91ce04b9aca163acb1927c3878c45d1a07
> Author: Yasushi SHOJI <yashi@atmark-techno.com>
> Date:   Sat Aug 13 19:58:56 2005 +0900
> 
>     [PATCH] plug memory leak in diff.c::diff_free_filepair()

Undoing that second one (068eac91ce04b9aca163acb1927c3878c45d1a07) fixes 
the valgrind errors.

		Linus
