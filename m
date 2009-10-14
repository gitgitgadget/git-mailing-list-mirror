From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 18:22:34 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <4AD5601A.8090503@catalyst.net.nz>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz> <7vr5t6lfr0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxwKy-0001Un-8L
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZJNFXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZJNFXN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:23:13 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51224 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZJNFXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:23:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 3606432214;
	Wed, 14 Oct 2009 18:22:35 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dC8n9gk38zc; Wed, 14 Oct 2009 18:22:34 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id ADEF93219C;
	Wed, 14 Oct 2009 18:22:34 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <7vr5t6lfr0.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130253>

Junio C Hamano wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
> 
>> Add a simple hook that will run before checkouts.
>>
>> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
>> ---
>>  Documentation/githooks.txt |   20 +++++++++++++++-----
>>  builtin-checkout.c         |   25 ++++++++++++++++++++++---
>>  2 files changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index 06e0f31..8dc3fbf 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -143,21 +143,31 @@ pre-rebase
>>  This hook is called by 'git-rebase' and can be used to prevent a branch
>>  from getting rebased.
>>  
>> +pre-checkout
>> +-----------
>>  
>> -post-checkout
>> -~~~~~~~~~~~~~
>> -
>> -This hook is invoked when a 'git-checkout' is run after having updated the
>> +This hook is invoked when a 'git-checkout' is run after before updating the
> 
> "after before"?

*ahem* whoops :).  I think I got the heading style wrong too...

> This is not about your patch, but the patch text shows that our diff
> algorithm seems to have a room for improvement.  I expected to see a
> straight insersion of block of text, not touching anything in the original
> section on post-checkout hook.

Correct.  This is because the paragraph explaining when the hook runs
has been moved to the pre-checkout paragraph, which appears before the
post-checkout section.  I just compared the output to 'diff -du' and it
seems to be the same, so I wouldn't worry too much.
-- 
Sam Vilain, Perl Hacker, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        PGP ID: 0x66B25843
