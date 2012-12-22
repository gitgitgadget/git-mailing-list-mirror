From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Sat, 22 Dec 2012 17:41:27 +0100
Message-ID: <50D5E2B7.5010303@drmicha.warpmail.net>
References: <op.wpiovoj5qrq7tp@acorna.invalid.invalid> <50D454D2.5030403@drmicha.warpmail.net> <op.wpn2xz07vqd7e2@damia.oslo.osa> <50D468E6.2090900@drmicha.warpmail.net> <op.wpn9d6xuvqd7e2@damia.oslo.osa> <vpqhanf2yny.fsf@grenoble-inp.fr> <op.wpontloxvqd7e2@damia.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Yngve Nysaeter Pettersen <yngve@opera.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 17:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmS91-0004mK-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 17:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab2LVQle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 11:41:34 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43632 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659Ab2LVQld (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 11:41:33 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D0DF3203D8;
	Sat, 22 Dec 2012 11:41:32 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 22 Dec 2012 11:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=FijCUxQ10n6TfxU2BA+6Ao
	9f2Sw=; b=bWYmhn/FaFtQycRcklLOqstqz346bW8EtP+0cda0TSMuxeookV6w2z
	yhfvhJx6+jzBH8NmTVp+/wGdkZ27wPjKOznsifXH3hniNo5IEyT90ALfnA0gLTZB
	QD2rl0QXRXlYV7uNhimHjNPhHZOZBz01vZcbaErlPAy9S1Q/lswkU=
X-Sasl-enc: lNp/uyrdMbMRhJ+9ifVxkhG+WuNQb4iS3SfG40sf1x+8 1356194492
Received: from localhost.localdomain (unknown [88.70.134.107])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1E2988E06FA;
	Sat, 22 Dec 2012 11:41:31 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <op.wpontloxvqd7e2@damia.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212057>

Yngve Nysaeter Pettersen venit, vidit, dixit 21.12.2012 21:13:
> On Fri, 21 Dec 2012 16:49:21 +0100, Matthieu Moy  
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> 
>> "Yngve Nysaeter Pettersen" <yngve@opera.com> writes:
>>
>>> The split command will create a new repository for all files foo in a
>>> folder (path/foo) and their commit history.
>>>
>>> The replant command reverses that process, re-adding the path prefix
>>> for each file. It may be possible to extend that process into one that
>>> automatically reintegrates the new commits in the original history,
>>> but I never had time to complete that work.
>>>
>>> I did originally add the "replant" functionality into my version of
>>> the git-subtree script, but given the number of commits in the
>>> original repository, git-subtree turned out to be inefficient, due to
>>> the use of temporary files (tens of thousands of files IIRC).
>>>
>>> Those problems led to my development of git-splitter in Python
>>> (bypassing the problem of temporary files), but just including the
>>> functionality I needed, join was not one of those functions.
>>
>> That still doesn't answer the question: why did you need to write a new
>> tool instead of extending git-subtree?
> 
> The primary problem with git-subtree was that I ended up with a temporary  
> file directory containing 100+K files, which I tracked back to being used  
> to manage the commit-to-tree mapping. On Windows, at least, that literally  
> slowed down the process to a crawl.
> 
>> If one doesn't use "replant", is your tool different from git-subtree?
> 
> No, it is not different. However, my tool will use RAM, not diskspace to  
> manage information.

That is some valuable input. It can help improve git-subtree for Windows
users, or replace it by something else.

Michael
