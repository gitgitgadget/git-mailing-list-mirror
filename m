From: david@lang.hm
Subject: Re: rsync vs. git-push/pull ? (+kudus)
Date: Wed, 10 Sep 2008 06:27:22 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809100624130.8096@asgard.lang.hm>
References: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>  <alpine.DEB.1.10.0809062326000.8096@asgard.lang.hm> <dfb262380809092331i3399731cqdec3b2bb79d2fcdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Ramagudi Naziir <naziirr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 15:29:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdPjN-0007y1-F1
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 15:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbYIJN02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 09:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYIJN01
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 09:26:27 -0400
Received: from mail.lang.hm ([64.81.33.126]:57090 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbYIJN01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 09:26:27 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m8ADQPco011208;
	Wed, 10 Sep 2008 06:26:26 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <dfb262380809092331i3399731cqdec3b2bb79d2fcdd@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95517>

On Wed, 10 Sep 2008, Ramagudi Naziir wrote:

> Hi David,
>
> On Sun, Sep 7, 2008 at 9:27 AM,  <david@lang.hm> wrote:
>> On Sun, 7 Sep 2008, Ramagudi Naziir wrote:
>>
>>> Hi all,
>>>
>>> I have several local git repositories on my machine. I'm the only
>>> user, and use them only locally. Now, sometimes when I need to work
>>> remotely, I just rsync my repositories to my laptop, and keep working
>>> there. When I finish (few hours, days or sometimes weeks later), I
>>> just rsync everything back to my local git repositories on my main
>>> workstation, and continue working there.
>>>
>>> Now I was wondering whether it's OK or whether there are bad
>>> implication I might not think of working this way. For example, maybe
>>> some of these little git files are named differently on each machine,
>>> and rsyncing them back and forth makes me piling a lot of clutter (in
>>> that case maybe git-gc will clean up everything). Or maybe something
>>> else horrid is going on and I really should just use git-push or pull.
>>
>> the git files are names by their content so you don't need to worry about
>> them being named differently
>
> But can I end up having a lot of clutter ? e.g. if these files change,
> then rsync will copy the new files, and the old ones will still be
> kept, piling up like crud. is this correct ? is it problematic ? will
> git-gc fix it ?

git keeps copies of all the old files around anyway (that's it's purpose 
after all ;-)


when git gc runs it creates pack files to replace the individual files, 
but unless you run git gc --prune it does not remove anything and the 
individual files hang around.

so when you do the rsync back and forth you should have it delete files 
from the target that aren't on the source (or run git gc --prune 
afterwords)

David Lang
