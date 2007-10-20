From: Erich Ocean <erich@atlasocean.com>
Subject: [Solved] How can I access remote branches in a cloned repository on my local machine?
Date: Sat, 20 Oct 2007 07:18:46 -0700
Message-ID: <20CAFC3D-7684-480D-B340-C3206BA08DE5@atlasocean.com>
References: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com> <Pine.LNX.4.64.0710201449340.8248@beast.quantumfyre.co.uk> <Pine.LNX.4.64.0710201455540.8248@beast.quantumfyre.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 16:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjFAp-00083s-N3
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 16:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbXJTOSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbXJTOSt
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 10:18:49 -0400
Received: from georgia.textdrive.com ([207.7.107.246]:56604 "EHLO
	georgia.textdrive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbXJTOSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 10:18:48 -0400
Received: from [192.168.6.221] (mail.one-k.com [206.114.20.226])
	by georgia.textdrive.com (Postfix) with ESMTP id 580FF3509C
	for <git@vger.kernel.org>; Sat, 20 Oct 2007 14:18:48 +0000 (GMT)
In-Reply-To: <Pine.LNX.4.64.0710201455540.8248@beast.quantumfyre.co.uk>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61839>

Per Julian Phillips' suggestion:

 > logan-2:~ ocean$ cd commiters/
 > logan-2:~/commiters ocean$ git config remote.origin.fetch +refs/ 
remotes/*:refs/remotes/*
 > logan-2:~/commiters ocean$ git fetch
 > git@git.1kstudios.lan's password:
 > * refs/remotes/eocean/master: storing remote branch 'eocean/ 
master' of git@git.1kstudios.lan:dev
 >   commit: 06b4b2e
 > * refs/remotes/gt/master: storing remote branch 'gt/master' of  
git@git.1kstudios.lan:dev
 >   commit: 889a585
 > * refs/remotes/jchumley/master: storing remote branch 'jchumley/ 
master' of git@git.1kstudios.lan:dev
 >   commit: 18cead3
 > logan-2:~/commiters ocean$ git branch
 >   +refs/remotes/eocean/master
 >   +refs/remotes/gt/master
 >   +refs/remotes/jchumley/master
 > * master
 > logan-2:~/commiters ocean$ git checkout  +refs/remotes/jchumley/ 
master
 > Switched to branch "+refs/remotes/jchumley/master"

Best, Erich

On Oct 20, 2007, at 6:56 AM, Julian Phillips wrote:

> On Sat, 20 Oct 2007, Julian Phillips wrote:
>
>>>  The problem is, when I clone git@git.1kstudios.lan:dev, the various
>>>  <username>/master's aren't there. I have tried a bunch of  
>>> different ways,
>>>  but they all give me errors. For example:
>>
>> The default fetch refspec doesn't include the remotes - after all,  
>> you normally don't want the origin for your origin ...
>>
>>>  How can I access remote branches in a cloned repository on my local
>>>  machine?
>>
>> Try something like:
>>
>> git config remote.origin.fetch +refs/remotes/*:+refs/remotes/*
>
> sorry, that should have been:
> git config remote.origin.fetch +refs/remotes/*:refs/remotes/*
>
>> git fetch
>
> -- 
> Julian
>
>  ---
> "The National Association of Theater Concessionaires reported that in
> 1986, 60% of all candy sold in movie theaters was sold to Roger  
> Ebert."
> 		-- D. Letterman
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
