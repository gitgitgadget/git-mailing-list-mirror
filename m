From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 17:41:17 +0100
Message-ID: <4D877FAD.9000807@viscovery.net>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com> <7vwrjssbfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:41:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1iAa-000636-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab1CUQlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:41:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27431 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753750Ab1CUQlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:41:22 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q1iAP-0002hZ-OV; Mon, 21 Mar 2011 17:41:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 741621660F;
	Mon, 21 Mar 2011 17:41:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vwrjssbfk.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169610>

Am 3/21/2011 17:09, schrieb Junio C Hamano:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>> But when I take a different approach, and in addition to this:
>>
>>> If I edit the file and remove the "<<<< HEAD" marked and code
>>> between "===" and ">>>"  then
>>
>> I also manually add the "+line" which is the change done in the cherry-picked
>> commit, git diff shows a lot of other changes in unrelated lines
>> (which lie close
>> but still were not modified by the patch, nor were shown previously by
>> git diff).
>>
>> This is very weird.
> 
> Sorry, I have no idea what you are talking about.

Assuming you did not 'git add' the file yet, you are looking at the
"condensed combined diff" after manually resolving the conflict by doing
the "+line" manually that the cherry-pick should have brought in. Of
course, a lot of context is visible here if both sides have diverged
considerably in this area.

I.e. the diff will look something like

 +line from HEAD
 +line from HEAD
+ line from cherry-picked
 +line from HEAD
...

Notice the double columns before the content lines. This sort of diff
extens above and below the conflicting section until there is a "gap" of 3
lines that changed neither on the HEAD side nor on the cherry-picked side
since the merge base.

-- Hannes
