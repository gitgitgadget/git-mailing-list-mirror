From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Date parsing
Date: Sat, 21 Jun 2008 15:37:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806211530560.2926@woody.linux-foundation.org>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com> <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil> <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com> <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
 <20080621215240.GD15111@leksak.fem-net> <alpine.LFD.1.10.0806211507370.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jun 22 00:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KABjL-0000qE-V0
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 00:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbYFUWhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 18:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYFUWhS
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 18:37:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35546 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097AbYFUWhR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jun 2008 18:37:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5LMb4qS004043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jun 2008 15:37:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5LMb4CH014700;
	Sat, 21 Jun 2008 15:37:04 -0700
In-Reply-To: <alpine.LFD.1.10.0806211507370.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.346 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85736>



On Sat, 21 Jun 2008, Linus Torvalds wrote:
> 
> Remember: the git date handling was _not_ meant to be a generic date 
> library. It is very much meant to be a *git* date library.

Btw, I'm not proud of that. The whole of "date.c" was a huge hack to 
overcome the fact that

 - standard library date parsing is pure and utter shit, even for standard 
   date formats.

 - Never mind the standard date formats, very few seem to do the relative 
   dateslike "10 days ago".

 - So I couldn't find anybody elses code to "borrow" that did a reasonable 
   job and handled the nice relative dates too.

The GNU "date" command has pretty good support for doing things like "5 
minutes ago", but I think I tried to look at the code, and quicky decided 
that it was not an option (when I say "I think I tried", I have to admit 
that I don't have strong memories from it, but I suspect it was all so 
utterly horrid that I repressed the episode).

I don't mind using other peoples code (the whole xdiff library and the 
SHA1 stuff was certainly all from outside), but it needs to be in a format 
that doesn't cause projectile vomiting.

If somebody has a good date parser, I think we could drop the git-specific 
one in an instant.

Or if somebody wants to just improve on it... Hint, hint.

		Linus
