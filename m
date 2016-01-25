From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and submodule.autoInitialize
Date: Mon, 25 Jan 2016 10:59:12 -0800
Message-ID: <CAGZ79kY1Wa7kHh7GaCTAAmyaRgrT4_91XLaHZFrko9umEbNYkw@mail.gmail.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
	<56A52818.8080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:59:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmMA-0000ul-9m
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 19:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbcAYS7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 13:59:15 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35513 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbcAYS7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 13:59:13 -0500
Received: by mail-ig0-f182.google.com with SMTP id t15so42444688igr.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ri6ghxHnqtz1rs3ivRGxUkn5HfvkGqusj+gRglQOa7g=;
        b=RtwF8uzVu0YwFOxwTlXWj0hwOgXNGT81TYri7Sel2eiMz1A7KwinhptTxF88lSr/2+
         cbDyiXQdmikRIVfklWeohn6eR4m0XNInSz48di0nIJED2z5AlxCu2A8XZJfJfIs33eBA
         e6Z0KpMHXeCUxji20gdJIjAHKYse99LRhGHSKiXmPM11jNLhg3Z+BMPibtrIuLd3Nv+F
         9t07IhonWvgytrDxTlJ6nBXnkpV+pcEL7rrxRCo9PUvArIpGxKZYWoJ2deSn13qQQ8PG
         s8oXF773nlgKkNKV8/8vj1o5Dj6ZNWWTnibu5dnXs81pyGyHSsAXVkaTTW43APxrUYHC
         g2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ri6ghxHnqtz1rs3ivRGxUkn5HfvkGqusj+gRglQOa7g=;
        b=ifqOODXsOWY/q0usqjWnEz1cJepeXAZm4jBBV0jN2gGcdJqlq83XZ2or+ot7sph9ei
         FYS4sxkBhQdu1qUyRoQt96BLvoZQ7FBKRt9Sze8BXR9oI9fLawlnapM+tRsZ7F6CZG+8
         +PJ3sWvIqCeGKCV0BNxosLErrOH51EQaKSYR/GPBXSO7VRJv6ut5JzJjGDNbQOy6ZTzf
         sj8RYXn2takJCORsJxUL/0OU/6vC9Llcpixc96UMUE5qskBEx8UQSU5kIquNPzuhNq8E
         x0PybcYK0nOGS4GQKuzUH/R5ap1boxM48o1GqjlQ7BMkbdD7NAmSB5kUzXcDM6TMnKzP
         Twfg==
X-Gm-Message-State: AG10YOR6bL5V3/hmpxcal5q+XxeZIbiiBHxoITI68m6uWEFZQKYSoJZzut7v9n+fR13WK6c219zpxq9yZRlOEvbT
X-Received: by 10.50.88.74 with SMTP id be10mr17269359igb.93.1453748352467;
 Mon, 25 Jan 2016 10:59:12 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 25 Jan 2016 10:59:12 -0800 (PST)
In-Reply-To: <56A52818.8080808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284747>

On Sun, Jan 24, 2016 at 11:38 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Disclaimer: Due to my currently very limited Git time budget I only
> glanced over the recent discussion and patches. If you think I missed
> something already discussed, I'd be happy being pointed to the relevant
> discussion so I can catch up and avoid wasting everybody's time.
>
> Am 23.01.2016 um 01:31 schrieb Stefan Beller:
>>
>> This series introduces labels which you can attach to submodules like so:
>>
>>      $ cat .gitmodules
>>      [submodule "gcc"]
>>          path = gcc
>>          url = git://...
>>          label = default
>>          label = devel
>>      [submodule "linux"]
>>          path = linux
>>          url = git://...
>>          label = default
>>
>>      $ git submodule add --name emacs --label "editor" --label default
>> git://...
>>
>>      # If upstream has submodules properly labeled, you can make use of
>> them:
>
>
> Cool. Without having looked at the code I assume you also can label
> submodules yourself in .git/config (or your global config) to override
> upstream's settings (or use your own labels if .gitmodules does not
> contain any)?

I am not sure. I'll add a test for that in a reroll and make sure it passes.

>
>>      $ git config --add submodule.autoInitialize "*default"
>>      $ git config --add submodule.autoInitialize ":name"
>>      $ git config --add submodule.autoInitialize "./by/path"
>
>
> Ok. Though we might wanna call it submodule.autoUpdate, as initializing
> it is only the prerequisite for automatically updating submodules. And
> I believe automatically updating is the thing we're after here, right?

