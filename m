From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Mon, 23 Jul 2007 17:11:25 +0200
Message-ID: <46A4C51D.2060202@fs.ei.tum.de>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>	 <Pine.LNX.4.64.0707221959100.14781@racer.site>	 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>	 <Pine.LNX.4.64.0707222013200.14781@racer.site>	 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>	 <Pine.LNX.4.64.0707222238180.14781@racer.site>	 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>	 <Pine.LNX.4.64.0707230048570.14781@racer.site>	 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>	 <Pine.LNX.4.64.0707230136360.14781@racer.site> <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 17:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICzZL-0000WP-AY
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 17:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbXGWPL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755085AbXGWPL2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 11:11:28 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42514 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbXGWPL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 11:11:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A188A28139;
	Mon, 23 Jul 2007 17:11:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AvxjAKonBG2T; Mon, 23 Jul 2007 17:11:26 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id E6EB12811C;
	Mon, 23 Jul 2007 17:11:25 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53440>

Jon Smirl wrote:
> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Okay, I did not really test thoroughly, it seems.  Sorry.  Next try.
> 
> It's working a lot better. People deal with $Id two different ways.
> One way they delete all of the $Id lines, that is the case of the
> Sonos patch. In the Phytec patch they left all of the $Id lines in
> place which caused them to get modified. In both cases you just want
> the lines with $Id to disappear in the patch.
> 
> It doesn't catch the $Id case from the Phytec patch.
> 
> diff -uarN linux-2.6.10/arch/cris/arch-v10/boot/rescue/head.S
> linux-2.6.10-lpc3180/arch/cris/arch-v10/boot/rescue/head.S
> --- linux-2.6.10/arch/cris/arch-v10/boot/rescue/head.S  2004-12-25
> 05:35:24.000000000 +0800
> +++ linux-2.6.10-lpc3180/arch/cris/arch-v10/boot/rescue/head.S
> 2006-11-20 15:49:30.000000000 +0800
> @@ -1,4 +1,5 @@
> /* $Id: head.S,v 1.6 2003/04/09 08:12:43 pkj Exp $
> +/* $Id: head.S,v 1.2 2005/02/18 13:06:31 mike Exp $
>  *
>  * Rescue code, made to reside at the beginning of the
>  * flash-memory. when it starts, it checks a partition
> 
> It's not catching all of the $Revision and $Date deltas.
> 
> The output diff shouldn't contain any CVS keywords. It is somewhat
> tricky to catch all of the cases and fix up the diffs. This filter
> should get written and debugged once and then made part of something
> like git so that it doesn't get written over and over again. Perl is
> way better for this I had 1000 lines of C in my program and it was
> still missing 10% of the cases.

Maybe I am missing something, but apart from $Log$, what's so hard about collapsing the CVS keywords?  That's something like

s/\$(Id|Date|Header|CVSHeader|Author|Revision):[^$]*\$/$\1$/

or not?

I see that people want to modify the patch text to remove the churn, but that seems wrong.  It would be much easier to just collapse the keywords before applying the patch, and then work on a newly created diff (from the git repo).

cheers
  simon
