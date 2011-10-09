From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sat, 08 Oct 2011 23:39:04 -0600
Message-ID: <160538a7-a5cf-48d6-b89e-f53f79ed25b6@email.android.com>
References: <1318107488.5865.46.camel@R0b0ty> <20111008213741.GA24409@goldbirke> <ab706826-75df-4410-941e-6b40ec92713c@email.android.com> <4E9115B0.3030701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: szeder@ira.uka.de, daly.gutierrez@gmail.com
To: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 07:41:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCm8Q-0002r8-6E
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 07:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab1JIFlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 01:41:08 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:63438 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1JIFlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 01:41:07 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6493"; a="126023669"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 08 Oct 2011 22:41:06 -0700
Received: from [192.168.1.190] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 5C18110004C2;
	Sat,  8 Oct 2011 22:40:48 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <4E9115B0.3030701@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183184>



"Joel C. Salomon" <joelcsalomon@gmail.com> wrote:

>On 10/08/2011 06:00 PM, Martin Fick wrote:
>>> git reflog to the rescue.
><snip>
>>> There you see the first line of the commit message from your "lost"
>>> commit, and you can do
>>>
>>>  git checkout -b lost_detached_head 92aa5381
>>>
>>> and you get a branch pointing to that commit you made while on
>>> detached head, and you can work with it as usual.
>> 
>> While rflog is cool, I can't help but think that git could be even
>more helpful for these scenarios.
>> 
>> First, maybe git could create refs for these automatically, perhaps
>with a name like orphans/1?  Maybe these refs would only be visible via
>git branch --orphans.
>
>Creating these "orphan" refs would require the equivalent of (part of)
>git-fsck; I can't imagine that could be imposed without significant
>overhead on too many operations.  I think you'd be better off wrapping
>git-fsck in a script that can create these branches.
 
Is there another way to create orphan refs than by doing a checkout and leaving the orphan behind?  I guess a rebase or other branch rewinding operations, but shouldn't it already know on those that that if it alters anything, it will create an orphan?  Git already checks for to see if it is leaving orphan refs behind on a checkout, why not just give the orphan a branch name at those points (not sure what to do if the check is bypassed with -q, just punt I guess)? 

-Martin 


Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
