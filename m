From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin: push/pull takes very long time
Date: Thu, 2 Mar 2006 19:28:06 -0500
Message-ID: <20060303002806.GB7497@trixie.casa.cgf.cx>
References: <81b0412b0603020526w7db41994v54a96895c1a6e960@mail.gmail.com> <81b0412b0603020909p179ed9bx4ed8fc2ddf77e868@mail.gmail.com> <20060302215408.GC6183@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 03 01:28:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEy9U-0003Pd-AY
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 01:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbWCCA2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbWCCA2I
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 19:28:08 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:48025 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1752091AbWCCA2H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 19:28:07 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 733514A8168; Thu,  2 Mar 2006 19:28:06 -0500 (EST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060302215408.GC6183@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17125>

On Thu, Mar 02, 2006 at 10:54:08PM +0100, Alex Riesen wrote:
>Alex Riesen, Thu, Mar 02, 2006 18:09:23 +0100:
>>I'll cleanup the profiling code and send it as well soon (I had to
>>instrument x*alloc).
>
>This is not exactly the same.  It counts free as well, even if that is
>not really interesting - there are places were there is more frees than
>allocs.  Probably something missed or a result coming from libc.
>
>Also it is _not_ the code I used for windows.  I had to have a global
>variable for argv[0], which needs modification of all main()s, which
>gets too easily out of sync.

I wasn't following this discussion closely so maybe this is useless
information, but for Cygwin you can either use the undocumented global
__argv or you can use /proc/cmdline.  /proc/self/cmdline is going to be
pretty slow, however.

It looks like pure Windows console apps define _argv in stdlib.h also
but I've never used this and don't know if it is what it looks like.

cgf
