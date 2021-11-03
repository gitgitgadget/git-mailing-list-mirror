Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78377C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F24760FC2
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhKCQvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:51:09 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35346 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhKCQvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 12:51:08 -0400
Received: by mail-ed1-f48.google.com with SMTP id g14so11585788edz.2
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 09:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmZLa4OBV5cfoA/2xXnfWkt6acW9lX08RQ2bK6HfywE=;
        b=3sSM35NQxhjlnyQg6pcFoEtSeveC/p0Lr2PvMqcU0V8kls11HoKOnmJJ1GlADfzS7e
         hn+GOfxAoEgHtX5DeY4P8y6MZ37e9KrxGEQY4nzl3uXXnHU12SwOHaI+JvWrgmtzB5m4
         l/kJMVYkGyfibFoX0WIH/it+UYJ36Q6PwMybN3VFzwyqWvi1PnQs3l4HnW6CFMJMTT6F
         QAAqL+GnYPxzJIYKAsSDKeaySX+8JxsCz2Vq3w+oBPfmpy378r4kmzOTJSG8Xrq6z3x2
         eFAJlyQPZJEQJAmF2b4oJ3u/0f9VPz4ub8gb3njAcDbVY0dGa5G5u6FKESBZpdSg9G/P
         mPvA==
X-Gm-Message-State: AOAM532hu6YtyKSLyG3WyNllTrkNUqfN4QhQZdMJouueUwiyjwX34/qp
        xtNwm/fuGwu2l257kCox+Qk+31FCsMHVUOdII5vuDS6FRzk=
X-Google-Smtp-Source: ABdhPJy1AMvyneGW7QUOaO1PYyXkuFQip+oBb1o8eMpH2Tz/qHsHC70pqDPliuOhYlr7U2pDnPTNV+6pE5yL1CwB+ZU=
X-Received: by 2002:a17:906:b29a:: with SMTP id q26mr37235818ejz.262.1635958110305;
 Wed, 03 Nov 2021 09:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
 <20211102164434.1005707-1-thomas@t-8ch.de> <211102.86czni1o72.gmgdl@evledraar.gmail.com>
 <YYJ0aQ11uHA/XUt3@coredump.intra.peff.net>
In-Reply-To: <YYJ0aQ11uHA/XUt3@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Nov 2021 12:48:19 -0400
Message-ID: <CAPig+cQ1fdU=YNc5jtT8oYaBMd8MP-j23hSsZ7GD-T99vDDeoA@mail.gmail.com>
Subject: Re: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 3, 2021 at 7:37 AM Jeff King <peff@peff.net> wrote:
> I.e., I don't think introducing a new variable into "git var" is that
> big a deal. They don't have to be related to an environment variable;
> the documentation calls them "logical variables". This is exactly the
> kind of thing it's designed for.

I almost don't want to mention it since it's not very discoverable
(and is never the first place I think to look), but git-rev-parse
already contains a grab-bag of options unrelated to revision parsing.
Many of the options relate to querying paths (--show-toplevel,
--show-cdup, etc.) or other information related to a repository
(--local-env-vars, --show-object-format, etc.). So, adding
--show-default-branch may be one possibility.
