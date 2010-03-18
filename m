From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Thu, 18 Mar 2010 08:08:51 +0100
Message-ID: <4BA1D183.3050907@viscovery.net>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock> <4BA07DC7.9070502@viscovery.net> <20100317155842.GA2557@m62s10.vlinux.de> <4BA0FE59.7020303@viscovery.net> <20100317184210.GB2557@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 18 08:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns9qn-0000iI-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 08:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab0CRHI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 03:08:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5056 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922Ab0CRHIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 03:08:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ns9qe-0006tf-6C; Thu, 18 Mar 2010 08:08:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E078C1660F;
	Thu, 18 Mar 2010 08:08:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100317184210.GB2557@m62s10.vlinux.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142451>

Peter Baumann schrieb:
> On Wed, Mar 17, 2010 at 05:07:53PM +0100, Johannes Sixt wrote:
>> Peter Baumann schrieb:
>>> On Wed, Mar 17, 2010 at 07:59:19AM +0100, Johannes Sixt wrote:
>>>> If I were to re-merge topic into master a second time after this
>>>> situation, I would install a temporary graft that removes the second
>>>> parent of M and repeat the merge. After the graft is removed, the history
>>>> would look like this:
>>>>
>>>>      B --- C --- D --------------.   [topic]
>>>>    /              \               \
>>>>   A ---  ...   --- M ... --- U ... N [master]
>>>>
>>>> Are there any downsides? I don't know - I haven't thought it through.
>>>>
>>> Might be. If there is any branch starting anywhere in between M and U
>>> which also needs to merge [topic] will also cause you headaches :-)
>>>
>>>        B --- C --- D --------------.   [topic]
>>>      /              \               \
>>>     A ---  ...   --- M ... --- U ... N [master]
>>>                          \
>>>                           x --- y [side_branch wich needs to merge topic] 
>> ?? I don't follow you. The side branch already contains the topic. What do
>> you want to merge?
>>
> 
> Won't it loose the revert 'U' after merging side_branch back to master?
> 
> Ah. Looking at the picture more closely, I could answer myself and say it would
> only cause a huge mergeconflict, won't it?.

No. N and the merge-base of N and y are identical (wrt changes introduced
by B,C,D). At least this part will not cause any conflicts.

-- Hannes
