From: Sergei Organov <osv@javad.com>
Subject: Re: Amending merge commits?
Date: Wed, 30 Jul 2014 12:42:58 +0400
Message-ID: <87siljxmnh.fsf@osv.gnss.ru>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	<87r4147agk.fsf@osv.gnss.ru>
	<CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Besen\, David" <david.besen@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 10:43:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCPTb-00034B-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 10:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbaG3InF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 04:43:05 -0400
Received: from mail.javad.com ([54.86.164.124]:35968 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbaG3InC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 04:43:02 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 8A776617FA;
	Wed, 30 Jul 2014 08:43:00 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XCPTO-0001OB-SS; Wed, 30 Jul 2014 12:42:58 +0400
In-Reply-To: <CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
	(Nico Williams's message of "Tue, 29 Jul 2014 10:44:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254481>

Nico Williams <nico@cryptonector.com> writes:

> On Tue, Jul 29, 2014 at 4:58 AM, Sergei Organov <osv@javad.com> wrote:
>> Nico Williams <nico@cryptonector.com> writes:
>>> That exception aside, keeping all local commits "on top" by always
>>> rebasing them onto the upstream is extremely useful: a) in simplifying
>>> conflict resolution, b) making it easy to identify as-yet-unintegrated
>>> local commits, c) making it easy to contribute local commits.
>>
>> But 'pull --rebase=preserve' does rebase local commits onto the
>> upstream, and result is exactly the same as 'pull --rebase=true', unless
>> you have some of your own merges to be rebased. That's where the
>> difference between these two options appears. It's --rebase=false that
>> performs merges rather than rebase.
>
> Local merge commits mean that you either didn't rebase to keep all
> your local commits on top of the upstream, or that you have multiple
> upstreams (the example exception I gave).

I rather have multiple (release) branches on single upstream, say, v2.3
and v2.4. When something needs to be fixed in 2.3, it's fixed there and
pushed upstream, then, on 2.4, the 2.3 is merged to it, and result is
pushed upstream. When I do this merge, I need to push the merge
upstream, and this won't work reliably when --rebase=true is acitve
(through pull.merge=rebase). If nothing changes upstream, I can simply
push this, and the merge is correctly preserved. However, if somebody
makes any changes upstream while I perform the merge, I'll need to pull
before pushing, and this immediately flattens-out my merge, that is
absolutely not what is needed here. Or I can simply pull before push,
just in case, and this flattens history even when there are no any
changes upstream!

Once again, nobody yet gave any clue of when/why pull.merge=preserve
configuration is inferior to pull.merge=rebase, as for all the scenario
you seem to care about they bring the same result.

> Conversely, if you always rebase your local commits on top of the
> upstream then you won't have merge commits to worry about.

Wrong. I do alwys rebase my local commits on top of upstream, but I
still do have my own merge commits to worry about, as explained above.

-- 
Sergey.
