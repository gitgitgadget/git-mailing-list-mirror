From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: GIT - breaking backward compatibility
Date: Tue, 20 Sep 2005 00:41:32 -0400
Message-ID: <432F92FC.4000405@didntduck.org>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net> <432F8C33.5080603@didntduck.org> <Pine.LNX.4.58.0509192131260.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 06:42:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHZwi-0004YX-Ct
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 06:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVITEl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 00:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVITEl3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 00:41:29 -0400
Received: from quark.didntduck.org ([69.55.226.66]:64203 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964885AbVITEl3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 00:41:29 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j8K4fMI30016;
	Tue, 20 Sep 2005 00:41:22 -0400
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509192131260.2553@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8973>

Linus Torvalds wrote:
> 
> On Tue, 20 Sep 2005, Brian Gerst wrote:
> 
>>Essentially what I want to do is:
>>
>>git-ls-files --others | xargs git-update-index --add --
>>git-ls-files --deleted | xargs git-update-index --remove --
>>git-ls-files --modified | xargs git-update-index --
>>
>>This will completely resync the index and cache to the working tree 
>>state after applying a patch.
> 
> 
> It will also be extremely inefficient.
> 
> If you really have a _patch_, then "git-apply --index" is what you want to 
> apply it with. It applies a patch _and_ updates the index as appropriate. 
> It's how git-applymbox can apply hundreds of patches in short order.
> 
> 		Linus
> 

That would be great, if git-apply accepted fuzzy patches.  I am trying 
to apply the -mm series patches, which often are slightly out of date. 
Andrew doesn't rebase them until they won't apply at all.

--
				Brian Gerst
