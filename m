From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Mon, 4 Sep 2006 08:19:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609040805400.27779@g5.osdl.org>
References: <20060829165811.GB21729@spearce.org>
 <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
 <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
 <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
 <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
 <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609021138500.27779@g5.osdl.org> <7vslj8tydc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609031456520.27779@g5.osdl.org> <7vodtwtw9v.fsf@assigned-by-dhcp.cox.net>
 <7vhczos2ak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 17:19:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKGEL-0002jQ-An
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 17:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWIDPTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 11:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWIDPTN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 11:19:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751459AbWIDPTM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 11:19:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k84FJ7nW030010
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Sep 2006 08:19:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k84FJ74A026707;
	Mon, 4 Sep 2006 08:19:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhczos2ak.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.482 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26419>



On Sun, 3 Sep 2006, Junio C Hamano wrote:
> 
> So here is a patch against "master" which contains none of the
> earlier patches in this thread.

Ok, this looks good. It only adds two extra seconds for me (after fixing 
the patch: "unpack_object_header_gently()" was static to sha1_file.c so 
your patch wouldn't actually compile on its own), and it should be a lot 
less prone to problems.

		Linus
