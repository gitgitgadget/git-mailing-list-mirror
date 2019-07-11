Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157661F461
	for <e@80x24.org>; Thu, 11 Jul 2019 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGKVyj (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 17:54:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfGKVyi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 17:54:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so7872721wrm.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UUK0z3Rc38WVXhNd7Ys7pidTXhWOQen+o25t/WhfHnU=;
        b=WBp3wXdNUnbVBcdHq5WjHRaGNvl8U5imSZ9QyAubbxietwl9LeXzU+XVrLV/0+KofU
         M7MexAAlwWH4O+4XjWuhCZB9pw46RJ62N/OVWTaQUj5D//FDK7CS564JZ2z1/sUD1fjr
         ZEpiEjhG0j0uZD4QhLrsczAPqPas3yFIia7JJWiCDQdy1pQQb+UwHhVyCAWQoCoYKjGS
         7TLghgIunE2sFcSNdtvCirHNfK4r4u7vo5eHZuFcJ0jjZX/OjOGsXdA6xJ+vb0BllT4R
         GN7u0qc5YD4JRSGJWcSRcaVd1a1wUspOIbZcDv5xcZh2M/Ok7niwIzTeA89qhwQ1kEAY
         dhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=UUK0z3Rc38WVXhNd7Ys7pidTXhWOQen+o25t/WhfHnU=;
        b=e/4fXnHeEb3w1LrpyTBylD0aOngO2r3P96ClORWY/UrIDCbi7rL6ssYhEkNb5rJWFb
         73Rrq7PwlCCWcyI77uU5r6QWuRVEJ4VPiegx+MqO/odkU4ZZfe12laQHzkm6lH2LkGew
         ndee/jWP0IuToOHyNupHyH7VrD50Yp/2OIP2P67JvZSVwWyzoXU3DnIpyEOqWoXxqGie
         CdkSJtvB9v1aTluvpjCgdlQqAfwswMM1F4W1/udFnrUwyenfAnXD9or0lKZFmkJfNhVB
         H2BIoYSvIHMpI/LZnzsGq2RENKdqMQ2l1LrdSy6nO3qRfauU/Iys27w1RSUzZi5eLHS5
         VSZA==
X-Gm-Message-State: APjAAAUVK1//1VvicvWZXZ/lc9zUWG371LRSU5al5z31yAJZvQ+xbhdt
        FHWHB9hZyzInK3qnrRQtrLk=
X-Google-Smtp-Source: APXvYqwfBsm/9+iFpEIAxnR6ElcULsAn60DI26w72D4QhsCuy06IhBI3OUjaCdKYkUVaG0Md87zWKA==
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr7243943wrt.206.1562882075670;
        Thu, 11 Jul 2019 14:54:35 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egd227.neoplus.adsl.tpnet.pl. [83.21.67.227])
        by smtp.gmail.com with ESMTPSA id b8sm5586631wrr.43.2019.07.11.14.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 14:54:34 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/3] [RFC] Create 'core.featureAdoptionRate' setting to update config defaults
References: <pull.254.v2.git.gitgitgadget@gmail.com>
        <pull.254.v3.git.gitgitgadget@gmail.com>
        <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com>
