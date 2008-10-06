From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Mon, 06 Oct 2008 17:15:22 +0200
Message-ID: <vpqtzbpwy9h.fsf@bauges.imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
	<20080928041040.GA24214@coredump.intra.peff.net>
	<vpqd4io1tla.fsf@bauges.imag.fr>
	<20080928161106.GA30199@coredump.intra.peff.net>
	<vpqk5ctfyp6.fsf@bauges.imag.fr>
	<20080930164545.GA20305@sigill.intra.peff.net>
	<20081005214114.GA21875@coredump.intra.peff.net>
	<48E9B036.6090805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 06 17:56:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmsMr-0008Pd-Ct
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 17:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbYJFPuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 11:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYJFPuR
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 11:50:17 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:62943 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbYJFPuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 11:50:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m96FkkiC010851;
	Mon, 6 Oct 2008 17:46:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kmrnv-0001JX-1s; Mon, 06 Oct 2008 17:15:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kmrnu-0001ki-Vn; Mon, 06 Oct 2008 17:15:22 +0200
In-Reply-To: <48E9B036.6090805@viscovery.net> (Johannes Sixt's message of "Mon\, 06 Oct 2008 08\:29\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 06 Oct 2008 17:46:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97595>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Does the series in any way change whether plumbing and porcelain invoke
> the external diff drivers? I have this particular use-case, which I'd like
> that still works:
>
> - In .git/info/attributes I have specified a diff driver:
>
>     *.doc   diff=docdiff
>
>   The driver runs a script that literally loads the two version of the
>   file into MS Word and uses Word's diffing capability.
>
> - git-gui should not use the diff driver. That is, plumbing should bypass
>   the diff driver and say "Binary files differ". [*]

Actually, I understand you don't want git gui and gitk to load MS-Word
anytime you click something, but I'd love to see the textconv+diff in
gitk.

(yeah, that's pretty hard to specify right, the ideal requirement
seems to be "in a gui, use the good part of the diff driver, but not
the other" :-\).

-- 
Matthieu
