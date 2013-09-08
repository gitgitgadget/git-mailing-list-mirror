From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 02:15:17 -0500
Message-ID: <CAMP44s3LLHL=oP2PFr4b7VD0dL4yGBOL00O_GWj8eZLrYNM3kg@mail.gmail.com>
References: <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908044329.GA15087@sigill.intra.peff.net>
	<CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
	<20130908052107.GA15610@sigill.intra.peff.net>
	<CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
	<20130908065420.GI14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 09:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZDQ-0000qJ-0u
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab3IHHPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:15:20 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:50435 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3IHHPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:15:19 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so4076160lbh.34
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x5rzyCkSgtMFZF1SS7KpBM/WNEhvh2IxltaDSat3BoI=;
        b=cGL7WKuHOUYIhoar90gRZVni1Hxz7dfBJnmoR/u4Yukq3+xY2exWaZB/WrBXWiq4vW
         XCN+7SHFks4m4vDIjXbxh9lPG8+nikb2+D3XK+lVWiCAdba/zPaOPJhFjrjzGvKJIDzd
         GS4Gb+jQY17epzvFu1THm6IiFcLyXXE7RmDb+t4iLMioELOQf4KJwDtSmiQS/vRmUCen
         O/xaX7MhrrPfgxl9lRpWPW3N4I6h43JpFpuDu+jo/p9YXgKnd0E13vWgH05AO5lQjiey
         /Ra3i2sAMwXR/XSyVR5aFUaVDFGVnnseaMA/IA9hGdW0jcvCYJ/2xd65gAm018ZSxXEL
         IzJA==
X-Received: by 10.112.89.100 with SMTP id bn4mr10736245lbb.16.1378624517755;
 Sun, 08 Sep 2013 00:15:17 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 00:15:17 -0700 (PDT)
In-Reply-To: <20130908065420.GI14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234196>

On Sun, Sep 8, 2013 at 1:54 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 08, 2013 at 01:17:42AM -0500, Felipe Contreras wrote:
>
>> > I think it's fine to tell them to do "git pull --merge". What I'd worry
>> > more about is somebody who is suddenly presented with the choice between
>> > "--rebase" and "--merge" and doesn't know which to choose. We've created a
>> > cognitive load on the user, and even more load if they choose --rebase
>> > and don't quite understand what it means.
>>
>> If that happens they will go back to the guy that told them to run
>> those commands.
>
> I think "the guy" may be git itself. For example, here is a possible
> session with jc/pull-training-wheel:
>
>   $ git push

Who told him to use 'git push'? Certainly not git.

>   To ...
>    ! [rejected]        master -> master (non-fast-forward)
>   error: failed to push some refs to '...'
>   hint: Updates were rejected because the tip of your current branch is behind
>   hint: its remote counterpart. Integrate the remote changes (e.g.
>   hint: 'git pull ...') before pushing again.
>   hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>
>   $ git pull

>   The pull does not fast-forward; please specify
>   if you want to merge or rebase.
>
>   Use either
>
>       git pull --rebase
>       git pull --merge
>
>   You can also use 'git config pull.rebase true' (if you want --rebase) or
>   'git config pull.rebase false' (if you want --merge) to set this once for
>   this project and forget about it.

Why stop there? Post the whole man page already.

Moreover, it's overly verbose on all the wrong and irrelevant
information. If you are going to waste precious screen state, explain
wth a "non fast-forward" is; people can figure out what a merge is,
and maybe a rebase, but a "non fast-forward" definitely not.

> The user is pointed at "pull" from "push", and then gets presented with
> the "merge or rebase" choice. It may be that the advice you can find by
> googling "merge vs rebase" is enough to then help the person along
> (and/or we may need to improve the manpages in that respect).

Yes, but that's not the use-case we are talking about. You mentioned
specifically a "svn-like" worfklow where the guy was told by somebody
else to replace the svn commands with git ones.

If we are talking about a guy that is learning git, that's and
entirely different case.

> I am genuinely curious what people in favor of this feature would want
> to say in the documentation to a user encountering this choice for the
> first time. In my experience, rebasing introduces more complications,
> specifically:

Yes, but it's what the user might want.

> I know those are all balanced by some advantages of rebasing, but I also
> think they are things that can be troublesome for a user who does not
> fully grok the rebase process. I'm just wondering if we should mention
> both, but steer people towards merging as the safer alternative (you
> might have ugly history, but you are less likely to create a mess with
> duplicate commits or badly-resolved conflicts).

The purpose of this change in the code is not to change the user
behavior. The choice of merge vs. rebase is entirely up to the user,
and we are not changing that.

The purpose of this change is to avoid doing a merge when the user
wanted a rebase, or maybe something more complicated. So a rebase
being complicated is not an issue, because we know that's what the
user wants, that's the whole reason we are trying to avoid the
automated merge.

>> Fortunately there probably are very few of these users.
>
> Maybe. I am not sure how one would measure.
>
> If you are interested, I can ask the opinion of some of the GitHub
> trainers. They see a lot of new users and have a sense of what kinds of
> confusion come up most frequently, what kinds of workflows they tend to
> see, etc. Their experience may be biased towards corporate-ish users,
> though, because those are the people who pay for training.

Ask. I'm sure they will tell you doing merges by mistake with 'git
pull' is an issue.

>> > The current warning message in jc/pull-training-wheel is quite neutral
>> > between the two options. Perhaps we should lean more towards merging?
>>
>> I don't like that message. I would like this for the deprecation period:
>>
>> "The pull was not fast-forward, in the future you would have to choose
>> a merge or a rebase, merging automatically for now. Read 'man git
>> pull' for more help."
>>
>> Then when obsolete:
>>
>> The pull was not fast-forward, please either merge or rebase.
>
> A deprecation message helps people who are making the transition from an
> older behavior to a newer one. It cannot help new users who start with a
> git version after the deprecation period.

The new users are told to either merge or rebase, if they don't know
what that means, they will go on look it up, just like they looked up
the 'git pull' command in the first place.

>> "Any more babysitting with essay long messages is counter-productive
>> to the vast majority of Git users."
>
> I think that is what we have advice.* for.

I don't understand what that means.

-- 
Felipe Contreras
