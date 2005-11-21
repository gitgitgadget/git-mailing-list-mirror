From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 13:01:30 -0800
Message-ID: <438235AA.8070805@zytor.com>
References: <87hda61a80.fsf@gmail.com>	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org> <7vacfxrdao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:02:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeInm-0004ZL-Cy
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKUVCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKUVCJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:02:09 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56216 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750706AbVKUVCI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:02:08 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jALL1Z6x030150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 13:01:37 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacfxrdao.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12481>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
>>Of course, arguably "-M100" should really do this optimization for you. 
>>Junio?
> 
> 
> Probably something like this would suffice.
> 
> -- >8 --
> Subject: rename detection with -M100 means "exact renames only".
> 
> When the user is interested in pure renames, there is no point
> doing the similarity scores.  This changes the score argument
> parsing to special case -M100 (otherwise, it is a precision
> scaled value 0 <= v < 1 and would mean 0.1, not 1.0 --- if you
> do mean 0.1, you can say -M1), and optimizes the diffcore_rename
> transformation to only look at pure renames in that case.
> 

Any reason we can't make it take an actual decimal number, like -M1.0 or 
-M0.345?  It seems odd and annoying to invent our own notation for 
floating-point numbers, especially in userspace.

	-hpa
