Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CD31F803
	for <e@80x24.org>; Tue,  8 Jan 2019 13:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfAHNym (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 08:54:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37548 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfAHNym (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 08:54:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so4153476wrt.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+yNYHiPJS15xOXcyriZvWvKGlIDoPfS84fZGO2qIitI=;
        b=FBcTuRIHLy+krViT9FLTFr8qGYSnmZUpRb8Z+PnVqEJGS80DexIiHlNUPoh2JwsO1U
         BqiGGTi7LW+eLzccXw2v6SrUzU2glHU0vsdsRloumHcuFKmO6QMKrYL9mJbwOMGIJM9a
         sdWHgi9XYGZ5aOLLRDhyiW79BDHAGgCo24xuhHQ+2eYCrwGXmmvfUBluMS+PnUuibHPt
         6FLwif0iy1LqA1i+TDs0JfP9TaL2MUupDeAnYtWbxVHwycKPw4ew+iSrWuho9uaA7RdL
         RLake4uG/Wep6OWlxgx7h+HI42Q2cnBRVdicwrvzvzYU8XtwUbesJUUWRoaf69TSZVw8
         3czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+yNYHiPJS15xOXcyriZvWvKGlIDoPfS84fZGO2qIitI=;
        b=fjnTx27foukfkCigyC714v2/mdr2L7iw98HSg+WScUkeRIaihn1qJENnpvrkmBCBVz
         phBrPA31IDwRVuxlmsqHdyyGrG1bgCYMQiktHy4fAvM4VFd850mBVuqDyWsBkY5yqJig
         vnDx3PkuCwNGVyJ5U39pu/pWFS1OpCCys/MniDOaS6oxPxI9Os6iIjmAVsljuJvgJdYK
         6Rk7VLOESdIRgxoUi/alUwTwNuK9HI4Efk2g4smOzoPi+ZONkR8tIvy4JgxPF6X19ZJk
         Y2lyp4I0wBy1i+OLAJsOTD/d/Cwj0gIvOqFfvTfG5KUMwjjqSKOB7HWH6rI4xvVZb0he
         PCDw==
X-Gm-Message-State: AJcUukcOQP4RsBq6Fb01jR47+qsAONxQL6gnckmeWQCOTxRA/2u5Uham
        /lW8T1sCjU5xsDtE7M9926w=
X-Google-Smtp-Source: ALg8bN6/XoeF8D7vtLLOvT1D9vP48qLxvnD4fdv3m0+TspCVcruELibRvfctAxDV9FwGp1Upvbg4dg==
X-Received: by 2002:adf:e509:: with SMTP id j9mr1675811wrm.76.1546955679406;
        Tue, 08 Jan 2019 05:54:39 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id z206sm9944353wmc.18.2019.01.08.05.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 05:54:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Alessandro Menti <alessandro.menti@hotmail.it>,
        Jiang Xin <worldhello.net@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: Translation of git manpages
References: <1992944.NOdEsaAZKb@cayenne>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <1992944.NOdEsaAZKb@cayenne>
Date:   Tue, 08 Jan 2019 14:54:36 +0100
Message-ID: <87lg3v6yqr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 07 2019, Jean-No=C3=ABl AVILA wrote:

> Dear fellow translators,
>
> I'm trying to put up a longstanding project of providing translated manual
> pages for Git. After several experiments, the best choice seemed to be th=
e use
> of po4a[1] to convert the asciidoc[2] sources of git manpages into po fil=
es
> that could be processed the same way we are already doing for the transla=
tion
> of Git itself.
>
> The text is segmented into paragraphs and structural units (titles, list
> items...) and when translated, they are reinjected into the original text
> structure. Only inline asciidoc formatting marks are passed in segments.
>
> The translation takes place in a dedicated repository[3]  . It simpler to=
 not
> meddle in git main workflow while adjusting the translation workflow. If
> everybody is satisfied with it, we can maybe migrate the repo under git
> organization. Now, this repo is standalone with respect to translation co=
ntent
> source, but a patch has been submitted so that the translated manpages ca=
n be
> generated and installed from the main git project[4]. Symmetrically, ther=
e's a
> script in the project to pull the manpages source files from the main git=
 repo.
>
> The repository is connected to Weblate[5]  if you have collaborators who =
don't
> know how to process po files and prefer translating in the browser.
>
> The repository is also open to pull-request on the tooling. Let me know i=
f you
> have issues. In any case, the translation work can be reused for any other
> arrangements.
>
> There is already a kernel of translation in French, from my experiments a=
nd a
> previous effort of German translation[6] was gettextized. If you have such
> archives for other languages, I'd be happy to integrate them, even if the=
y are
> not up to date.

Thanks. This has come up on list many times before and it's great to
have some movement on it.

I think a way to have early exposure of these to a lot more people would
be to have these on the git-scm.com site. Jeff knows more about the
build process there.

I see the general completion of French & German is at ~10%, but maybe
there's some pages that are fully translated already? We could then have
some UI or git-scm.com that allows you to switch between languages along
with some general overview page per-language.

Are the translations contributed through
https://hosted.weblate.org/projects/git-manpages/translations/ something
that license-wise (Signed-off-by etc.) we'd eventually be able to
upstream in git.git?

It would be great to eventually have something we can build as part of
our build process, so e.g. Debian can have git-man-de similar to
manpages-de now.