Date:   Thu, 11 Jul 2019 23:54:30 +0200
In-Reply-To: <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com> (Derrick
        Stolee's message of "Mon, 8 Jul 2019 15:22:49 -0400")
Message-ID: <867e8o9qzt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 7/1/2019 10:29 AM, Derrick Stolee via GitGitGadget wrote:
>>
>> Here is a second run at this RFC, which aims to create a "meta" config
>> setting that automatically turns on other settings according to a user's
>> willingness to trade new Git behavior or new feature risk for performance
>> benefits. The new name for the setting is "core.featureAdoptionRate" and=
 is
>> an integer scale from 0 to 10. There will be multiple "categories" of
>> settings, and the intention is to allow more granular levels as necessar=
y.
>
> (Adding people who contributed feedback to CC line.)
>
> It seems that this "Feature Adoption Rate" idea was too simplistic, and
> had several issues. Time to take a different stab at this direction, but
> with these clear goals in mind:
>
>  1. We want intermediate users to be able to take advantage of new config
>     options without watching every release for new config options.
>
>  2. The config name should match the general effect of the implied
>     settings.
>
>  3. There are orthogonal settings that may not apply beneficially to
>     all repos.
>
> With this in mind, I propose instead a set of "feature.*" config settings
> that form groups of "community recommended" settings (with some caveats).
> In the space below, I'll list a set of possible feature names and the
> implied config options.

A bit of bikeshed painting: I am unsure if "feature.*" is the best name
for this category of config (meta)settings.  Perhaps "defaults.*" or
"presets.*" would be a better name -- they would certainly be more
indicative of what setting this config variable actually *does*.

> First, the main two categories we've discussed so far: many commits and
> many files. These two feature sets are for when your repo is large in
> one of these dimensions. Perhaps there are other settings to include
> in these?
>
> 	feature.manyFiles:
> 		index.version =3D 4
> 		index.threads =3D true
> 		core.untrackedCache =3D true
>
> 	feature.manyCommits:
> 		core.commitGraph =3D true
> 		gc.writeCommitGraph =3D true
> 		(future: fetch.writeSplitCommitGraph =3D true)
>
> Note: the `fetch.writeSplitCommitGraph` does not exist yet, but could
> be introduced in a later release to write a new commit-graph (with --spli=
t)
> on fetch.

That looks really nice (for a built-in set of defaults).

It would be good if the above format, or something like it, could be
used as a source of truth for this feature.

> The other category that has been discussed already is that of "experiment=
al
> features that we generally think are helpful but change behavior slightly=
 in
> some cases".
>
> 	feature.experimental:
> 		pack.useSparse =3D true
> 		status.aheadBehind =3D false
> 		fetch.showForcedUpdates =3D false
> 		merge.directoryRenames =3D true
> 		protocol.version =3D 2
> 		fetch.negotiationAlgorithm =3D skipping

Well... turning off by default status.aheadBehind and
fetch.showForcedUpdates makes sense only if also repository is large.
Otherwise it is not useful, and even a bad thing.

Both of status.aheadBehind and fetch.showForcedUpdates are discoverable;
as far as I remember Git would show a hint about those config options
when the related task takes too long (either 'git status' in case of
status.aheadBehind, or 'git fetch' in the latter case).

I don't know if we have discoverability in the opposite direction: do we
show some advice (which as all advice can be turned off in the config)
if either of status.aheadBehind or fetch.showForcedUpdates is false?

> We have not discussed anything like the next category, but Dscho thought
> a set of configs to make pretty diffs could be a fun "meta-config" settin=
g:
>
> 	feature.prettyDiff:
> 		diff.color =3D auto
> 		ui.color =3D auto
> 		diff.context =3D 5
> 		diff.colorMoved =3D true
> 		diff.colorMovedWs =3D allow-indentation-change
> 		diff.algorithm =3D minimal
>
> These are just a first round of suggestions. I'm sure we would enjoy a
> debate around an optimal set of diff settings.

Maybe Git for Windows defaults would be shipped in similar form; though
I wonder if in this case it is better from simple system-wide settings.

> Finally, here is a kind of feature that I could imagine being helpful
> in the future, but maybe is not a good idea to pursue right now. In
> some cases users use "gc.auto =3D 0" to prevent all user-time blocking
> maintenance.

Don't we have a hook for that?

>              This can degrade performance over time as loose objects
> and pack-files accumulate. The performance could mostly be recovered
> by using a multi-pack-index, but there is not current way to automatically
> write the file. This would not solve the space issues that happen here.
>
> 	feature.noGC:
> 		gc.auto =3D 0
> 		core.multiPackIndex =3D true
> 		(future: fetch.writeMultiPackIndex =3D true)
>
> What do people think about this general idea? Are there any other
> feature.* settings that could be useful? Any additional settings
> to add to these groups?

Maybe feature.slowFilesystem / defaults.slowFilesystem?  Or maybe
feature.server?

Best regards,
--=20
Jakub Nar=C4=99bski
