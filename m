Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E1B1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 20:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIIBqG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 21:46:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55929 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbeIIBqF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 21:46:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9874520F02;
        Sat,  8 Sep 2018 16:59:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 16:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Zy5irQnECv3wxxwPx/C6b97r1sWKH
        cdTmQbhshEMHoM=; b=e0l4M0jTMwlSyXMMaoZcP51JfyPEYdXbsEhYEGw4DmyEK
        +p4taD6HXWaaeRqaVHorhUGIWMzLWbQ12ikYPmVQPKDwg57tkFVs4A0l1+dLqmwT
        ENhl8s/74HLUoe9/BF2crJLNqf3/lFBYPYiKgP16ztDhkmsx3m6+fRyrhSh5flg7
        rqqH6Gg7KHrb1k+THzA5fAY4SlVInGkNAvD5I76OS2f8d0WpQzEBUosHj1V0PaUj
        A+yxBQr5S8l1a7vZ8aL7Sw+2OTS0w62grWfDCF1yJmvAE7cNA5lq/y5WLvPP999l
        BD3SELceebXbIrKI0qo9v355Ec7Qw2tJdNjsbefng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Zy5irQ
        nECv3wxxwPx/C6b97r1sWKHcdTmQbhshEMHoM=; b=iiZNjMrjGOqbqrIsepDGWi
        zkVCOYJAbJNvXQLxemIHh/WSLWWYju7lvhQe3126K5MzMTXeopO9YbiJU1g/DanR
        pPB5XyZyHb1gpiosNk2IcP74EDxFoIGZRaAGqFac/bQfKF67X6MfGz98iW/GHZoO
        3Kl/wP1HtbkvCFKS2ttn2ZLouyDaGXkQ8fCNQRW8YTKXjreAj89a5kTB6PqAAXYc
        MhJRNX7UIE/tpcWdoT+rvAHl/dKv6bBvJd3H5ohn+C7evbgCZS3ZmH7hlB61pYqg
        6q+Fu+p4hoRrP1o5BSfUcgyPt1sRWUxdQYIdaaE9huqEPwH1/mAZo44/UHW95rsg
        ==
X-ME-Proxy: <xmx:FTiUW2tGAosL0wBbiuw_NOLuqQl4OyBDa3Kfh_SrpyXJVLgkumJTFA>
    <xmx:FTiUW05TIZ2JUfmopw6rjaifoS3n33xS7wZUk0K7dZgMEyqB8WIxdg>
    <xmx:FTiUWxXahpY6htgGWGGbnpbfIFyFcfSW9qV4jVzX5IUwZwdf8s68dg>
    <xmx:FTiUW2_MoAhXmSDjTdvPIg_Ub3PZsi7IJy9OZ7F9qeEfm5AyjYTDvg>
    <xmx:FTiUW9mro_c8qpikqchvuTpMXjv1rxQbidZSw6UMlb-QVMv7DFwzkw>
    <xmx:FTiUWw89odoP4fCgz_ZCK40GilievIl1A5S0fHL8L11NhMh6MCrSTg>
X-ME-Sender: <xms:FTiUW5NPF5MtNLsgbBxKadY6ybuSsLIfPUiGX_pia6QdilXG4BwuGw>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 698C610294;
        Sat,  8 Sep 2018 16:59:00 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
 <87a7orrc3w.fsf@evledraar.gmail.com>
 <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
 <877ejvraxh.fsf@evledraar.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <b1658700-dbec-f354-4979-5c3ab341af17@stason.org>
Date:   Sat, 8 Sep 2018 13:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877ejvraxh.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 01:28 PM, Ævar Arnfjörð Bjarmason wrote:
[...]
> Yeah, some version of this is sensible. There's at least a doc patch in
> here somewhere, if not some "warn if missing" mode.
> 
> So don't take any of this as minimizing that aspect of your bug report.
> 
> *But*
> 
> There's just no way that "git" the tool can somehow in a sane way rescue
> you from knowing the quoting rules of the shell on your system, which
> differ wildly between the likes of Windows and Linux.

I understand. All your explanations are perfectly reasonable, Ævar.
Thank you.

Yet, there needs to be some way for a user to know that git ignored
something if their configuration doesn't work as expected.

1) I suggest this is done via:

  git config --list --show-origin

where the new addition would be to also show configuration parts that
are not active and indicating why it is so.

So for example currently I get on a valid configuration setup and having
git/../.gitconfig in place the following output:

[...]
file:/home/stas/.gitconfig      mergetool.prompt=false
[...]
file:.git/config        include.path=../.gitconfig
[...]
file:.git/../.gitconfig
filter.fastai-nbstripout-code.clean=tools/fastai-nbstripout
[...]

Now, if include.path=../.gitconfig is there and file:.git/../.gitconfig
is not found, it will indicate that in some way that stands out for the
user. Perhaps:

[...]
file:/home/stas/.gitconfig      mergetool.prompt=false
[...]
file:.git/config        include.path=../.gitconfig
[...]
file:.git/../.gitconfig FILE NOT FOUND! Ignored configuration
[...]

So that would allow things to work as before, but now we have a way to
debug user-side configuration. And of course hoping that the docs would
indicate that method for debugging configuration problems.

I hope this is a reasonable suggestion that doesn't require any
modification on the users' part who rely on this silent ignoring
"feature", yet lending to a configuration debug feature.

2) And a secondary suggestion I mentioned earlier is to also have a flag
for git config to validate the path as it is being configured:

 git config --local include.path '../.gitconfig' --validate-path

so that on shells that deal with quoting differently, than what git
expects, this git command will fail saying:

error: can't find file:.git/'../.gitconfig'

or at the very least give a warning if we don't want it be fatal. Though
I see no problem with it being fatal if a user uses a special flag.

I made this second suggestion since it will help users to detect the
problem early on. Before they need to search for another debug solution
such as the first one suggested in this email.

3) Finally, it'd be useful to have GIT_TRACE=1 state that so and so
include path wasn't found and was ignored during various 'git whatever'
commands.

I am open to any or all of these solutions, or alternative suggestions
of course.

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
