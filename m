From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: fetchmail (Re: [PATCH] git gc --auto: defer on battery)
Date: Mon, 31 Mar 2008 10:00:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803310953030.14670@woody.linux-foundation.org>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org> <7vr6drsl47.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803310757550.14670@woody.linux-foundation.org>
 <20080331164328.GA31518@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgNOj-0002Ty-BY
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 19:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYCaRBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbYCaRBe
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 13:01:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45870 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334AbYCaRBe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 13:01:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2VH0WLG019992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Mar 2008 10:00:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2VH0VSI016581;
	Mon, 31 Mar 2008 10:00:31 -0700
In-Reply-To: <20080331164328.GA31518@atjola.homenet>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.851 required=5 tests=AWL,BAYES_00,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78592>



On Mon, 31 Mar 2008, Bj?rn Steinbrink wrote:
> 
> Hm, that's weird. My header shows my name as iso-8859-1, same as the
> body. I checked the copy that I got from the list to eliminate any weird
> local-copy effects.
> 
> From:	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
> 
> So maybe your MUA is iso-8859-1 challenged instead? I'll send this one
> out as UTF-8.

Ahhah! That's it. Not my MUA, but I'm using fetchmail, and I have copied 
my .fetchmailrc file around for years. As a result, it has 'mimedecode' 
set, because pine used to be really bad at this and obviously all my 
original BK (and later git) email scripts didn't do mime decoding either.

So what is probably happening is that my fetchmail setup dropped the 
charset information for the header (this is documented by fetchmail, so 
it's not a bug, it's just part of the rules) and just turned it into the 
raw byte sequence.

I've turned off mimedecode, can you send another email to me (in private) 
to see if not doing that just fixes things?

			Linus
