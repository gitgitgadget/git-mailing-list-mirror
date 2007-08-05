From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Sun, 05 Aug 2007 21:57:11 +0200
Message-ID: <vpqlkcpah60.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708031121000.14781@racer.site>
	<7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
	<vpqps24i9sx.fsf@bauges.imag.fr>
	<7v1wekmgo8.fsf@assigned-by-dhcp.cox.net>
	<vpqir7wi5oc.fsf@bauges.imag.fr>
	<7vlkcskx5z.fsf@assigned-by-dhcp.cox.net>
	<vpqr6mhahtx.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708052044570.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:58:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHmEx-0000hs-5R
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbXHET6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757595AbXHET6L
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:58:11 -0400
Received: from imag.imag.fr ([129.88.30.1]:48388 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757449AbXHET6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 15:58:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l75JvBNo014366
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 21:57:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IHmDv-00010N-Pc; Sun, 05 Aug 2007 21:57:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IHmDv-0007m2-NA; Sun, 05 Aug 2007 21:57:11 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>,  Steven Grimm <koreth@midwinter.com>, Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0708052044570.14781@racer.site> (Johannes Schindelin's message of "Sun\, 5 Aug 2007 20\:45\:54 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 05 Aug 2007 21:57:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55066>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I don't know whether it was a typo, but we're not talking about
>> "commit", but "status".
>
> No typo.  "git status" is literally "git commit --dry-run".  Why?  Because 
> people expected it to be called "git status".
>
> And even if I think about it over and over again, it makes sense.

I was surprised of that when looking at the source, but yes, it makes
sense.

But the message I was replying to claimed that 
"git status-or-commit -a" _needed_ to put objects in the object
database. That's true of "git commit -a" but not of "git status -a",
even if you call it "git commit --dry-run -a", precisely because of
the --dry-run thing.

-- 
Matthieu
