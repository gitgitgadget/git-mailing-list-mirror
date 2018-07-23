Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3E01F597
	for <e@80x24.org>; Mon, 23 Jul 2018 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbeGWTAU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:00:20 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41920 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWTAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:00:20 -0400
Received: by mail-yw0-f196.google.com with SMTP id q129-v6so545615ywg.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sguquI4Nj1TCZuACwiiOccd/cEPap+HILj279YUGx7s=;
        b=shxTGgBsl9nVbSEICg/z6G/JGB+avMq0r18dGq43Jt0kv87mZRoSglkxr679yxKQ0g
         0m9BQcH1ybkzVaXxtteaGvmXxJJP1umOzTchzyLNnQBPWCGuP1cG5qjXhOE3dkGzuz8n
         d2hpye/q7wihbsZ31Y1VWdo/F7qCWvAE3zuWAhDBiSyvx0pwdGlUk8qpIWsB725DEUZI
         AhM3k143EOUCB7cSL51Kmaac4lQ27Iss1fkz412SKK6LyAPJuoCAnKIPLn/y7QwxkXT2
         5xv0nxhEYEsyZj2cU/24sZ8nMbYMY8ahgMk0h9aR+lzxt9fDJiMWEkAWwmxn5ciiBqHb
         FOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sguquI4Nj1TCZuACwiiOccd/cEPap+HILj279YUGx7s=;
        b=C1q834VfLihYYIps6niB+toyHo0lrh1+lEYeAmaCAAXRPUUrEDI8WMwAnX14PzWyHe
         XWjQBKdvIAxeIqR80GPu+GoE9XKCZwolhJJjacUoyAe2HOPiD6a52ZqfmU8bwJKOLJYd
         7KkMVeFMoGd8jzkklIYW4v7ysnlBHSXVS/qIYDleY4HfcI09yMrE7kgcZF0uFOokECsZ
         OaHVKNfT43rXNBEPI/1qUashU/+ORktyH2s0Dc3umxBcwMRh4Uqiwa4Qexqa/j471RGS
         l+QIIPo65JxZsYcX4ehlSPgHBnOEaSUqT42Bz9fH/foLl4Ab8hz53j4d5e39sjRczgJi
         wq1w==
X-Gm-Message-State: AOUpUlEx4nCG8OzquEASSDq3/zCdIyJ0geh8lRext2suBDSbfTh/fKKw
        Z0uTawGN0GPnTVt41/SXfhV7hue0gKVp7ZC78+3Nag==
X-Google-Smtp-Source: AAOMgpdrXLMcULuKjfT6Be7A4j76z3bIXMDMlue59wKjbs33BIJUfOOh3j3HRIWKbs0IHiESayeukVkNUdSg9RVwyvs=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr7241406ywd.500.1532368677122;
 Mon, 23 Jul 2018 10:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net> <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
In-Reply-To: <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 10:57:46 -0700
Message-ID: <CAGZ79kYT0S6H1mTqUAhgq5CKx3Gd5FfY3MALcOSbq48OVsY6dw@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     demerphq <demerphq@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 5:41 AM demerphq <demerphq@gmail.com> wrote:
>
> On Sun, 22 Jul 2018 at 01:59, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I will admit that I don't love making this decision by myself, because
> > right now, whatever I pick, somebody is going to be unhappy.  I want to
> > state, unambiguously, that I'm trying to make a decision that is in the
> > interests of the Git Project, the community, and our users.
> >
> > I'm happy to wait a few more days to see if a consensus develops; if so,
> > I'll follow it.  If we haven't come to one by, say, Wednesday, I'll make
> > a decision and write my patches accordingly.  The community is free, as
> > always, to reject my patches if taking them is not in the interest of
> > the project.
>
> Hi Brian.
>
> I do not envy you this decision.
>
> Personally I would aim towards pushing this decision out to the git
> user base and facilitating things so we can choose whatever hash
> function (and config) we wish, including ones not invented yet.

By Git user base you actually mean millions of people?
(And they'll have different opinions and needs)

One of the goals of the hash transition is to pick a hash function
such that git repositories are compatible.
If users were to pick their own hashes, we would need to not just give
a SHA-1 -> <newhash> transition plan, but we'd have to make sure the
full matrix of possible hashes is interchangeable as we have no idea
of what the user would think of "safer". For example one server operator
might decide to settle on SHA2 and another would settle on blake2,
whereas a user that uses both servers as remotes settles with k12.

Then there would be a whole lot of conversion going on (you cannot talk
natively to a remote with a different hash; checking pgp signatures is
also harder as you have an abstraction layer in between).

I would rather just have the discussion now and then provide only one
conversion tool which might be easy to adapt, but after the majority
converted, it is rather left to bitrot instead of needing to support ongoing
conversions.

On the other hand, even if we'd provide a "different hashes are fine"
solution, I would think the network effect would make sure that eventually
most people end up with one hash.

One example of using different hashes successfully are transports,
like TLS, SSH. The difference there is that it is a point-to-point communication
whereas a git repository needs to be read by many parties involved; also
a communication over TLS/SSH is ephemeral unlike objects in Git.

> Failing that I would aim towards a hashing strategy which has the most
> flexibility. Keccak for instance has the interesting property that its
> security level is tunable, and that it can produce aribitrarily long
> hashes.  Leaving aside other concerns raised elsewhere in this thread,
> these two features alone seem to make it a superior choice for an
> initial implementation. You can find bugs by selecting unusual hash
> sizes, including very long ones, and you can provide ways to tune the
> function to peoples security and speed preferences.  Someone really
> paranoid can specify an unusually large round count and a very long
> hash.

I do not object to this in theory, but I would rather not want to burden
the need to write code for this on the community.

> I am not a cryptographer.

Same here. My personal preference would be blake2b
as that is the fastest IIRC.

Re-reading brians initial mail, I think we should settle on
SHA-256, as that is a conservative choice for security and
the winner in HW accelerated setups, and not to shabby in
a software implementation; it is also widely available.

Stefan
