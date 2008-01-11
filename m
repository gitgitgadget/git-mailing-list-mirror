From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 18:10:38 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
 <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
 <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org> <4786BFCD.1000303@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 03:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD9NT-0006EB-AQ
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 03:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402AbYAKCLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 21:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbYAKCLn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 21:11:43 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55797 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756313AbYAKCLm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 21:11:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0B2Ad6Y008517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jan 2008 18:10:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0B2AcQP021112;
	Thu, 10 Jan 2008 18:10:38 -0800
In-Reply-To: <4786BFCD.1000303@vilain.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70115>



On Fri, 11 Jan 2008, Sam Vilain wrote:
> 
> Without compression of deltas:
> 
> wilber:~/src/perl-preview$ du -sk .git/objects/pack/
> 86781 .git/objects/pack/
> 
> With compression of deltas:
> 
> wilber:~/src/perl-preview$ du -sk .git/objects/pack/
> 72907 .git/objects/pack/

Ok, so non-compressed deltas are 20% bigger.

That may well be a perfectly acceptable trade-off if the end result is 
then a lot faster. Has somebody done performance numbers? I may have 
missed them.. The best test is probably something like "git blame" on a 
file that takes an appreciable amount of time.

			Linus
