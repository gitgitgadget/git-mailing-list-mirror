From: Junio C Hamano <junkio@cox.net>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 01 May 2005 14:25:40 -0700
Message-ID: <7voebuskob.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505011544120.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0505011337070.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 23:32:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSM2p-00017L-UE
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVEAVdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVEAVbA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:31:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29068 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262691AbVEAVZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 17:25:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501212542.OJGZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 17:25:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011337070.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 13:46:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sun, 1 May 2005, Daniel Barkalow wrote:
>> 
>> Right; what I want to make programs able to do is take explicit
>> references, instead of only taking the objects they reference. So you
>> say heads/master or heads/linus instead of
>> "198b0fb635ed8a007bac0c16eab112c5e2c7995c".

LT> That's fine. 

LT> This is really just an issue of havign a function that does "get_sha1()", 
LT> and then making the things that take command line arguments use that 
LT> one instead of "get_sha1_hex()".

LT> Then you can have rules like:
LT>  - if it's a hex number, take it
LT>  - if it's a filename,  look it up
LT>  - if ".git/refs + str is a filename, look it up.

LT> The _only_ thing I want to be careful about is that all the _internal_
LT> stuff still have to use the strict "get_sha1_hex()" function, ie we should
LT> never _ever_ accept a tree object where the "sha1" ends up being anything
LT> but the hex thing. So this "generalized get_sha1()" would have to be used 
LT> only on real user input (ie argv[] array and the like).

I agree with Linus.  Dan, you are welcome to lift the code from
the find-in-vicinity() function in jit-util.c in my JIT toolset,
found at http://members.cox.net/junkio/.

