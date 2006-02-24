From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Fri, 24 Feb 2006 16:29:48 +0200
Message-ID: <43FF185C.1080909@dawes.za.net>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>	 <86hd6qgit5.fsf@blue.stonehenge.com>	 <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>	 <863bi9hq6u.fsf@blue.stonehenge.com>	 <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>	 <86lkw1g647.fsf@blue.stonehenge.com>	 <20060223211403.GB5827@steel.home> <43FE9771.4030206@dawes.za.net> <81b0412b0602240527v5d617111sc33e627ff3e1641c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 15:30:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCdxO-0001mQ-WA
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 15:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBXOaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 09:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBXOaB
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 09:30:01 -0500
Received: from whisk.dreamhost.com ([205.196.208.4]:15236 "EHLO
	whisk.dreamhost.com") by vger.kernel.org with ESMTP id S932168AbWBXOaA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 09:30:00 -0500
Received: from [200.14.17.1] (unknown [196.26.235.107])
	by whisk.dreamhost.com (Postfix) with ESMTP id D73FA7F024;
	Fri, 24 Feb 2006 06:29:53 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051201)
Newsgroups: gmane.comp.version-control.git
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602240527v5d617111sc33e627ff3e1641c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16705>

Alex Riesen wrote:
> On 2/24/06, Rogan Dawes <discard@dawes.za.net> wrote:
> > Not true.
>>
>>  > type t
>> #!perl -w
>>
>> print qx{echo joe & echo joe}."\n";
>>  > perl t
>> joe
>> joe
>>
> 
> Does not seem to be the case here (and yes, I check build 815 too):
> 
> $ perl -v
> 
> This is perl, v5.8.6 built for MSWin32-x86-multi-thread
> (with 3 registered patches, see perl -V for more detail)
> 
> Copyright 1987-2004, Larry Wall
> 
> Binary build 811 provided by ActiveState Corp. http://www.ActiveState.com
> ActiveState is a division of Sophos.
> Built Dec 13 2004 09:52:01
> ...
> 
> $ perl -e 'print qx{echo joe & echo joe}."\n";'
> joe & echo joe

Interesting. I tried to do that one-liner at a DOS prompt (not cygwin, 
which I assume you are using), and I was unable to do so. CMD was seeing 
the "&" first, and splitting the command in 2, namely

perl -e 'print qx joe

and

echo joe}."\n";'

which obviously didn't work.

Do you get the same results if you run it from a DOS prompt? and via a file?

Rogan
