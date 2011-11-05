From: Gelonida N <gelonida@gmail.com>
Subject: Re: share object storage for multiple clones of different repositories
Date: Sat, 05 Nov 2011 17:06:26 +0100
Message-ID: <j93mu2$ce7$1@dough.gmane.org>
References: <j91rcq$1uo$1@dough.gmane.org> <7vobwr9uf0.fsf@alter.siamese.dyndns.org> <op.v4gp4mai0aolir@keputer.lokaal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 17:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMim4-0002u3-MP
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab1KEQGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:06:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:58168 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1KEQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:06:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RMilU-0002ex-A8
	for git@vger.kernel.org; Sat, 05 Nov 2011 17:06:40 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:06:40 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:06:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <op.v4gp4mai0aolir@keputer.lokaal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184856>

Thanks for both of your replies,


I'll probably mix both approaches and try out how it works.
I didn't know about git.git
What is the best url for an intrudoction into git.git?




On 11/05/2011 08:37 AM, Frans Klaver wrote:
> On Sat, 05 Nov 2011 03:26:11 +0100, Junio C Hamano <gitster@pobox.com>
> wrote:
> 
>> Gelonida N <gelonida@gmail.com> writes:
>>
>>> SHARED_STORAGE=$HOME/shared_storage
>>> mkdir $SHARED_STORAGE
>>>
>>> git clone remotehost1:repo1
>>> cd repo1
>>> rsync -av .git/objects $SHARED_REPO
>>
>> Up to this part it is probably OK.  Repeat that for all your local
>> repositories to collect all objects in $HOME/shared_storage.
>>
>> After doing that, do this in all of your local repositories:
>>
>>     rm -rf .git/objects
>>         mkdir -p .git/objects/info
>>         echo $HOME/shared/storage >.git/objects/info/alternates
>>
>> The reason why nobody should follow your original recipe is because any
>> "git gc"/"git repack" in any of your local repositories would break
>> others
>> with that approach.
> 
> 
> Alternatively there's the git-new-workdir script in contrib/workdir in
> git.git. Haven't tested it, but it seems like it does what you want.
> 
> Frans
