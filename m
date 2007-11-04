From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for
 interactive GUI use
Date: Sat, 3 Nov 2007 22:38:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 06:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoYC5-0006Nd-3q
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbXKDFib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXKDFib
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:38:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59546 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371AbXKDFia (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 01:38:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA45cIMh010514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Nov 2007 22:38:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA45cIUE018089;
	Sat, 3 Nov 2007 22:38:18 -0700
In-Reply-To: <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63352>



On Sun, 4 Nov 2007, Paul Mackerras wrote:
>
> Linus Torvalds writes:
> 
> > When the full list is generated, there will be a "Final output:" string
> > prepended to it, regardless of whether any early commits were shown or
> > not, so that the consumer can always know the difference between early
> > output and the final list.
> 
> How hard would it be to put the total number of commits on that "Final
> output" line?  That would be useful for me.

Not hard. I think we basically have it anyway. The reason I didn't do it 
is that there's actually multiple numbers: there's the number of primary 
("interesting") commits, and then there are the "others", ie the edge 
things etc. So the number I'd pick would be the number of actual 
interesting commits, no edges, no nothing. Or what?

One other thing I was thinking of was also to perhaps allow multiple 
partial early-output things, in case we get just 5 commits in the first 
0.1 seconds, then 50 in the first second, and 200 after 2 seconds.. I can 
well imagine getting the full list taking a long time over a network 
filesystem (somebody mentioned samba), and maybe having just a single 
trigger is too inflexible.

			Linus
