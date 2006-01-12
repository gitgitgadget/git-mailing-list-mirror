From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 10:12:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601121011370.3535@g5.osdl.org>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>  <43C558FB.3030102@op5.se>
  <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org> <2cd57c900601120215pdb5da27l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:13:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex6wO-0002Li-F2
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 19:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWALSMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 13:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWALSMt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 13:12:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030287AbWALSMs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 13:12:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0CICeDZ001446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 10:12:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0CICcwS029956;
	Thu, 12 Jan 2006 10:12:39 -0800
To: Coywolf Qi Hunt <coywolf@gmail.com>
In-Reply-To: <2cd57c900601120215pdb5da27l@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14572>



On Thu, 12 Jan 2006, Coywolf Qi Hunt wrote:
> >
> > With stripped binaries, you can't really do _anything_. You get a
> > core-file, and you're screwed.
> 
> Are you sure?

I'm sure.

> In gdb:
> 
> No symbol table is loaded.  Use the "file" command.
> (gdb) bt
> #0  0xb7f16445 in ext2fs_mark_generic_bitmap () from /lib/libext2fs.so.2

Note where the debug info comes from. It comes from the _library_.

> So with stripped binary, I still get the backtrace to locate the buggy
> function.

No you don't. With the _non-stripped_ library you get the backtrace. 
There's no backtrace at all for the binary itself.

		Linus
