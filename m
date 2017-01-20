Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008F020A17
	for <e@80x24.org>; Fri, 20 Jan 2017 01:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbdATBW3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 20:22:29 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33457 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbdATBW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 20:22:29 -0500
Received: by mail-io0-f172.google.com with SMTP id v96so52110770ioi.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 17:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h4MhdELcd726NmfsAlhyCu2qdQyWsXeRBTfQk4lMkPk=;
        b=jczbAm0haKLtCqhigD15BiEladCcQ6hnnmXMuD/Mc+XNn/8Bp1KH/HE4B5apeG4suv
         Sb7MehduXunDax4kVL5RKnubUnrIjYBLjsdHRYPk38G5S1b44AW2zoSSHgpwUeoSwzbS
         tQ+6M0/Oq3KJOqqsU2785dy7CXw7go7o3OXZYycXjj8vYYSDUqTh0MOdLI9AjF5G5pGB
         tghaft715sf8BBvYhmqYpij/OcYquZte4j6N+4mi7GNOY0qNGCSMGnrCfu2Pzwobe0Yl
         JbggahPE1qaGTIdt0dUn7R/oFR3pzaAZlgvGBTtGA3rg3IfOBGpMl6PJuTMyyxF+F1K4
         p7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h4MhdELcd726NmfsAlhyCu2qdQyWsXeRBTfQk4lMkPk=;
        b=awMlB9077f9ifVM6d9HLaZAGOwt2R4Ih+rlV1eeTpgZzVd29gDXL9iDu5b0PrpETNU
         meLc4yBOiVw+hSzqCS/rIG+AaAnVtqfTphMUP/v4SyrJAzoUKZhdjVopiTKvXeUDnatU
         eaukywLyU/UAjHCP/r4ztkLO6zMxKz6gtd0RB+XphD6Ayk5/tgTNnGwnh3/rJMw5BO1n
         P4g6ajazh5JJooPvKrWkh1hF/A3A5Pxh36hqzAtuJVVQEIkL1az8epepJtV/bQfVX11z
         7d7qzsZmSbIZXP15wsciAi6VFIb22nCogYbpRmJvAvRb+VbHogQVROs0K6OX18OQnVKW
         myBg==
X-Gm-Message-State: AIkVDXJr+TskVFE94uyjcigKjEcb58s9dxhfE/BUICvdmcmWBCcID/yIyISSpuFCogWAtazzcc+yZCL9NAJMJnlP
X-Received: by 10.107.3.160 with SMTP id e32mr11199380ioi.52.1484875333230;
 Thu, 19 Jan 2017 17:22:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 19 Jan 2017 17:22:12 -0800 (PST)
In-Reply-To: <e6c5567a-2032-c598-97c8-08518f86b611@gmail.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
 <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com> <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
 <e6c5567a-2032-c598-97c8-08518f86b611@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jan 2017 17:22:12 -0800
Message-ID: <CAGZ79kaS7zt3DKrRuqzzODc1HHEP-xd-8HBC0JA-HvmqAJOZfw@mail.gmail.com>
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     "Brian J. Davis" <bitminer@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Between the init and the update step you can modify the URLs.
>> These commands are just a repetition from the first email, but the
>> git commands can be viewed as moving from one state to another
>> for submodules; submodules itself can be seen as a state machine
>> according to that proposed documentation. Maybe such a state machine
>> makes it easier to understand for some people.
>
>
> "Between the init and the update step you can modify the URLs."  Yes I can
> and have to... wish it was not this way.

So how would yo u rather want to do it?
look at the .gitmodules file beforehand and then run a "submodule update" ?
Or a thing like

    git -c url.https://internal.insteadOf git://github.com/ \
        -c submodule.record-rewritten-urls submodule update

(no need for init there as theoretically there is not
need for such an intermediate step)


>> [remote "origin"]
>>    url = https://github.com/..
>> [remote "inhouse"]
>>    url = https://inhouse.corp/..
>>
>> But where do we clone it from?
>> (Or do we just do a "git init" on that submodule and fetch
>> from both remotes? in which order?)
>
> origin by default and inhouse if specified. There is already a implied
> default (origin). The idea was not to do both but rather what is specified.
> Origin and inhouse are just names for remotes. If one wanted a
> "--all-remotes" could pull from everywhere in the Ether if feature was to be
> implemented.

How is origin implied to be the default?
Should there be an order (e.g. if you cannot find it at inhouse get it
from github,
if they are down, get it from kernel.org)
