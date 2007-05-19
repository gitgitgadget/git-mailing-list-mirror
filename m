From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-svn: avoid crashing svnserve when creating new directories
Date: Sat, 19 May 2007 14:02:36 +0200
Message-ID: <vpq7ir5m36r.fsf@bauges.imag.fr>
References: <vpq7irfengj.fsf@bauges.imag.fr>
	<8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com>
	<vpqtzuf46k9.fsf@bauges.imag.fr> <20070519061422.GA17528@muzzle>
	<20070519095837.GA387@muzzle> <vpqtzu9m7za.fsf@bauges.imag.fr>
	<20070519105800.GA22230@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat May 19 14:03:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNeF-0006Vb-M4
	for gcvg-git@gmane.org; Sat, 19 May 2007 14:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbXESMCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 08:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbXESMCw
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 08:02:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:56017 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757772AbXESMCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 08:02:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4JC2a4O007216
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 19 May 2007 14:02:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HpNds-0007Cy-2z; Sat, 19 May 2007 14:02:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HpNds-0006Yf-0e; Sat, 19 May 2007 14:02:36 +0200
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>, Junio C Hamano <junkio@cox.net>,  git@vger.kernel.org
In-Reply-To: <20070519105800.GA22230@muzzle> (Eric Wong's message of "Sat\, 19 May 2007 03\:58\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 19 May 2007 14:02:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47742>

Eric Wong <normalperson@yhbt.net> writes:

> I have a modified version of the test I posted earlier based on your
> test.  However, I'm not comfortable binding to any port (even without
> ssh) on a users machine or potentially leaving a daemon running if the
> test is interrupted.

How about keeping the pid somewhere, and using "trap" to kill the svn
server process on interruption?

-- 
Matthieu
