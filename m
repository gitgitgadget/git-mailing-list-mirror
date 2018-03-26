Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534491F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeCZVoX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:44:23 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34985 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCZVoW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:44:22 -0400
Received: by mail-wr0-f181.google.com with SMTP id 80so19277504wrb.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rCOSKgvT9sxEMBPeTexBD94k3ITwoVmJqjD5jayC6YQ=;
        b=XV1LUpr0dPs7UIepPvZfU082CIlSoYfUJ4uKfB0Urv4WMhGy5JRL2r/+Hpyies/Jx/
         BKj5Vx4f/bQ766ZFjzI+b/2e/kCTMwbY36ZsvjWPiZZayHY4UC0lAn77kCgB7jgPW+pH
         8VvXXpLKRo9qJBWbFNsNDCIahSGq7DuDAtzQXVSPnq8J+GXsBlQI27/vc/5CjD0LZ9vW
         f5AGm46ayjiecAMt0+lLb3UMfCkBkyDRg+Gd9fZ+RLEut2z6wTuzAogXK96ZBQsloJhj
         DReVD59rem1fNJ5IN6pirHTUFYoMpNw6Pvk2Qd7wpu2tNBEKYhJhjfzo/deHIkZ2nJpP
         HsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rCOSKgvT9sxEMBPeTexBD94k3ITwoVmJqjD5jayC6YQ=;
        b=Z+SvpN4/8pZGPCuXWYQX6cMn8FpMejgQACbFB6gt+XVDo2Q1HsfNo7jYtON0Tfl/VO
         bYxhlIfDt/wpVIN8qPcrXHsajL6vwJx55FTgpXYBYNtuxjAfZDPj+Q6UvxGyuicEy/qf
         voaeN3+aXEynDT/QQWP57lbsUNIG45TiU/JHnPbxBkGGorBho2H/lTz9RArcpG/WL5Q2
         ciZfRbPLtTY8ivGWbMK2TxHk0sFhqShPqLL5pXq7/sTLlF8k/m6VZVxlwv6F0/BgwUj4
         9X6rp72e5kHqKqvBEK3Pa0GINgdyvK7CqwylkWzEkLpO2j7ISmqiz8Vm66VMgiJNV2S1
         cTFw==
X-Gm-Message-State: AElRT7FB7TpLsMxEo5+LxMRC+u2HJRGfZjkhw0UtQY5/RAA/gwqAsB5+
        ApmHzwFcegvQ5cS018Wp9fAp3uED
X-Google-Smtp-Source: AG47ELvxf9NU2KsHD77bYPwq8DjwCVQU1DjJaTFIbSrsPWxERBze7thP5PsAkHo2UqNO/djUdkH3ig==
X-Received: by 10.223.185.21 with SMTP id k21mr33416575wrf.116.1522100660481;
        Mon, 26 Mar 2018 14:44:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d28sm5798255wra.37.2018.03.26.14.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 14:44:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rafael Ascensao <rafa.almas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: git complains packed-refs is not a directory when used with GIT_DIR and GIT_WORK_TREE envvars.
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
Date:   Mon, 26 Mar 2018 23:44:18 +0200
Message-ID: <87woxywlzh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 26 2018, Rafael Ascensao wrote:

> One of the tools that manages PKGBUILDS for Arch Linux stores PKGBUILD
> git repos inside a cache directory for reuse.
>
> One of the repos is triggering some unexpected behaviour that can be
> reproduced in the CLI with:
>
>   $ GIT_DIR=spotify/.git GIT_WORK_TREE=spotify git reset HEAD
>   fatal: couldn't read spotify/.git/packed-refs: Not a directory
>
> Moving up one directory works as expected.
>   $ cd ..
>   $ GIT_DIR=sync/spotify/.git GIT_WORK_TREE=sync/spotify git reset HEAD
>
> Using -C seems to work fine too.
>   $ git -C spotify reset HEAD
>
> $ GIT_TRACE_SETUP=2 GIT_TRACE=2 GIT_DIR="spotify/.git"
> GIT_WORK_TREE="spotify" git reset HEAD
> 22:10:53.020525 trace.c:315             setup: git_dir: spotify/.git
> 22:10:53.020605 trace.c:316             setup: git_common_dir: spotify/.git
> 22:10:53.020616 trace.c:317             setup: worktree:
> /home/rafasc/.cache/aurutils/sync/spotify
> 22:10:53.020625 trace.c:318             setup: cwd:
> /home/rafasc/.cache/aurutils/sync
> 22:10:53.020635 trace.c:319             setup: prefix: (null)
> 22:10:53.020644 git.c:344               trace: built-in: git 'reset' 'HEAD'
> fatal: couldn't read spotify/.git/packed-refs: Not a directory
>
> The issue seems to bisect to f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0
> I can't pinpoint why this particular repo is behaving differently.

CC-ing Duy, the author of that commit.
