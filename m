From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 21:59:28 +0900
Message-ID: <buooddvekb3.fsf@dhapc248.dev.necel.com>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	<7voddv6fxz.fsf@gitster.siamese.dyndns.org>
	<buozlxfeu0z.fsf@dhapc248.dev.necel.com>
	<995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com>
	<buotznnesw9.fsf@dhapc248.dev.necel.com>
	<86tznn4y7v.fsf@lola.quinscape.zz>
	<fc339e4a0711150300n64b9d670o1e183553a9de0cba@mail.gmail.com>
	<861war4uzp.fsf@lola.quinscape.zz>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 14:00:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IseKA-0003MD-G0
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 14:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbXKOM7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 07:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbXKOM7p
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 07:59:45 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:49947 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbXKOM7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 07:59:43 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAFCxLGw005432;
	Thu, 15 Nov 2007 21:59:28 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay21.aps.necel.com with ESMTP; Thu, 15 Nov 2007 21:59:28 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Thu, 15 Nov 2007 21:59:28 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 9DA7B43B; Thu, 15 Nov 2007 21:59:28 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <861war4uzp.fsf@lola.quinscape.zz> (David Kastrup's message of "Thu\, 15 Nov 2007 12\:18\:50 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65116>

David Kastrup <dak@gnu.org> writes:
>> For typical straightforward usage, there seems little problem.
>>
>> [The main portability problems I've actually _noticed_ with sed are
>> the "-e" versus ";" issue and what happens with "\n" in various
>> contexts...]
>
> What about character classes containing the pattern delimiter, \+, \?,
> \|, nested grouping, anchors in groups, * after groups?  That's all
> rather straightforward usage.

You're right that the regexp stuff is not really "dusty corners", but
none of those affect typical sed usage I think -- most sed usage being
really rather simple (and the old "regexps differ between traditional
unix tools" issue tends to dampen enthusiasm for really complex regexps
with those tools).

I looked over the various random uses of sed I have locally (a couple of
hundred instances), and the only thing which would potentially affect
any of them would be the SVR3 thing about no nested groups (does anybody
actually care about SVR3 though?!?).

-Miles

-- 
Yo mama's so fat when she gets on an elevator it HAS to go down.
