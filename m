Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24691F597
	for <e@80x24.org>; Thu, 19 Jul 2018 09:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeGSKM1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 06:12:27 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44143 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeGSKM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 06:12:27 -0400
Received: by mail-wr1-f49.google.com with SMTP id r16-v6so7329382wrt.11
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3HnvtfJBv2+sUY/To6iHQgKMgCQpN713kZuUT0Iqf2I=;
        b=HSsS7WE9ccLX+7GqpmmM+45Q6AGSgfC2ljBFbzovyUZLkcN6pVQvNEeAvNgsvo5B0y
         PEgt8EPMq92GBRfIRUBPvH6KPeA3UAaPAMbubu+OVuPmEvacy8igqnguZtY7AkpHC1WM
         c+QHK0uOSE5ydVbBoQgZDJUsdFx+sipYbzO+YXetSckmAnIQwa4azmhHoLcI/cdFd3us
         FI+Ugl3BP1IupZ9dePYo1ryCROqgM4NrCv96C+u2ynbnvVTPxKzFuBjQzbkR0nQ2MR1a
         D6vZXHa5ER6GXqIqXAzKeHO4uNZDGp5t0IobNSPxrIRi8OlrMpUhPNi2HJm6WuyiPu2D
         rVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3HnvtfJBv2+sUY/To6iHQgKMgCQpN713kZuUT0Iqf2I=;
        b=ixRCeHrYDCdmf/ps2kesHPErFqy4A7wtXAR8q4HQQ/G4H6HW3p6YzYIZFWoNN87cvE
         seVK1cdRtSOUZw0062ZOIGmAtYZ5ja3AbMqheBPB+mWQeRBRJ/X+wNUdWDsjJqsc0znG
         /N6sQ2zkYYHqKHbY4KTN1qmf/k+xLv5NHzDpsIqXeB+T8iBtGukXfnRq5JZUIR9bCIRH
         BK0KDwuN96IWkXALlldTUlp/F9+DHR13h9aQE2St310cmUGMg/X+qYftC5T24XCuccqm
         kG+vmq5uJu6mphq2SrHDe3HZbw/d5XRK5i21VIKibrYjfcQxc1jB5ggNWJc+pQk5ypOG
         LGsg==
X-Gm-Message-State: AOUpUlEm5oroK29rsHa8sRITpimImXpHaxR7PLfNC5eRnLZUQoOGzFim
        1uoVUw9MzdzGgQ4RkJmWGnc=
X-Google-Smtp-Source: AAOMgpd9FFyd5z8SrMl4pn25cSgheLnhv6POPQE0mVDNlVy6H88ThJjXxMkYNCfoYgNFcGha19/Adw==
X-Received: by 2002:adf:9c91:: with SMTP id d17-v6mr6692202wre.11.1531992609534;
        Thu, 19 Jul 2018 02:30:09 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id h7-v6sm4063363wrq.41.2018.07.19.02.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 02:30:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Timothy Rice <timothy.rice@unimelb.edu.au>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: Q: Ignore ./foo, but not script/foo
References: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de> <8736wfd579.fsf@evledraar.gmail.com> <20180719090656.GA18624@sleipnir>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180719090656.GA18624@sleipnir>
Date:   Thu, 19 Jul 2018 11:30:08 +0200
Message-ID: <871sbzd13z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 19 2018, Timothy Rice wrote:

>> How did you come up with this "./" syntax?
>
> It is a Unix thing: "./" or just "." refers to the current directory.
>
> When calling scripts or programs in the current directory from a Unix
> command line, it is required to refer to them as, say, "./foo" (not just
> "foo") -- unless "." is in your PATH.
>
> Most people do put "." in their PATH for convenience but it is considered a
> little unsafe [1].
>
> Personally, I am surprised that gitignore does not understand this
> notation. To me, OPs meaning was crystal clear: "./foo" should mean to only
> ignore the foo in the repository's root directory.
>
> [1] https://superuser.com/questions/156582/why-is-not-in-the-path-by-default

To clarify I was trying to fish for whether we'd accidentally documented
"./" somewhere since OP was making references to the docs.
