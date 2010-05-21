From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 15:49:19 +0200
Message-ID: <4BF68F5F.9010309@drmicha.warpmail.net>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri May 21 15:49:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFSbc-0004XT-PI
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 15:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab0EUNtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 09:49:35 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33621 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753666Ab0EUNtf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 09:49:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1C1FDF7C4C;
	Fri, 21 May 2010 09:49:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 21 May 2010 09:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NuX2OeLkx05WG2ydL6pvzQbz+uk=; b=U1byRbYKqqXhUq53Xa2MVpHwOUAAmUFYdl3W6ZBakolJDkC8zvEl/FyzbFd3Av+E2SLz+jCbOhNKc8H1hLeyUDch8fN3BjU9WQcoxry1x4Q60FLwDYsBSLHwRc2OOcNYSlBDvu4FWvgt0dvx5emWcONRtVc2F87I00BEHHDniyM=
X-Sasl-enc: +GeAmLF/K8/CwACuR2ZnyKiqjdB6i5PFWq+sHvG42iWP 1274449769
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C7284CCD66;
	Fri, 21 May 2010 09:49:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147454>

Peter Kjellerstedt venit, vidit, dixit 21.05.2010 14:59:
> Is there some way to make "git pull --ff-only" be the default?
> I could not find anything about this in "git config --help" and
> also the lack of a --no-ff-only option for git pull (it exists 
> for git merge) indicates that there is no such support.
> 
> I did considered the branch.<name>.mergeoptions configuration
> option, but it does not seem appropriate as it only applies to
> a specific branch, whereas I want it to apply to all branches
> by default.
> 
> Yes, I know I could do "git config alias.pl 'pull --ff-only'",
> but since my intensions are for this to be the default for all
> developers in our organization (most of whom have no git knowledge
> at all yet) to avoid unnecessary branches caused by the developers 
> hacking directly on master rather than a topic branch, I would 
> very much prefer a configuration option rather than an alias (as 
> I am unlikely to get the developers to remember to do "git pl" 
> instead of "git pull").

Problem is they have to remember to set your new config, or, if you are
able to set all developers system config, they have to refrain from
overriding it.

> My idea was to add something like merge.options and pull.options
> as configuration options (I want to be able to specify the options
> separately for pull and merge). However, I wanted throw this out
> here first before starting to hack away at the code, in case I
> missed something obvious, or if others find this to be an
> incredibly stupid idea...
> 

In general, you can't control reliably what people do in their repos.
But you can control what kind of pushes into a central repo you allow.
That is the usual approach: Let them mess up their repos, they'll learn
their lesson when they can't push ;)

Michael
