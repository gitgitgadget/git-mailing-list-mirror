From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 10:13:22 +0200
Message-ID: <vpqvecgvmjh.fsf@bauges.imag.fr>
References: <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 10:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBRjP-00077A-7G
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 10:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317AbXGSIv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 04:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757773AbXGSIv0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 04:51:26 -0400
Received: from imag.imag.fr ([129.88.30.1]:43577 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbXGSIvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 04:51:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6J8DNrk015642
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 10:13:23 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IBR8V-0002H1-1h; Thu, 19 Jul 2007 10:13:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IBR8U-0003EZ-Ua; Thu, 19 Jul 2007 10:13:22 +0200
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>, Junio C Hamano <gitster@pobox.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Kastrup <dak@gnu.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20070719060922.GF32566@spearce.org> (Shawn O. Pearce's message of "Thu\, 19 Jul 2007 02\:09\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 19 Jul 2007 10:13:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52951>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If I do:
>
>   mkdir -p foo/bar
>   echo hello >foo/bar/world
>   git add foo
>   git -f rm foo/bar/world
>
> I never asked for foo/bar or foo to stay.

Well, outside git, if you do

$ mkdir -p foo/bar
$ echo hello > foo/bar/world
$ rm -f foo/bar/world

You didn't ask foo/bar to stay either, and still, it's quite natural
to have it stay in your filesystem. So, the same way you'd have ran
"rm -r foo", it seems reasonable to me to ask for "git-rm -r foo" if
the user wants to get rid of foo/ itself.

-- 
Matthieu
