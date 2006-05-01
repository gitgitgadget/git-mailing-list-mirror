From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Mon, 01 May 2006 13:25:30 +1200
Message-ID: <4455638A.3070802@vilain.net>
References: <20060429165151.2570.qmail@science.horizon.com>	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>	<e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>	<7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net> <7v8xpmva9x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 03:26:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaNAo-000461-0t
	for gcvg-git@gmane.org; Mon, 01 May 2006 03:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWEABZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 21:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEABZy
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 21:25:54 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52870 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750793AbWEABZx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 21:25:53 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 83CCE5968; Mon,  1 May 2006 13:25:42 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id AEC441C04;
	Mon,  1 May 2006 13:25:31 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xpmva9x.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19367>

Junio C Hamano wrote:

>>We can fast-forward if (1) you pulled from "pu" the last time,
>>and (2) you haven't added anything on top of it on your own, and
>>(3) you pull from "pu" again, if the previous "pu" (i.e. your
>>"pu") is a parent of the updated "pu".  We do not need "prior"
>>for that.  The old "pu" being _one_ _of_ the parents, not even
>>necessarily be the first one, would do just fine.
>>    
>>
>
>This part may want a bit more elaboration.  
>
>Often, we see in the Linus kernel tree a fast forward of his tip
>from a recent commit Linus made to bunch of networking commits
>made by David S Miller.  For example, Linus fast forwarded to
>18118c from David's tree before making this commit:
> [...]
>To David, the commits he has in the chain between 6b426e to
>18118c obviously suited the purpose of his tree better, and that
>was why these commits were made.  And the fact Linus fast
>forwarded to the tip of David is an implicit statement by Linus
>that that results suits the purpose of Linus tree better as well
>compared to his old tip, presumably 6b426e.
>  
>

Aha, now I see reason in the madness. So, the "prior" head is not stored
in the trees, and tracking the progress of actual head transitions is
loosely defined / a research topic. But demonstrably derivable. That
works for me.

Sam.
