From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 14:30:00 +0200 (CEST)
Message-ID: <8199b7ae4c441c4311045141ddaaa36f.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
    <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
    <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net>
    <48F7280C.3080205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Pedro Melo" <melo@simplicidade.org>,
	"Pieter de Bie" <pdebie@ai.rug.nl>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 14:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqRxZ-00023T-GO
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 14:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbYJPM05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 08:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbYJPM05
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 08:26:57 -0400
Received: from mail.codewut.de ([78.47.135.140]:51267 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbYJPM04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 08:26:56 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 655BD7BEF1; Thu, 16 Oct 2008 14:30:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id CDDF87BE4C;
	Thu, 16 Oct 2008 14:30:00 +0200 (CEST)
Received: from 194.127.8.18
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Thu, 16 Oct 2008 14:30:00 +0200 (CEST)
In-Reply-To: <48F7280C.3080205@viscovery.net>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98374>

Thanks again for your feedback, guys!

Ok, I've done it and tracked it down. Unfortunately my MacBook
has no access to the company network or internet (must get an iPhone ;-),
so I cannot copy&paste my finding.

For now I can you give this:
1.5.6.rc1.24.gd629 fails
1.5.6.rc1.23.g6c2ce works

The commit was on Jun 5, 14:47:50 by Marius Storm-Olsen and the relevant
file is wt-status.c.

Ok, I think I found the issue. I enabled showUntrackedFiles in my gitconfig:

status.showUntrackedFiles = all

On the one hand it makes sense to list submodule folder as untracked
files. Then again it feels wrong because it is a registered submodule. Hm
:-)

Anyway, bisect is really impressive!

Yours,
Lars
