From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 12:34:22 -0400
Message-ID: <20070715123422.9a431506.seanlkml@sympatico.ca>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	<e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	<20070715104858.GG2568@steel.home>
	<e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	<e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	<20070715083529.6855a858.seanlkml@sympatico.ca>
	<e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
	<20070715110415.33692142.seanlkml@sympatico.ca>
	<e5bfff550707150858i1825e01clf0897ad4db319373@mail.gmail.com>
	<20070715121600.792982ef.seanlkml@sympatico.ca>
	<e5bfff550707150927l745926f0nab04ad82dff913@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 18:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA75Q-0008E7-6o
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 18:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658AbXGOQgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 12:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758335AbXGOQgk
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 12:36:40 -0400
Received: from s1.bay2.hotmail.com ([65.54.246.99]:8669 "EHLO
	bay0-omc1-s27.bay0.hotmail.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758624AbXGOQgj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 12:36:39 -0400
Received: from BAYC1-PASMTP02.bayc1.hotmail.com ([65.54.191.162]) by bay0-omc1-s27.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 09:36:39 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 09:36:38 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IA75J-0000ri-R4; Sun, 15 Jul 2007 12:36:37 -0400
In-Reply-To: <e5bfff550707150927l745926f0nab04ad82dff913@mail.gmail.com>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 16:36:39.0109 (UTC) FILETIME=[51492750:01C7C6FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52571>

On Sun, 15 Jul 2007 18:27:41 +0200
"Marco Costalba" <mcostalba@gmail.com> wrote:

> But your scheme does not fail if the patch is not \n terminated ?

I'm pretty sure there is always a preceding end-of-line marker,
before the terminating NUL; although i haven't broken down and
read the code yet.

> It can happen if the patch adds lines at the end of a file and the
> last line is not \n terminated.
> 
> In this case your scheme seems to miss the good next revision boundary.
> 

Just tested this case here with "git log --parents --pretty=raw -z -r -p"
and git prints out: "\ No newline at end of file"  followed by a newline
and then the NUL.

Sean
