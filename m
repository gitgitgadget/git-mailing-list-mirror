From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] wt-status: take advice.statusHints seriously
Date: Fri, 23 Apr 2010 10:09:52 +0200
Message-ID: <4BD155D0.5080402@drmicha.warpmail.net>
References: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>	 <7v39yo53mt.fsf@alter.siamese.dyndns.org>	 <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net> <q2ibe6fef0d1004222115gcdd8fd81xce8993508bfa9f5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 10:13:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5E0s-0007Qw-Mt
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 10:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab0DWINH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 04:13:07 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34423 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752688Ab0DWIND (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 04:13:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B1D9AEB254;
	Fri, 23 Apr 2010 04:13:01 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 23 Apr 2010 04:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Lys4OY6g1lCIwB+SupuO2FibMxg=; b=CTIxiasa7h/g2Yq5nKNuF3VS0C73myrhEOvJVfxOWTa61kOnN06YFoYyr063rGoq7eO75QaibzFHNjoCpeS15DRhd1FQpmNF+YaqovIiFfJiq9kVXaBMnvnSsTQnp2/Tx96R5W/qsH1xps8iaxbxwX1Q/BLO0ii/DL7Yp/nnJLY=
X-Sasl-enc: 0XC0hVFAZmREL28WMrTw9mmfwpm+YKZ++8E5IgkPNCyf 1272010381
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D95DF485B2;
	Fri, 23 Apr 2010 04:13:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <q2ibe6fef0d1004222115gcdd8fd81xce8993508bfa9f5d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145594>

Tay Ray Chuan venit, vidit, dixit 23.04.2010 06:15:
> Hi,
> 
> On Fri, Apr 23, 2010 at 4:30 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>>                else if (s->untracked.nr)
>> -                       printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
>> +                       printf("nothing added to commit but untracked files present%s\n",
>> +                               advice_status_hints
>> +                               ? " (use \"git add\" to track)" : "");
> 
> while we're at it, perhaps we could put the hints on its own line,

I don't think I'm the only one to turn sour at every encounter with the
phrase "while we're at it". I did fix one extraneous space in code
"while I was at it", yes, but:

> with a "hint: " prefix:
> 
>   nothing added to commit but untracked files present
>   hint: use "git add" to track
> 
> This way, we give future git usability hackers the space to elaborate
> further on why a certain flag or command was recommended.
> 

I'm suggesting a change in (output) behaviour (hint vs. no hint), which
one may even consider to be a bug fix in terms of matching the obvious
expections related to advice.statusHints false.

You're suggesting a different presentation of the output. In fact, I
noticed inconsistent capitalisation in the hints which should be
adjusted, maybe together with the presentation.

But I deem both changes (overlapping though) unrelated.

Cheers,
Michael
