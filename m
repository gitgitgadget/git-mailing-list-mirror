From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 19:10:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511191901560.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
 <7vek5deam6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
 <7v7jb57wud.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
 <Pine.LNX.4.63.0511200215480.11653@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-994416775-1132456253=:13959"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 04:12:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edfbr-0005PC-J2
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 04:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVKTDLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 22:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVKTDLN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 22:11:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751174AbVKTDLL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 22:11:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAK3AxnO031509
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 19 Nov 2005 19:11:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAK3ArxG020884;
	Sat, 19 Nov 2005 19:10:57 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511200215480.11653@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12367>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-994416775-1132456253=:13959
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 20 Nov 2005, Johannes Schindelin wrote:
> 
> On Sat, 19 Nov 2005, Linus Torvalds wrote:
> >
> > And text with 8-bit latin1 is almost never valid utf-8. 
> 
> I had the impression utf-8 was designed in a way so you could strike 
> "almost". But I don't have my docs handy...

No, strange latin combinations will be valid utf-8. 

It needs to be some really strange text to be real latin1 but look like it 
might be utf-8, though.

(In Finnish/Swedish, the letter 'ä' is code \x00E4, which in UTF-8 is the 
sequence \xA5\xC3. But you can't know if a text that has that sequence is 
UTF-8, or if it's a strange two-character latin1 sequence of "Ã¥" 
(character codes \x00A5 and \x00C3).

But I can pretty much guarantee that most any _sane_ latin1 text will 
obviously not be UTF-8, so in _practice_ you can definitely tell the two 
apart.

		Linus
--21872808-994416775-1132456253=:13959--
