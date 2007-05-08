From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to
Date: Tue,  8 May 2007 09:28:25 -0400
Message-ID: <11786309073709-git-send-email-tytso@mit.edu>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 15:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlPkC-0008S8-Qz
	for gcvg-git@gmane.org; Tue, 08 May 2007 15:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934706AbXEHN2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 09:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934738AbXEHN2h
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 09:28:37 -0400
Received: from THUNK.ORG ([69.25.196.29]:60766 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934706AbXEHN2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 09:28:36 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlPqo-0002Rr-Nf; Tue, 08 May 2007 09:35:34 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlPjv-0007qI-B2; Tue, 08 May 2007 09:28:27 -0400
X-Mailer: git-send-email 1.5.2.rc2.22.ga39d
In-Reply-To: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
References: <E1HlFqU-0002ir-GK@candygram.thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46577>

OK, here's a patch to implement pack.depth (with the default tweaked
to 50 --- is that too high?), followed by a simplified and reworked
patch to git-gc that only implements --no-reuse-delta.

I don't imagine that most users will want to use that feature most of
the time, hence the long option name, but occasionally, it might be
useful.  Yes, the user could just run "git-repack -a -d -f -l" after
running git-gc, but then the "git-repack -a -d -l" in git-gc is just a
wasted disk i/o.  I don't know if I'll manage to convince you, if not,
just drop the second patch, I guess.  :-)

						 - Ted
