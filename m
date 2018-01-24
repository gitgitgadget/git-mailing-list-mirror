Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2632A1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeAXXZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:25:24 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35685 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeAXXZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:25:23 -0500
Received: by mail-wm0-f41.google.com with SMTP id r78so11728567wme.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 15:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4MG7xcvWjN+j1321pzdYgrUA06UB4ZOq/C4uiMqiVQg=;
        b=qUwzJGGpp0oO0p0AlAtkCI2eo7xDC5pjPHnuKgEFDX8k/jvz+NyctYSkkbsdXQbifo
         XHA8TuNTOzpHMgZU70Lk9wdxqB/6QRamPfQ3urs3L5m62Nv2ceF+ZIG3CWVkVRVzTtfO
         caNvdVrz8S0INdmx31QUOs7sPBTlNZ5dPL28PjcO0T6Y/nMyVP9IkI8vhiIXTq3hWJ53
         qPf59UZcUXcObJgfXMgDh5yGsbG+bxZVQNKdVWoB1z6fk2cHSYu+pkZhom5ScIaYIDI8
         Q0Yl7z+VNu3YmPw1mDLrAvB/w3njIn7p5gbGI3QtR7+Hr3jYo3z/zAmMl77oThWeEoRU
         /m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4MG7xcvWjN+j1321pzdYgrUA06UB4ZOq/C4uiMqiVQg=;
        b=pmGQFrkGPjv55ib4MUKjIUw+OEG01UN+aYKbt+TPGepdORJ3NCOzr5voCdGOKVuGv6
         YgUIO05++yvy/JNDo2DYK8lb+6CYMFvS3HLj6OROqy0KbkeAxLbgzepW+kIUDcstA4CR
         Q8NpPLTbBpJsgpE5U1IsnYPhtXs257LCyeGVJDDSDIu2x5ayOuUYbdIJwbQqF8SDq3hw
         12W1yUIluAFPLQze/dKjA3KSHNpb9JlF2jzSR5tsRnkswjMzoLQYkkb6HDcGfruKZThb
         91K0tQtwNne05qS0vOKuysAeDD+Py48agK3xAdeka3NzsCyAO35fT314gl/A471ST8EI
         S9fw==
X-Gm-Message-State: AKwxytd3arHxJ0Ua+AGtqadEO8A0nJZfVac5h3b4pj7DRKQt/beWBAB8
        EjntqOGZ0W7JgWIMuTU92cE=
X-Google-Smtp-Source: AH8x225D7Leyv/8fVNNzyoFwNOmF/f0MfAXQJtDhaTv1D3yWs8uWki1MUEUMlAibrQOzKP/9T+DYEQ==
X-Received: by 10.28.35.200 with SMTP id j191mr6716980wmj.146.1516836322044;
        Wed, 24 Jan 2018 15:25:22 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id r76sm1521456wmf.0.2018.01.24.15.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 15:25:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com> <20180123221326.28495-1-avarab@gmail.com> <xmqqwp06amfw.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqwp06amfw.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 25 Jan 2018 00:25:19 +0100
Message-ID: <877es6yh40.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>>  Documentation/config.txt               |  20 ++++-
>>  Documentation/fetch-options.txt        |  18 +++-
>>  Documentation/git-fetch.txt            |  76 +++++++++++++++++
>>  Documentation/git-remote.txt           |  14 +--
>>  builtin/fetch.c                        |  37 +++++++-
>>  contrib/completion/git-completion.bash |   2 +-
>>  remote.c                               |   5 +-
>>  remote.h                               |   3 +
>>  t/t5510-fetch.sh                       | 152 ++++++++++++++++++++++++---------
>>  9 files changed, 275 insertions(+), 52 deletions(-)
>
> I've queued this round but saw a few minor conflicts with another
> topi in flight, so please double check the result when I push the
> result out shortly.

Yikes. fetch.c is busy these days. Looked it over, looks good to me. In
particular the potential logic error introduced by mis-merging "fetch:
refactor calculation of remote list" has a test which would fail.
