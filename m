Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754691F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030456AbeCSUmG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:42:06 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34954 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030438AbeCSUl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:41:59 -0400
Received: by mail-wr0-f176.google.com with SMTP id n12so20018617wra.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eGIYpE6wg4ZrzyK6Mhp4Y4OhVKMkmb3yJj8u7AUR2Bc=;
        b=pYnmFi31FBqFOvOMIiG4fjURqTFLPbbidrG/ntui7y/I+RMiSkuaGIrTd2NGFn3xib
         zlEct/4hJqvdmEygKY0hv14AB7o4id+2kf81Br4jLyjxHBEN8562T7Ga55lWdHAeb2xm
         T2YLjkFToswaoa10aq97MHldXLFkH6y2YYpBPmbyEMXYSKlDiLdklCuHvK1SZrjx5n1d
         UbNKfSCG2jiuW8y0aVvQNYZnWNS6bCQuXGiKnOeg5JfN7yUaMiT4k++RWiURNlvjgWxI
         apHyEoK8gdLeD5efJRuaa2KEc9RkSwMcceYkyGkLRTu4S30LTmijiiHMGaF6svp4HC/d
         uc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eGIYpE6wg4ZrzyK6Mhp4Y4OhVKMkmb3yJj8u7AUR2Bc=;
        b=pb/EfUDfWGW42CdBANRMiNemXQVG/uGT1XIFGExQ+D4vbwGKZOK+LLqZ8aIKxpuaum
         6jdvcGVNVVvQYs8Bi9C4nXAjieJ77tT37dVR03ODP9c6js5i36MhJWE13SOiymP/4iol
         cVQfB9HyslHIVcq60bYSFzzpqhHLbHR8dtF2xePmnsmExiu7R1NtbftdCo/kjqXHY0Z6
         FosRXxvEYlkczPS4AUDuFmgWF+wS9otU9UEdug4p1uFf3U3Gbqd4aujZlhmESj3VQ6R7
         BVuRQLzGxCCcchlbP/5DQJq703nLfmHJkA8VH/41BkWK7TYfbaJu9Ag0bjE4O0t3qEKg
         DHGQ==
X-Gm-Message-State: AElRT7E1oXwO1C3dJVFeRdrOLCvMiHID9OdYD0dN6pdsXfqzSWJg6qjC
        qThB1cCX288FcTS944OE5p0=
X-Google-Smtp-Source: AG47ELudrFpW7td/kfIvN7zy95idVY8w1a9X3HMuhqwvrqjFUr9Bo104Gbe/2jsldXF421KvbvzQmw==
X-Received: by 10.223.177.213 with SMTP id r21mr4848757wra.89.1521492117724;
        Mon, 19 Mar 2018 13:41:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j12sm31145wmc.18.2018.03.19.13.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 13:41:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
References: <20180319025046.58052-1-dnj@google.com>
        <20180319025046.58052-3-dnj@google.com>
        <87zi33c22l.fsf@evledraar.gmail.com>
        <CAD1RUU_MpCeXfCF9NqvD-CvsWtsJShfMyg9HFAXrN-ULCE67FA@mail.gmail.com>
        <CAD1RUU-K1rFaOEVXE=XZ_gu4ktmaEBGr3wtJvGJd1fivNXa21A@mail.gmail.com>
Date:   Mon, 19 Mar 2018 13:41:56 -0700
In-Reply-To: <CAD1RUU-K1rFaOEVXE=XZ_gu4ktmaEBGr3wtJvGJd1fivNXa21A@mail.gmail.com>
        (Daniel Jacques's message of "Mon, 19 Mar 2018 19:17:14 +0000")
Message-ID: <xmqqpo3zu7aj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Jacques <dnj@google.com> writes:

>> > The merge conflict becomes a tad easier to deal with, also makes sense
>> > to have gitexecdir after infodir since that's the order we're listing
>> > these in just a few lines earlier, and this is otherwise (mostly)
>> > consistent.
>
> Actually as a quick follow-up question: for these patch sets, is it best
> for me to have them based off of "master", "next", or a different branch?

When you are cooperating with somebody else, e.g. in this case you
are planning your changes to work well with the ab/install-symlinks
topic, there are three choices, I think.

 (1) Build your topic on 'master'.  From time to time (and
     especially before sending it out to the list), do a trial merge
     of your topic to 'master', 'next' and 'pu' to see how badly it
     interacts with the other topic.  

     If the conflicts are not too bad, and if it makes sense for
     your topic to graduate without the other topic being in
     'master', then this is the preferrable approach.

 (2) Build your topic on top of the other's topic.  When the other
     branch gets updated (either by rerolling if it is not yet on
     'next', or by adding a follow up commit), you may need to
     rebase before sending an update.

     As long as you can live without new stuff added to 'master'
     since the other's topic forked from 'master', this is probably
     the second best option.  It definitely is worse than (1) as
     you'd need to rebase on top of other's work, which will become
     impossible once your topic hits 'next'.

 (3) Make a merge of the other's topic into 'master', and then build
     your topic on top of the result.  Keep the updates from the
     other's topic to the minimum once you start working on your
     topic to simplify the task to update your topic.  From time to
     time, do a trial merge to 'master', 'next' and 'pu' to ensure
     you are compatible with the updates made to the other's topic
     since you forked from them.

     As long as the other's topic is already fairly stable, and if
     you need to depend on new stuff added to 'master' since the
     other's topic forked from 'master', this is a workable
     approach.

I suspect that (1) is fine in this case.  As to the reordering of
gitexecdir_relative thing Ævar mentioned, I agree that such a change
is good because the order of the lines in the result makes more
sense.

Thanks.
