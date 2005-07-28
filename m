From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Thu, 28 Jul 2005 12:04:31 -0400
Message-ID: <42E9020F.3080302@gmail.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <20050728155210.GA17952@pasky.ji.cz>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:10:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyAxe-0005ho-Q6
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVG1QJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVG1QHA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 12:07:00 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:27735 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVG1QEf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 12:04:35 -0400
Received: by wproxy.gmail.com with SMTP id i24so426176wra
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 09:04:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XP1O1yE2Hi7bLibpii9YhWkxtq9BWfvt8gCIR/SQFZeG5Oip1ktCaP9buAdgIoSASaIMcsJt5yS6vyY76/d077O2rGJgIYMe3t0z8gy2kZUlsVqxRIPVohN59wVjccZbqwvRDp8Pkz42Igw9R8zbNP9crDa5AdISWY4e+T/Lnt4=
Received: by 10.54.13.59 with SMTP id 59mr859971wrm;
        Thu, 28 Jul 2005 09:04:34 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 45sm1397958wri.2005.07.28.09.04.33;
        Thu, 28 Jul 2005 09:04:34 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050728155210.GA17952@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>   I think this is wrong, and my brief experiments confirm that. I think
> that the actually useful semantics of exclusion would be for
> _subsequent_ exclusions, not preliminary ones. You generally don't say
> "I never want this ignored, but I want the rest of that ignored", but
> "I want that ignored, except this". This also gives you more
> flexibility:
> 
> 	*.html
> 	!f*.html
> 	fo*.html
> 
> would ignore *.html and fo*.html, but not any other f*.html filenames.
> But more importantly,
> 
> 	.gitignore: *.txt
> 	Documentation/.gitignore: !*.txt
> 
> will not work, which was the whole _point_ of the exclusion.

So you're arguing for "last match wins" versus "first match wins". I, 
personally, find the former more natural and easier to debug by hand.
