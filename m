From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-pack-objects gitattributes?
Date: Mon, 19 Oct 2009 21:15:19 +0200
Message-ID: <4ADCBAC7.9010601@drmicha.warpmail.net>
References: <4AD3B4F8.6030007@codeaurora.org> <4ADCB457.8050601@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 21:15:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzxhf-0000Dm-A7
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 21:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbZJSTPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZJSTPX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 15:15:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58653 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702AbZJSTPX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 15:15:23 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5D39FB4BAC;
	Mon, 19 Oct 2009 15:15:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 19 Oct 2009 15:15:27 -0400
X-Sasl-enc: wQoZGki8Dwy6aBFXhqobkkLON08YfqHw7hq6prfX33VU 1255979726
Received: from localhost.localdomain (p5DCC180B.dip0.t-ipconnect.de [93.204.24.11])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C06A29AE5;
	Mon, 19 Oct 2009 15:15:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091019 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <4ADCB457.8050601@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130729>

Nasser Grainawi venit, vidit, dixit 19.10.2009 20:47:
> Nasser Grainawi wrote:
>> Hello,
>>
>> I'm trying to avoid doing delta compression on a number of large binary 
>> files. I got a suggestion to use $GIT_DIR/info/attributes and a line 
>> like this:
>> *.bin -delta
>>
>> This doesn't seem to show a big improvement (and honestly I can't find 
>> where in the git-pack-objects source the value of this attribute is used).
>>
>> Could someone shed some light on this attribute and any other 
>> improvements I could make for efficiently serving up a repo over 
>> git-daemon with near-weekly revisions of 100MB+ files?
>>
>> Thanks,
>> Nasser
> 
> ping? any help? anyone?

Well, describing a reproducable test case would help... as well as
telling us your git version.

builtin-pack-objects.c certainly refers to the delta attribute, see
no_try_delta() and its callers.

Have you checked your attrs with git-check-attr? How do you measure the
improvements you expect?

Michael
