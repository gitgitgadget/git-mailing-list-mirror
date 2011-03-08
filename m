From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 08 Mar 2011 10:39:55 +0100
Message-ID: <4D75F96B.7000707@drmicha.warpmail.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com> <4D75ED72.8030203@drmicha.warpmail.net> <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 10:43:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwtS0-0003Or-4g
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 10:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab1CHJn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 04:43:27 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41904 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753784Ab1CHJnY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 04:43:24 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 165B8209D4;
	Tue,  8 Mar 2011 04:43:24 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 08 Mar 2011 04:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5AJJbbt0CBPVKLS9HX1CMhR5wfk=; b=XnIbx/WGt9+RMmPGD0v+qdIszKoNL7bxkc99hOvNlno0+Aljree+7cCaAFLdogV3Clfs83u+pGKESWqUEVidkmLYcE0JhfyJcTfQO4eijogF4VYnH/eoDPVsM2fv+kcBXgEVOJ/1ulav8a/U1HB8kJniAvSIxqEWpQskrBylspA=
X-Sasl-enc: 5YHfzUToh59+waEv0zml1Nbe72IQIO5nCYrJsx17fxpk 1299577403
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 92719408309;
	Tue,  8 Mar 2011 04:43:23 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168650>

Jay Soffian venit, vidit, dixit 08.03.2011 10:35:
> On Tue, Mar 8, 2011 at 3:48 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Have you tried:
>>
>> git rev-list --ancestry-path --left-right foo...bar
>>
>> If the ">" commits are the ones that you want you only have to wait for
>> the "--right-only" option which is cooking in pu. And grep '^>' for now ;)
> 
> Ah. The rev-list man page entry on --ancestry-path only talks about
> using it with '..', so I didn't even try it with the symmetric diff
> operator ('...').

I understood --ancestry-path only after looking at revision.c, where
there's talk about "bottom commits", which gave me the right hint
(because I've been messing with the walker lately).

> 
> That said, seems it would be useful to have an easy way to get to the
> merge which has a merge-base as one of its parents. Maybe even a
> generic way to find all commits which have a particular parent. I
> think rev-list --parents | grep is the only way to do that today.

I had a patch for that but it was shot down because of the "grep"
workaround:

http://permalink.gmane.org/gmane.comp.version-control.git/157636

Maybe I should try again...

Michael
