From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Mon, 19 Feb 2007 14:21:01 +0100
Organization: At home
Message-ID: <erc846$bk7$1@sea.gmane.org>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org> <7virdybu9a.fsf@assigned-by-dhcp.cox.net> <20070219073238.GA30030@spearce.org> <81b0412b0702190305j20cf2d10w8f75c4345ba0fc26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 14:19:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ8Qq-0002lL-Rh
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 14:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbXBSNTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 08:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbXBSNTs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 08:19:48 -0500
Received: from main.gmane.org ([80.91.229.2]:33573 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218AbXBSNTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 08:19:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJ8QR-0007kL-E7
	for git@vger.kernel.org; Mon, 19 Feb 2007 14:19:28 +0100
Received: from host-81-190-18-211.torun.mm.pl ([81.190.18.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 14:19:27 +0100
Received: from jnareb by host-81-190-18-211.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 14:19:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-211.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40125>

Alex Riesen wrote:

> On 2/19/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Junio C Hamano <junkio@cox.net> wrote:
>> > "Theodore Ts'o" <tytso@mit.edu> writes:
>> >
>> > > This allows users to use the command "git remote update" to update all
>> > > remotes that are being tracked in the repository.
>> >
>> > Sounds like a good idea.  Thanks.
>>
>> <personalwishlist>
>>
>> It would be nice to define "gang remotes".  For example I want to
>> be able to have:
>>
>>   `git fetch cs`  ==  `git fetch cs-one; git fetch cs-two`
>>   `git fetch jc`  ==  `git fetch origin; git fetch alt`
> 
> I was thinking about something very similar.
> 
>> Why?  Well, I often have multiple remotes setup to the *same*
>> repository depending on the SSH hostname I want to use to access
>> that repository.  This has a lot to do with the way my firewalls
>> are setup and where I'm physically connected at any given time.
> 
> For all the same reasons :)
> 
>> Yes, I really do have multiple remotes setup to the access the
>> same (remote) physical disk.  :)
>>
>> Possible syntax:
>>
>>         [remote "cs"]
>>                 remote = cs-one
>>                 remote = cs-two
>>         [remote "jc"]
>>                 remote = origin
>>                 remote = alt
>>
> 
> Or :
> 
>   [remote "jc"]
>     url = git://...
>     fetch = refs/heads/*:remotes/jc/*
>     remote ("include"? "next"?) = origin
> 
> (I mean: it can be allowed to mix url/fetch and remote).
> 
> And:
> 
>   [remote "jc"]
>     fail = all-fail
>     remote = origin
>     remote = backup
> 
> IOW: the fetch fails only if all fetches fail (with default
> being "fail = first").

Or just allow fetch remotes to have multiple URLs, and fetch from all/try to fetch starting from first.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
