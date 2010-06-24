From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 14:56:15 +0200
Message-ID: <4C2355EF.7030604@drmicha.warpmail.net>
References: <2251bbc1e40505dcb80103bf5daebea07dc0e9f7.1277374210.git.git@drmicha.warpmail.net> <vpqmxukir3e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 24 14:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORlza-0002ii-Uk
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 14:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab0FXM5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 08:57:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47809 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752381Ab0FXM5L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 08:57:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2C99A10940C;
	Thu, 24 Jun 2010 08:57:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 24 Jun 2010 08:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iuPcrdEqoRPzU/RKbs2X1ZtFnDs=; b=LHjIeFMkQQ11v/BD8OvvB5Oz6qDpmok+/5eHR5abp1ebSdQZESfWJumpbpl1CBQATPTww7oOmfM/CFDPzXz8jZURtnA2fkmDVftOkZWDV1rWjFV1rh06VqZpn0bRaNw8qNkpOraXgmr5ejNeZU/yBzxziw1u931MHRguln3KCJ4=
X-Sasl-enc: 3qCxvkO8GdtulbGHeTNBS87gCnrHo016hVhbF6fXHtqC 1277384217
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D94C24E2462;
	Thu, 24 Jun 2010 08:56:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <vpqmxukir3e.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149588>

Matthieu Moy venit, vidit, dixit 24.06.2010 13:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> This formulation is based on my understanding that you can't cat-file
>>  --textconv something in the index or worktree.
> 
> Actually, you can't textconv from the worktree, but you can from the
> index, saying
> 
> git cat-file --textconv :path/to/file
> 
> (the :<path> syntax is not specific here, you can use it in other Git
> commands)
> 
>> +--textconv::
>> +	Show the content as transformed by a textconv filter. In this case,
>> +	<object> has be of the form <treeish:path>, with treeish defaulting to
>> +	HEAD.
> 
> So the "defaulting to HEAD" is incorrect. 

Oh no, this is bad! I'd say every git command defaults to HEAD when a
commitish/treeish is not specified!!

Wait a minute:

git show HEAD:path >a
git show :path >b
diff a b

Oh no! We've been having this all along. This is bad but probably
unchangeable.

> Also, I prefer
> <treeish>:<path> to <treeish:path>, to make it clear the : is actually
> a :.

I was going with the usage line, but you are right: <a>:<b> makes more
sense semantically and is clearer.

> 
> What about this:
> 
> --textconv:: 
> 	Show the content as transformed by a textconv filter. In this
> 	case, <object> has be of the form <treeish>:<path>, or :<path>
> 	to run the filter on the file <path> stored in the index.
> 

I'll be more mathematically stubborn about "file", see v2;)

Michael
