Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910632023D
	for <e@80x24.org>; Fri,  4 May 2018 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeEDImO (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 04:42:14 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38564 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbeEDImN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 04:42:13 -0400
Received: by mail-wm0-f49.google.com with SMTP id m198-v6so2523221wmg.3
        for <git@vger.kernel.org>; Fri, 04 May 2018 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4DZxEUpzsqCb+gJ4XRzFvJKQntCkamdf7jqnxXQ5e+k=;
        b=jWqbmpTYELUr7FT/dS/O9XG662ohbKku6r9/APGIACIRYTAPYWPCQySNnu5DdE0uB3
         K3nhZTqI7NcHSTh80dzCHphSS96K9YeK3mJcYgxVTLp8244pLnQrkOazPWXprVZlgQEU
         8+JndlyhrPnC6Gp022aXBUfvD+eXdwRB1CtssGrpeG8wO5O2I/4zoS53m52Iuo2exIZE
         IfJPiUGqfhS71jzm5jZ/hbAz0rMrvfdGcZJX1TSATcMqVIV9OZChmEUwINj5nwYwKWvA
         eHaL1ewJLz3kJGbZFjPtkIbiV9dwb1P2GOlbVnHdd7BByu9lzKOIhmF7LSJlx25Iqryo
         NycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4DZxEUpzsqCb+gJ4XRzFvJKQntCkamdf7jqnxXQ5e+k=;
        b=mIuZ5veZGyuy2V09oNdBHja8n+G2mj5s1Ec/FjrNTdkcZux3m+77eTQ2gwOiGMqOlW
         PXMSspdFakaBTONygGJn/pS+cOgLizENF9qHedqQ1046UNX3tJU/skiPMWe+QiR4R6V3
         fESi2dBVNgLg4DPiB7q51Udo3zhUxkUJsZ819P1K9KoDKnUEDcWEU+x54tf7/ubuzun/
         Xk+WgWh83FCOUMsEIPG5wZqaGY0kqPl9FdFhKcClGAPbnQIHcQ2OfMeOYbPwWYnbCGt/
         osK5cptcyzF8ZcMHzCbXC19ZyCoIxLcbcVLhQufnpM0qbbfd1YLP5T6Is81Q0HmrkWyy
         2EWw==
X-Gm-Message-State: ALQs6tD/rWlB9j4/8uyPm5iymsW+uX169Lj+jR7bGKErcJmasAQyvPqD
        I2Y1I5Aj2fYrMSPNqKUu6Ao=
X-Google-Smtp-Source: AB8JxZqNe+jeq7BFmcQkhSoIg3Iljxgqu470AHueHRsMQEHny2KYCm6VNqzX2ylDzI9r8BCmoz1UxA==
X-Received: by 2002:a50:8fa5:: with SMTP id y34-v6mr35335536edy.290.1525423331717;
        Fri, 04 May 2018 01:42:11 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id p1-v6sm8934615edm.0.2018.05.04.01.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 01:42:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
        <87wowlxko8.fsf@evledraar.gmail.com>
        <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 04 May 2018 10:42:09 +0200
Message-ID: <87lgczyfq6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 04 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> The reason I'm doing this is because I found it confusing that I can't
>> do:
>>
>>     for t in tag commit tree blob; do ./git --exec-path=$PWD rev-parse 7452^{$t}; done
>>
>> And get, respectively, only the SHAs that match the respective type, but
>> currently (with released git) you can do:
>>
>>     for t in tag commit committish treeish tree blob; do git -c core.disambiguate=$t rev-parse 7452; done
>
> Exactly.  The former asks "I (think I) know 7452 can be used to name
> an object of type $t, with peeling if necessary--give me the underlying
> object of type $t".

Right, and I'm with you so far, this makes sense to me for all existing
uses of the peel syntax, otherwise v2.17.0^{tree} wouldn't be the same
as rev-parse v2.17.0^{tree}^{tree}...

> In short, the fact that you can write "$X^{$t}"
> says that $X is a $t-ish (otherwise $X cannot be used as a stand-in
> for an object of type $t) and that you fully expect that $X can merely
> be of type $t-ish and not exactly $t (otherwise you wouldn't be
> making sure to coerce $X into $t with ^{$t} notation).
>
> In *THAT* context, disambiguation help that lists objects whose name
> begins with "7452" you gave, hoping that it is a unique enough
> prefix when it wasn't in reality, *MUST* give $t-ish; restricting it
> to $t makes the help mostly useless.
>
>> 1) Am I missing some subtlety or am I correct that there was no way to
>> get git to return more than one SHA-1 for ^{commit} or ^{tree} before
>> this disambiguation feature was added?
>
> There is no such feature either before or after the disambiguation
> help.  I am not saying there shouldn't exist such a feature.  I am
> saying that breaking the existing feature and making it useless is
> not the way to add such a feature.

