From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Thu, 15 Nov 2007 02:21:44 +0100
Message-ID: <85ir441exj.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
	<20071114204732.GE3973@steel.home>
	<7vprycfrk6.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de>
	<20071114232809.GH3973@steel.home>
	<20071115001756.GA25021@atjola.homenet>
	<7v3av89wq7.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0711141640400.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTS9-00007Y-9o
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbXKOBXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756894AbXKOBXS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:23:18 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:49240 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbXKOBXP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:23:15 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IsTRn-0007Fy-EK; Wed, 14 Nov 2007 20:23:11 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A022F1C27968; Thu, 15 Nov 2007 02:21:45 +0100 (CET)
In-Reply-To: <alpine.LFD.0.9999.0711141640400.2786@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 14 Nov 2007 16:44:05 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65039>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 14 Nov 2007, Junio C Hamano wrote:
>> 
>> Maybe your compiler needs -DFLEX_ARRAY=0 in CFLAGS?
>
> Actually, for old pre-C99 compilers, you're probably better off using 
> -DFLEX_ARRAY=1, since a zero-sized array could be considered bogus by 
> some.

Is that supposed to work?  I would have thought that the only options
would be empty and 0.  I am pretty sure I have seen size calculations in
the deltifying code that would break badly using FLEX_ARRAY=1.  So _IFF_
-DFLEX_ARRAY=1 is supposed to be necessary for some compilers, I could
try seeing whether I find those locations again.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
