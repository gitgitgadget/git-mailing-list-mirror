Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3557F1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeKAWML (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:12:11 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35556 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWML (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:12:11 -0400
Received: by mail-wr1-f49.google.com with SMTP id z16-v6so2135788wrv.2
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cD7es9e3kKS+QOxDdloHfIH8A6Xm2VSLGlDYtBHYkp8=;
        b=fyea2zIECNsht2d5PiAtGGWNkEDRMYKNYTlrpJ2OkRSi0HhI2mI7qx2TIn7ni0sv0R
         abpp5Gz9rAVNvTlHS4Dbo5y6olVYrCtmflXQoOI8AcHfQPGSyJpg2ObvEjQ6Nl3mcged
         N2m6wFEXxCnZSa3+4TTAAtdHd+K5O5fpB/PTUBLv+j3b9lf++jtOgBHw8txoHPN8PmZU
         ID2RhqRlhI21oCuyeHHewZZGxsfh5SBUDOXzAsbL/XsnjFiwL5g/iRlHpFOc924YR/oL
         jAQzH2gv948n3tijTCSD0a9h+iXLZyQ1qMpz05Nm+fejn6bjemvVpY4WMt6uM316cmC6
         eXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cD7es9e3kKS+QOxDdloHfIH8A6Xm2VSLGlDYtBHYkp8=;
        b=tZL0iMunYYcWA+uovcOdL+7M0crRCbT83n2Fix1FmXdY6eSNqt5CztYzDlVBaWDGFm
         f3qJzYNtRxzt2sLRqtofbsL3zio48ynH0OH6ukJyTBN1Ey89ZVp3p3zxs9bWMi8jdNax
         HUZPyVuAIaDD2nhg2qZwcAMkk5nofO2B6IbL8W4aExKvgSUBmeXidGuiMK3ke9XytcgX
         WgESA7C6hCY0Ew/H4mjOFE39MVQyTCrtvZwEPCrlj0N7hTMwI2dePQKivWVUSqH8XJSw
         r7+wSYnd4azla99hwLgq15eRqYPStgjksIVuSlNXKm7grK+7uD/xnX8OZ0nJ5a/DA/RY
         9jwg==
X-Gm-Message-State: AGRZ1gK6z3Q0nTyKKHRYBMxVpxetyXAbNJwzUDqlNoB6XROMdEHgJGGU
        xcJ4GOKLVrf26wm03AUMIhbtcg2H
X-Google-Smtp-Source: AJdET5cm1c3HGay4RFIe+JbskxoyyIFBk7eubIoc/IcAot1DBkOkNNlETxiG6YYU1aD9aKuanbQ8Ew==
X-Received: by 2002:adf:8b0a:: with SMTP id n10-v6mr6094818wra.282.1541077755142;
        Thu, 01 Nov 2018 06:09:15 -0700 (PDT)
Received: from evledraar ([2001:981:2f6f:1:6765:91b4:348a:a673])
        by smtp.gmail.com with ESMTPSA id q190-v6sm33954940wmg.40.2018.11.01.06.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 06:09:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nicolas Mailhot <nicolas.mailhot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Please add a standard ref object to releases
References: <b639c19a881476be2d4dbdd731cd305384b287a9.camel@laposte.net> <871s85kq16.fsf@evledraar.gmail.com> <c414f7ae84c763cacd55d14ba68fbf2572b65132.camel@laposte.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c414f7ae84c763cacd55d14ba68fbf2572b65132.camel@laposte.net>
Date:   Thu, 01 Nov 2018 14:09:13 +0100
Message-ID: <87y3adj66e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Nicolas Mailhot wrote:

> Le jeudi 01 novembre 2018 à 12:15 +0100, Ævar Arnfjörð Bjarmason a
> écrit :
>>
>> For both this and your other report, it would be helpful if you
>> describe
>> in concrete terms (with examples of git commands, or UI etc.) what git
>> commands do now, what's wrong with it, and some sketch of what you
>> expect an alternate interface to look like.
>>
>> As for this report: I know this area of git quite well, but I still
>> have no idea quite what you're asking for.
>
> It says a lot that you claim to know this area of git quite well, but
> have no understanding how it is (mis)used on github/gitlab/bitbucket/etc
> by people who actually try to use git.

Yeah I think it says a lot about how vague your proposal is.

You're the one trying to ostensibly file some sort of bug report or
feature request, it's up to you to explain the problem in detail.

> I’m just asking that when a project releases “x.y.z”
>
> 1. there was a standard git command available to it to create "the
> release “x.y.z”" ref

And would these also be annotated tags, or are you proposing that we add
a new "release" object type in addition to blob/tree/commit/tag? If so
what would that look like?

> 2. there was a git syntax to say "the release “x.y.z”" ref in all git
> commands that manipulate refs

What do you mean "git syntaX"? The rev-parse syntax (see 'git help
rev-parse`) or something else?

> 3. that this "release “x.y.z”" ref could be used in all the "download
> release “x.y.z”" on GitLab/GitHub, etc

So instead of offering a download of annotated tags as they do now, see
https://github.com/git/git/releases and
https://gitlab.com/git-vcs/git/tags they'd offer a download of whatevr
this new thing is?

> 4. that there was no fuziness or human interpretation involved into
> converting "x.y.z" into the syntax used to select "release “x.y.z”" in
> git commands

So since we'd store this in refs/* somewhere since it's (presumably)
named named ref of some sort, you're suggesting that this thing be
exempt from the DWYM name resolution of refs, e.g. us resolving "master"
to "refs/heads/master" or v1.0 to "refs/tags/v1.0" (but as you note
that's ambiguous).

So you'd always need to do e.g. "git show refs/releases/v1.0"?

> 5. there was no ambiguïty in this syntax that led to the selection of
> things that are not "release" refs and just look like them

I don't know what you mean by "syntax" and "selection" in this context.

> And **not** the current situation where there are no official "release
> ref" objects and "just map release names to tags, mapping recipe is left
> to the reader". Because everyone invents its own recipe and the result
> does not work.

I'm still entirely unclear about "does not work" here.

> And no, vfoo is not a form of release ref, because v1 can be a branch,
> not a tag, version3 tag is not the release ersion3, etc (real-world
> examples I can provide links if you don't believe me). You can’t let
> things undefined as they are now because git users as a whole are making
> a mess of things without tooling help.

This seems like another complaint about the ref ambiguities. That's fair
enough, but how is that per-se related to this proposal? We also have
ambiguity now between "master" tags and branches.

>> If we assume this is a good idea, how do you imagine this would work
>> once you don't just have two levels (random labels v.s. "real"
>> releases)
>> but three or more (random labels v.s. "real" releases v.s. "LTS"
>> releases, ....)?
>
> IMHO you’re over-engineering things there. There is a need for separate
> release refs, as evidenced by the fact every major git web frontend had
> to separate them from normal tags in its UI. I'm not aware of the same
> thing for LTS or whatever.
>
> Of course implementing generic namespacing, would be a way to get a
> separate release namespace. As long as this release namespace is
> unambiguously defined at the git level without replaying the 'just
> invent your own tag recipe' mess at another level.

It's not over-engineering. Right now we have a hierarchical namespace
for tags and branches, so if you want N levels deep or whatever you do
that with prefixes or subdirectories, and there's plenty of examples of
that in the wild. E.g. tags created for hacking, QA, pre-release,
release, LTS etc.

Whereas if you're proposing some mechanism that we draw a line somewhere
in that flow and say "now tag/mark/release stuff as different sorts of
objects" it's up to you to convince us why that's a realistic view of
the world.
