From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Branch dependencies
Date: Wed, 3 Aug 2011 01:25:42 +0200
Message-ID: <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
	<CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
	<20110802190806.GA16674@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 01:25:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoOLM-0007GB-J1
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 01:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab1HBXZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 19:25:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57118 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab1HBXZn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 19:25:43 -0400
Received: by vws1 with SMTP id 1so104633vws.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T98KtbDz7EOtMIkwJ6WVK3bFJ+4von4REHd3b9jcvjU=;
        b=VHIncwdmiCDIC/3Fe4vW74TxXUZxipCYQf/ZkS/E9IlhbeMZe6AXg5fY4vPAE1ft8Y
         4XKc0wXeltoHvbv7elz33zdWrGZ0eubhop2kMUmxWk/PRFh02VZX6bGzSDycsDvaGbxe
         dp8zDoyf/2IDva+XHfjWDWdzzTJPTUawCK9uA=
Received: by 10.52.20.202 with SMTP id p10mr6100707vde.304.1312327542613; Tue,
 02 Aug 2011 16:25:42 -0700 (PDT)
Received: by 10.52.184.4 with HTTP; Tue, 2 Aug 2011 16:25:42 -0700 (PDT)
In-Reply-To: <20110802190806.GA16674@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178532>

Hi,

On Tue, Aug 2, 2011 at 21:08, martin f krafft <madduck@madduck.net> wrote:
> also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2011.08.02.1506 +0200]:
>> while I appreciate, that you dig this topic up. I think you are trying
>> to solve the wrong problem first. My main problem with the TopGit
>> approach is, that you can't freely change the dependencies of a topic.
>> This may be not the most common case in distro development. But in my
>> eyes more problematic than maintaining the meta data.
>
> Hello Bert, thank you for taking the time to respond!
>
> Could you please try to illuminate me a bit on a use-case of
> changing dependencies? I am aware that TopGit has had a problem with
> changing dependencies due to renamed branches, and I think I have
> a solution to that (encode the dependent ref, not the branch head),
> but I cannot come up with a use case for freely changing
> dependencies just like that.

Not each feature branch may end up in master. And there does not need
to be one feature branch which depends on all other features. For the
latter you have probably an empty feature branch which just depends on
all features. I call this branch mostly 'tip'. Removing a feature
branch from the tips dependency list only with merges can't be done
right now, and the proposed solutions never reached a usable state.

My second usecase is to convert a big quilt patch series into TopGit.
Such big Quilt patches have mostly an artificial dependency to its
predecessors. Removing these artifical dependencies makes it necessary
to remove dependencies from patches.

>
>> For my first mentioned problem, I think a new 'system' needs to be
>> 'rebase' based, not merge based like TopGit.
>
> The problem with rebasing is that you cannot publish the branches.

That doesn't hold you back to publish them. But the other side need to
know how to deal with them.

Saying that doesn't mean I know a good way to deal with them. I mostly
end up using plumbing commands to deal with this.

>
> However, maybe I am simply not seeing the light here. Do you have
> some further ideas about what this would be like? Please keep in
> mind that what I seek is not just a way to bring feature branches
> up-to-date with upstream, but also to have those branches be shared
> among developers.

I think that having the TopGit philosophy of one feature branch is one
patch, you can handle an rebased upstream. Thinking of a feature
branch as a series of patches makes this way harder. But I would like
to have this philosophy.

Bert

>
> Thanks,
>
