Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1774A208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeG2Vhf (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 17:37:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50493 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbeG2Vhf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 17:37:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so10860236wmc.0
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NXiSqp4pPeJZTlVhT0FmI1UiLMG5Y2AuLhtnWSxqbjc=;
        b=n3CxpPIN2sPee2SRMDOP+/di/j4VTuyYeMfqtMIX2AV67GhWXrx9GohgrRfMEjpXWB
         dfTOyXOx5OM9WfcgDyUwBfWRtpJRSVunWQMzfpgtCc1O7W7JTrLOUF9GK1smRpwIGsLy
         0TwTIr3dTnDINjsBQ5owMVLOjmGJsbyXjty+p0TuX4Wmz+4sI7CY0XsIip/pPCJXrAsS
         7/cnFLvrJWfDu5kyqxWBHstkCUbZr2FdXgc0l8ILmUiJ8F6qnOgyGS0U5ZLxxnRk4NXL
         /EpNvscDVDHnQhPWRmd9Ik5oQROmixdj12kyiFgShpd8aNf4Cnc97o53EhwI8U+TAUje
         F+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NXiSqp4pPeJZTlVhT0FmI1UiLMG5Y2AuLhtnWSxqbjc=;
        b=bxrXzxMGa0cYkuhoo6cuvZorfkMeNIWDmXG43siy8VrlDVhBqG+c3ihjkN+YpKVHOC
         nxsuCryhXe71z6loFWRq4hoc/6VeUs/xuLFuVeeopY0xRXY4nN8qz1IwC4p5Y/MC7Swp
         6+16nz1IWhtRpjeelIOU56J8aCLsbIB0e6YnqOfDRa0DWIU98chqCcFJMymaQwrsm/IC
         UfE/WQrO2Nt++qpTnC/Um7j+pfQuBqMPp1YxOqbOYuk7RQVc3g81Ud1bdOKMTrq7EQAk
         hnQTXz90gB4zNJFpLIgMKj2BllTPvseQAND9pnLyzuyL7xrmDysHI2hcxxksMKRzNx9g
         qIpQ==
X-Gm-Message-State: AOUpUlG46tegjDK/LlZ6lcK4E3/7QG8DKgbVNPwX+8qokEnJ/x8Uvclf
        wa6FZX/Vd7D5kcjgmtmLC8U=
X-Google-Smtp-Source: AAOMgpevnvmre9PfVNKcyJviXT1ArfDrmujQBbTXGOoEz6XqB3GDgLfVuhKWXydLNeaFA4DgWyVdQA==
X-Received: by 2002:a1c:9042:: with SMTP id s63-v6mr12105137wmd.91.1532894754689;
        Sun, 29 Jul 2018 13:05:54 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id o4-v6sm10612645wmo.20.2018.07.29.13.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 13:05:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael <aixtools@felt.demon.nl>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl> <20180729181006.GC945730@genre.crustytoothpaste.net> <466c7a59-0535-e72c-6c90-5288a53b59a0@felt.demon.nl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <466c7a59-0535-e72c-6c90-5288a53b59a0@felt.demon.nl>
Date:   Sun, 29 Jul 2018 22:05:52 +0200
Message-ID: <87zhy9u7rz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 29 2018, Michael wrote:

> On 29/07/2018 20:10, brian m. carlson wrote:
>> On Sun, Jul 29, 2018 at 06:44:26PM +0200, Michael wrote:
>>> root@x066:[/tmp/xxx]git --version
>>> git version 2.13.3
>>> root@x066:[/tmp/xxx]git clone git@github.com:aixtools/hello-world.git
>>> Cloning into 'hello-world'...
>>> remote: Counting objects: 3, done.
>>> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 3
>>> Receiving objects: 100% (3/3), done.
>>> fatal: pack is corrupted (SHA1 mismatch)
>>> fatal: index-pack failed
>>>
>>> p.s. - what surprises me re: git-2.13.2 - no messages about 'Cloning into
>>> ...', which version 2.13.1 did give.
>>>
>>> I guess a bisect is the next step - between version 2.13.2 and 2.13.3. Other
>>> suggestions welcome!
>> Are you using SHA1DC on that system, and does compiling with another
>> SHA-1 implementation help?  There was a change to the SHA1DC code big
>> endian detection in that commit, which might be the cause of your
>> problems if you're using a POWER or PowerPC system.
>
> I was thinking it might be an 'endian' issue. So, yes - AIX runs on
> POWER, only as BigEndian.
>
> git bisect returns:
>
> michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect bad
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [35049a2343948f686861e176a8c395f9f67da7b6] Merge branch
> 'aw/contrib-subtree-doc-asciidoctor' into maint
> michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect good
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [9936c1b52a39fa14fca04f937df3e75f7498ac66] sha1dc: update from upstream
>
>
> michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect bad
> 9936c1b52a39fa14fca04f937df3e75f7498ac66 is the first bad commit
> commit 9936c1b52a39fa14fca04f937df3e75f7498ac66
> Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Date: Sat Jul 1 22:05:45 2017 +0000
>
>  sha1dc: update from upstream
>
>  Update sha1dc from the latest version by the upstream maintainer[1].
>
>  See commit 6b851e536b ("sha1dc: update from upstream", 2017-06-06) for
>  the last update.
>
>  This solves the Big Endian detection on Solaris reported against
>  v2.13.2[2], hopefully without any regressions. A version of this has
>  been tested on two Solaris SPARC installations, Cygwin (by jturney on
>  cygwin@Freenode), and on numerous more boring systems (mainly
>  linux/x86_64). See [3] for a discussion of the implementation and
>  platform-specific issues.
>
>  See commit a0103914c2 ("sha1dc: update from upstream", 2017-05-20) and
>  6b851e536b ("sha1dc: update from upstream", 2017-06-06) for previous
>  attempts in the 2.13 series to address various compile-time feature
>  detection in this library.
>
>
> 1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/19d97bf5af05312267c2e874ee6bcf584d9e9681
>
>
> 2. <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
> (https://public-inbox.org/git/CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com/)
>
>  3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/34
>
>  Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>  Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :040000 040000 a84797967fb742e4ca9618a641d53ce3a6c6589b
> 32efa656d78901da961e4a47d84b6d82fede064b M sha1dc

Sorry about that. As can be seen from those PRs and the "git log"
detecting whether something is big endian or not can be quite tricky, we
figured out how to do it on both BSD and Solaris, but apparently broke
AIX as a result.

You should be able to define -DSHA1DC_FORCE_LITTLEENDIAN or
-DSHA1DC_FORCE_BIGENDIAN (looks like you'll need the latter) to get the
latest version to compile, but I and upstream cr-marcstevens would be
very interested to know from someone who knows AIX how this broke.

Also, to you and anyone else with access to AIX: I'd be happy to figure
these issues out pro-actively if you give me a login to an AIX
machine. I promise not to do anything except compile/debug/test git on
it.

I used to have access to an AIX box through a previous job ages ago,
it's a very interesting OS and like with Solaris it's easy to discover a
lot of portability issues.
