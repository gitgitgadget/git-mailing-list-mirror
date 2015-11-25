From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Sparse checkout in worktree
Date: Wed, 25 Nov 2015 21:44:04 +0100
Message-ID: <56561D94.7020503@drmicha.warpmail.net>
References: <5655AC29.20801@drmicha.warpmail.net>
 <CACsJy8Acb0Z3sw7_r6QfTTz=GqedsU76QxjexWf4yZFg9O7W-w@mail.gmail.com>
 <56560FAE.3000605@drmicha.warpmail.net>
 <CACsJy8BGPk7C3d9JWjRwYrgh4OTUiiAjGzcKcRJy8+-5=x8=Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:44:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gvC-0006qS-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbKYUoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:44:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50247 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038AbbKYUoH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 15:44:07 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3128520C29
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 15:44:07 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Nov 2015 15:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=XXyaTKABokxlNnElPaAUxV7Hoj4=; b=AFaXU0
	Ab+u2yX40SETnbGeIjBFGDsjVbs8lYn//rEFADj0yEJ0FgK76Nd2k1V+mePlwwm/
	8Ae+FdHMsYt7tXiGbgEbWcm2TYvBFeBfLOXxzA12djCoB7p2z+gzJP/vA+baGT8T
	hBeYp4hzC8Vp0H/EUoZBYoo4OvbKK2NbIcqQI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=XXyaTKABokxlNnE
	lPaAUxV7Hoj4=; b=tFRCmsrlU3tPgF3EAQaOPlsdISP7IuVUE1AK66nmwJaIwsv
	yey5JdKDJZ1rIoPFhFCqDFvEdUyZUa59S7WC1NAcE/yof3jAHFShRmndVo9AKpyf
	Jz8kMro+LdEr2H4l7oiVNZ9jCfsIvE+cCKwAvReu9XSRks6+lE2O8sxYhoxo=
X-Sasl-enc: bZgAEZKUwM+bvBrV3RY9ZdyzspBoQzhevGaNY4EoEfWW 1448484246
Received: from UltraSam.fritz.box (dslc-082-083-017-046.pools.arcor-ip.net [82.83.17.46])
	by mail.messagingengine.com (Postfix) with ESMTPA id 639CB680183;
	Wed, 25 Nov 2015 15:44:06 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CACsJy8BGPk7C3d9JWjRwYrgh4OTUiiAjGzcKcRJy8+-5=x8=Pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281743>

Duy Nguyen venit, vidit, dixit 25.11.2015 21:17:
> On Wed, Nov 25, 2015 at 8:44 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Duy Nguyen venit, vidit, dixit 25.11.2015 20:38:
>>> On Wed, Nov 25, 2015 at 1:40 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Hi there,
>>>>
>>>> I'm wondering how much it would take to enable worktree specific sparse
>>>> checkouts. From a superfluous look:
>>>>
>>>> - $GIT_DIR/info/sparse_checkout needs to be worktree specific
>>>
>>> It already is.
>>
>> But where should I put the worktree specific sparse_checkout file? Is
>> Documentation/technical really the only place to find information about
>> this? And to make the existing tree sparse, do I need to rm -r and
>> checkout sparsely?
> 
> Ahh.. worktree-specific files of the checkout "foo" stay in
> $GIT_DIR/repos/foo. So sparse-checkout path should be
> $GIT_DIR/repos/foo/info/sparse-checkout. This is another good reason
> to add 'git checkout --edit-sparse' that opens the sparse-checkout
> file for you to update. Or you could use 'git rev-parse --git-path
> info/sparse-checkout" to get full path.
> 

[ "worktrees", not "repos" ]

Maybe creating an empty info dir by default would help already - I had
looked in there but didn't find anything.

OTOH, config is common: core.sparseCheckout
So, the per worktree "switch" is the presence of the sparse-checkout file.

Michael
