From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 15:03:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161502160.20061@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
 <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org>
 <20070716202550.GH16878@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org>
 <469BE1D4.1070408@slamb.org> <alpine.LFD.0.999.0707161442410.20061@woody.linux-foundation.org>
 <469BEA21.5080308@slamb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 00:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAYg9-00087Z-CJ
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 00:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762973AbXGPWEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762986AbXGPWEE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 18:04:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60317 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760622AbXGPWEB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 18:04:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GM3sWp021919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 15:03:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GM3nuA006602;
	Mon, 16 Jul 2007 15:03:49 -0700
In-Reply-To: <469BEA21.5080308@slamb.org>
X-Spam-Status: No, hits=-4.644 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52729>



On Mon, 16 Jul 2007, Scott Lamb wrote:
> Linus Torvalds wrote:
> > 
> > In fact, with the Solaris behaviour for unlink(), you *cannot* have a 
> > non-broken "remove()".
> 
> I'd hoped to see that they made a new syscall to properly implement the
> new behavior.

Ahh, yes, with a new system call you could do it.

> But they didn't. It reminds me of glibc's pselect().

Yeah, that was a bit pointless, although it does make it easier to port 
binaries and then have them to work in practice most of the time.

		Linus
