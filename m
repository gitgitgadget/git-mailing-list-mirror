From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH 3/6] Make showdate use "Linus format"
Date: Sat, 11 Jun 2005 10:28:56 +0200
Message-ID: <42AAA0C8.9020102@gmail.com>
References: <42A825C2.1060302@gmail.com> <20050610225938.GE22111@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 10:30:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh1Nh-0003uS-4H
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 10:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVFKIaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 04:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVFKI3f
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 04:29:35 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:889 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261652AbVFKI3B (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 04:29:01 -0400
Received: by wproxy.gmail.com with SMTP id 68so595046wri
        for <git@vger.kernel.org>; Sat, 11 Jun 2005 01:28:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DHTWIG+HIe8a1UiqLlfhFJMC1D8UqTdaxNv+n4CGG6QNjthuuRSP4JgL/QuegYlEWYcJZKcN2P9N7RIYbyZ9wFpHHVeNANF07nawcGM9RtmXg9jbp0g0vueA8uoSXpI7l+O5MdsMAyzHeUZTLle0taVM+4higLBf01G4GGACxPQ=
Received: by 10.54.10.7 with SMTP id 7mr1409585wrj;
        Sat, 11 Jun 2005 01:28:58 -0700 (PDT)
Received: from ?192.168.0.124? ([81.224.201.139])
        by mx.gmail.com with ESMTP id g5sm2139078wra.2005.06.11.01.28.57;
        Sat, 11 Jun 2005 01:28:58 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050610225938.GE22111@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Thanks, applied.
> 
> Dear diary, on Thu, Jun 09, 2005 at 01:19:30PM CEST, I got a letter
> where Dan Holmsand <holmsand@gmail.com> told me that...
> 
>>This makes showdate use the same date format as
>>git-rev-list --pretty, and gives some speedup. It might also
>>be more portable.
> 
> 
> I dropped the format change bit, because I really think the Linus' date
> format is bad. The current standardized, international and most widely
> used (even your mailer agent used it in your Date: header) date format
> is RFC 822, so please let's stick with it. It's perfect for our use, and
> better human-readable too. The date part isn't split all around but
> concentrated in the first half while the second half is dedicated to
> time.

Ok, I really have nothing against RFC822. But if Linus' format is bad, 
then git-rev-list --pretty should be fixed (or, rather, date.c). It 
doesn't make any sense to me to have different formats between cogito 
and core git.

And I'd really, really like to use as much of git-rev-list --pretty 
output as possible in cg-log. That makes the whole thing some orders of 
magnitude faster, and thus more usable.

>>Note that this changes the calling convention: the previous
>>version used seconds from $1, but timezone from the global
>>variable $date. cg-mkpatch is modified to the new way.
> 
> 
> You forgot to modify cg-log accordingly. (I fixed that.)

Thanks. I did the "hope he takes my other patch too" thing... Sorry 
'bout that.

/dan
