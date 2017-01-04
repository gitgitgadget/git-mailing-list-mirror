Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFA420756
	for <e@80x24.org>; Wed,  4 Jan 2017 23:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761774AbdADX2p (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 18:28:45 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36674 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761760AbdADX2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 18:28:44 -0500
Received: by mail-qk0-f170.google.com with SMTP id n21so416969114qka.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z9TUPIDXPEyy4qjnC+LDS1QsxVJGUgTAlDDMMMpiiIs=;
        b=lKN+gL2Gy7RU9yqNIwygmL626HCyW6tl8Mz77BSIIL0erE8LxkDPYDPcD22/bqcPfT
         O8bwR6EzWM36p92O5oAWHtqeEeriTe8uzd0d2U1XcGBYch30AO/A97kBOcPvXOIJFtjR
         /frq8qMGzx88O8TPbWAwi1IMrSaz6pGzAAdH5H0kk9NXiYEAhbYlwZFnQmgTZRcPKHmL
         7Uavvse3qvaS4B2zUeaZoCFVNNsQWc0Q3HzOicwyD0awvw6M0yKbWitJFhR9pNL+DKRh
         cuaOKcnboj/pbfMbmLYmZ6OBkk3nvDb6k4dMAtJgfCGK4zHmF8YIKJGRZFiRgfVR5VcF
         nNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z9TUPIDXPEyy4qjnC+LDS1QsxVJGUgTAlDDMMMpiiIs=;
        b=B3X3Yf1+geNH0qZBa5PziaccU/eEPPkoVTHGaGyqTBOJT2GyLoZv9Qt9JemVxak9N9
         SZ8C36+IWTh6Q0dZKClsp4V/ZspcekIF52BUSci6Th7l6iYXOEVmC3oTki8kI/JfGSI0
         z8ivwK+srxxKb2HVylKqAMECyjCuvJhla/NecEveopavwAaBnCRdpRiHXh9PQMcO1O00
         kuq4Oq+HMtKFLJ9Zc5MFjvmDZygxx3hDIJrV+DZT6Ben6n5fbKViyYDDyk3YsQOmaGfb
         1fBxkcZjWZDO7jodnDDO/uWjDorTfhTMEVPkwwT30E8RSi76yDhG70esOYLHhc1LSY9E
         FzRA==
X-Gm-Message-State: AIkVDXItl0Vy+iOEnvCDd554mDHb+fcKYzNBSFWRdDw7vdKN3co3xoznYlm9ovfXNCnAtLqbDNW+fpl1GUQOyLhg
X-Received: by 10.55.197.28 with SMTP id p28mr66807440qki.255.1483572523290;
 Wed, 04 Jan 2017 15:28:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 4 Jan 2017 15:28:42 -0800 (PST)
In-Reply-To: <20170104231605.GB68241@google.com>
References: <20170104205346.GE69227@google.com> <20170104231027.7065-1-sbeller@google.com>
 <20170104231605.GB68241@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Jan 2017 15:28:42 -0800
Message-ID: <CAGZ79kbo3uKD5Un_P+EPdO2mMt6WUVjWPqfYEbitzU0zw0ex3A@mail.gmail.com>
Subject: Re: [PATCHv5] pathspec: give better message for submodule related
 pathspec error
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I haven't taken a through look at this patch but I think you may want to
> base it off of 'origin/bw/pathspec-cleanup' series as the changes made in this
> patch now conflict with that series.

eh right, I forgot to mention this in the notes, it requires
sb/submodule-embed-gitdir as well, so I'll have to figure that out.

>
> Also I still don't really think this solves the problem of telling the
> user what is wrong, which is that the submodule's gitdir is gone.
>

The "git dir gone" is not a big deal IMHO as a deinitialized submodule
is perfectly fine (e.g. not initialized). The errors as I tested in Gerrit,
a superproject that contains submodules in plugins/* :

    : gerrit/plugins/cookbook-plugin$ git add .
    fatal: Pathspec '.' is in submodule 'plugins/cookbook-plugin'
    : gerrit/plugins/cookbook-plugin$ cd ..
    : gerrit/plugins$ git add cookbook-plugin/a
    fatal: Pathspec 'cookbook-plugin/a' is in submodule
'plugins/cookbook-plugin'
    : gerrit/plugins$ git add cookbook-plugin/.
    : gerrit/plugins$ git add cookbook-plugin/./.
    : gerrit/plugins$

I think that is perfect behavior for now, as it reliably detects
(a) the submodule being there and (b) if you are in there, no
matter if there is a .git dir or not.

The same error coming up if the submodule is initialized and valid, e.g.

    : gerrit/plugins$ git submodule update --init cookbook-plugin
    : gerrit/plugins$ git add cookbook-plugin/a/.
    fatal: Pathspec 'cookbook-plugin/a/.' is in submodule
'plugins/cookbook-plugin'

So I think this is pretty much exactly what we want for now:
* if PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE is set
   we keep the behavior as is and do the expensive thing
* if the caller wants to use path inside of a submodule no matter
  the git dir of the submodule, then set the CHEAP flag instead
* in case of the assert (that I originally wanted to fix), we fall back to the
  EXPENSIVE thing reporting the error message that we already reported
  in such cases.

TL;DR: I was rather asking about the code being a viable;
by now I am convinced this is the correct behavior. ;)
