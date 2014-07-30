From: Sergei Organov <osv@javad.com>
Subject: Re: Amending merge commits?
Date: Wed, 30 Jul 2014 22:28:23 +0400
Message-ID: <877g2uu2ew.fsf@osv.gnss.ru>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	<87r4147agk.fsf@osv.gnss.ru>
	<CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
	<87siljxmnh.fsf@osv.gnss.ru>
	<CAK3OfOgcO9dmePtXCu9gUSf2bdQytJf9-RCZDXhv9Gy8UVyDOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Besen\, David" <david.besen@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:28:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCYc3-0007ob-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 20:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbaG3S21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 14:28:27 -0400
Received: from mail.javad.com ([54.86.164.124]:45956 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbaG3S21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 14:28:27 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 7867B617FA;
	Wed, 30 Jul 2014 18:28:25 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XCYbv-0001uT-D3; Wed, 30 Jul 2014 22:28:23 +0400
In-Reply-To: <CAK3OfOgcO9dmePtXCu9gUSf2bdQytJf9-RCZDXhv9Gy8UVyDOQ@mail.gmail.com>
	(Nico Williams's message of "Wed, 30 Jul 2014 12:43:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254508>

Nico Williams <nico@cryptonector.com> writes:

> On Wed, Jul 30, 2014 at 3:42 AM, Sergei Organov <osv@javad.com> wrote:
>> Nico Williams <nico@cryptonector.com> writes:
>>> Local merge commits mean that you either didn't rebase to keep all
>>> your local commits on top of the upstream, or that you have multiple
>>> upstreams (the example exception I gave).
>>
>> I rather have multiple (release) branches on single upstream, say, v2.3
>> and v2.4. When something needs to be fixed in 2.3, it's fixed there and
>> pushed upstream, then, on 2.4, the 2.3 is merged to it, and result is
>> pushed upstream. When I do this merge, I need to push the merge
>
> Hmm, why not cherry-pick the fix?  That's how every project I know
> that ports fixes across release branches does it.

Cherry-pick? Why bother? What problem do we solve, having no merges
whatsoever? Why? GIT is so good at merges!

My impression is that people mostly rather do topic branches, and merge
them wherever they need the fixes, no?

>> upstream, and this won't work reliably when --rebase=true is acitve
>> (through pull.merge=rebase). If nothing changes upstream, I can simply
>> push this, and the merge is correctly preserved. However, if somebody
>> makes any changes upstream while I perform the merge, I'll need to pull
>> before pushing, and this immediately flattens-out my merge, that is
>> absolutely not what is needed here. Or I can simply pull before push,
>> just in case, and this flattens history even when there are no any
>> changes upstream!
>
> Does this change if you give your merge commits an different commit
> message?

Different from what? I'm almost sure commit message has nothing to do
with it. Please refer to this explanation to see for yourself how git
behaves when rebasing:

http://www.mail-archive.com/git%40vger.kernel.org/msg55605.html

>
>>> Conversely, if you always rebase your local commits on top of the
>>> upstream then you won't have merge commits to worry about.
>>
>> Wrong. I do alwys rebase my local commits on top of upstream, but I
>> still do have my own merge commits to worry about, as explained above.
>
> If you cherry-pick the cross-release-branch commits you'll not have a
> merge commit to worry about.

I fail to see why do you consider merge commits to be an evil, really. I
didn't think about cherry-picking carefully, but I don't feel
cherry-picking is the best tool for the job here. I suspect random
cherry-picking would create a mess, sooner or later.

-- 
Sergey.
