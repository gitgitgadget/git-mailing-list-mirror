From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Fri, 03 Aug 2007 23:32:14 +0200
Message-ID: <vpqps24i9sx.fsf@bauges.imag.fr>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4mX-0006ci-Uh
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764105AbXHCVd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764095AbXHCVd6
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:33:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:33040 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763576AbXHCVd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:33:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l73LWECr025796
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Aug 2007 23:32:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IH4ko-0000Gr-NQ; Fri, 03 Aug 2007 23:32:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IH4ko-0005wV-Kj; Fri, 03 Aug 2007 23:32:14 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Steven Grimm <koreth@midwinter.com>, Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>, git@vger.kernel.org
In-Reply-To: <7vir7wmk84.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri\, 03 Aug 2007 13\:33\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 03 Aug 2007 23:32:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54763>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> But I'd really think that what should be done (if anything has to be done 
>> at all) is to introduce a config variable which triggers the same logic in 
>> git-diff as was introduced in 2b5f9a8c0cff511f2bb0833b1ee02645b79323f4.
>
> Sorry, I don't follow at all.  The diff toolchain works all
> inside core without having to write a temporary index out, which
> was the issue the commit you are quoting was about.
>
> In any case, enough discussion.  Here is an updated patch, which
> I _could_ be pursuaded to consider for inclusion after v1.5.3
> happens, if there are enough agreements and Acks.

To me, that patch makes sense, yes.

That said, a configuration option would probably be better than a
command-line option. The expected behavior seems to depend on user,
but not much on use-cases. So, people who like the old behavior could
set the option and forget about it, and other would not be distracted
about it.

Also, is there any particular reason not to update the index stat
information when files are found to be identical? Well, we've
discussed that quite much in this thread, but this is what status is
doing, and I still fail to see why diff shouldn't. (I can update the
patch myself if you agree it should be done. I don't know the git
codebase well, so it takes time for me, but the exercise is fun ;-) )

Side performance note: if I understand your patch correctly, you're
comparing the file content twice for actually modified changes. But
that probably doesn't matter much since the expansive thing is to load
the files and to compute the diff.

Thanks,

-- 
Matthieu
