Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BB8208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 05:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdHPFwU (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 01:52:20 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36786 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdHPFwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 01:52:19 -0400
Received: by mail-yw0-f179.google.com with SMTP id u207so16768526ywc.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SO29yxDD9cePElIvGF6gJ01kGfNZ8ibv/eC1HlFC2nw=;
        b=GnJVqLoPX+qT0xq/oKKsVI4Dv5dVZ5lhWvzM2zCOKkzQgGh4+sPdR/o1vzhg2lf5No
         0Entzg8pAGtSg4F0G7ekxUSKoSpci/JNqfXuUJJCVZiScR95g5YlD1PanSx1DaB8JnjW
         qaU9owo4jqn2g81brfzGR+nOgLYPOPqwKirUWOkOOA30H4g42HVGDIKiC+a1aVeH7FS7
         lMIKmz98O+zWENNrzj4ui1IVH7yl0lcK3d/y/flGV4eo19sY9VHLwzkm8jlDyDGf+plm
         Vs2ndZLRuHYpIMCc8yHja/mWgDO8tFpz+Ae0iI1t8cL8fPEnVzB9OifSlEVkH+o5Tui2
         DgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SO29yxDD9cePElIvGF6gJ01kGfNZ8ibv/eC1HlFC2nw=;
        b=HkxpBgJ72YR50Apm/+YorC/kKjFvzNwhCuoARmmJua/2LUJTiASGBuE68bFjpwm9wR
         BBJjXTe/y3YD7EhabmuBZGqTJ+ncu3KXf+5tR+96lETaWQ934OL97Y9Ea+/sELYheKdQ
         bpiSwcLMtKHFfjz0c74J+0dr5X7rB9WcU5OIAREyRUKkgBTggUAGxyB3lqZVMc9NskRS
         KpxplIh8WNv9fc+UoSEIQdnlttkJ9D39RteSik00XG9P/yYSuc0UeZ8pox04vJQsIHwG
         LN9tPotV1usyOSCmqYv7v/YX4xNgS1jPTeLRH0/F7np/FbzyygvYr/J/5ce9rQANNHrV
         yEJQ==
X-Gm-Message-State: AHYfb5heZrIJetWahp/uhbcP2j1yb0hneIw8YbOCK7l2HkJXekcIst/V
        L4+AN7SLm6zW1rYoZ3ssqHEIqPr7xrHb
X-Received: by 10.37.115.78 with SMTP id o75mr483158ybc.244.1502862738672;
 Tue, 15 Aug 2017 22:52:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 22:52:18 -0700 (PDT)
In-Reply-To: <20170816020809.GI13924@aiede.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com> <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com>
 <xmqqd17wpe14.fsf@gitster.mtv.corp.google.com> <CAGZ79kZAkdiKHUweQK6U4dqAakfzReDMfiHKDmzsKGuAH3BgyA@mail.gmail.com>
 <20170816020809.GI13924@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 22:52:18 -0700
Message-ID: <CAGZ79kaUgPmoPw7XGY6qxc64_5DygfX4xM5noX4E5EW6=Ejm+Q@mail.gmail.com>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 7:08 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>> On Tue, Aug 15, 2017 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>> Junio C Hamano wrote:
>
>>>>> Is "is it populated" a good thing to check here, though?  IIRC,
>>>>> add-submodule-odb allows you to add the object database of an
>>>>> inactivated submodule, so this seems to change the behaviour.  I do
>>>>> not know if the behaviour change is a good thing (i.e. bugfix) or
>>>>> not (i.e. regression) offhand, though.
>>>>
>>>> Good point, we should be able to push non-populated, even inactive(?)
>>>> submodules. For that we strictly need add_submodule_odb here
>>>> (or the repo object of the submodule, eventually).
>>>>
>>>> So let's retract this patch for now.
>>>
>>> Not so fast.
>>
>> Ok, I took another look at the code.
>>
>> While we may desire that un-populated submodules can be pushed
>> (due to checking out another revision where the submodule
>> doesn't exist, before pushing), this is not supported currently, because
>> the call to run the push in the submodule assumes there is a
>> "<path>/.git" on which the child process can operate.
>> So for now we HAVE to have the submodule populated.
>
> It was not immediately obvious to me that this is just "for now".
>
> I would be really confused if I had deactivated a submodule and
> "git push --recurse-submodules" pushed from it anyway.

agreed.

>  If the
> submodule is active but not populated, then the question becomes "Why
> wasn't it populated?"

because you checked out a different revision where the sub is not
part of the working tree, for example. As long as you have locally
interesting "stuff" you want to transfer it. (IMHO even when the sub
is not active)

> If this is a bare repository, then nothing is populated,

Currently bare repos do not support having submodules
AT ALL, i.e. there is no modules/<name> directory
where the submodules would have any valuable information.
instead we *only* have the .gitmodules files at e.g. HEAD.

> and pushing
> from an active-but-unpopulated submodule sounds like a plausible wish.

it seems we're on the same page here.

> But in a non-bare repository, I'm having trouble imagining the use
> case that brings this situation about.

git checkout revision-with-sub
# hack.. hack.. hack..
"git commit --recurse-submodules -m bugfix"
# ^ not yet implemented
git checkout revision-without-sub
# Oh! I forgot to push the bugfix
git push --recurse-submodule <bugfix>

> And where people have been needing this so far has been non-bare
> repositories.  In that context, the check "is active and populated"
> does not seem unusual or provisional.  Are you hinting that replacing
> the check with "is active" would make it work well in bare
> repositories?

No I was saying:
* currently the code only works when "is populated"
* currently "is active" seems not to be considered

* in the future the code shall work even when not "is populated",
  (but submodule git dir is there at the very least)
* we may want to discuss if we want to care about "is active"
  additionally

>  I think I agree, though you'd have to be careful about
> the case where the submodule is active but hasn't been fetched to
> $GIT_DIR/modules yet.

When not fetched yet, there is no modules/<name> git dir and
we are sure there is no locally interesting information, so we
want to omit the push. (see above "has git dir" is the minimum
requirement, as opposed to current "is populated".

> Thanks,
> Jonathan
