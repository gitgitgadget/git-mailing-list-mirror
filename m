From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 21:51:56 +0100
Message-ID: <200511182151.56161.Josef.Weidendorfer@gmx.de>
References: <200511181833.40048.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <437E3971.3060803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 23:34:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDDT-0007ZH-01
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbVKRUv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbVKRUv7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:51:59 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:17349 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1161198AbVKRUv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:51:58 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 39851289F
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 21:51:57 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <437E3971.3060803@zytor.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12275>

On Friday 18 November 2005 21:28, H. Peter Anvin wrote:
> I think the point is: what do you do with the data?  If it *looks* like 
> valid UTF-8, you pretty much have to assume it is; if it's not (it 
> contains invalid UTF-8 sequences), what do you do?  There are only a 
> small handful of alternatives, and none are really good:
> 
> 	- Reject it (it's kind of too late, should have been done at
> 	  checkin)
> 	- Show them as SUBSTITUTE characters (U+FFFD).
> 	- Show them as Latin-1 or Windows-1252
> 	- Provide a complex configuration mechanism
> 
> I think Kay is going with the second option.

In the case of the Linux kernel, UTF-8 of course is the
way to go. As you can not reject already commited objects, the second
option seems the best way.

But I think it would be better to have a config option specifying the
prefered encoding for commit comments in a project. Something like

	core.commit-encoding = Latin-1

gitweb should use this.

Josef
> 
