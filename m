From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: on pulling/cloning git notes
Date: Thu, 24 Jun 2010 11:48:21 +0200
Message-ID: <4C2329E5.8050904@drmicha.warpmail.net>
References: <AANLkTilDMVU6b7SwHx0Bztu1rTCubiIPTuDDX6pJBcHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 11:49:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORj3Y-0005gQ-VP
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 11:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab0FXJtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 05:49:06 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45731 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402Ab0FXJtF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 05:49:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 67AD1107F2E;
	Thu, 24 Jun 2010 05:49:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 24 Jun 2010 05:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qFWttlJpVG5CZce8Jr/mIyQou4I=; b=mXa3eCjjbaqxk6A0UXRzkRsaOs8CautJLrMqmF+9gkAcuaZhjvLk9VfdM/PEvg25bzaHWjZcTUhBk1Kk0sKRRxyuK7ZFUJr7fJluJKp3KW9d87+c/RdY+nNcbQL6A6vapbKAL2A7H7hlBjjQvnBZ3jfezYpsMRLSRDiNThFLChg=
X-Sasl-enc: vMEfyS7Cabq5YAeLrzYJ9gTSmCBKXEuePWF0kzavJM4k 1277372943
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D44B85A524;
	Thu, 24 Jun 2010 05:49:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTilDMVU6b7SwHx0Bztu1rTCubiIPTuDDX6pJBcHx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149568>

Christian MICHON venit, vidit, dixit 24.06.2010 10:22:
> Hi list,
> 
> I've been playing recently with git notes and figured out how to push
> my notes to my central gitolite server, tweaking .git/config in this
> way (adding a push section):
> 
> [remote "gitolite"]
>         url = gitolite:daat
>         fetch = +refs/heads/*:refs/remotes/gitolite/*
>         push = +refs/notes/*:refs/notes/*
> 
> When trying to to a 'git clone --mirror' from that same gitolite
> server, I was expecting to get back refs/notes, but I did not.
> 
> Did I miss something or git notes are actually not meant to be cloned/pulled?
> 

As you can see from the default "fetch" line above, "refs/heads" are
fetched by default (when cloning, fetching etc.), but nothing else
(well, besides some tags). You can set up an additional fetch refspec to
get the notes also.

It's not done by default because it's up to you decide what to do with
the notes. Sometimes, you want them to end up in "refs/notes" so that
they are displayed by default. But maybe you want them in
"refs/notes/remotes/gitolites" e.g. and display them only on request
(--show-notes=remotes/gitolite), or merge them into your own notes.

Michael
