From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Thu, 8 Apr 2010 18:12:49 +0200
Message-ID: <201004081812.50112.trast@student.ethz.ch>
References: <20100407204536.GA32382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 18:13:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzuLm-0003B5-Tt
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 18:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718Ab0DHQMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 12:12:53 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:16208 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833Ab0DHQMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 12:12:52 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.247.2; Thu, 8 Apr
 2010 18:12:50 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Thu, 8 Apr
 2010 18:12:50 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100407204536.GA32382@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144358>

Jeff King wrote:
> Log shows notes by default if no --pretty format is given.
> However, depending on what's in your default notes ref, that
> may actually be quite distracting when reading a normal log.
> Let's let the user decide whether they want to see notes by
> default.

Looks useful to me, and the patch looks obviously correct.

> My git repository has your mailing list reference notes in
> refs/notes/commits. They're quite bulky, and being headers, they look
> kind of like a new commit stanza, which always confuses me when reading
> log output. I got tired of typing --no-notes.
> 
> I guess an alternate solution would be for me to store them in some
> other ref, and then use --show-notes=email when I do want to see them
> (instead of just --show-notes, as I would do with this patch). But I
> still wonder if log.shownotes is a sensible addition, just for the sake
> of completeness.

I think it is a useful addition, *especially* in the case where the
configuration departs from the default.  Typing --show-notes=email
--show-notes=commits just to avoid showing a third set of notes in
refs/notes/bulky will get old fairly quickly...

BTW, now that I seem to have a couple of users for those notes: what
would you like to see in the "short" version (notes/terse)?  Improving
that to be the "common" case has been on my todo list for quite some
time.  For example, I'm considering changing the 'permalink' to
'thread' so that access to the full thread is easier (you'll still
have to click the subject to find the root).  Also, the message text
snippets have been broken since I revived it in February, does anyone
miss them?  They made the output even bulkier.

Of course, I also hope that in the long run we can somehow generate
this from Junio's amlog for better accuracy :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
