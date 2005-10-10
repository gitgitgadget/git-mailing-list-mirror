From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Add ".git/config" file parser
Date: Mon, 10 Oct 2005 14:50:01 -0700
Message-ID: <434AE209.60605@zytor.com>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net> <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> <Pine.LNX.4.63.0510100220330.23242@iabervon.org> <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510101354520.23242@iabervon.org> <Pine.LNX.4.64.0510101120410.14597@g5.osdl.org> <Pine.LNX.4.64.0510101415080.14597@g5.osdl.org> <Pine.LNX.4.64.0510101446180.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 23:52:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5XL-0006Pb-KL
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJJVuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVJJVuU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:50:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5090 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751275AbVJJVuS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 17:50:18 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9ALo5ss010648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 14:50:05 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510101446180.14597@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9947>

Linus Torvalds wrote:
> 
> On Mon, 10 Oct 2005, Linus Torvalds wrote:
> 
>>	; core variables
>>	[core]
>>		; Don't trust file modes
>>		filemode = false
>>
>>	; Our diff algorithm 
>>	[diff]
>>		external = "/usr/local/bin/gnu-diff -u"
>>		renames = true
>>
>>which parses into two variables: "core.filemode" is associated with the 
>>string "false", and "diff.external" gets the appropriate quoted value.
>  
> _Three_ variables. Duh. I added the "renames" thing later, as I was 
> looking at what kinds of default flags the "git-diff-xyz" family might be 
> interested in having.
> 

A suggestion: if you make your basic types (integer, string, boolean) 
recognizable by the parser, you can present them in that way.  This 
pretty much means strings will have to always be double-quoted, but that 
avoids a bunch of ambiguities.

	-hpa
