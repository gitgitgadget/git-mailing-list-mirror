From: Peter Voss <info@petervoss.org>
Subject: Re: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 13:51:56 +0200
Message-ID: <64652870-CF95-49A7-920A-0F9A6C202B40@petervoss.org>
References: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org> <200907131259.42313.johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 13:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQK4q-0001IT-Vg
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 13:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbZGMLwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 07:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbZGMLwE
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 07:52:04 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:64596 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbZGMLwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 07:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1247485918; l=2050;
	s=domk; d=petervoss.org;
	h=References:Date:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:Cc:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=aZyDPS4IYBwiZIG51kySAnY1oBk=;
	b=zFgcGy6HMcH5Ecd1hajYCk4ymUSXxWDBUQKjwSBBsNOL2LG2wcCCA15IgtE+FQ/KgXo
	TQftPzNbSZs0yj3GHQlvwxKCl9b8Ip4+osAOj6KLz7v1SaoFdZ5vejVc2OnIDrCuv23A6
	8ElWd7ytFuwwVdqFClJ4dzAUnf+i7G7R9Xw=
X-RZG-AUTH: :JWICemC4fusRF4tAhweiuU4SRqyWF3gXMlHyMhzObhKwDIReNIDrirxOEFeT
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.108]
	(ip-62-143-242-232.unitymediagroup.de [62.143.242.232])
	by post.strato.de (klopstock mo62) (RZmta 18.49)
	with ESMTP id v01c1dl6DAhFHm ; Mon, 13 Jul 2009 13:51:57 +0200 (MEST)
In-Reply-To: <200907131259.42313.johan@herland.net>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123187>

Hi Johan,

On 13.07.2009, at 12:59, Johan Herland wrote:

> On Monday 13 July 2009, Peter Voss wrote:
>> Hi,
>>
>> I want to use the git submodule feature to move part of my code to a
>> different repository at github.
>>
>> The issue is that developers should use different repository URLs for
>> the submodule depending on whether they have commit rights or not.
>>
>> At the beginning I was using the public URL to set-up the submodule:
>> git submodule add git://github.com/x/mymodule.git mymodule
>>
>> The issue is that some developers are working behind a firewall that
>> blocks the git protocol. These could only use the git@github.com:x/
>> mymodule.git URL to get access.
>> But other developers can only go through the public URL git://
>> github.com/x/mymodule.git. So whatever I use it won't work for
>> everybody.
>>
>> What's the best way to deal with that? Could I set-up different
>> repository URLs for one and the same submodule and use which one is
>> appropriate?
>
> You might be able to pull this off using relative submodule URLs. If  
> the
> submodule URLs in .gitmodules are relative (i.e. ../foo.git or
> similar), they will be resolved to absolute URLs using the origin URL
> of the super-repo. I.e. if you cloned the super-repo from
> git://github.com/x/mymodule.git, the ../foo.git submodule will be
> cloned from git://github.com/x/foo.git, and if you cloned from
> git@github.com:x/mymodule.git, the submodule will be cloned from
> git@github.com:x/foo.git.

That's a good hint. Unfortunately I can't use this to go up 2  
directories. I.e. I can't get from
git@github.com:xxx/mymodule.git
to
git@github.com:yyy/foo.git

Using the relative URL ../../yyy/foo.git leads to the result:
Clone of 'git@github.com:xxx/yyy/foo.git' into submodule path 'foo'  
failed

So I basically cannot replace the xxx part.

Anyway, thanks for the hint.
--Peter

> Hope this helps,
>
>
> Have fun! :)
>
> ...Johan
>
>
> -- 
> Johan Herland, <johan@herland.net>
> www.herland.net
