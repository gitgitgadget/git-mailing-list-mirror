From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 21:04:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604182101360.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> 
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
  <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net> <46a038f90604182051n4a16ee9atd2577d658befc335@mail.gmail.com>
 <Pine.LNX.4.64.0604182056390.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 06:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW3vP-0007vb-U8
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 06:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWDSEER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 00:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDSEER
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 00:04:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbWDSEEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 00:04:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J445tH001724
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 21:04:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J444NL007959;
	Tue, 18 Apr 2006 21:04:04 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0604182056390.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18905>



On Tue, 18 Apr 2006, Linus Torvalds wrote:
> 
> And no, I didn't actually test it. But it really _should_ work with that 
> trivial diff, including with the "a..b" format.

Ok, tested and verified.

On the kernel:

	git diff v2.6.13:drivers/block/..HEAD:block/ -- ll_rw_blk.c

actually does the right thing - it shows the diff for ll_rw_blk.c which 
got moved from drivers/block/ into block/ between 2.6.13 and current.

Note that the "--" is required, since ll_rw_blk.c doesn't exist in the 
top-level directory where we run the command (but does exist in the git 
trees that we have specified manually with the new shorthand).

		Linus
