From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 20:58:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604182056390.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> 
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
  <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net> <46a038f90604182051n4a16ee9atd2577d658befc335@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 05:58:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW3pn-0007Nl-4x
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 05:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDSD62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 23:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDSD62
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 23:58:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWDSD61 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 23:58:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J3wMtH001316
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 20:58:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J3wI0s007761;
	Tue, 18 Apr 2006 20:58:19 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604182051n4a16ee9atd2577d658befc335@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18903>



On Wed, 19 Apr 2006, Martin Langhoff wrote:
>
> <wishlist>
>   What about support for diffing a subtree?
> 
>       git diff v2.2:net/appletalk v2.9:net/appletalk-ng
> 
> </whishlist>

Did you try it? It works as-is with that patch. Exactly because it will 
call git-diff-tree with the two SHA1's, and since they are now trees (and 
not blobs) git-diff-tree will do the right thing.

And no, I didn't actually test it. But it really _should_ work with that 
trivial diff, including with the "a..b" format.

		Linus
