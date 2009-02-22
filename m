From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: merge smart enough to adapt to renames?
Date: Sun, 22 Feb 2009 19:13:49 +0200
Message-ID: <49A187CD.2020403@dawes.za.net>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>	 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>	 <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>	 <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>	 <499E5A9C.6090900@dawes.za.net>	 <e51f4f550902202048g9a210f0t8fefaee4d8376f6c@mail.gmail.com> <81bfc67a0902211700m7a0d0ae8jd17a871ba102fd9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kris Shannon <kris@shannon.id.au>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHvJ-0003nN-Lr
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbZBVRN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 12:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZBVRN5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:13:57 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:38044 "EHLO
	spunkymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751891AbZBVRN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 12:13:56 -0500
Received: from [192.168.201.113] (unknown [41.246.15.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a3.g.dreamhost.com (Postfix) with ESMTP id 0F81C15D4EA;
	Sun, 22 Feb 2009 09:13:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <81bfc67a0902211700m7a0d0ae8jd17a871ba102fd9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111023>

Caleb Cushing wrote:
> On Fri, Feb 20, 2009 at 11:48 PM, Kris Shannon <kris@shannon.id.au> wrote:
>> Rogan Dawes wrote:
>>> It seems to me that git is smart enough to figure out where contents get
>>> moved to, once. Of course, if you have conflicting moves in the same
>>> repo, git's automation falls down. So, if you need to move the "same"
>>> file in different repositories to different places, you need to do it
>>> via an intermediate repo that will be able to "remember" which movement
>>> you chose.
>> You don't need a whole different repo,  branches are good enough.
>>
>> git checkout gentoo-integration
>> git pull gentoo
>>
>> git checkout sunrise-integration
>> git pull sunrise
>>
>> git checkout master
>> git merge gentoo
>> git merge sunrise
>>
>> The integration branches can remember your local changes to
>> the remotes (like the move of packages.mask)
>>
> 
> it sounds like a decent plan on paper... but when you realize each
> checkout is 100,000+ files...to where as if I create a repo just for
> it... it ends up being like 5 files... and I'm not entirely sure that
> has much of a negative side effect... other than... yet another
> remote...
> 

Well, if you use an "integration branch", rather than a whole separate
repository, that should simplify things, I think.

And, if the differences between the branches are limited to those 5
files, a checkout (if you even really need to check it out) will only
update those files that are different between the branches. It may even
be possible to do an "in index" merge, without even having a checkout,
if there are no conflicts.

Rogan
