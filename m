From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Tue, 9 Sep 2008 01:54:41 +0400
Message-ID: <20080908215441.GA924@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com> <1220900995-11928-2-git-send-email-becky.bruce@freescale.com> <48C57A92.6060608@freescale.com> <20080908212717.GA21338@oksana.dev.rtsoft.ru> <48C59B71.3040902@freescale.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Becky Bruce <becky.bruce@freescale.com>, linuxppc-dev@ozlabs.org,
	git@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:55:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcoi7-00041c-3W
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbYIHVyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 17:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbYIHVyn
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:54:43 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:60580 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754033AbYIHVyn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 17:54:43 -0400
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 8610B881F; Tue,  9 Sep 2008 02:54:41 +0500 (SAMST)
Content-Disposition: inline
In-Reply-To: <48C59B71.3040902@freescale.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95308>

On Mon, Sep 08, 2008 at 04:38:57PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>> I always thought that posting "-M" patches to the public lists is
>> discouraged since it is quite difficult to apply them via patch(1).
>> Also think of non-git users...
>
> I think the substantially enhanced reviewability trumps non-git-users  
> who can follow the rename instructions manually (or fix up their patch  
> utility) if they insist on shunning tools that would make their life 
> easier.

Can't disagree, I myself use git. ;-) But I'm also using standard
patch(1) to test occasional patches... And sometimes linux-X tree
isn't tracked by git (e.g. -mm otm snapshots).

>> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
>> new file mode 100644
>> index 0000000..ae5708e
>> [...]
>> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
>> deleted file mode 100644
>> index ae5708e..0000000
>>
>> That is, if hashes match then it was pure rename.
>
> I suppose, though it's not as easy to spot, and won't help in showing  
> what the differences are if there are any.

..rename and changes ideally go in separate patches.

IIRC this also helps git to track renames (it can easily compare
hashes instead of guessing).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
