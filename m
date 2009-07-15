From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "mailinfo: Remove only one set of square brackets" considered
 harmful
Date: Wed, 15 Jul 2009 08:30:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907150821280.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 17:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR6Su-0003cc-Lu
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 17:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbZGOPcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbZGOPcI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 11:32:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49692 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330AbZGOPcG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 11:32:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6FFUxGJ017309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Jul 2009 08:31:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6FFUwF2007545;
	Wed, 15 Jul 2009 08:30:59 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123322>


So I see why Andreas did it, and I don't disagree violently, BUT...

The fact is, we have mailing lists etc that add their own headers to the 
subject, and they know they can add things in brackets. The most obvious 
example is the Linux kernel security list, which adds a prefix of

	"[Security] "

to the subject line in order to stand out (I'm on other lists that do 
this too, but those generally don'thave patches).

So I have emails witgh subjects like

	Subject: [Security] [patch] random: make get_random_int() more random

but I also have people who do the same thing themselves, eg:

	Subject: [PATCH -rc] [BUGFIX] x86: fix kernel_trap_sp()
	Subject: [BUGFIX][PATCH] fix bad page removal from LRU (Was Re: [RFC][PATCH] ..

so people did kind of depend on the "remove square brackets" behavior.

Sure, I end up editing the subject lines (and in that last example I would 
have had to anyway), but I'm not so sure this was a good change.

The commit log says:

    However, since format-patch only adds one set of square brackets,
    this behaviour is quite easily undesrstood and defended while the
    previous behaviour is not.

but sadly, Andreas totally missed the fact that we're not talking about 
just format-patch, and that the whole bracket removal is about emails 
in general.

So I'd suggest at least a setting to reinstate the previous behavior.

			Linus
