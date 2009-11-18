From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn of both trunk and tags while having no access to the
   'parent' of those
Date: Wed, 18 Nov 2009 10:01:07 +0100
Message-ID: <4B03B7D3.8050905@drmicha.warpmail.net>
References: <20091117025945.GE17964@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 10:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAgQa-0007Jy-8m
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 10:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbZKRJCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 04:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbZKRJCA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 04:02:00 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:45821 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643AbZKRJB7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 04:01:59 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 93AFBBFC78;
	Wed, 18 Nov 2009 04:02:05 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 18 Nov 2009 04:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9WSgHmqGYfvZM9WDhnqIuGwQt0c=; b=CQ3Qjqa6NnxgF1L07lqMWB3efs2C5OWH6SMjPx4ZDi6s165GOJCrRsnpCAjYZ/yxs5rgqyZdzk49/AVd9FnOWhcDqlwI0b+wQrHfYURLcQ1b3pVwby8zfZjOpEKOFTpoKbEJCG5ImxaAn/WClW5MX8WgzgbtXSPQe3F0iPezpY0=
X-Sasl-enc: 4jhl2kQsJWu7F4vxNeKysGzosZP02xcIY92XpP6j/7+h 1258534925
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 027EB4B2D0B;
	Wed, 18 Nov 2009 04:02:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <20091117025945.GE17964@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133158>

Yaroslav Halchenko venit, vidit, dixit 17.11.2009 03:59:
> Dear Git People,
> 
> I've ran into a situation here:
> 
> there is a repository with trunk and releases (analog to tags there)
> available for public, but the rest of directories and their parent is
> not available without authentication... ie I can access
> 
> http://domain.com/svnrepo/trunk
> http://domain.com/svnrepo/releases
> but not
> http://domain.com/svnrepo/
> 
> Whenever I use git-svn (1.6.5 in Debian):
> 
> git svn clone --prefix=upstream-svn/ -T trunk -t releases http://domain.com/svnrepo svnrepo.gitsvn
> 
> it asks for authentication... I guess, now I can only clone trunk and
> releases separately? or may be there is some way to avoid the
> problem, ie avoid looking 'into root'?
> 
> Thanks in advance!

Your problem description seems to match perfectly with the description
of the "--no-minimize-url" option in git svn's man page. I'm sure it's
worth a try.

Michael
