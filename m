From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 09:37:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708040928350.5037@woody.linux-foundation.org>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi>
 <20070804065516.GS20052@spearce.org>
 <20070804071131.GA6557@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	V?in? J?rvel? <v@pp.inet.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:37:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMdF-0003LZ-Je
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644AbXHDQhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760233AbXHDQhe
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:37:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47457 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754462AbXHDQhd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 12:37:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l74GbOAq009863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 09:37:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l74GbH0v001282;
	Sat, 4 Aug 2007 09:37:18 -0700
In-Reply-To: <20070804071131.GA6557@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.721 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54881>



On Sat, 4 Aug 2007, Jeff King wrote:
>
> On Sat, Aug 04, 2007 at 02:55:16AM -0400, Shawn O. Pearce wrote:
> 
> > V??in?? J??rvel?? <v@pp.inet.fi> wrote:
> 
> Your mailer claims this message is in us-ascii, but I think it isn't...

Actually, the email claims it was iso-latin1, at least here. Which the 
*body* of the email apparently really was.

However (and this is a pretty common thing), the *headers* are 
unspecified, and a lot of email clients seem to think that if that 
happens, they default to US-ASCII and think that those iso-latin1 
characters are crud.

Which is a damn shame. "alpine" does this, and it irritates me no end. I 
see emails where I can read the body fine, but it shows '????' for subject 
lines and authors even though it's the exact same character set.

Stupid, stupid, stupid.

Dammit, if the thing says

	Content-type: text/plain; charset=ISO-8859-1; format=flowed

(which it did), then yes, by some idiotic reading of the RFC's that 
probably only affects the body of the email. But those headers (and the 
"From:" line in particular) were *also* in ISO-8859-1, and email clients 
should default to using the same character set unless something else is 
said.

Btw, I suspect git "mailsplit" gets this wrong too. I rant and rave, but 
in the end, I solved it by just having the code guess sanely (commit 
b59d398beab604e577846ef8393735478c1ca3c2 makes things come out right in 
practice, regardless) instead of trying to do something "technically 
correct".

			Linus
