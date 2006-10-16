From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 18:33:23 +0200
Message-ID: <87mz7wp6ek.fsf@rho.meyering.net>
References: <87slhopcws.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:35:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVQO-0005ac-50
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWJPQd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWJPQdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:33:25 -0400
Received: from mx.meyering.net ([82.230.74.64]:32187 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1422758AbWJPQdY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 12:33:24 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1DC152734E; Mon, 16 Oct 2006 18:33:23 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 16 Oct 2006 09:12:35 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28967>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 16 Oct 2006, Linus Torvalds wrote:
...
> So I think xdiff has chosen too small a hash. Can you try what happens if
> you change xdl_hashbits() (in xdiff/xutil.c) instead? Try making it return
> a bigger value (for example, by initializing "bits" to 2 instead of 0),
> and see if that makes a difference.

It makes no difference.

Bear in mind that there are a *lot* of duplicate lines in the files
being compared: filtering each through "sort -u" removes 40-50k lines.
