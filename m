From: Stefan Beller <sbeller@google.com>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Mon, 26 Oct 2015 09:28:11 -0700
Message-ID: <CAGZ79kb2kStk0+MqUXREH3g+rqbsXoNiTGj=4SxJ4vOR8TqEcA@mail.gmail.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
	<CAFOYHZAKvN8xMKePCNFgo_ySHr0dc0+ASY0ux7j0p8UF1fuWCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Smith <johsmi9933@inbox.com>, GIT <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 17:28:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqkd8-0001gV-Tj
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 17:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbJZQ2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 12:28:13 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36683 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbJZQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 12:28:12 -0400
Received: by ykba4 with SMTP id a4so183258388ykb.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gfV2iYmHjqvDu1xB7IpY8Af5pmg7rkfK8GrXGwKrB2U=;
        b=fbj418h1Lf0q7kOWoeceE7gNsGWFZ9+V9E62e8wBWeu1yRD/UBxLdAaF6gdcI2cDKD
         kY807NogibpLBTLourAIT5GGPdmJTjcgLuvJ/QbP+12ilUGGK97/YaFPMd0u6oL3HwCA
         rvEjt9vSatPvwNJY+va7slCjBxsnrk2xt4XRWBZ5sLzacsetYClVP22sH4wA70RL4cx+
         n+X1x3zWSko2DhW2pi7pgFD9FkE63QlCEFiGSp6tWGxs/2BN/Xad5K47VL3B0kx2ut1e
         HVz1d1ROg6PdbIFC6uB4lbRUgg0Dio1J6wthRALD2b8U+jR7cyOUW1Gq+JlD9RBad8he
         l/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gfV2iYmHjqvDu1xB7IpY8Af5pmg7rkfK8GrXGwKrB2U=;
        b=dtqQPGmngZcW2TGHeZCweIAIcnL5mpsOFtXscLq9eFrcWJBSYYZpLH5PL12McAxkAr
         lA5mTfObGl0nSRYvu8XC5tg7jMY9HBG787ul1wnxK1WR1RYpIgdvaQjytmwi0ozt5D0l
         b9s6WPMEgVE7hT3t64fU5WfSP7Px2zUNXORldSKiy+df1mwnabKSR6SN22LhINlbpR/2
         R4Md2jrZZ7YBKLOzVfkNxNeQdk/GhjTqdTxpC6F6bfh7FgvHHjSsTS/5K6JsIghobR+5
         h2O/fiDiaUzh6rRdSPswVs1BAX0NvRURswQkq7d2B2/ZEU3t9KWAv54uzTvWfWDOu6cO
         vEaw==
X-Gm-Message-State: ALoCoQlNfMXtc8F7XhIwrpwVW1sQleaXOtLFJQ9E8yDtdcg/5L78Awrj2EIbeZrEtc45N/Dabv6z
X-Received: by 10.129.155.130 with SMTP id s124mr25108533ywg.68.1445876891965;
 Mon, 26 Oct 2015 09:28:11 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 26 Oct 2015 09:28:11 -0700 (PDT)
In-Reply-To: <CAFOYHZAKvN8xMKePCNFgo_ySHr0dc0+ASY0ux7j0p8UF1fuWCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280198>

On Sun, Oct 25, 2015 at 5:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
> On Mon, Oct 26, 2015 at 12:10 PM, John Smith <johsmi9933@inbox.com> wrote:
>> I found that I use submodules much, much more often in my git projects than I used externals
>> in Subversion and the reason is that git encourages/forces to organize large projects into
>> smaller repositories, one reason for this being that subversion allows to check out parts of
>> a repository while git does not.
>>
>> But when I clone a git repository with subprojects, I (and everyone else) has to remember to
>> add the --recursive option. When switching between branches with different versions/commits of the
>> submodules everyone has to remember to update the submodules. When updating a submodule
>> everyone has to remember to recurse there too.
>
> The config option fetch.recurseSubmodules exists. It's not quite the
> same as what git clone --recurse-submodules does but it's a start.
>
>>
>> Basically, everything with submodules has to be done manually every time and there seems
>> to be no way to change that default.
>>
>> Why is that? Basically all the time I use submodules I would want automatic handling of
>> submodules to happen and I cannot  remember having had a single situation where I would
>> not have wanted it to happen. So  why does git default to doing nothing?

IIUC at the time submodules were invented, there was need for lots of
code to be written.
Each command needed new code to deal with submodules. As there was not
enough people/time
to do it properly, the "do nothing" was the safest action which could
be added fast.

>
> It's hard to pick a default that suits every workflow that submodules
> support. Also with submodules there is a chicken-and-egg scenario.
> While you can put things in ~/.gitconfig most of what you'd want to
> configure when using submodules would be in super/.git/config but that
> doesn't exist until you've cloned super.git.
>
>> Why does it not provide a way to enable automatic
>> pulling/updating of submodules e.g. when cloning or switching branches?
>
> I believe Jens and Stefan (Cc'd) have been doing some great work in
> this area. Jens even posted his todo list a few days ago
> (https://github.com/jlehmann/git-submod-enhancements/wiki).

Yeah I would also point at Jens' wiki today.

All I did up to now was rewriting parts of the submodule code in C
(git submodule update specifically), while the code/patches you find at Jens'
copy of Git includes already lots of useful stuff such as `git
checkout --recurse-submodules`
(IIRC you don't need to type --recurse-submodules if you configured
that to be the default)

>
>> When would people routinely check out a branch and want to stay with the submodules as
>> the have been checked out for the old branch?

As said above, it was a sane choice which could be implemented fast, IIUC.

I mean what would happen if you had commits made in the submodule, or
just a dirty working tree?

>>
>> I honestly do not understand it.
>>
>> John
>>

Stefan
