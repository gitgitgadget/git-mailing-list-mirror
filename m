From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Failing svn imports from apache.org
Date: Fri, 14 Sep 2012 12:11:55 +0200
Message-ID: <505302EB.8040600@drmicha.warpmail.net>
References: <7c3575e3-dab1-4cd2-a0e0-74778316c8b4@zcs> <d5b32995-59c6-4669-bf4d-2532a1d58d2a@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Fri Sep 14 12:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSsZ-0003hs-4H
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 12:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758490Ab2INKL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 06:11:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32908 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756605Ab2INKL6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 06:11:58 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A648F206B2;
	Fri, 14 Sep 2012 06:11:57 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 14 Sep 2012 06:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=fLiV23uEalNHTdZQBbD8f3
	iFmhs=; b=NdYS8jJ/NUl343CCYQedCjIu3w1xf6sVBrV8GBO/U/JrPuxq2Ta4jQ
	rnLftpyXw8eEeySTT3Pe+nSEtqdUnBqYCaY9bd5N4tGsfpp823vw3vf/bCSmvuZf
	y5nyFo5bE8Gjk/TZoL+wErQKViZwBqboQidlQxCJu2CHnAEUau9uU=
X-Sasl-enc: 0TiHoDZ34CwBRGd68pzKI93HU5+BI+I+kKsRf8sezLfB 1347617517
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E766D4835FC;
	Fri, 14 Sep 2012 06:11:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <d5b32995-59c6-4669-bf4d-2532a1d58d2a@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205478>

Enrico Weigelt venit, vidit, dixit 13.09.2012 15:32:
> Hi folks,
> 
> I'm currently trying to import apache.org svn server, without success.
> See:
> 
> git@moonshine:~/projects/common/libs$ git svn clone --stdlayout http://svn.apache.org/repos/asf/commons/proper/discovery/
> Initialized empty Git repository in /home/git/projects/common/libs/discovery/.git/
> W: Ignoring error from SVN, path probably does not exist: (160013): Filesystem has no item: '/repos/asf/!svn/bc/100/commons/proper/discovery' path not found
> W: Do not be alarmed at the above message git-svn is just searching aggressively for old history.
> This may take a while on large repositories
> mkdir .git: No such file or directory at /usr/lib/git-core/git-svn line 3669
> 
> Does anyone have an idea, what might be wrong here / how to fix it ?

Here: git svn --version
git-svn version 1.7.12.592.g41e7905 (svn 1.6.18)

What's yours?

I'm getting

Initialized empty Git repository in /tmp/discovery/.git/
Using higher level of URL:
http://svn.apache.org/repos/asf/commons/proper/discovery =>
http://svn.apache.org/repos/asf
W: Ignoring error from SVN, path probably does not exist: (160013):
Dateisystem hat keinen Eintrag: File not found: revision 100, path
'/commons/proper/discovery'
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories

and then it checks the revisions. I didn't want to wait for r1301705...

Does your git svn abort earlier or after checking all revs?
