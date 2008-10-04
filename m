From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git apply: git diff header lacks filename information for git
 diff --no-index patch
Date: Sat, 4 Oct 2008 10:08:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810041004290.3208@nehalem.linux-foundation.org>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net> <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 19:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmAe6-0006FJ-Oa
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 19:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYJDRJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 13:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYJDRJE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 13:09:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59061 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751982AbYJDRJE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Oct 2008 13:09:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94H8xgi000648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Oct 2008 10:09:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94H8woM024195;
	Sat, 4 Oct 2008 10:08:58 -0700
In-Reply-To: <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97474>



On Sat, 4 Oct 2008, Linus Torvalds wrote:
> 
> Anyway, for now I'd suggest a patch like this. Hmm? The "diff --git" 
> format assumes that the names are the same, so make it so.

Ahh, never mind, this one is broken. It's not _horribly_ so, but I 
shouldhave checked the test breakage. It changes non-broken cases from

	diff --git a/file b/file

into

	diff --git a/file a/file

so the header thing would need to be done differently. Don't even bother 
with that broken patch. I'll think about doing it better.

		Linus
