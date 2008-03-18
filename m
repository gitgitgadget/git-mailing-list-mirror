From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <poststelle@suesserott.de>
Subject: Re: gitk: how to apply '--color-words' to the diff command
Date: Tue, 18 Mar 2008 21:55:14 +0100
Message-ID: <47E02C32.10009@suesserott.de>
References: <47DEC41D.9050409@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:14:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8Qm-0001qW-Am
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbYCTAOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939975AbYCTAOJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:14:09 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:45483 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939949AbYCTAOG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:14:06 -0400
X-Greylist: delayed 17099 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2008 20:14:05 EDT
Received: from [84.176.99.154] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <poststelle@suesserott.de>)
	id 1Jbiq4-00039g-0c
	for git@vger.kernel.org; Tue, 18 Mar 2008 21:55:16 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <47DEC41D.9050409@dirk.my1.cc>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77592>

>
> a few days ago I found a patch for gitk that adds a checkbox 'Ignore 
> space change' to the gitk GUI and -- when clicked -- adds the '-w' 
> switch to the diff command. I found that a very convenient way to see 
> 'what has really changed'. The patch was contributed by Steffen 
> Prohaska and has sha1 b9b86007e27d9a06d58feab618a5be1d491ed13e in the
> git://git.kernel.org/pub/scm/git/git.git repository.
>
> Inspired by this, I thought a '--color-words' switch would be even more
> convenient. I took the patch as a template and kinda replaced all
> occurences of '-w' with '--color-words' (do not take this literally).
>
> Unfortunately gitk then shows the diffs not colorized but with those 
> ugly escape sequences instead. I'm not a Python person and just able 
> to 'copy and waste', but probably some of you had the same idea and 
> got it right.
>
I'm not only not a Python person but also not a Tcl person. Did't even 
figure out the difference. :-(

However, what I figured out is that it's not as simple as I thought: The 
colorization in question is hard coded in the last 'else' branch of 
'getblobdiffline'. When a line starts with a '+' or '-', then it's shown 
in green or red. To support the --color-words switch it would be 
neccessary to actually parse diff's output wrt. to the colors. Not that 
easy, I guess.

Sorry for the noise.

Dirk
