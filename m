From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-apply segfault.
Date: Fri, 10 Feb 2006 11:22:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602101120440.19172@g5.osdl.org>
References: <20060210183745.GI22611@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 20:23:05 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7drE-0002TJ-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 20:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWBJTXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 14:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWBJTXA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 14:23:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751309AbWBJTW7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 14:22:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1AJMnDZ020564
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Feb 2006 11:22:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1AJMk8E031971;
	Fri, 10 Feb 2006 11:22:48 -0800
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060210183745.GI22611@redhat.com>
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15877>



On Fri, 10 Feb 2006, Dave Jones wrote:
>
> (gdb) bt
> #0  0x0000003287f73474 in memset () from /lib64/libc.so.6
> #1  0x0000003287f6c92a in calloc () from /lib64/libc.so.6
> #2  0x0000000000407399 in read_cache () at read-cache.c:537

Ouch. Looks like malloc heap corruption.

> git on hera is 1.1.6-1

Can you try running "valgrind" on it? That should show what corrupts the 
heap.

		Linus
