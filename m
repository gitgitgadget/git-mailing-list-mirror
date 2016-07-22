Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4065203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbcGVRkq (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:40:46 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36073 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbcGVRkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:40:46 -0400
Received: by mail-io0-f178.google.com with SMTP id b62so111306478iod.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 10:40:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WI8n51qfO/sJKPrHe9DY7K26e+NPNdTAxbVX4ls/jO8=;
        b=RO3uMywyY71/kCFpzz/rJKlQzhMcC3G1AAJ6i16hJTfw9Ovjv6VS+kstZNdTAQbSng
         HQZ+YzuqrevtR31GEex0oKd69NNf6Vnn2Q8rk4TXonwNwE9hVD7tstcuUpSM9yKxzWB3
         q/omIOD+AfrCWZPx+GTygoWkPGEglDKHqP48t0ghuk0NanYKd17jnF/qXAfe8vWPKtl1
         ititemmA1+vltpdUBpw/8gPImM30vnL1mdveAuwufeCca4395hnCmJtfyN+iuwiaUKnM
         26vGV7hoZ+xH1y1wo5LIb5kB0sQXh4J1rbhzKk4iTtJMhJrAalUV/O/Fk7ExKo5KTy6J
         Veqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WI8n51qfO/sJKPrHe9DY7K26e+NPNdTAxbVX4ls/jO8=;
        b=aM3CZZguJ842lAGIMl208v5mOw3tYCrzuUpxdVJj190hPN/AgPXJw8ERIuCJDyq08y
         Hj4EjOqVrp6cmtJ8nvxpJMCZQ4VeNJRxQh0qUgQXK4OUX5I4ulm+VjOIaM0C+/giu//0
         yZ8e2pmJH0zTh5XXhWbfkoG2bPF9Ybu3K9cmnA5MXw80kM4vrtwkT5AgSaeJ65n6YwMM
         wgajtJNqMoqiwmAzoDbo+PwAOIT0PdduQKevyEIE1t0w+ZPFRet0BIJDczr1CyDLnYkL
         21RMZjjZroYnaL+LAzkTkh6A/Os3UtzM6Ssc7mlHD3lTI62EeMixAGWlE07mSy7I8r3c
         c60A==
X-Gm-Message-State: AEkooutC6qut94yqBTO4+GTxiqWsKgLUQ+ObEa2FNK7lQVA8Usp1cGDkXT6BBh0TOcJlW5A4eYv2LNOTKib0A8bk
X-Received: by 10.107.131.38 with SMTP id f38mr6140778iod.173.1469209244951;
 Fri, 22 Jul 2016 10:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 10:40:44 -0700 (PDT)
In-Reply-To: <xmqqmvl9boju.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com> <xmqqmvl9boju.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 10:40:44 -0700
Message-ID: <CAGZ79kbH=ywi7sXUz5KKyRqo-Eg4RF3W9pf53rzKE-oz5-PW1Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> From a users POV there are:
>> * non existent submodules (no gitlink recorded, no config set,
>>   no repo in place)
>> * not initialized submodules (gitlink is recorded, no config set,
>>   and an empty repo is put in the working tree as a place holder).

I meant empty directory, not empty repo.

>
> This is no different from what you later call "embedded".  The only
> difference is that embedded thing hasn't seen its initial commit.

That did not occur to me.
The "not initialized" is what you'd get via

    git clone --no-recurse repo-with-submodules

whereas the "embedded" could come from

   git clone <repo with no submodules> tmp
   cd tmp && git clone <another repo, maybe unrelated>

>
>> * initialized submodules (gitlink is recorded, the config
>>   submodule .<name>.url is copied from the .gitmodules file to .git/config.
>>   an empty dir in the working tree as a place holder)
>>   A user may change the configuration before the next step as the url in
>>   the .gitmodules file may be wrong and the user doesn't want to
>>   rewrite history
>
> i.e. what "submodule init" gives you.

Right.

>
>> * existing submodules (gitlink is recorded, the config option is set
>>   and instead of an empty placeholder dir, we actually have a git
>>   repo there.)
>
> i.e. what "submodule update" after "submodule init" gives you.

Right.

>
>> * matching submodules (the recorded git link matches
>>   the actual checked out state of the repo!, config option and repo exist)
>
> Is this any different from "existing" case for the purpose of
> discussing the interaction between a submodule (and its checkout)
> and having possibly multiple worktrees of its superproject?

I don't think so.

>
> I agree that when a top-level superproject has multiple worktrees
> these multiple worktrees may want to have the same submodule in
> different states, but I'd imagine that they want to share the same
> physical repository (i.e. $GIT_DIR/modules/$name of the primary
> worktree of the superproject)---is everybody involved in the
> discussion share this assumption?

At least me agrees.

>
> Assuming that everybody is on the same page, that means "do we have
> the repository for that submodule, and if so where in our local
> filesystem?" is a bit of information shared across the worktrees of
> the superproject.  And the "name" used to identify the submodule is
> also shared across these worktrees of the superproject, as it is
> meant to be a unique (within the superproject) identifier for that
> "other" project it uses, no matter where in the superproject's
> working tree (note: this is "working tree", not "worktree") it would
> be checked out, and where the upstream URL to get further updates to
> the submodule is (i.e. that URL may change over time if they relocate,
> or it may even change when the user who works on the superproject
> decides to use a different mirror).

I agree.

>
> What can be different between the instantiation of the same
> submodule in these multiple worktrees, and how they should be
> recorded?
>
>  * submodule.$name.URL?  I am not sure if we want to have different
>    "upstreams" depending on the worktree of the superproject.  While
>    there is no fundamental reason to forbid it, having to maintain a
>    single local repository for a submodule would mean they would
>    need to be treated as separate "remotes" in the submodule
>    repository.

You can only have a remote if the the submodule repo exists already.
I guess that can be made a requirement.

So setting up the worktrees and submodule URLs in the config and
then doing the clone of said submodule is maybe not encouraged.

>
>  * submodule.$name.path of course can be different depending on
>    which commit of the superproject is checked out in the worktree,
>    as the superproject may move the submodule binding site across
>    its versions.

Right.

>
>  * submodule.$name.update, submodule.$name.ignore,
>    submodule.$name.branch, etc. would need to be all different among
>    worktrees of the superproject, as that is the whole point of
>    being able to work on separate branches of the superproject in
>    separate worktrees.

What do you mean by "would need". The ability to be different or rather
the veto of an 'inheritance' of defaults from the repository configuration?

>
> Somewhere in this discussion thread, you present the conclusion of
> your discussion with Jonathan Nieder that there needs a separate
> "should the submodule directory be populated?" bit, which currently
> is tied to submodule.$name.URL in $GIT_DIR/config.

I'll try to get the discussion back on list and whenever Jonathan starts talking
off list, I'll poke him with a stick.

>  I tend to agree
> that knowing where you get other people's update of that submodule
> repository should come from and wanting to have/keep a checkout of
> that submodule in the working tree of a particular worktree are two
> different things, so such a separate bit would be needed, and that
> would belong to per-worktree configuration.
>

Okay. How would you disentangle these two things?
