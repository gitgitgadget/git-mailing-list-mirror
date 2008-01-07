From: Jeff King <peff@peff.net>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 22:06:42 -0500
Message-ID: <20080107030642.GA18194@coredump.intra.peff.net>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com> <alpine.LFD.1.00.0801061108320.2811@woody.linux-foundation.org> <20080107015518.GD17748@coredump.intra.peff.net> <7v63y62xwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 04:07:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBiKW-0002uu-45
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 04:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbYAGDGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 22:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbYAGDGp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 22:06:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1043 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYAGDGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 22:06:45 -0500
Received: (qmail 2652 invoked by uid 111); 7 Jan 2008 03:06:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 22:06:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 22:06:42 -0500
Content-Disposition: inline
In-Reply-To: <7v63y62xwj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69757>

On Sun, Jan 06, 2008 at 06:05:16PM -0800, Junio C Hamano wrote:

> Actually, I think I found a bug.
> 
> 	$ git reset --hard
> 	$ echo >>Makefile
>         $ git diff --numstat
>         1	0	Makefile
>         $ git mv Makefile makefile
>         $ git diff
>         $ git diff --cached -M --numstat
>         1	0	Makefile => makefile
> 
> "git mv" should not have staged the change.  It should have
> moved the index entry from Makefile to makefile and moved the
> work tree files.

I thought there was some discussion about this a few months ago,
concerning what exactly it should do, and that was how we arrived at the
current behavior. However, I can't seem to find it now. Maybe I dreamed
it.

-Peff
