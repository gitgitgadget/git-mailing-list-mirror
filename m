From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Git on MSys broken
Date: Thu, 26 Feb 2009 21:52:16 +0100
Message-ID: <49A70100.4010604@trolltech.com>
References: <20090226195639.GB19384@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:54:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcnEr-0003zD-Qy
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbZBZUwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 15:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbZBZUwW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:52:22 -0500
Received: from hoat.troll.no ([62.70.27.150]:52041 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbZBZUwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 15:52:22 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3893F21017;
	Thu, 26 Feb 2009 21:52:15 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 177082100D;
	Thu, 26 Feb 2009 21:52:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <20090226195639.GB19384@denkbrett.schottelius.org>
X-Enigmail-Version: 0.95.7
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111599>

Nico -telmich- Schottelius said the following on 26.02.2009 20:56:
> Well, it's already known, but the the hint from 
> http://code.google.com/p/msysgit/issues/detail?id=133 (found only
> from http://code.google.com/p/msysgit/issues/detail?id=176)
> 
> to install a differnt dll can just be considered a dirty hack.
> 
> Sorry msys-guys, the only thing left now is a bad impression.

Well, to our defence, it's not our bug but an MSys issue. The r00t of 
the problem is the base address of the msys dll, and that relocating 
it for some reason breaks. So, in the end it depends on you system, 
and which DLLs msys will pull in there, and what those DLLs base 
address is. If they collide, and the msys dll need to relocate on your 
machine, this bug may manifest itself.

AFAIK someone on the team is looking into it, but the team is rather 
small and have limited resources. Any help would be greatly 
appreciated, especially from people that can reproduce the error, 
which I can't :-(

--
.marius
