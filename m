From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 13:48:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2097605737-1132350538=:13959"
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:14:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdE7A-0003W9-01
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVKRVtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKRVtc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:49:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932197AbVKRVtQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:49:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAILn2nO032029
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 13:49:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAILmxhC002507;
	Fri, 18 Nov 2005 13:49:00 -0800
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12270>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2097605737-1132350538=:13959
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 18 Nov 2005, Linus Torvalds wrote:
> 
> And last I heard (if I remember correctly), Junio explicitly said that a 
> lot of the people he works with still use shift-jis.

I should have dug it up. Apparently it's AUC-JP, not SJIS. 

Anyway. I literally have _no_ idea what the difference between those 
encodings are. I'm totally clueless when it comes to how the encodings 
actually work etc. I wouldn't know a Japanese character if it painted 
itself purple and did a risqué dance number.

But I do know just how slowly these conversions happen, and what a huge 
deal it is for people who have documents and tools and databases that are 
encoded in some particular encoding.

You do have to realize that while you may think that it's stupid that 
people use a non-utf8 encoding, those very people don't actually see a 
huge advantage from switching away from what has worked for them for 
decades, and they _do_ see huge transition pains and costs.

So let's say that you have a project where the coding style includes S-JIS 
or EUC-JP (of which there are multiple variations, I believe, just to make 
things even more fun). You could argue that if such a project moves into 
git, it should be converted to UTF-8 at that point. That's all fine and 
dandy, but usually you don't do flag-days. You have people who start 
tracking it in git, and maybe even developing it in git, but they still 
have to work with the outside people. 

Want to do on-the-fly conversion on CVS import (or worse yet - something 
like clearcase)? With magic rules or fragile heuristics for binary files? 
That's crazy, and that's not how these things work. No, the way these 
things work is that they continue to be maintained in EUC-JP or whatever, 
and a tool that requires conversion is a tool that just doesn't get used.

			Linus
--21872808-2097605737-1132350538=:13959--
