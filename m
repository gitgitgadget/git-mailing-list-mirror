From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CFT: merge-recursive in C
Date: Mon, 26 Jun 2006 16:54:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606261652350.3927@g5.osdl.org>
References: <20060626233838.GA3121@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 01:55:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0ux-0008Lz-A3
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933139AbWFZXy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933135AbWFZXyz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:54:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933139AbWFZXyy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 19:54:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5QNsJnW016057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Jun 2006 16:54:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5QNsIGw005253;
	Mon, 26 Jun 2006 16:54:19 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060626233838.GA3121@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22698>



On Tue, 27 Jun 2006, Alex Riesen wrote:
> 
> To my deep disappointment, it didn't work out as good as I hoped: one
> program I see most often and for longest time in the process list
> (git-diff-tree) is a too complex thing to be put directly into
> merge-recursive.c, so any help in this direction will be greatly
> appreciated.

Are you sure?

git-diff-tree is one of the simplest git operations. We've got absolutely 
_tons_ of infrastructure in place to do it efficiently, since it's done 
all over the map (a "git-rev-list" with path limiting will do a diff-tree 
against all the commits).

Some of the interfaces might be a bit non-obvious, but the diff stuff was 
some of the first ones to be libified exactly because they end up being so 
fundamental.

		Linus
