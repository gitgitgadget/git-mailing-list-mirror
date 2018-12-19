Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3983A1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 23:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeLSX3w (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 18:29:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36282 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLSX3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 18:29:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so10166269plo.3
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 15:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ju8fcfFJEuwQfmWyblNlx0R+Cc7V8Vu+b2VhMazBP2c=;
        b=CrEtjcUQTEOosU2rx4habIJDf24XkoxGWV3haKeywTV7tmRVMEq+B+UUn2dVytiUo9
         OookWKvIcclMQM1r+qe6qV02qm/szDaW2ASycI2tI4+CGfyy+JsQeCUaXzokx6PzJ3iK
         zABr4TpiB+66YG/r9TmU5Lc5vXdLkNGXBKBON0gy3yT/yfFJSw0hbNVZ6LW2bB+iDe/h
         YBN6PhIwmMelZj5kaCppKXYDAAT+f4TCFxZJUqIFNLIqQahK4mKuECicQ3khuH+sCfRs
         wkhP6NMKnxpB9c+x9vECpQyF6yHP2JR6UBf/eUigilAwozYwbSgMu+jbs8UjnSPuBN0M
         vjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ju8fcfFJEuwQfmWyblNlx0R+Cc7V8Vu+b2VhMazBP2c=;
        b=dbdANcCVcOPwSBf3dplU9zK68cFyeOKYOsjVSdEV/IykvI6dwd7ypUzI3iUdVh3fcF
         wOpQRpw4qu9BxEnzSTqqVFVxecnr/PQhSMxZsd74x61eMti6SQVGPFU/mhCv4kWP+B3u
         I37NTzqN9Lp3oUN+0+dac7rb0VXl7isIfe8CfZJv9NoSc9TjnFz0v6aWZ4zMh6trZFYL
         LuTwlf+I7NJsiKBSLwn+TH+vaqs2oYlOnxHfIo0qeqx+Cz7BRM9kAe6m9DpFRHETjcHc
         CXZW2r8ylKh6TwM5HtpRWwLIMyimmK9RYagKCVHSgAmDgbLOrOwH64DwBG+kIcOsJHEh
         02Lw==
X-Gm-Message-State: AA+aEWbjmXdILQpShYpghntJzblxwVmUdNsrKymhAM+XsDaZSKFdiWj1
        EqAulaTqyKRBEQqXGic7CNpshXbT
X-Google-Smtp-Source: AFSGD/VGnk+tqf5KSV21MKqjYZu13hZn2mRYbFxIYFWByJA9WCw8NL7xmHKYYBbmtYxRVXGotD7p7A==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr22151051plb.79.1545262190968;
        Wed, 19 Dec 2018 15:29:50 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id b202sm35214134pfb.88.2018.12.19.15.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 15:29:50 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:29:48 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181219232948.GD228469@google.com>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
 <20181219182216.GA17309@sigill.intra.peff.net>
 <20181219183927.GA228469@google.com>
 <20181219224810.GA20888@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219224810.GA20888@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Dec 19, 2018 at 10:39:27AM -0800, Jonathan Nieder wrote:

>> Is there some rule about how long the hex string has to be for this to
>> work?
>
> In both cases, it has to be 7 characters.

Thanks.

[...]
>> The issue with this is that it is ambiguous about what the tag name is
>> referring to: does that mean that "git describe" and "git version"
>> tell me that v2.11.0 is the nearest *previous* release to that commit
>> or that "git name-rev" tells me that v2.11.0 is a nearby *subsequent*
>> release that contains it?
>
> Sure, it's ambiguous if you've never seen it. But if it becomes a
> convention in the project, then I don't think that's an obstacle.

I'm speaking from experience: this is hard for newcomers to grasp.

> I'm also not sure it really matters all that much either way. If you buy
> my argument that this is just about placing the general era of the
> commit in the mind of the reader, then "just before v2.11" or "just
> after v2.11" are about the same.

If it's that unreliable, I'd rather just have the hash, to be honest.

Ideally the full 40 characters, since that would make git name-rev
--stdin work. :)

[...]
>> I think a more promising approach is the Fixes trailer Duy mentioned,
>> which has been working well for the Linux kernel project.  I'll follow
>> up in a reply to his message.
>
> I think that's a good idea if something is in fact being fixed. But
> there are many other reasons to refer to another commit in prose (or
> even outside of a commit message entirely).

Sure, but in those cases do we need the ability to query on them?

To me it seems similar to having a policy on how to reference people
in commit messages (e.g. "always include their email address"), so
that I can grep for a contributor to see how they were involved in a
patch.  If it's not structured data, then at some point I stop
worrying so much about machine parsability.

Thanks,
Jonathan
