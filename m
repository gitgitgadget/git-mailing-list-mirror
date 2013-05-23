From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Thu, 23 May 2013 12:07:12 +0200
Message-ID: <519DEA50.4030407@drmicha.warpmail.net>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org> <519C7431.8050208@drmicha.warpmail.net> <7vy5b7j7kc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 12:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSQU-0006LQ-00
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758019Ab3EWKHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:07:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51479 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757887Ab3EWKHD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 06:07:03 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2133220AE2;
	Thu, 23 May 2013 06:07:03 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 23 May 2013 06:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qwHHHkNQzefS4Gn4/g9DlL
	+Dac4=; b=eZ2CK6AvjWWQTW2u6HPG41p0ELC7sQvwWG5zmeW/l+8VGBg/xwgVu/
	uwdoFEn3wJOhN59oDk83u+kR94nTtmmwRE8vnMZZoOwKjOul8/jfQwcuSTJXkmkF
	tOHZwI13xDIcLt8nL0N6s1e09YjGUr6kP11I6KFrPCZCrMNzzQ5oM=
X-Sasl-enc: cliID+m80cnaSQqD1V/s6eiE8eWwEqn7/F0Sy8R1zqTX 1369303622
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5963D200056;
	Thu, 23 May 2013 06:07:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
In-Reply-To: <7vy5b7j7kc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225231>

Junio C Hamano venit, vidit, dixit 22.05.2013 18:36:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> * mg/more-textconv (2013-05-10) 7 commits
>>>  - grep: honor --textconv for the case rev:path
>>>  - grep: allow to use textconv filters
>>>  - t7008: demonstrate behavior of grep with textconv
>>>  - cat-file: do not die on --textconv without textconv filters
>>>  - show: honor --textconv for blobs
>>>  - diff_opt: track whether flags have been set explicitly
>>>  - t4030: demonstrate behavior of show with textconv
>>>
>>>  I think this is ready for 'next'; not that it matters during the
>>>  prerelease feature freeze.
>>
>> Oh, I'm sorry, I thought we were still in discussions about the default
>> mechanism (config or attributes) and the implementation (tacking context
>> onto each object)? Therefore, I didn't hurry to polish and follow up
>> over my vacation. I'm not sure I had smoothed out all minor things
>> (honor/obey and such) when the object struct size issue came up. I'll
>> check today or tomorrow. (Freeze, yes, but we don't want too many next
>> rewrites, and one is coming soon...)
> 
> I thought this was fine as-is, but we can kick it back to 'pu' and
> replace it with a reroll after 1.8.3 if that is necessary.

Didn't you have concerns about storing the context in the object struct?
I can't quite judge how much of an issue this can be for fsck and such.
I don't want to increase the memory footprint unnecessarily, of course.

Other than that, the mechanism was still up for discussion (separate
"show" attribute or a config) given that the default behavior for
showing blobs is not to change.

Michael
