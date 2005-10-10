From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 18:29:08 +0200
Message-ID: <20051010162908.GA23401@ebar091.ebar.dtu.dk>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 10 18:43:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP0h3-0000oU-Ni
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 18:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVJJQkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 12:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVJJQkB
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 12:40:01 -0400
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:50666 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1750905AbVJJQkB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 12:40:01 -0400
Received: (qmail 23410 invoked by uid 5842); 10 Oct 2005 16:29:08 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <8664s5gxl9.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9895>

On Mon, Oct 10, 2005 at 09:12:34AM -0700, Randal L. Schwartz wrote:
> 
> I noticed "openbsd" in the operating systems detected in Makefile,
> but when I tried this on my openbsd system, I get an abort here:
> 
>     gcc -g -O2 -Wall -I/usr/local/include -L/usr/local/lib '-DSHA1_HEADER=<openssl/sha.h>' -o git-mailinfo mailinfo.o libgit.a  -liconv
>     mailinfo.o(.text+0x22d): In function `slurp_attr':
>     /opt/git/src/git-snapshot-20051010/mailinfo.c:130: undefined reference to `strcasestr'
>     mailinfo.o(.text+0x2a9): In function `handle_subcontent_type':
>     /opt/git/src/git-snapshot-20051010/mailinfo.c:155: undefined reference to `strcasestr'
>     mailinfo.o(.text+0x39d): In function `handle_content_transfer_encoding':
>     /opt/git/src/git-snapshot-20051010/mailinfo.c:181: undefined reference to `strcasestr'
>     mailinfo.o(.text+0x3c6):/opt/git/src/git-snapshot-20051010/mailinfo.c:183: undefined reference to `strcasestr'
>     collect2: ld returned 1 exit status
>     gmake: *** [git-mailinfo] Error 1
> 
> What am I doing wrong?

You need to compile with

$ gmake NO_STRCASESTR=Indeed

Peter
