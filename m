From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 17:10:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505191656310.2322@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
 <7vsm0jyryf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
 <7vy8abx8ay.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0505191643030.20274@localhost.localdomain>
 <7vll6ayjok.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.org>
 <7vhdgyyeom.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 02:09:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYv4D-0000Wj-JJ
	for gcvg-git@gmane.org; Fri, 20 May 2005 02:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVETAJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 20:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVETAJI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 20:09:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:1502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261154AbVETAI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 20:08:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4K08nU3030585
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 17:08:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4K08lm2018191;
	Thu, 19 May 2005 17:08:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdgyyeom.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Junio C Hamano wrote:
>
> Not quite a related topic, but unless we start to support the
> copy detection you recommended against, my understanding is that
> -M does not do anything useful for git-diff-files.  Is there a
> good use case for it?  I am not advocating for its removal so
> please leave the command line option there.

Hmm.. You're right, but it feels kind of wrong. Clearly we support
removals in diff-files, but you're right, we can never have something show
up as an addition, since we only ever compare against files that are
already mentioned in the cache.

On the other hand, a unmerged entry really _could_ be a new file, could it 
not? Even if we right now always report it as "Unmerged path"? If it's a 
case of existing in stage 2/3 only, it really should show up as a new file 
diff for git-diff-files, no?

Or am I just being confused and/or stupid?

		Linus
