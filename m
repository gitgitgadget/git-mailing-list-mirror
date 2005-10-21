From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Fri, 21 Oct 2005 08:26:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510210822380.10477@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
 <Pine.LNX.4.64.0510201645450.10477@g5.osdl.org> <loom.20051021T022509-63@post.gmane.org>
 <Pine.LNX.4.64.0510201752050.10477@g5.osdl.org> <861x2fdloj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@twinsun.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 17:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESyn6-0007UZ-Nk
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 17:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVJUP0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 11:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVJUP0m
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 11:26:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964983AbVJUP0l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 11:26:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9LFQWFC003184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 08:26:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9LFQVC7008078;
	Fri, 21 Oct 2005 08:26:31 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <861x2fdloj.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10436>



On Fri, 21 Oct 2005, Randal L. Schwartz wrote:
> 
> Doesn't yet work for me.  What do I need to do now?
> 
>     * committish: 4ae22d96fe9248dac4f26b1fc91154ba5e879799
>       branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
>     * refs/heads/origin: same as branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
>     Updating from ea5a65a59916503d2a14369c46b1023384d51645 to 4ae22d96fe9248dac4f26b1fc91154ba5e879799.
>     fetch-pack.c: needs update

Your previous failed pull had left the unfinished merge around, so now 
when you try to pull and it tries to update, it can't. 

Do a 

	git checkout -f

first to reset your tree to your old HEAD, and then try again. It should 
work then.

(Or do "git reset --hard", which should end up doing the same thing)

		Linus
