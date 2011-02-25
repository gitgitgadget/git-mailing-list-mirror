From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 14:05:49 +0100
Message-ID: <4D67A92D.2000300@drmicha.warpmail.net>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com> <AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com> <4D67A293.2050306@drmicha.warpmail.net> <AANLkTimqszvGjVeJHKLPWicDugeOuqbgO1+wy5BO-AE0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 14:09:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsxQ3-0001CT-Ll
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 14:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1BYNJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 08:09:10 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35753 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755301Ab1BYNJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 08:09:09 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9F99D20B54;
	Fri, 25 Feb 2011 08:09:08 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 25 Feb 2011 08:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hrrhIfl3P/zQvjIX2GIKXw6d0cE=; b=IbwRocgG8+PjdtD/caDIhCET7X3tQqycCb+GJFbztZeMP788WGndxGCBYf1Up44h+env+W1oPl0gFOb42HAzT8GiFi4E41kiqNFCoEK9cX3T3TQXMK58bDkmJWRqQLbILza+JnxVU73Bad9HZr+jZ+l7yhH+olP3I0I8Igkll/s=
X-Sasl-enc: ghAGnxXTtTpXX7/NWYMIEYOcrdDsw3L4Cm2Ksd8ChzMt 1298639348
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E8B4244268E;
	Fri, 25 Feb 2011 08:09:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTimqszvGjVeJHKLPWicDugeOuqbgO1+wy5BO-AE0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167904>

Dario Rodriguez venit, vidit, dixit 25.02.2011 13:48:
> The most sensible way to do this seems to be:

To do what? I you hadn't top posted we would know what "this" referred to.

>  git checkout HEAD~2 file.c
> 
> And your index will show file.c modified, as it will have it's content
> reverted 2 commits.

It will have its content reset to what it was in HEAD~2. This is very
different from reverting the change made in HEAD~2:

> The behavior of 'revert' is to revert commits, not files, so it's not
> expected to work if you say 'git revert <commit> <path>'

It makes perfect sense, it's just not implemented.

Note that you can also

git show <commit> -- <path> | git apply -R

to achieve a partial revert. That might be the easiest route to take.

Michael

[Cutting the bottom copy - what is it good for there?]
