From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: gitk: how to apply '--color-words' to the diff command
Date: Tue, 18 Mar 2008 21:58:40 +0100
Message-ID: <47E02D00.2080703@dirk.my1.cc>
References: <47DEC41D.9050409@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 02:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc9JU-0000TY-0T
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 02:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927AbYCTBKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 21:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758350AbYCTBKJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 21:10:09 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:49496 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235AbYCTBKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 21:10:07 -0400
Received: from [84.176.99.154] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JbitN-00039A-83
	for git@vger.kernel.org; Tue, 18 Mar 2008 21:58:41 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <47DEC41D.9050409@dirk.my1.cc>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77610>

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
figure out the difference. Sorry for that.

However, what I figured out is that it's not as simple as I thought: The 
colorization in question is hard coded in the last 'else' branch of 
'getblobdiffline'. When a line starts with a '+' or '-', then it's shown 
in green or red. To support the --color-words switch it would be 
neccessary to actually parse diff's output wrt. to the colors.

Sorry for the noise.

Dirk
