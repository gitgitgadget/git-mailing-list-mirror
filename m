Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321881F404
	for <e@80x24.org>; Sun,  9 Sep 2018 03:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeIIIjv (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 04:39:51 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:40362 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbeIIIjv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Sep 2018 04:39:51 -0400
X-Greylist: delayed 2409 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Sep 2018 04:39:50 EDT
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 0C9F0202ABA0F
        for <git@vger.kernel.org>; Sat,  8 Sep 2018 20:51:10 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id ypobfUzuCak7typobfBXA0; Sat, 08 Sep 2018 20:51:10 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8cCJPTEHGfaxoo8nbwAiw8VH9fnyyR5EaTAXZQhIJDs=; b=NVgQSCPOvlmMoZhdQVUxyqz+Wn
        Qoed/9xAi+aO1DVeke2m7by5bYepSEOwKw8Ws8V8jBmRcmeKbGK+uGcq2TdGqI9pdM9+5A3+ZmzkW
        AE24iOCXb3ye2c2bZCSq4L3+R;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:54852 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fypob-003ZGY-7Q; Sat, 08 Sep 2018 20:51:09 -0600
Message-ID: <d9330ba54fbda54a92a9f4d9320836d88ce9a6e6.camel@mad-scientist.net>
Subject: Re: git silently ignores include directive with single quotes
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Stas Bekman <stas@stason.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Date:   Sat, 08 Sep 2018 22:51:08 -0400
In-Reply-To: <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
         <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
         <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
         <87a7orrc3w.fsf@evledraar.gmail.com>
         <acf93aef-f1f8-1aab-a16d-9655402d445f@stason.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1fypob-003ZGY-7Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:54852
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2018-09-08 at 13:13 -0700, Stas Bekman wrote:
> I remind that the original problem came from a simple command:
> 
>  git config --local include.path '../.gitconfig'
> 
> Which on linux removed the quotes and all was fine, and on windows
> the same command kept the quotes and the user was tearing his hair
> out trying to understand why the custom config was ignored.

I'm quite sure that the user was not using the Git Bash shell when they
entered this command, but instead using command.com or powershell or
some variant of that.

If you use Git Bash as your shell then quotes will be handled like any
POSIX shell and the above will do what (we all) expect.

If you use command.com and powershell and use single quotes, then the
single quotes will be put into the config file as you observed, because
those shells don't deal with single quotes.

You could use double-quotes, which ARE handled by command.com and
powershell; in that case they would be stripped out and would not
appear in the config.


If we were designing from scratch maybe using something like GNU make's
"include" vs "sinclude" (silent include--this is another name for the
already mentioned "-include") would work; maybe "path" and "spath" or
something.  But to make it work right you really want the default
behavior to be "warn if the file is not found" and have the special
behavior be "quiet if the file is not found" otherwise it doesn't
really help beginners to avoid errors.  And that's a backward-
compatibility problem.  To my mind, adding extra "check this" options
isn't very useful either: these kinds of warnings need to be on by
default to be effective.  The beginners, who need them, aren't going to
remember to add extra options to enable more checking.

What I personally think would be more useful would be some sort of
"verbose parsing" option to git config, that would parse the
configuration just as a normal Git command would and show diagnostic
output as the entire config is parsed: for each action line the config
file name and line number, and the operation performed (and any message
about it) would be printed.  This could be useful in a variety of
situations, for instance to discover conflicts between local, global,
and system configuration, easily see where settings are coming from,
etc.

And as part of this output, when an include file was not present or we
didn't have permissions or whatever, an appropriate error message would
be generated.
