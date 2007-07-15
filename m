From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 12:16:00 -0400
Message-ID: <20070715121600.792982ef.seanlkml@sympatico.ca>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	<e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	<20070715093529.GD2568@steel.home>
	<e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	<20070715104858.GG2568@steel.home>
	<e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	<e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	<20070715083529.6855a858.seanlkml@sympatico.ca>
	<e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
	<20070715110415.33692142.seanlkml@sympatico.ca>
	<e5bfff550707150858i1825e01clf0897ad4db319373@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 18:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA6o8-00024k-33
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 18:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763649AbXGOQSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 12:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762558AbXGOQST
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 12:18:19 -0400
Received: from bay0-omc2-s36.bay0.hotmail.com ([65.54.246.172]:50165 "EHLO
	bay0-omc2-s36.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760815AbXGOQSS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 12:18:18 -0400
Received: from BAYC1-PASMTP08.bayc1.hotmail.com ([65.54.191.168]) by bay0-omc2-s36.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 09:18:17 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP08.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 09:19:38 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IA6nY-0000pr-8a; Sun, 15 Jul 2007 12:18:16 -0400
In-Reply-To: <e5bfff550707150858i1825e01clf0897ad4db319373@mail.gmail.com>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 16:19:39.0140 (UTC) FILETIME=[F1563C40:01C7C6FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52569>

On Sun, 15 Jul 2007 17:58:21 +0200
"Marco Costalba" <mcostalba@gmail.com> wrote:

> What should I search for to find the revision boundary? "\n\0" ? is
> this that you mean with ^\0

Essentially yes.  That pattern will never appear inside the comment
or patch text because both sections are always indented.  So in the
example you cite, "\n\0" would match the proper terminator, and the
"\n-\0" NUL would be ignored.

Sean
