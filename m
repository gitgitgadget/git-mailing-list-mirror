From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 13:30:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-401385306-1132349147=:13959"
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:53:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDop-000260-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVKRVak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKRVak
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:30:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751004AbVKRVaj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:30:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAILUUnO031183
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 13:30:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAILUNCG001646;
	Fri, 18 Nov 2005 13:30:27 -0800
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051118205513.GA3168@vrfy.org>
Content-ID: <Pine.LNX.4.64.0511181327310.13959@g5.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12279>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-401385306-1132349147=:13959
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0511181327311.13959@g5.osdl.org>



On Fri, 18 Nov 2005, Kay Sievers wrote:
> 
> Actually, the real bug is not to try to prevent binary nonsense in textual
> commit logs, which are distibuted. Remember, that you provide a SCM not a
> filesystem.

I never said they were text, and in fact, I never even said I'm doing an 
SCM. Quite the reverse. I very much said that I'm doing a filesystem that 
is flexible.

The fact that the headers are text-like is not so much about text as it is 
about flexibility and easy tool access. If you look at the git object 
format, for example, the header is strictly NUL-terminated ASCII, but the 
object itself is a pure binary data stream. Which obviously just _happens_ 
to often be text too, since quite often the object contents is something 
like a C source file, but there's a real power to _not_ thinking that it 
means that files are text-files.

And I like UTF-8, but the fact is, all my editors and mail tools are still 
Latin-1. My editor converts the UTF-8 input into latin1 and keeps it in 
that format on disk (it writes it to the _screen_ as UTF-1 just to make 
the glyphs come out right, but the file it works with is still latin1).

Could I change? Yup, I could change pretty easily. I wrote the code that 
did the latin1 conversion, and I've got source for my tools, so I could 
just decide one day that I'll join the 21st century and switch. I just 
haven't done so yet.

The fact that _I_ can't be bothered, even though I'm in just about the 
best possible situation (I've got a keyboard with едц on it, but they're 
not in my name, so I don't use them that much) should tell you something. 
Namely, it should tell you that there's a _lot_ of people who have a much 
harder time than I do in changing their setups. 

I think most of Asia _still_ doesn't use utf-8. And I _guarantee_ you that 
it's a hell of a lot easier for you to complain about it and say "they 
should" than it is for them to actually do so and convert all the programs 
they use.

On this mailing list, the only person that I've seen pipe up about these 
things in the past _and_ that I suspect actually has to work with this 
thing in real life (instead of just from a theoretical "this is how things 
should be done" standpoint) is Junio. And last I heard (if I remember 
correctly), Junio explicitly said that a lot of the people he works with 
still use shift-jis.

And I'm not surprised. Look on the web. As far as I know, shift-jis is 
still much more common than utf-8.

AND IT DOESN'T MATTER ONE WHIT WHEN SOME GEEK SAYS "THEY SHOULDN'T DO 
THAT, THEN"!

Software should conform to people, not the other way around. 

		Linus
--21872808-401385306-1132349147=:13959--
