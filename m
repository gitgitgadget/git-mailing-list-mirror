Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702C3203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 23:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbcGYXZ0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 19:25:26 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35635 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbcGYXZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 19:25:25 -0400
Received: by mail-it0-f48.google.com with SMTP id u186so98233176ita.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 16:25:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xlj+LW1vb91nfRjfy0D7NJeqcoRMaYt3/IK+u/23KII=;
        b=cB2FHE2aYH01yJysqyabz1JzLGjZhbAQ1Zdsxrkwvc+hIV/mUcXKhJRnA8dn5MRRGC
         b73DyQbXKGiX+DgaHtktq42J4p0i69gzjICO7lvOa+OpPibuGEBonKtKgxf7w0aooC22
         LvJOn9Yd70gz+QqidglMDSTDCUVZ4Fbwwzw4EP2e4soFcSBjVEOEpebgZlyaxf5jj090
         2zFhEu63ouOeq9oAm16HNat+Y0XVHlZRYIm8zjsvkYdavW4GUB+hUTGbStggI+pwI4+G
         o7yqNEPUS1PKZZ83Wy4bpCGL2vKUy3zHH1Oijam2WeJVxq0Ppw3Tfxbi8d2JnWrlqF/m
         RiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xlj+LW1vb91nfRjfy0D7NJeqcoRMaYt3/IK+u/23KII=;
        b=JAfWApCUTFG+5Ctc5LC5RtTnRlf2wrDv8BfjX8J16dL/sKSwB8/k4CuXxE63dQfbjo
         VtOueDVlnfUPcAVXgDAr2pnBb4g6SWJMSlQirM5WPKiuOM1m7zJyETe1n2FL3+jRkwnv
         y7s52sdYZu9F8Sqes7d0yeHmZJbNOBMGEEU9ldp4l6ykwwLybR+nP4H1yNHQvQyDkMkh
         SQZNic6V8uDXOWIa4br0h+aXaA8SkyBXatDHj5F0n4YOY4DbMeB+5B5T9Vr/5zNJ43GQ
         bISJXCZf+0y3kel4hAoTWBax9qmeHMRIpKOLJnkoSpervtMMp1SCYTMq6GWWXZkt+HUd
         ZDPA==
X-Gm-Message-State: ALyK8tLrHswzddYzUGGN41wkSr/nlt7hQOUoOScujNRcQwPP7542isfMPJBZRPDm15tiGi+nGlFjq9TtQM87tszz
X-Received: by 10.36.250.132 with SMTP id v126mr65273195ith.46.1469489123997;
 Mon, 25 Jul 2016 16:25:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 25 Jul 2016 16:25:23 -0700 (PDT)
In-Reply-To: <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com> <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 25 Jul 2016 16:25:23 -0700
Message-ID: <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 10:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jul 22, 2016 at 7:25 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Jul 22, 2016 at 10:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>> I just quickly glanced through the rest of this mail because, as a
>>> submodule ignorant, it's just mumbo jumbo to me. But what I see here
>>> is, there may be problems if we choose to share some submodule info,
>>> but I haven't seen any good thing from sharing any submodule info at
>>> all.
>>
>> Okay. :(
>
> Didn't mean to make you feel sad :)

I was using the :( a bit carelessly here. I was quite surprised that you
"haven't seen any good thing from sharing any submodule info at all."

So what is the design philosophy in worktrees? How much independence does
one working tree have?

So here is what I did:
 *  s/git submodule init/git submodule update --init/
 * added a test_pause to the last test on the last line
 * Then:

$ find . |grep da5e6058
./addtest/.git/modules/submod/objects/08/da5e6058267d6be703ae058d173ce38ed53066
./addtest/.git/worktrees/super-elsewhere/modules/submod/objects/08/da5e6058267d6be703ae058d173ce38ed53066
./addtest/.git/worktrees/super-elsewhere/modules/submod2/objects/08/da5e6058267d6be703ae058d173ce38ed53066
./.git/objects/08/da5e6058267d6be703ae058d173ce38ed53066

The last entry is the "upstream" for the addtest clone, so that is fine.
However inside the ./addtest/ (and its worktrees, which currently are
embedded in there?) we only want to have one object store for a given
submodule?

>
>> I assume the sharing is beneficial. (As a work-tree ignorant) I thought
>> we had this main work tree, which also holds the repository, whereas
>> the other working trees have a light weight implementation (e.g. just
>> a .git file pointing back to the main working tree/git dir).
>
> The main worktree is special for historical reason. But from the user
> point of view (and even developer's at a certain level) they should be
> treated equally. Think of it like cloning the same repo multiple
> times. Only now you save disk space because there's only one object
> database.

That's what we want for submodules too, see above?

>
>> So in a way my mental model is more like the config sharing here
>> You can configure things in ~/.gitconfig for example that have effects
>> on more than one repo. Similarly you would want to configure things
>> in one repo, that has effect on more than one working tree?
>>
>> And my assumption was to have the repository specific parts be shared,
>> whereas the working tree specific things should not be shared.
>
> I think that's a good assumption. Although I would rather be not
> sharing by default and let the user initiate it when they want to
> share something. Like ~/..gitconfig, we never write anything there
> unless the user asks us to explicitly (with git config --user).
> Accidental share could have negative effect.

Okay, got it.

>
>>> I can imagine long term you may want to just clone a submodule repo
>>> once and share it across worktrees that use it, so maybe it's just me
>>> not seeing things and this may be a step towards that.
>>
>> Just as Junio put it:
>>> I agree that when a top-level superproject has multiple worktrees
>>> these multiple worktrees may want to have the same submodule in
>>> different states, but I'd imagine that they want to share the same
>>> physical repository (i.e. $GIT_DIR/modules/$name of the primary
>>> worktree of the superproject)---is everybody involved in the
>>> discussion share this assumption?
>>
>> I agree with that as well.
>
> Yeah. We have a long way to go though. As I see it, you may need ref
> namespace as well (so they look like separate clones), which has never
> been used on the client side before. Either that or odb alternates...
>
>>> And because I have not heard any bad thing about the new config
>>> design, I'm going to drop submodule patches from this series and focus
>>> on polishing config stuff.
>>
>> Oh, sorry for not focusing on that part. The design of git config --worktree
>> is sound IMO.
>
> This makes me happy (I know other people can still find flaws in it,
> and I'm ok with that). This config split thing has been wrecking my
> brain for a long time, find the the "right" way to do with minimum
> impacts :)

After playing with this series a bit more, I actually like the UI as it is an
easy mental model "submodules behave completely independent".

However in 3/4 you said:

+ - `submodule.*` in current state should not be shared because the
+   information is tied to a particular version of .gitmodules in a
+   working directory.

This is already a problem with say different branches/versions.
That has been solved by duplicating that information to .git/config
as a required step. (I don't like that approach, as it is super confusing
IMHO)

+
+ - `remote.*` added by submodules may be per working directory as
+   well, unless you are sure remotes from all possible submodules in
+   history are consistent.
+

Same as above.

I planned to have a series out last Friday, but it took longer than expected
as it was unclear how to best proceed and I ran into problems solving
"trivial issues".

I am back to the drawing board for the submodule side of things,
but I guess this series could be used once we figure out how to
have just one object database for a submodule.

Thanks,
Stefan

> --
> Duy
