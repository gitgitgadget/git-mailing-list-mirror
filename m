From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: More builtin git-am issues..
Date: Sat, 5 Sep 2015 09:30:27 +0200
Message-ID: <55EA9A13.2050108@kdbg.org>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
 <CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
 <xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 09:31:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY7w5-0007vf-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 09:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbbIEHad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 03:30:33 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:2884 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbbIEHab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 03:30:31 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3n7SFw1bN0z5tlT;
	Sat,  5 Sep 2015 09:30:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6E20452EC;
	Sat,  5 Sep 2015 09:30:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277361>

Am 05.09.2015 um 02:54 schrieb Junio C Hamano:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So I think that logic should basically be extended to saying
>>
>>   - if any line in the last chunk has a "Signed-off-by:", set a flag.
>>
>>   - at the end of the loop, if that flag wasn't set, return 0.
>
> I am reluctant to special case S-o-b: too much, even though this is
> about "am -s" and by definition S-o-b: is special, as that is what
> we are adding after all.
>
> How about a bit looser rule like this?
>
>      A block of text at the end of the message, each and every
>      line in which must match "^[^: 	]+:[      ]" (that is,
>      a "keyword" that does not contain a whitespace nor a colon,
>      followed by a colon and whitespace, and arbitrary value thru
>      the end of line) is a signature block.

Why do we need a new rule? The old git-am had a logic that pleased 
everyone, and it must have been implemented somewhere. Shouldn't it be 
sufficient to just re-implement or re-use that logic?

-- Hannes
