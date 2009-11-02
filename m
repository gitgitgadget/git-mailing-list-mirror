From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Headless tags don't have a follows or precedes?
Date: Mon, 02 Nov 2009 16:54:06 +0100
Message-ID: <4AEF009E.5060005@drmicha.warpmail.net>
References: <1257067898626-3926483.post@n2.nabble.com> <4AEEA96F.7080609@drmicha.warpmail.net> <1257167247221-3931674.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4zEs-000624-73
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZKBPyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbZKBPyM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:54:12 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53390 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755599AbZKBPyK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 10:54:10 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A2FD9BD827;
	Mon,  2 Nov 2009 10:54:12 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 02 Nov 2009 10:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gA9+I6XDILWegqRF458Jitxqcqg=; b=uKIfB6vjw3tspKkeoviXlOIfOjeyH9xKDbEKQU6zkkhNd/QOh34QltkbMS05wG+JLXy8t/SNxVejgQUjnxu7OU6xfiqmWlMsM08lUh6mW8iw/1uEvMCl3csJyXGR9L4kEwzU6E/BXakrOgOoIPzwje3zl//MGPXF8E4GmEer4Gs=
X-Sasl-enc: 3d8WzqWqJiZeSlircLey5jjWUF/wTC4GzLyCK4b4/lro 1257177252
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B36394A2579;
	Mon,  2 Nov 2009 10:54:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091102 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <1257167247221-3931674.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131918>

Tim Mazid venit, vidit, dixit 02.11.2009 14:07:
> 
> 
> Michael J Gruber-2 wrote:
>>
>> Tim Mazid venit, vidit, dixit 01.11.2009 10:31:
>>>
>>> Hi all,
>>>
>>> I've noticed that if I create a headless tag (one that doesn't have a
>>> branch, right?), when I click on that commit, it doesn't have precedes or
>>> follows information. Is this by design? Is there a work-around I can use
>>> without creating a branch there?
>>
>> Reposting (without even saying so) doesn't necessarily increase your
>> chance of getting responses.
>>
> I didn't repost. Or at the least, I didn't mean to repost. The mailing list
> kept complaining (spamming me) that my post was pending, and I eventually
> realised that was the old forum. I deleted it from there, and copy-pasted
> here. I didn't even realise it had posted here, and that when I deleted from
> the old forum, it didn't delete here.
> 

OK :) (It git through to gmane a while ago.)

> Michael J Gruber-2 wrote:
>>
>> Would would help:
>>
>> - saying you're talking about gitk/git view/whatever it is you're
>> "clicking" on
>>
> My apologies, yes, in gitk.
> 

Now we only need the version... but we'll see if current versions
reproduce it.

> Michael J Gruber-2 wrote:
>>
>> - providing a minimal example others can reproduce. That would be one
>> where a tag on a detached head (assuming that's what you mean) has no
>> precedes/follow but a tag "on a branch" does have that info
>>
> 
> Example (unless specified, commands as entered into bash)

Great example, thanks!

> 
> mkdir temp
> cd temp
> git init
> gitk --all &
> git commit --allow-empty -m '1'
> git tag v1
> git commit --allow-empty -m '1.1'
> git tag v1.1
> git commit --allow-empty -m '1.2'
> git tag v1.2
> (in gitk, press ctrl+f5; all follows and precedes info is there)
> git checkout v1.1
> git commit --allow-empty -m '1.1.1'
> git tag v1.1.1
> (in gitk, press f5; follows and precedes info missing for v1.1 and v1.1.1)

For me, v1.1.1 has no info and v1.1 is missing v1.1.1 in its precedes.

> (close gitk)
> gitk --all &
> (info still missing)
> git commit --allow-empty -m '1.1.2'
> git tag v1.1.2
> (in gitk, press f5, info still missing)

v1.1.1 and v1.1.2 missing all follow/precede info.

> git checkout master
> git commit --allow-empty -m '1.3'
> git tag v1.3
> (in gitk, press f5, info still missing)

Now, even v1.3 is missing its follows and v1.2 its precedes, even though
they've got nothing to do with the "detached branch".

> git commit --allow-empty -m '1.4'
> git tag v1.4
> (in gitk, press f5, info still missing)
> git checkout -b temp v1.2
> git commit --allow-empty -m '1.2.1'
> git tag v1.2.1
> (in gitk, press f5, info still missing)
> git checkout master
> git branch -D temp
> git commit --allow-empty -m '1.5'
> git tag v1.5
> (in gitk, press f5, info still missing)
> 
> 
> In the end, the only follows/precedes info is:
> v1: precedes v1.1
> v1.1: follows v1, precedes v1.2
> v1.2: follows v1.1
> All the rest is missing.

So basically, all connectivity which has been created after detaching
the head is missing, even that which has been created on a "proper
branch", which means (to me) it has nothing to do with git's revision
parsing (such as missing out on lightweight tags on detached heads).

I looked at the gitk code and got the expected result: no clue (tcl/tk
doesn't tick my fancy). gitk's parsing of ancestry relations seems to be
done completely in tcl (rather then relaying a lot to git-rev-parse,
which may not be efficient here). So I'll take the liberty to cc the
main gitk guy. A few more notes:

After generating v1.1.1 (which misses "follows"), .git/gitk.cache has
this (\n added for clarity):

1 1\n
6bfcf857ceef0507bb50ee17302c1d068b697540
b67f4651e49a33ee8cc77157e4e51d1e635a7c0d
{540abf2b75aec7ccbd8c0413863a018fc1c1eb37
b67f4651e49a33ee8cc77157e4e51d1e635a7c0d}\n
1\n

If I move that out of the way and rerun gitk, everything's in apple pie
order, and the cache file is:

1 3\n
2fd83b12ccea07c88f5998aa6303003ef1e4858b
540abf2b75aec7ccbd8c0413863a018fc1c1eb37
540abf2b75aec7ccbd8c0413863a018fc1c1eb37\n
6bfcf857ceef0507bb50ee17302c1d068b697540
540abf2b75aec7ccbd8c0413863a018fc1c1eb37
540abf2b75aec7ccbd8c0413863a018fc1c1eb37\n
540abf2b75aec7ccbd8c0413863a018fc1c1eb37
b67f4651e49a33ee8cc77157e4e51d1e635a7c0d
b67f4651e49a33ee8cc77157e4e51d1e635a7c0d\n
1\n

Unsurprisingly, v1.1.2 (committed & tagged on a detached head) trips
things up again, moving gitk.cache out of the way helps again.

Surprisingly, v1.3 (committed and tagged on a checked out branch) trips
things up again, moving... helps again.

Paul, I hope you can make sense of this. Something in gitk.cache
prevents gitk from rescanning for new children, an empty cache gets it
right, but only until the next run.

Michael
