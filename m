Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308D21F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeBLVhT (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:37:19 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51715 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVhS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:37:18 -0500
Received: by mail-wm0-f48.google.com with SMTP id r71so12250039wmd.1;
        Mon, 12 Feb 2018 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fBoaAseK96R2il/Iay5CDvvHCfJL7RRVebQPkFsBaQw=;
        b=apf9Qn8OJGM77F9zL1QfPq0N/K/gBB1+tDwvsAqbRJuJftqUlW4X2o5bpWBsWZNDDS
         4e7xRxWRg1hG8iTmyAyKeY67WN0fQqfrRlCqsh62fzPlVJt6vkYPUkM9G0Ua5sRpdkUO
         xwZazSLsCRBCp8B+4pe5l4b3p6l+Qx/eRGbQLDLF49KIu5bEuzCwMcBAGW43gDJeGRrq
         8Tl3ENblGTlmiLxfxEeX9qk8IbJkUMT4GjQNRE6GApehW28tlyniCQgKFtagjQ2RTkeW
         uVy5QDZzwmyFpnd6Z5Vi0L4vBthmHyV1oGdGJIcX39ucWtKeebS41JD8rUR37nFY0pIX
         YD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fBoaAseK96R2il/Iay5CDvvHCfJL7RRVebQPkFsBaQw=;
        b=leVgPF+ACnFRummb5uXDqlNcbDYoHagIRe7yqK4s9y33ZQPHq8Q5g8RXjPCExRndHe
         6+qMEgk446RtRuKtCNYeNLqfIckBVy2m7Vt4uXAh9dLYH28EW46buXlgehGogr5VepA/
         Z9IqD9Fau0EQNIYHsE6vRJ3LXZTtgPSK3PYUhgAeIquatmItdZffGuOPFLehoSbdyMQI
         x2cyHMT0KQJKhvNZM/d273S9xwzZ1x1uWdoQa6mQVwHUY9IIFjhGqk8UCimCe/nCDbc7
         RctcfB7mTXlRDV2odheENqd12ENDVwc6ybg1rowrBn/u4KV1F57Gh2ttQDlbiQySN0El
         D+PQ==
X-Gm-Message-State: APf1xPCfY39MhBiwDMRNHrveokZJ080NAQkMYT4+dUVOA+by7RLtkvht
        hnxJwtjh8bdY51BBgBq8TGM=
X-Google-Smtp-Source: AH8x224bS5YjWj1HZWga/we3cQrdHp7f4RQiX9vFjDbTDr2kfFfxWQ390IMZ9KRyrS8SY4ZJWsanmg==
X-Received: by 10.28.5.145 with SMTP id 139mr4291022wmf.89.1518471436070;
        Mon, 12 Feb 2018 13:37:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y11sm8163514wrh.30.2018.02.12.13.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 13:37:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
Date:   Mon, 12 Feb 2018 13:37:14 -0800
In-Reply-To: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 12 Feb 2018 13:15:04 -0800")
Message-ID: <xmqqk1vhsxdh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Feb 12, 2018 at 1:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> The problem, of course, is that since git is distributed, git doesn't
> know who is "upstream" and who is "downstream", so there's no
> _technical_ difference between merging a development tree, and a
> development tree doing a back-merge of the upstream tree.
>
> Maybe it was a mistake to make signed tag merges non-fast-forward,
> since they cause these kinds of issues with people who use "pull" to
> update their otherwise unmodified trees.
>
> I can always teach myself to just use --no-ff, since I end up doing
> things like verifying at the signatures anyway.
>
> Junio, comments?

I have a slight suspicion that allowing 'pull' to fast-forward even
when merging a signed tag when it is pulling from a configured
default remote for the branch the user is on, and otherwise keeping
the current behaviour, would make majority of people from both camps
happier, but I also have a strong conviction that it is being too
clever and making it hard to explain to people to do such a dwim
that tries to guess which way is 'upstream'.

Another clue we _might_ be able to take advantage of is that when
upstream maintainers merge a signed tag, we do *not* fetch and store
the tag from downstream contributers in our local repository (it is
likely that we have --no-tags in remote.<name>.tagopt), but when
downstream contributers sync from us with "git pull", they do fetch
and store our tags in their local repository.

So "git pull $somewhere $tag" that defaults to "--ff" when the tag
gets stored somewhere in refs/ (or more explicitly, in refs/tags/)
and defaults to "--no-ff" otherwise (i.e. the tag is fetched only to
be recorded in the resulting merge, without ever stored in any of
our refs), might be a good balance.  

And it is easy to explain: "We realize that it was a mistake to
unconditionally default to --no-ff and we are reverting the default
to --ff, but with a twist.  When we tell 'pull' to grab a tag, if
we do not store it anywhere in our local ref space, that would mean
the tag is totally lost if the pull fast-forwards.  That is why we
still use --no-ff in such a case."


