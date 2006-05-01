From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Mon, 01 May 2006 12:05:24 +1200
Message-ID: <445550C4.5020800@vilain.net>
References: <20060429165151.2570.qmail@science.horizon.com>	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 02:05:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaLv7-0000S9-9W
	for gcvg-git@gmane.org; Mon, 01 May 2006 02:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEAAFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 20:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWEAAFm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 20:05:42 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50310 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750700AbWEAAFl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 20:05:41 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id E16B3595A; Mon,  1 May 2006 12:05:34 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 2BB401C9B;
	Mon,  1 May 2006 12:05:26 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viros1585.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19365>

Junio C Hamano wrote:

>> * "prior" - heads that represent topic branch merges
>>    
>>
>
>This is not any different from usual "parent" at all (but you
>have to think about it a bit to realize it).
> [...]
>Once you start reading the commit parent to mean " considering
>what all of these commits have, what this new commit has suits
>my purpose better", it becomes clear that the "previous" pointer
>for a branch like my "pu" is just another "parent".
>  
>

How can you look back at the merge history and determine which of these
scenarios is the case?

It still looks like to me that you are recording two distinct types of
parent using the same type of link.  You're now just expanding the
definition of parent so they look to be the same.

Actually it might be alright if you have an extra merge commit object. 
ie, make a complete merge of the new tips, then make a second merge that
merges the two heads.  It's still a little bit of a research topic to
look at that mess and figure out which type of relationship each parent
actually is, but if you really want to decide that is that and done is
done then I guess we'll all just have to live with it or fork.

Sam.
