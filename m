From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git pull (Your local changes to ... would be overwritten by merge)
Date: Thu, 17 Jun 2010 12:42:00 +0200
Message-ID: <4C19FBF8.6010709@drmicha.warpmail.net>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com> <AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Blendea <bdaniel7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 12:43:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPCYm-0005Hz-7U
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 12:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759876Ab0FQKmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 06:42:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39954 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756456Ab0FQKmy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 06:42:54 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E5290F8B3D;
	Thu, 17 Jun 2010 06:42:41 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Jun 2010 06:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4+BOQ0ZFAeMydyrUhjscrKdWwQY=; b=F3xpPbZmUr2eZsilbF0r0E8mgcYy4dp2mpmsOJQzjh+f3C5PP42t9ZBwFoFsisUhjIwAXdoyqV8trFhK9UgSzQm4j4f/U6obZTPz3f6CdepN++i8rBmGmVmFC2j+pnIZlsWOZq/KncO+McTJ+sCgiHfUuQ4YkB57ax6SIlj86B4=
X-Sasl-enc: 6/KWWiRh4X676cib8SjTHGX6KsSnRXIHjL1lFF+QgkbR 1276771355
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C8E3D4DEFAD;
	Thu, 17 Jun 2010 06:42:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149297>

Daniel Blendea venit, vidit, dixit 17.06.2010 11:35:
> Hello,
> 
> A while ago I have cloned on my computer a git repo.
> Since then, the developers have modified several files in the repo.
> Now I want to update my copy with the latest changes.
> 
> I do 'git pull' but I get 'Your local changes to .... would be
> overwritten by merge.  Aborting.'
> I didn't modified any local file. I tried using 'git stash save' but no luck.
> 
> How can I make git update and override my local copy?
> With all the fuss about it, I thought I will handle this operation
> pretty easily.

If you are sure you have no own modifications which you would miss:

git fetch --all
git reset --hard origin/master

Fetch is pull without trying to merge or rebase anything.
the send line resets your master branch to what you just fetched.

Most likely the remote side did a non-forward push and brought you in
that situation.

[Which, on a side note, is one reason why I still believe that git
should not create any local branch for a clone. git fetch && git
checkout origin/master does not suffer from this issue.]

Michael