I am not sure here, too. I would not mind an occasional "git submodule update"
for whenever I want upstream to come down on my disk. However that's what I
do with "git pull" in the non-submodule case, so you'd expect git pull to
also run the update strategies for all submodules which are configured to
autoUpdate?

That makes sense to me. Though I never use "git pull" to begin with.
I always use fetch and see how to go from there (merge or rebase
after inspecting the code I fetched). That would mean we want to
add the autoUpdate strategy to merge/rebase and the fetching of
submodules to the fetch command?

>
> I'll try to explain why I believe we should be generous in initializing
> submodules: If a submodule in one branch has a label configured to be
> automatically updated and hasn't got the same label in another branch,
> we still need to initialize the submodule even when we are on the latter
> branch in case the user switches to the first branch, right?

No. "git checkout" ought to autoInitalize the submodule in question when
switching branches. I don't want to see initialized, but unused submodules
around (neither empty dirs nor in the .git/config ideally)?


> And the
> fetch command needs to fetch submodule changes too when they happen in
> a branch where this submodule is part of a label group configured to be
> updated automatically, no matter what is currently found in the work
> tree.

Right, as said above fetch needs to fetch all the submodules as well. I wonder
if it needs to fetch all submodule sha1s only or just try to get as
much from the
submodule as possible.

>
> So I'd propose to:
>
> *) Initialize every submodule present on clone or newly fetched when
>    the autoUpdate config is set.

What if you clone branch A and then switch to B ? B has a submodule which
was not initialized in A. I do not think initializing on clone/fetch
is the right thing
to do, but rather the branch switching command (checkout) shall make sure
all its autoUpdate/autoInitialze submodules are setup properly, no?

>
> *) Automatically fetch only those submodules that are changed in
>    a commit where they have a label configured (in the commit's
>    .gitmodules or locally) that is to be checked out.

Not sure I follow here.

>
> *) Let "git submodule update" update only those submodules that
>    have an autoupdate label configured.

Why not update all initialized submodules? (In my imagination
"all initialized submodules" are equal to "all submodules the user is
interested in", i.e. when going from branch A to B, the checkout will
(de-)init submodules as necessary.

>
> That will make switching between branches with different label
> configurations work fine. Or am I missing something here?
>
> And we need to teach diff and status to complain about empty work
> trees and missing initialization of submodules that are to be
> automatically updated too.

What about empty work trees?

I'll add "git status" complaining about missing initialized submodules.

>
>>      # The prefix * denotes a label as found in .gitmodules
>>      # : goes before names
>>      # path are prefixed ./ currently
>>      # both path and names need work
>
>
> Question: how do I configure all submodules to be automatically
> initialized without having to give them a label? "./*"? Or just
> setting the option without a specific value?

I'd guess ./* should do. Path wildcard patterns are not supported in this
series, but I think it would be a viable way.

>
>>      # no --init necessary, partially initializes submodules (only those
>> which
>>      # were specified by label, name or path)
>>      $ git submodule update
>
>
> Yup. Just like they will be fetched if they haven't been yet they
> should be initialized if they haven't been yet but are configured
> to be automatically updated.
>
>>      # time passes, upstream may have added new submodules and we get them
>> without
>>      # extra commands!
>>      $ git submodule update
>>
>>      # The above configuration can be given to git clone directly via:
>>      $ git clone --init-submodule=*labelA ...
>
>
> Ok. Expecially nice is the ability to also give names and paths to
> "--init-submodule". (but maybe that option should be called
> "--autoupdate-submodule" for the reasons stated above?)

If I can understand the discussion above a bit further, I'd be happy
to rename the option.

I think we have some different opinions on when
submodules are initialized (the invariant of what an initalized submodules
means), and resulting from that we also have different opinions on when
to do the (de-)init.

>
>> Why?
>> ====
>> If you have lots of submodules, you probably don't need all of them at
>> once,
>> but you have functional units. Some submodules are absolutely required,
>> some are optional and only for very specific purposes.
>
>
> I'd rather like to see this as a special case of sparse checkout, as
> this will be a submodule-specific solution to a more generic problem.

That makes sense.

> But as I understand configuring sparse checkout won't materialize for
> quite some time, so I suspect we'll have to add labels first to make
> current submodule users happy in the near future. Sparse configuration
> can then re-use the infrastructure added here.
>
>


Thanks,
Stefan
