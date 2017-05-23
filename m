Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77C42023D
	for <e@80x24.org>; Tue, 23 May 2017 03:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbdEWDWD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 23:22:03 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33564 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdEWDWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 23:22:02 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so100490086pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 20:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lyRJjR9ipkfbj3QDCGyOAFps0xqSZ7c8bAjU4P8AFTw=;
        b=O3XkqlbTzIOQxQNKr49iserXfQiUMmAGgy/+ENtNLeft7MRnQpeqc92MH9Z0JAPp8c
         fcnNybRVUjZuuYTyt0JyPWcBLA+EZbDBx5GRB35x5XFmcIuor36SLcTAOGUJSVhR1ezn
         GggIm4vZPpmeKWN8TUZaGi1aa9/yQQmebScZnpoCMvnS0jqsUSJUvNrx75yEb2lXdZkf
         uKS1KkHaMpgoMKey1zK7OcLigAlSH1BecLcvl9gaExJVhfohcjRwsQgjXk8ECVfBIU6f
         A3y6gvSlhqZTnwGAcgg4EM4W7bkGFfazUPhDuaN5NFPmg2TlKvI9f9jXawE+BJk3mvhJ
         T2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lyRJjR9ipkfbj3QDCGyOAFps0xqSZ7c8bAjU4P8AFTw=;
        b=AyOJdbvF7onjc5nvDcDCnhrYx/sdPUiXWMIW4RPsCcb8vpQ8I6UTv7vxEmbvXeltBt
         7H9avEDZbz9KEpQdI2MOflH/pi7qfsj89dWwbLL7utFGZCuVCHwlqVCM+Rzv5hyZQzt/
         dbbQa0cHqLmHqBil3AOD3pCnkFSdwfKvW/Dh4+3evi2kDdbueAkoDag3V750d2Vr/aj+
         h+dm2JrN/ZAfJm11MOucE0BwMfEtq7/aVwJ/d4mz7/eeMwkd1hfyffODj/RcX18QvLU3
         QvRU9KpA7uBPxw0K9MokulP++21a/7ncMFVLalDPd9TS+LQh/ikMo3J18+aelrfl3wZG
         1I/Q==
X-Gm-Message-State: AODbwcAZYttSPsW/UyzqdIqABDXnVzeXfgAK7GbDpRAmY4oU5CUFi9AH
        bCbptbaEDWnDBpV/iBw=
X-Received: by 10.99.96.70 with SMTP id u67mr29996669pgb.101.1495509721526;
        Mon, 22 May 2017 20:22:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id b129sm14773407pfg.102.2017.05.22.20.22.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 20:22:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
        <20170520115429.12289-1-avarab@gmail.com>
        <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb9Ca6QtyRzOW-1Q-E+7Z+PB7+MBtj4KvZx-mV36opWpA@mail.gmail.com>
Date:   Tue, 23 May 2017 12:22:00 +0900
In-Reply-To: <CAGZ79kb9Ca6QtyRzOW-1Q-E+7Z+PB7+MBtj4KvZx-mV36opWpA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 22 May 2017 15:48:45 -0700")
Message-ID: <xmqqtw4cmf53.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, May 22, 2017 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> I liked the suggestion to make the URL a relative path, but this would
>>> require you to maintain a mirror in the same places you push git.git
>>> to, is that something you'd be willing to do?
>>
>> After thinking about this a bit more, I know what I think we want a
>> bit better.
>>
>> Relative URL (e.g. ../sha1collisiondetection that sits next to the
>> copy of git.git) may be a good way to go.  I can arrange to create
>> necessary repository next to git.git on k.org and github.com but I
>> need to double check about other places
>
> And here we see another deficit with a single URL:
> We have to abide by the same scheme at all hosting endpoints.

FWIW, I do not see it a deficit.  It is a price you may or may not
be willing to pay for simplicity, and I think it is a reasonable
trade-off.

The .gitmodules format can be enhanced to list multiple URLs quite
easily.  I think the current users all use the equivalent of "git
config -f .gitmodules submodule.foo.url" to grab one value.  Unless
the user chooses to do anything special, they will continue to get
the same behaviour whensuch an enhancement happens, which is a good
thing.

But then, you need to design what users choose to do that is
"something special".  Should "git clone --recurse-submodules" have a
way to control which one of the not-yet-known-before-cloning URLs
that may be listed in .gitmodules?  Will we have a way to say "For
North American users, we recommend this URL, while Asians may want
to fetch from this other URL" in .gitmodules and then the recursive
clone have a way to say "I want the European option"?  Would the
recursive clone have a way to go interactive?

And from that point of view, "you'll find the submodules relative to
the superproject" convention is one way (not necessarily the only
way) to allow users not to care too much.  The simplicity comes with
price and that is perfectly acceptable.

Also a single URL scheme may still perfectly fine.  .gitmodules may
have new submodule.<name>.alternateURL fields and recursive clone
can be told to optionally go interactive when such fields are
present.

Or README can list alternate URLs and instruct the users to use the
insteadOf if they want to go to mirrors instead.  Those users who do
care about picking particular mirror are likely not favor simplicity
over flexibility, so they would not likely to do a recursive clone
(after all, clone is a single-time operation) and it may be
sufficient if they can clone the top-level, read README and then
decide how and from where they get their submodules.
