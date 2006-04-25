From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 10:11:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 19:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYR4Z-0003wH-9G
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 19:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWDYRLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 13:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDYRLQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 13:11:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932268AbWDYRLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 13:11:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PHBEtH014968
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 10:11:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PHBDPW030515;
	Tue, 25 Apr 2006 10:11:13 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2lijt$aco$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19154>



On Tue, 25 Apr 2006, Jakub Narebski wrote:
> 
> The generic commit links "related" which is fsck-able at least and "note"
> which is not. It is idea somewhat on the level of providing _extended
> attributes_ in VFS in Linux kernel, IMVHO.

And nobody actually uses extended attributes either, do they?

Plus it's _not_ fsck'able, since the thing doesn't even have any valid 
semantics. You guys can't even agree on whether the object must exist or 
not. 

Anyway, I'm not interested. I'm violently opposed to the mess that is 
darcs and other crapola. The WHOLE point of git is to have well-defined 
semantics and get away from the horrors that other systems have done, 
where they have allowed any random crap to "make sense". 

If you want darcs-like semantics where there are no rules, just use darcs, 
for chrissake! And if you want to base it on git because you've noticed 
that git is (a) stable, (b) fast and (c) has developed remarkably well, 
then think for a second _why_ git is stable, fast, and well-developed. 
It's that exactly because it has clear semantics, and no room for random 
crud.

Git tracks contents, and the well-defined history of how those contents 
came to be. Git does NOT track "additional notes" left by the developer 
that have weak semantics. Git does not track when a developer says "I 
renamed a file".

For exactly the same reason, git should not track it when a developer says 
"I think this commit is related to that commit". It's not hard data, that 
has hard and clear semantics.

Once you start adding data that has no clear semantics, you're screwed. At 
that point, it's a "track guesses" game, not a "track contents" game.

			Linus
