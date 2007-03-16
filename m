From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 09:58:04 +0100
Message-ID: <vpqveh15zvn.fsf@olympe.imag.fr>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org> <45FA501B.FA5B9F30@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 09:59:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS8HL-0002Aw-66
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 09:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbXCPI6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 04:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbXCPI6X
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 04:58:23 -0400
Received: from imag.imag.fr ([129.88.30.1]:44001 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbXCPI6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 04:58:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2G8w4dj023412
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 16 Mar 2007 09:58:05 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HS8GC-0000Ou-KT
	for git@vger.kernel.org; Fri, 16 Mar 2007 09:58:04 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HS8GC-0002C9-FR
	for git@vger.kernel.org; Fri, 16 Mar 2007 09:58:04 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <45FA501B.FA5B9F30@eudaptics.com> (Johannes Sixt's message of "Fri\, 16 Mar 2007 09\:06\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 16 Mar 2007 09:58:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42336>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> You could think about longjmp(3)ing out into main(), which would have to
> setjmp(3). But in order to clean up intermediate frames, you would have
> to have a stack of setjmp/longjmp buffers.
>
> Oh, well, how do I *love* them C++ exceptions!

You can have exceptions in C too.

I've used it a bit while contributing to Baz 1.x (the fork of tla).
The library used was cexcept ( http://cexcept.sourceforge.net/ ).

As you mention, jumping is the easy part, and cleaning up is the hard
one. Baz was using talloc, hacked to somehow work with cexcept. The
mini-library doesn't seem to be available as a tarball anymore, so I
did the checkout+targz in case someone's curious to have a look, and
lazy enough not to install baz to get it:

http://www-verimag.imag.fr/~moy/tmp/talloc-except--2.0.1--patch-2.tar.gz

This stuff is not supported anymore, but very small anyway.

-- 
Matthieu
