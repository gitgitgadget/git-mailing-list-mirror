From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:55:13 -0700
Message-ID: <928D2C14-23B9-4351-BBB2-234A94980E83@cs.indiana.edu>
References: <7vtzd5fta0.fsf@gitster.siamese.dyndns.org> <1219912327.7107.245.camel@pmac.infradead.org> <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com> <20080828115408.GA30834@hera.kernel.org> <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com> <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com> <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org> <B0BAA28F-C029-411B-BE86-3A63951CE213@cs.indiana.edu> <m3prnsrbdp.fsf@localhost.localdomain> <CD2FC91F-D5BB-486D-B138-F521A493FE73@cs.indiana.edu> <20080828234506.GA30195@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:56:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrLv-0001iq-3m
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYH1Xza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbYH1Xza
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:55:30 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:60710 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbYH1Xz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:55:29 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SNtK18015222;
	Thu, 28 Aug 2008 19:55:20 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SNtEtG011198
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 19:55:18 -0400
In-Reply-To: <20080828234506.GA30195@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94218>

Okay, thanks for the analysis!  He pulled a minor remark out and said  
I didn't look, when I had.  I have other things to do this week, but  
this thread is now, so I gotta do the ballpark measurements now (with  
some hope of reversing a upward compatibility breakage, which isn't  
important any more, see my other post).  Later I go in and s/git<DASH>/ 
git<SPACE>/g in my one-true-editor 8) and see for sure how many I  
actually need to change.  Gitweb wasn't my main problem, just one I  
had to think about when I can sit down and test the upgrade to 1.6.0.

-- Perry


On Aug 28, 2008, at 4:45 PM, Jeff King wrote:

> On Thu, Aug 28, 2008 at 04:14:14PM -0700, Perry Wagle wrote:
>
>> I did:
>>
>> pwagle@starscream:/usr/lib/cgi-bin$ ls -l
>> total 352
>> -rw-r--r-- 1 root root    164 2008-03-07 12:03 git-favicon.png
>> -rw-r--r-- 1 root root    208 2008-03-07 12:03 git-logo.png
>> -rwxr-xr-x 1 root root 167729 2008-03-07 12:03 gitweb.cgi
>> -rw-r--r-- 1 root root   7112 2008-03-07 12:03 gitweb.css
>> -rwxr-xr-x 1 root root 167932 2008-03-07 12:03 gitweb.perl
>> pwagle@starscream:/usr/lib/cgi-bin$ grep git- * | wc -l
>> 68
>> pwagle@starscream:/usr/lib/cgi-bin$
>
> 1. Your numbers are doubled because gitweb.cgi is the built form of
> gitweb.perl.
>
> 2. Look at the grep output. They are all in comments or messages.
> Perhaps the messages should say "open git diff failed" instead of  
> "open
> git-diff failed". But the "git-foo" form has been kept as a
> typographical convention because it makes more sense from a language
> perspective (just as you would hyphenate some compound words, or an
> adjective phrase). Perhaps that is a mistake, given the confusion.
>
> -Peff
