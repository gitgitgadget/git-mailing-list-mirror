From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git rev-list formatting
Date: Mon, 22 Mar 2010 14:08:47 +0100
Message-ID: <4BA76BDF.6060106@drmicha.warpmail.net>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu> <m3eijcpoud.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 14:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NthPy-0002we-I4
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 14:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab0CVNLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 09:11:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53698 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754620Ab0CVNLg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 09:11:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 04341E7F09;
	Mon, 22 Mar 2010 09:11:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 22 Mar 2010 09:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zPEdQb4bTSYtXJF/S0lTNWxLOOs=; b=n76SKGC85/wt1VmaCJ+R102tLO2CcQO2IkCgTkmwzpYv9506uRJcTZVtfwSqhx2ETSwKTxBMkbvh8Eobx7wHSM7aO4SCeoTL64f7JEHwrJSV3yTKrXKl9O3kS9JJz1Frqd9wv7e7iTgaXwFvk4c7lfadgD9d1xEABFUjkAh0sZs=
X-Sasl-enc: UofOm5mcXImeygjjMEbwRr9+cQL+quyKkCxML1iiJceT 1269263495
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 514684B5918;
	Mon, 22 Mar 2010 09:11:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <m3eijcpoud.fsf@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142929>

Eli Barzilay venit, vidit, dixit 22.03.2010 12:39:
> Eli Barzilay <eli@barzilay.org> writes:
> 
>> [...]
>>
>> Also, is there a way to avoid the "commit <sha1>" line, print some
>> information that I specify in the format string, and show the whole
>> message as is (without wrapping or other tweaks)?
> 
> Looks like `git log' does something similar to what I want anyway,
> which leads me to a related question -- it's not clear to me what are
> the differences between `git rev-list', `git log', `git diff', and
> `git show', since it looks like they can all be tweaked to produce
> similar outputs.  Are they all the same with different outputs?  Is
> there some description of them with the differences explained?

The rev-list man page lists all commands of that family, with rev-list
being the bare bones version, and log and friends being more "high
level". log and rev-list walk the revision tree, show does not. Most of
that can be changed through options. whatchanged is a special family
member...

diff is from a completely different family (see git help diff or git
help diffcore). It never walks, but compares revisions (or other things).

The log family never compares things, but can show a patch, i.e. the
difference to the ancestor(s).

> Also related, it looks like `--abbrev-commit' has no effect on `git
> rev-list', but does on `git log', even through it's documented in the
> former's man page.  So it looks like either there are more
> (undocumented?) differences, or maybe that's also a bug?

I consider this a bug. In fact, it has an effect, but not a visible one.
You would have to use --abbrev=7 or such.

A patch is upcoming.

Cheers,
Michael
