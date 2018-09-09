Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F48E1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 02:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeIIHpj (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 03:45:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50433 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbeIIHpj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Sep 2018 03:45:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BE8321AB4;
        Sat,  8 Sep 2018 22:57:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 22:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=k4uw7AsEPVrRuQZyBoqM6SZ7lBgEd
        QXNTVnJJ6dDca8=; b=Vs1XerfQvYR5WqymS2D03PGDaEh0N2VfcvC3KYfe3jWzy
        wsQ+F4FMSBWmbftGBJHpNr25+BYRNVeGtg81RdB8yG1G+HHDrI+i8585WW/GMDqr
        7l2fW0dMXu0m9/89QZ9jnIAXK9ZuQIE+8xJOZ+q/5hxNIB3GfkVTeO4+Q0zky4Lu
        Wkp6R+3ozHQTbo0r/5EECQ3wYqhGADQpxmhSdB4Sg6Z3UhLGGtuMokE5Gsl4UHhl
        ZqYN6EWGHnkqSzxF10BdoJBBKEZNnd+PMnDwfEkanSrOS0bIMJC5CU7djuzITsg0
        MaL6ZeDzgJGazuxRTdYfBs2QU9hb8mbNsvMQeRqXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k4uw7A
        sEPVrRuQZyBoqM6SZ7lBgEdQXNTVnJJ6dDca8=; b=eDEfEQh+W0Rafdgwtb+sBy
        UYQr+hIeyeNN2M2q4xwM/ukSp3w/f9IQjuBQ0fVT2f63eRdheFd8aRMFdtyjDU7I
        +HoRaL28oehP66mdguVQQeDSIkzlhYNzvOqnlnN2wsr1oQGI1A/sEZBft+Ef/x3t
        FE2NwKSVgjnUvGlwNhL8Xf8BG0JnuP35wtmSGxqBwqEBQQl11mrou0RYhoCmRzqu
        qe2nTEXNcfe7etl76rqIvbihOkBhQTFj0mxOy0UmRG7VH57duqraW14cuzWX+fjB
        n1PLXGxomL4YZXByPC+IqSTVE+mu7+ZUyEaWN8CbBRHmsTF+RRlLlJ4aUOuRZdNg
        ==
X-ME-Proxy: <xmx:I4yUW0awXhv2d0me7SK-jb5foLnqljscF20K6oAPREoig-6q_7SGbg>
    <xmx:I4yUW60_zjz-70-svzNNZ5hzngmVyCwxvdm4KKb8Ep-H6D7GIOm5Bg>
    <xmx:I4yUWyeebXLfnjHKDc0WK0DwlERPSht3Tf0HmzT2uuTF6PjI2Pl-nw>
    <xmx:I4yUWzFH5O3HRK5uogOtfqwo7Uxatm-Dure-EnXjo050V3NQSjjDNQ>
    <xmx:I4yUW73oZiSe3ceVB2gn1_7rl2Z8rPAPtooxKtOVw60mUffEXjbCrQ>
    <xmx:JIyUW3iXyx2YW7-L3Ep4u7m-EMcBtFurGzYm4s00lm0UIyfFBHaM-w>
X-ME-Sender: <xms:I4yUW-X6b8-b0Hgksr2Xl1mS7fMPx32_xlEQ1i4iFtqRAt4JTlXOSg>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C72F10292;
        Sat,  8 Sep 2018 22:57:39 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     paul@mad-scientist.net,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
 <87a7orrc3w.fsf@evledraar.gmail.com>
 <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
 <d9330ba54fbda54a92a9f4d9320836d88ce9a6e6.camel@mad-scientist.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <066f8a3e-062f-b921-c15d-ce4dd7adf377@stason.org>
Date:   Sat, 8 Sep 2018 19:57:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d9330ba54fbda54a92a9f4d9320836d88ce9a6e6.camel@mad-scientist.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 07:51 PM, Paul Smith wrote:
[...]
> What I personally think would be more useful would be some sort of
> "verbose parsing" option to git config, that would parse the
> configuration just as a normal Git command would and show diagnostic
> output as the entire config is parsed: for each action line the config
> file name and line number, and the operation performed (and any message
> about it) would be printed.  This could be useful in a variety of
> situations, for instance to discover conflicts between local, global,
> and system configuration, easily see where settings are coming from,
> etc.
> 
> And as part of this output, when an include file was not present or we
> didn't have permissions or whatever, an appropriate error message would
> be generated.

I was thinking along the same lines, Paul - i.e. no need to change
anything in the config syntax, but to provide better diagnostics.

I quote below what I suggested in an earlier email, but I like Paul's
idea even better as it'd be useful to many situations and not just the
one that started this thread.

> 1) I suggest this is done via:
>
>   git config --list --show-origin
>
> where the new addition would be to also show configuration parts that
> are not active and indicating why it is so.
>
> So for example currently I get on a valid configuration setup and having
> git/../.gitconfig in place the following output:
>
> [...]
> file:/home/stas/.gitconfig      mergetool.prompt=false
> [...]
> file:.git/config        include.path=../.gitconfig
> [...]
> file:.git/../.gitconfig
> filter.fastai-nbstripout-code.clean=tools/fastai-nbstripout
> [...]
>
> Now, if include.path=../.gitconfig is there and file:.git/../.gitconfig
> is not found, it will indicate that in some way that stands out for the
> user. Perhaps:
>
> [...]
> file:/home/stas/.gitconfig      mergetool.prompt=false
> [...]
> file:.git/config        include.path=../.gitconfig
> [...]
> file:.git/../.gitconfig FILE NOT FOUND! Ignored configuration
> [...]
>
> So that would allow things to work as before, but now we have a way to
> debug user-side configuration. And of course hoping that the docs would
> indicate that method for debugging configuration problems.
>
> I hope this is a reasonable suggestion that doesn't require any
> modification on the users' part who rely on this silent ignoring
> "feature", yet lending to a configuration debug feature.



-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
