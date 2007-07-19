From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages
Date: Thu, 19 Jul 2007 12:44:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191239050.32611@reaper.quantumfyre.co.uk>
References: <m3k5sxiiib.fsf@pc7.dolda2000.com> <20070718213725.31383.50523.julian@quantumfyre.co.uk>
 <7vr6n55krx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
 <20070719113743.GA27553@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBUQa-00039S-S2
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716AbXGSLoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757609AbXGSLoK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:44:10 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33595 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757691AbXGSLoI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 07:44:08 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id A94D9B0EB9
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 12:44:06 +0100 (BST)
Received: (qmail 21898 invoked by uid 103); 19 Jul 2007 12:44:05 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3697. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03244 secs); 19 Jul 2007 11:44:05 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 19 Jul 2007 12:44:05 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070719113743.GA27553@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52974>

On Thu, 19 Jul 2007, Jonas Fonseca wrote:

> For the html output we can use a stylesheet to make sure that the
> listingblocks are presented in a monospaced font.  For the manpages do
> it manually by inserting a ".ft C" before and ".ft" after the block in
> question.
>
> In addition, also add an empty line after all verbatim blocks.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>
>  Julian Phillips <julian@quantumfyre.co.uk> wrote Thu, Jul 19, 2007:
>  > On Wed, 18 Jul 2007, Junio C Hamano wrote:
>  >
>  > >I tried with your patch, both with asciidoc7 and asciidoc8.  Did
>  > >you really mean "&#x2302;" above?  Replacing them with "."  gave
>  > >me a series of these changes (diff between output before and
>  > >after your patch with the "s/\&#x2302;/./g" fixup):
>  >
>  > I did mean it.  I originally just had .ft, but I was getting \&.ft in the
>  > manpage, which then just came out as .ft in the console.
>
>  This is because AsciiDoc does the escaping. I think it would be cleaner
>  to do this thing when converting from DocBook to roff like we already
>  do for other things.

No.  Docbook does the escaping (as it says here: 
http://docbook.sourceforge.net/release/xsl/current/RELEASE-NOTES.html#V1.72.0
).  I tried your approach first, but 1) I idn't want to copy that much 
from the docbook xsl, as then we won't get updates/changes/fixes etc, 2) I 
still had to use &#x2302; _anyway_.

Just compare the chunk that you have copied from the docbook xsl to the 
version from 1.72.0 and you will find that all the '.'s have become 
&#x2302;s ...

-- 
Julian

  ---
"It's when they say 2 + 2 = 5 that I begin to argue."
-- Eric Pepke
