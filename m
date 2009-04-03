From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add custom memory allocator to MinGW and MacOS builds
Date: Fri, 03 Apr 2009 16:20:37 +0200
Message-ID: <49D61B35.8060508@trolltech.com>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 16:22:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpkHc-0004rZ-Sy
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 16:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbZDCOUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761620AbZDCOUk
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 10:20:40 -0400
Received: from hoat.troll.no ([62.70.27.150]:39664 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840AbZDCOUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 10:20:39 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1A810211C9;
	Fri,  3 Apr 2009 16:20:37 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id EEBBB211C6;
	Fri,  3 Apr 2009 16:20:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <1238766761-3576-1-git-send-email-marius@trolltech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115531>

Marius Storm-Olsen said the following on 03.04.2009 15:52:
> The standard allocator on Windows is pretty bad prior
> to Windows Vista, and nedmalloc is better than the
> modified dlmalloc provided with newer versions of the
> MinGW libc.

Actually, it just struck me that it's probably the synchronization 
primitives which are better on Vista than XP, and not the memory 
manager? (Since mingw 4.3.3-tdm on XP and Vista most likely use the 
same dlmalloc fork?) ^shrug^

Anyways, not that I haven't tried to 'tune' nedmalloc in any way, just 
ensured that it compiles with the different MinGWs which I 
benchmarked. So, if anyone feels like it, maybe we can squeeze more 
performance out of it by tweaking it.

--
.marius
