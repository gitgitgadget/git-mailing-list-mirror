From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] merge: allow "-" as a short-hand for "previous branch"
Date: Fri, 08 Apr 2011 11:30:20 +0200
Message-ID: <4D9ED5AC.3050106@drmicha.warpmail.net>
References: <7vmxk164wd.fsf@alter.siamese.dyndns.org> <BANLkTikA3dFQpZWC=TC3+zp2FS=uBBxf0Q@mail.gmail.com> <7vbp0h63sw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Adam <thomas@xteddy.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 11:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q881N-0007WQ-3X
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 11:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab1DHJaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 05:30:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48532 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab1DHJaW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 05:30:22 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EDBB620B73;
	Fri,  8 Apr 2011 05:30:21 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 08 Apr 2011 05:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UIYTqFwP8nBg3mm10rnbfUsYEHU=; b=cGQZN4gFScx/8//OOg7uDNjMI4KEK/yK2X/FrHO652HtILjzy3z46jC17+KlZyqACzdnuJHvuZXyLuJox7ZbLpzEQ7vhiyxM1qGA2ubwXhO0Q6/lZS7uiCqj6HSQFTHgAH9LVuGc2gdzOZU02tPdrTKG8L+pJD5FlBGDdVflC/I=
X-Sasl-enc: CWcT9f3J7zXUecW1mz2286FgtNYNgc4Zx15rtU3uRUpV 1302255021
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 57943408588;
	Fri,  8 Apr 2011 05:30:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vbp0h63sw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171118>

Junio C Hamano venit, vidit, dixit 08.04.2011 01:26:
> Thomas Adam <thomas@xteddy.org> writes:
> 
>> I agree this is is useful, but is there a danger of this being a
>> common typo, and people merging in previous branches a lot more often
>> than they ever intended?  In the case of "git checkout -" that's not
>> as fatal, but if I ever mistype "git merge -" -- I'm now left with an
>> unraveling exercise to do.
> 
> Just like you can checkout the previous branch back if you found you
> checked out a wrong branch by a typo, if you found that you merged a wrong
> branch, you can just reset it away back to ORIG_HEAD, no?
> 
> Or am I missing something more obvious?

Only tests and doc :)

Seriously, I like that. If there are more places where this makes sense
(I haven't looked) we might even factor it out. In principle it makes
sense everywhere where a branch name makes sense, e.g.:

git branch -D foo
#...can't delete the current branch
git checkout whatever
git branch -D -

In this case, shell history is faster, of course.

Michael
