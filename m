From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in status output
Date: Wed, 10 Jan 2007 19:33:21 +0100
Message-ID: <17829.12657.814000.514351@lapjr.intranet.kiel.bmiag.de>
References: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
	<1168412892113-git-send-email-j.ruehle@bmiag.de>
	<17828.37642.473000.296809@lapjr.intranet.kiel.bmiag.de>
	<7v4pqzfhzd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 19:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4iGf-0001Zk-HP
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 19:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbXAJSdn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 13:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbXAJSdm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 13:33:42 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:2987 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965019AbXAJSdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 13:33:42 -0500
Received: (qmail 19241 invoked by uid 106); 10 Jan 2007 18:33:40 -0000
Received: from eotheod.intranet.kiel.bmiag.de(10.130.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdy8PxJZ; Wed Jan 10 19:33:30 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 76B6C3ADC8;
	Wed, 10 Jan 2007 19:33:30 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24253-02; Wed, 10 Jan 2007 19:33:27 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id E22483ADC6;
	Wed, 10 Jan 2007 19:33:24 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pqzfhzd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36522>

Junio C Hamano writes:
 > Juergen Ruehle <j.ruehle@bmiag.de> writes:
 > 
 > > Juergen Ruehle writes:
 > >  > [Corrupted patch deleted]
 > >
 > > Will try again when I know what happened.
 > 
 > While you are at it, let me point out one thing that has been
 > annoying me for a while.
 > 
 >  * The message claims to be from git-send-email;
 > 
 >  * Content-Type and CTE are UTF-8 and QP (which is fine);
 > 
 >  * You have in-body From: line; this is not wrong per-se and I
 >    understand why you would want one (your e-mail From: line
 >    uses ASCII approximations "ue" and "ue" and you would want
 >    the resulting commit to spell your name correctly).
 >
 >  * However, this in-body From: line is _doubly_ QP encoded (what
 >    you see above is your name, first RFC 2047 encoded and then
 >    QP encoded).  It shouldn't be.
 > 
 > So, my questions are:
 > 
 >  (1) is this what git-send-email generates and sends out by
 >      default?  If so that means it is a bug in that program that
 >      needs to be fixed.
 > 
 >  (2) if not, are you inserting the in-body From: by hand,
 >      perhaps cut & paste from format-patch output, before
 >      feeding git-send-email (which runs QP on it)?
 > 
 > If the latter, please do not paste the RFC 2047 quoted form.
 > You can spell your name in raw UTF-8 on the in-body From: line
 > just like you did on your Signed-off-by: line.

Yes, this is using git-send-email which sends the mail as 8bit encoded
and provides the QP encoded From line. Unfortunately there seems to be
a gateway in between that doesn't handle 8bit and QPs the mail again.
Perhaps I need some other switches for format-patch and send-email to
produce a better result? I'll take another look at the documentation
before annoying you again.
