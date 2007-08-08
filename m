From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Tue, 7 Aug 2007 20:42:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708072040160.25146@woody.linux-foundation.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
 <46B80993.3080409@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 05:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIcSD-0005dp-Ia
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 05:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936036AbXHHDnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 23:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935916AbXHHDnJ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 23:43:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55933 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935543AbXHHDnH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 23:43:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l783gIVB008930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 20:42:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l783gDH3019094;
	Tue, 7 Aug 2007 20:42:13 -0700
In-Reply-To: <46B80993.3080409@midwinter.com>
X-Spam-Status: No, hits=-4.724 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55295>



On Tue, 7 Aug 2007, Steven Grimm wrote:
> 
> Actually, though this will probably make people roll their eyes, before this
> discussion I would have guessed that "git status" would be the command that
> would tell you the index was out of date, and that there'd be a separate
> command (say, "git update-index"?) that you could then use to sync things up
> again.

Well, historically, you literally would just do

	git update-index --refresh

to do that.

"git status" is fairly newfangled, and is purely because users from other 
SCM's expected that kind of command to exist. The fact that as part of it 
running it does that update-index is really just a side effect.

		Linus