I still don't get how what you're proposing is going to be consistent,
but let's fully enumerate the output of 7452 with my patch to take that
case-by-case[1]:

    ^{tag}:
    7452b4b5786778d5d87f5c90a94fab8936502e20
    ^{commit}:
    hint:   74521eee4c commit 2007-12-01 - git-gui: install-sh from automake does not like -m755
    hint:   745224e04a commit 2014-06-18 - refs.c: SSE2 optimizations for check_refname_component
    ^{tree}:
    hint:   7452336aa3 tree
    hint:   74524f384d tree
    hint:   7452813bcd tree
    hint:   7452b1a701 tree
    hint:   7452b73c42 tree
    hint:   7452ca1557 tree
    ^{blob}:
    hint:   7452001351 blob
    hint:   745254665d blob
    hint:   7452a572c1 blob
    hint:   7452b9fd21 blob
    hint:   7452db13c8 blob
    hint:   7452fce0da blob

And[2]:

    core.disambiguate=tag:
    [same as ^{tag]
    core.disambiguate=commit:
    [same as ^{commit}]
    core.disambiguate=committish:
    hint:   7452b4b578 tag v2.1.0
    hint:   74521eee4c commit 2007-12-01 - git-gui: install-sh from automake does not like -m755
    hint:   745224e04a commit 2014-06-18 - refs.c: SSE2 optimizations for check_refname_component
    core.disambiguate=tree:
    [same as ^{tree}]
    core.disambiguate=treeish (same as $sha1:)
    hint:   7452b4b578 tag v2.1.0
    hint:   74521eee4c commit 2007-12-01 - git-gui: install-sh from automake does not like -m755
    hint:   745224e04a commit 2014-06-18 - refs.c: SSE2 optimizations for check_refname_component
    hint:   7452336aa3 tree
    hint:   74524f384d tree
    hint:   7452813bcd tree
    hint:   7452b1a701 tree
    hint:   7452b73c42 tree
    hint:   7452ca1557 tree
    core.disambiguate=blob:
    [same as ^{blob}]

So from my understanding of what you're saying you'd like to list tag,
commits and trees given $sha1^{tree}, because they're all types that can
be used to reach a tree.

I don't think that's very useful, yes it would "break" existing
disambiguations, but this is such an obscure (and purely manual)
use-case than I think that's fine.

Because I think to the extent anyone's going to use this it's because
they know they have e.g. a short blob, commit etc. SHA-1 they're not
going to use it because they have some short $SHA they know is a tree,
and then want all SHA-1s of that *and* random tag & commit objects that
happen to have the same object prefix just because tags and commits can
also point to trees.

How does that make any sense? The entire reason for using the normal
peel syntax is because you e.g. have v2.17.0 and want to get to the
^{tree} or the ^{commit} tht v2.17.0 directly points to. That's entirely
orthogonal to what the disambiguation is doing. There with your proposed
semantics you're peeling 7452 as 7452^{tree} because (IMO) you're
looking for trees, just to get some entirely unrelated commits and tags.

But *leaving that aside*, i.e. I don't see why the use-case would make
sense. What I *don't* get is why, if you think that, you only want to
apply that rule to ^{tree}. I.e. wouldn't it then be consistent to say:

    # a)
    ^{tag}    = tag
    ^{commit} = tag, commit
    ^{tree}   = tag, commit, tree
    ^{blob}   = tag, blob (blobish)

Whereas my patch now does:

    # b)
    ^{tag}    = tag
    ^{commit} = commit
    ^{tree}   = tree
    ^{blob}   = blob

But from what you seem to be proposing (or maybe you just didn't have a
chance to critique the ^{blob} and ^{commit} patches):

    # c)
    ^{tag}    = tag
    ^{commit} = commit
    ^{tree}   = tag, tree, commit
    ^{blob}   = blob

1. for type in tag commit tree blob; do echo "^{$type}:" && ./git --exec-path=$PWD rev-parse 7452^{$type} 2>&1|grep -E -e ^hint -e '^[0-9a-f]{40}$' |grep -v are:; done
2. for cfg in tag commit committish tree treeish blob; do echo "core.disambiguate=$cfg:" && ./git --exec-path=$PWD -c core.disambiguate=$cfg rev-parse 7452 2>&1|grep -E -e ^hint -e '^[0-9a-f]{40}$' |grep -v are:; done
