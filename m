From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git am and the wrong chunk of ---
Date: Fri, 10 Aug 2012 07:48:39 -0700
Message-ID: <b661ef79-510e-4be6-bed2-451e9967db6f@email.android.com>
References: <5024523F.3050208@zytor.com> <20120810103612.GA21562@sigill.intra.peff.net> <7vsjbuls9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 16:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzqWJ-0003RW-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 16:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924Ab2HJOsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 10:48:54 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51342 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758653Ab2HJOsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 10:48:54 -0400
Received: from wld7.hos.anvin.org (c-67-188-81-177.hsd1.ca.comcast.net [67.188.81.177])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q7AEmg1o020512
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 10 Aug 2012 07:48:42 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <7vsjbuls9h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203220>

The users I am referring to generally have a --- line, rather than a scissor, between the cover text and commit.  Also, there is (almost) always a From: line and subject at the top of the patch proper.

Junio C Hamano <gitster@pobox.com> wrote:

>Jeff King <peff@peff.net> writes:
>
>> If I understand your issue, somebody is writing:
>>
>>
>>     From: them
>>     To: you
>>     Date: ...
>>     Subject: [PATCH] subject line
>>
>>     commit message body
>>     ....
>>
>>     some cover letter material that should go below the "---"
>>     ---
>>       [diffstat + diff]
>>
>> How do you know when the commit message body ends, and the cover
>letter
>> begins? We already have two machine-readable formats for separating
>the
>> two ("---" after the commit message, and "-- >8 --" scissors before).
>Is
>> there some machine-readable hint? Is it always the paragraph before
>the
>> "---"? Chopping that off unconditionally seems like a dangerous
>> heuristic.
>
>Or it could be like this:
>
>    ...
>    Subject: [PATCH] patch title
>
>    Heya,
>
>    I was walking my dog when I found a solution to this
>    problem the other day.  Here it is.
>
>    commit message body
>
>    S-o-b: ...
>    ---
>
>And I agree that clever heuristics are dangerous.  We need to draw a
>line somewhere anyway, and the line should be at the place that is
>easily understandable to people.  That means mechanically parseable
>and easy to follow convention to use markers e.g. "---".

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
