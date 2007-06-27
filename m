From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH] git-send-email: Add --threaded option
Date: Tue, 26 Jun 2007 22:32:03 -0700
Message-ID: <70B55529-9309-46D4-89A0-3FFD4D4E0660@apple.com>
References: <11828981103069-git-send-email-aroben@apple.com> <7vvedaq8eg.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0 (Apple Message framework v890.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 07:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Q8O-0002xP-Nn
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 07:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbXF0FcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 01:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbXF0FcH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 01:32:07 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:61750 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbXF0FcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 01:32:06 -0400
Received: from relay5.apple.com (relay5.apple.com [17.128.113.35])
	by mail-out4.apple.com (Postfix) with ESMTP id 56301A9425D;
	Tue, 26 Jun 2007 22:32:04 -0700 (PDT)
Received: from relay5.apple.com (unknown [127.0.0.1])
	by relay5.apple.com (Symantec Mail Security) with ESMTP id 4604629C002;
	Tue, 26 Jun 2007 22:32:04 -0700 (PDT)
X-AuditID: 11807123-a481fbb000000a55-e1-4681f654fa76
Received: from [17.219.196.73] (int-si-a.apple.com [17.128.113.41])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay5.apple.com (Apple SCV relay) with ESMTP id 304B030400B;
	Tue, 26 Jun 2007 22:32:04 -0700 (PDT)
In-Reply-To: <7vvedaq8eg.fsf@assigned-by-dhcp.pobox.com>
X-Mailer: Apple Mail (2.890.1)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51017>

On Jun 26, 2007, at 10:21 PM, Junio C Hamano wrote:

> Adam Roben <aroben@apple.com> writes:
>
>> @@ -138,8 +141,8 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
>> 	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
>>
>> # Behavior modification variables
>> -my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
>> -	$dry_run) = (1, 0, 0, 0, 0);
>> +my ($threaded, $chain_reply_to, $quiet, $suppress_from,  
>> $no_signed_off_cc,
>> +	$dry_run) = (1, 1, 0, 0, 0, 0);
>
> While we are at it, you might want to make everything other than
> quiet and dry_run overridable the same way.

    --[no-]chain-reply-to, --suppress-from and --no-signed-off-cc  
already exist, so do you mean that we should support --no-suppress- 
from and --signed-off-cc (i.e., the negations) as well? Or that we  
should have equivalent config settings for these? Or both?

    I also realized after sending this that git-format-patch has a -- 
[no-]thread option, so I think I'll change the name of this option to  
match.

-Adam
