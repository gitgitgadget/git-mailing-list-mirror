From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 08:35:29 -0400
Message-ID: <20070715083529.6855a858.seanlkml@sympatico.ca>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	<7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	<20070715093529.GD2568@steel.home>
	<e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	<20070715104858.GG2568@steel.home>
	<e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	<e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 14:37:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA3MB-00028h-T6
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 14:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXGOMho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbXGOMho
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 08:37:44 -0400
Received: from bay0-omc1-s26.bay0.hotmail.com ([65.54.246.98]:50894 "EHLO
	bay0-omc1-s26.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751829AbXGOMhn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 08:37:43 -0400
Received: from BAYC1-PASMTP12.bayc1.hotmail.com ([65.54.191.185]) by bay0-omc1-s26.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 05:37:43 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 05:37:58 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IA3M6-0000We-1h; Sun, 15 Jul 2007 08:37:42 -0400
In-Reply-To: <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 12:37:58.0554 (UTC) FILETIME=[F991DFA0:01C7C6DC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52549>

On Sun, 15 Jul 2007 14:29:04 +0200
"Marco Costalba" <mcostalba@gmail.com> wrote:

> To further push for git patch, please check this from current linux tree:
> 
> git log --parents --pretty=raw -z -r -p c4201214
> 
> As you can see the diff contains a '\0' value (actually removed by the patch).
> 
> qgit of course fails, as any tool based on parsing '\0' delimiting
> character records. If the size of the patch was explicitly given
> instead no fail will occur.
> 

If you only look for ^\0 (ie. first position only) the parsing should
be okay.  Not that it helps with the performance issue you're trying
to address.

Sean
