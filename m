From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Simplify "git reset --hard"
Date: Mon, 15 May 2006 07:55:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605150752490.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
 <Pine.LNX.4.64.0605141110150.3866@g5.osdl.org> <7v1wuvwzdv.fsf@assigned-by-dhcp.cox.net>
 <7vwtcnvk76.fsf@assigned-by-dhcp.cox.net> <7vr72vvigy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 16:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfeUW-0007bt-Lw
	for gcvg-git@gmane.org; Mon, 15 May 2006 16:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWEOO4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWEOO4J
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 10:56:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751395AbWEOO4I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 10:56:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FEu0tH007788
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 07:56:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FEtxSV005274;
	Mon, 15 May 2006 07:56:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr72vvigy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20050>



On Mon, 15 May 2006, Junio C Hamano wrote:
>
> read-tree -u one-way merge fix to check out locally modified paths.
> 
> The "-u" flag means "update the working tree files", but to
> other types of merges, it also implies "I want to keep my local
> changes" -- because they prevent local changes from getting lost
> by using verify_uptodate.  The one-way merge is different from
> other merges in that its purpose is opposite of doing something
> else while keeping unrelated local changes.  The point of
> one-way merge is to nuke local changes.  So while it feels
> somewhat wrong that this actively loses local changes, it is the
> right thing to do.

Ack. On the other hand, I wonder if it might not make sense to have this 
part potentially depend on the "--reset" flag.

That way you wouldn't even have to apologize for it.

		Linus
