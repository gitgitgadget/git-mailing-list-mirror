Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC686C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9638922AAC
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLXGOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 01:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXGOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 01:14:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFAC061794;
        Wed, 23 Dec 2020 22:14:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r5so1255217eda.12;
        Wed, 23 Dec 2020 22:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZDPXNpnPcne0mL+tmv3yody46NyfX1YtoF37WL5mFA=;
        b=r77mbbpnt9/awcxAIEn4WoaBfTKTE5MLaPluLt+PO946Mw4q2I1SpZGVXbsPqzhjbI
         uUvt2oMn4owh7SKuS6GMQJKJ09ufYZR4mDfOwPNP1Qf3P7tTzN/l98AUBcJHP1oZR+pS
         m0oQG/tUgFqo4MTlvdBuILE3wm8mnCeEvWbbJAqvEFPsB5+1l3lm4mnIrgt9OQYRLM9m
         rHT16VT6ccOvpAKoNRwrtZAd4QvV8o7bHfBZ2I887AYxpOYzQ6xSSIvez8trl3mDUrsB
         UujP0DKpH3HWpU0qYeX14jnlToQIOhNOhoqdItSAQYGiWnoD1zihNS1ydFi/Yxr+1ggf
         jYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZDPXNpnPcne0mL+tmv3yody46NyfX1YtoF37WL5mFA=;
        b=cC2lxKla7yU+QnnqV7rP2E9/xte2OIXg9pdMXrltIDYkLayYWNpeIh/Azh45ZIw4W0
         7sx17Jlq48f5tVQHVIKAPJy1LamEps9i0zN7cjkJ7BZP+u50Yv2x/kG4Yefd9IDWcHib
         HBitSNeDt44WSfUie6bRChrHekPunwQgCCBa6ZI9psy1Xe6S/Qs9aVt0w16AxufADDsN
         QTItsSslGTr8zKI/DCRCpXRgq26qmmLCeyunP8XcDP/X7NX27Fjp4dW7EHKqOnFZO2Ra
         8kCf4KmcQ2a8CICbSKZffiklveQBNQ0wNm7UYw47mpD6DEaN7p7uPuJTmlczWvgg5dy6
         bTsw==
X-Gm-Message-State: AOAM5313xXNctmSkBMwI7mV3aopi6//oJW39eDZ3dYIOL0mZjFNYaKov
        dI/Jkvo7KAiipBBh6w95H4QT1LoF5nSR5ckDiGw=
X-Google-Smtp-Source: ABdhPJyI7VNa9K4yFxAFV4T2cfhIEWKmLqrUcmzSLIgNitILBdvHtDrZJCxjhH4ofkpofnKdrF3j0EgVHTo8WYe1H6Y=
X-Received: by 2002:a05:6402:45:: with SMTP id f5mr27319654edu.273.1608790448550;
 Wed, 23 Dec 2020 22:14:08 -0800 (PST)
MIME-Version: 1.0
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Dec 2020 07:13:57 +0100
Message-ID: <CAP8UFD3aHEpHZWxzwz=RQr7DNAmJhLeoiOzubRqk1=7gRyG4_g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.30.0-rc2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the suggestions below are found by GMail.

On Thu, Dec 24, 2020 at 12:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> A release candidate Git v2.30.0-rc2 is now available for testing
> at the usual places.  It is comprised of 19 non-merge commits since

Maybe: s/is comprised of/comprises/

> v2.30.0-rc1, contributed by 5 people, none of which are new faces.

[..]

>  * Various subcommands of "git config" that takes value_regex

s/takes/take/

>    learn the "--literal-value" option to take the value_regex option

s/learn/learned/

>    as a literal string.

[...]

> * More preliminary tests have been added to document desired outcome

s/outcome/outcomes/

>   of various "directory rename" situations.

[...]

>  * The code to see if "git stash drop" can safely remove refs/stash
>    has been made more carerful.

s/carerful/careful/

>    (merge 4f44c5659b rs/empty-reflog-check-fix later to maint).

[...]

>  * Since jgit does not yet work with SHA-256 repositories, mark the
>    tests that uses it not to run unless we are testing with ShA-1

s/uses/use/

>    repositories.
>    (merge ea699b4adc sg/t5310-jgit-wants-sha1 later to maint).

[...]

>  * "git apply" adjusted the permission bits of working-tree files and
>    directories according core.sharedRepository setting by mistake and

s/according/according to/

>    for a long time, which has been corrected.
>    (merge eb3c027e17 mt/do-not-use-scld-in-working-tree later to maint).

[...]

>  * "git pack-redandant" when there is only one packfile used to crash,

s/pack-redandant/pack-redundant/

>    which has been corrected.
>    (merge 0696232390 jx/pack-redundant-on-single-pack later to maint).
