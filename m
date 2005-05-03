From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Tue, 03 May 2005 03:16:26 +0200
Message-ID: <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org>
References: <3YQn9-8qX-5@gated-at.bofh.it> <3ZLEF-56n-1@gated-at.bofh.it> <3ZM7L-5ot-13@gated-at.bofh.it> <3ZN3P-69A-9@gated-at.bofh.it> <3ZNdz-6gK-9@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 03 03:13:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSlxr-0007TU-Me
	for gcvg-git@gmane.org; Tue, 03 May 2005 03:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVECBR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 21:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVECBR6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 21:17:58 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:34255 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261273AbVECBRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 21:17:51 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id CD4167B00;
	Tue,  3 May 2005 03:17:41 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP
	id 9A08873A06; Tue,  3 May 2005 03:17:50 +0200 (CEST)
Received: from be3.lrz.7eggert.dyndns.org (dsl-213-023-011-167.arcor-ip.net [213.23.11.167])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 52D2B177E4;
	Tue,  3 May 2005 03:17:50 +0200 (CEST)
Received: from be1.lrz ([192.168.1.201] helo=be1.7eggert.dyndns.org)
	by be3.lrz.7eggert.dyndns.org with esmtp (Exim 4.43)
	id 1DSm7r-0003n9-VA; Tue, 03 May 2005 03:23:04 +0200
Received: from localhost ([127.0.0.1] helo=be1)
	by be1.7eggert.dyndns.org with smtp (Exim 4.22)
	id 1DSm1T-0002Tc-FV; Tue, 03 May 2005 03:16:27 +0200
To: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
User-Agent: KNode/0.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 2 May 2005, Ryan Anderson wrote:
>> On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:

>> > That said, I think the /usr/bin/env trick is stupid too. It may be more
>> > portable for various Linux distributions, but if you want _true_
>> > portability, you use /bin/sh, and you do something like
>> > 
>> > #!/bin/sh
>> > exec perl perlscript.pl "$@"
>> if 0;

exec may fail.

#!/bin/sh
exec perl -x $0 ${1+"$@"} || exit 127
#!perl

>> You don't really want Perl to get itself into an exec loop.
> 
> This would _not_ be "perlscript.pl" itself. This is the shell-script, and
> it's not called ".pl".

In this thread, it originally was.
-- 

"Our parents, worse than our grandparents, gave birth to us who are worse than
they, and we shall in our turn bear offspring still more evil."
        -- Horace (BC 65-8)

