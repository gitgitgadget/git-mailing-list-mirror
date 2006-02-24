From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Fri, 24 Feb 2006 07:19:45 +0200
Message-ID: <43FE9771.4030206@dawes.za.net>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com> <86hd6qgit5.fsf@blue.stonehenge.com> <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net> <863bi9hq6u.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de> <86lkw1g647.fsf@blue.stonehenge.com> <20060223211403.GB5827@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 06:20:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCVNi-0003Qh-8g
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 06:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWBXFU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 00:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWBXFU0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 00:20:26 -0500
Received: from knife.dreamhost.com ([66.33.219.6]:59043 "EHLO
	knife.dreamhost.com") by vger.kernel.org with ESMTP
	id S1750879AbWBXFU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 00:20:26 -0500
Received: from [192.168.1.64] (dsl-146-90-253.telkomadsl.co.za [165.146.90.253])
	by knife.dreamhost.com (Postfix) with ESMTP id A8B3DFB1EA;
	Thu, 23 Feb 2006 21:20:19 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051201)
Newsgroups: gmane.comp.version-control.git
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060223211403.GB5827@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16682>

Alex Riesen wrote:
> Randal L. Schwartz, Thu, Feb 23, 2006 21:41:44 +0100:
>> Johannes> Now that our local Perl guru joined the discussion, may I ask what
>> Johannes> is, and what is not quoted when put inside qx{}?
>>
>> Nothing is quoted.  Your string acts as if it was XXX in:
>>
>>         sh -c 'XXX'
>>
> 
> Not so for ActiveState. It'll just run the first non-whitespace word
> passing the rest of the line in its command-line.
> It's not even worse then to pass it all to cmd/command :)
> 

Not true.

 > type t
#!perl -w

print qx{echo joe & echo joe}."\n";
 > perl t
joe
joe

 >

If the shell was not interpreting the arguments, you would expect to get 
1 line with:

joe & echo joe

on it.

 > perl -v
This is perl, v5.8.7 built for MSWin32-x86-multi-thread
(with 7 registered patches, see perl -V for more detail)

Copyright 1987-2005, Larry Wall

Binary build 813 [148120] provided by ActiveState http://www.ActiveState.com
ActiveState is a division of Sophos.
Built Jun  6 2005 13:36:37

Perl may be copied only under the terms of either the Artistic License 
or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using `man perl' or `perldoc perl'.  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.

Regards,

Rogan
