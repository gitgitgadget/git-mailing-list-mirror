From: Phil Hord <hordp@cisco.com>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 21:09:02 -0400
Message-ID: <4E277C2E.2020402@cisco.com>
References: <20110720221632.14223.qmail@science.horizon.com> <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home> <4E276DF8.8030301@cisco.com> <alpine.LFD.2.00.1107202041480.21187@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, George Spelvin <linux@horizon.com>,
	anthonyvdgent@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 03:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjhlH-0005XC-3a
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 03:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab1GUBJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 21:09:05 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:64627 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1GUBJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 21:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1731; q=dns/txt;
  s=iport; t=1311210544; x=1312420144;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=872XsIA1Jp8lyQ3G5D06ows4CVr3nI1oUNwisp9Wgm4=;
  b=HmGbwWz2jof0tpBH6NzjAcXvEX56r9FC8S01w78MSkth7Qzc941n2ir1
   WQXssrtG5ec7o8N/ruRGK8bcUm4y2yOSXf5y3dyDW049UVjFbMglUBgXE
   F6OxpEqLvFqgeSG/2Wpa0XZzadF5W7rbzzjDsJSOd1GFIaaPSBYZtfnDQ
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAGt7J06tJV2b/2dsb2JhbABTp2V3iHydWJ4fhj0Ekm6FB4ty
X-IronPort-AV: E=Sophos;i="4.67,238,1309737600"; 
   d="scan'208";a="4927847"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-2.cisco.com with ESMTP; 21 Jul 2011 01:09:04 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p6L193rQ001881;
	Thu, 21 Jul 2011 01:09:03 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <alpine.LFD.2.00.1107202041480.21187@xanadu.home>
X-TagToolbar-Keys: D20110720210902460
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177570>

On 07/20/2011 08:58 PM, Nicolas Pitre wrote:
> On Wed, 20 Jul 2011, Phil Hord wrote:
>
>> On 07/20/2011 07:36 PM, Nicolas Pitre wrote:
>>> On Wed, 20 Jul 2011, david@lang.hm wrote:
>>>
>>>> If the generation number is part of the repository then it's going to
>>>> be the same for everyone.
>>> The actual generation number will be, and has to be, the same for
>>> everyone with the same repository content, regardless of the cache used.
>>> It is a well defined number with no room to interpretation.
>> Nonsense.
>>
>> Even if the generation number is well-defined and shared by all clients, the
>> only quasi-essential definition is "for each A in ancestors_of(B), gen(A)<
>> gen(B)".
> Sure.  But what do you gain by making holes in the sequence?

Depends on the algorithm.  Probably speed.  Possibly more efficient 
limited-cache building (jit-style discovery in reverse, as-needed, for 
example).

What do you gain by enforcing contiguousness?  Why not require all gen 
numbers to be even?  Or prime?  ;)

>> In practice, the actual generation number *will be the same* for everyone with
>> the same repository content, unless and until someone develops a different
>> calculation method.  But there is no reason to require that the number *has to
>> be* the same for everyone unless you expect (or require) everyone to share
>> their gen-caches.
> And with the above you clearly reinforced the argument _against_ storing
> the generation number in the commit object.  If you can imagine a
> different calculation method already, and if it is actually useful, then
> who knows if something even better could be done eventually.

Good.  Nice to see I'm being self-consistent, then.

Phil
