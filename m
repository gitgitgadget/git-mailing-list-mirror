From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Headless tags don't have a follows or precedes?
Date: Mon, 2 Nov 2009 05:07:27 -0800 (PST)
Message-ID: <1257167247221-3931674.post@n2.nabble.com>
References: <1257067898626-3926483.post@n2.nabble.com> <4AEEA96F.7080609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 14:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4wdE-0006nj-Dl
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 14:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbZKBNHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 08:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbZKBNHY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 08:07:24 -0500
Received: from kuber.nabble.com ([216.139.236.158]:51993 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZKBNHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 08:07:24 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N4wd5-0000n0-7K
	for git@vger.kernel.org; Mon, 02 Nov 2009 05:07:27 -0800
In-Reply-To: <4AEEA96F.7080609@drmicha.warpmail.net>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131905>



Michael J Gruber-2 wrote:
> 
> Tim Mazid venit, vidit, dixit 01.11.2009 10:31:
>> 
>> Hi all,
>> 
>> I've noticed that if I create a headless tag (one that doesn't have a
>> branch, right?), when I click on that commit, it doesn't have precedes or
>> follows information. Is this by design? Is there a work-around I can use
>> without creating a branch there?
> 
> Reposting (without even saying so) doesn't necessarily increase your
> chance of getting responses.
> 
I didn't repost. Or at the least, I didn't mean to repost. The mailing list
kept complaining (spamming me) that my post was pending, and I eventually
realised that was the old forum. I deleted it from there, and copy-pasted
here. I didn't even realise it had posted here, and that when I deleted from
the old forum, it didn't delete here.


Michael J Gruber-2 wrote:
> 
> Would would help:
> 
> - saying you're talking about gitk/git view/whatever it is you're
> "clicking" on
> 
My apologies, yes, in gitk.


Michael J Gruber-2 wrote:
> 
> - providing a minimal example others can reproduce. That would be one
> where a tag on a detached head (assuming that's what you mean) has no
> precedes/follow but a tag "on a branch" does have that info
> 

Example (unless specified, commands as entered into bash)

mkdir temp
cd temp
git init
gitk --all &
git commit --allow-empty -m '1'
git tag v1
git commit --allow-empty -m '1.1'
git tag v1.1
git commit --allow-empty -m '1.2'
git tag v1.2
(in gitk, press ctrl+f5; all follows and precedes info is there)
git checkout v1.1
git commit --allow-empty -m '1.1.1'
git tag v1.1.1
(in gitk, press f5; follows and precedes info missing for v1.1 and v1.1.1)
(close gitk)
gitk --all &
(info still missing)
git commit --allow-empty -m '1.1.2'
git tag v1.1.2
(in gitk, press f5, info still missing)
git checkout master
git commit --allow-empty -m '1.3'
git tag v1.3
(in gitk, press f5, info still missing)
git commit --allow-empty -m '1.4'
git tag v1.4
(in gitk, press f5, info still missing)
git checkout -b temp v1.2
git commit --allow-empty -m '1.2.1'
git tag v1.2.1
(in gitk, press f5, info still missing)
git checkout master
git branch -D temp
git commit --allow-empty -m '1.5'
git tag v1.5
(in gitk, press f5, info still missing)


In the end, the only follows/precedes info is:
v1: precedes v1.1
v1.1: follows v1, precedes v1.2
v1.2: follows v1.1
All the rest is missing.
-- 
View this message in context: http://n2.nabble.com/Headless-tags-don-t-have-a-follows-or-precedes-tp3926483p3931674.html
Sent from the git mailing list archive at Nabble.com.
