Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E701FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 20:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbdAIUEC (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 15:04:02 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38215 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbdAIUEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 15:04:01 -0500
Received: by mail-it0-f46.google.com with SMTP id x2so71879784itf.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 12:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p42TKIxeqzA1F5PiTrlMi+XVrxGPqkbnXm3Um9az0sA=;
        b=fSF6LFlxSHMVbRitvHJa8+6nUvmuALGevIytRHXyQb/RcEZd4QE65CrYdCSRvRVzha
         XHsWziPMV8zvmwPgrCo6IvTYvWIo6HPta6M0fGWZ9TQg0ApW3K2FyenwF5k/DxCLIgKc
         VdSSFwPbjfcToiRU1CGLAUBALlaZVyBvpJqh1wlF+2QhMTpOtBaikc1CzX8EQuWcXSqF
         +KvfP5WzGWOtqpLw8AwmRjZReCmWlsPmjyVDVCqWah+JSb83OxPgxl7LsyEtdHgRWWCl
         NwyR1Wdk6rc9lUwzIWc0s9zQ9kNEy/tko2rjNEImxMbUDXu3jlDLogyd2GF/Wk1Fu+fm
         gbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p42TKIxeqzA1F5PiTrlMi+XVrxGPqkbnXm3Um9az0sA=;
        b=mvpvCLxXkba7Ox8u8eopEsqOwM6yEUP37FBxs7JpXGbd6MSIdSbL8ec9nntfO4nNpx
         n+3aVZs8F1p3WjT9PQXQ/9FL71zmlPBmrAe0mZd/VIBFL+FuNsZZm5dzu+0U/AHToL6i
         4Nr6o0yzkoopJCwD52NFWWev+G3dY1Z7NkbOrLuwRoDH/a5uKpn+bkWkOMe+9OkxVmMN
         UnNWP79m4msX5+4PQwCq7zYzg+6deCX8MbrzjvR596UANcwT0dGRaMttYhZFXJzE+aEX
         4ZcdnUIUfa3aXOUyDN+BujC8i+TlgBmxn2eCJC4+OuhWjOwZmUpcH52vUuogYYQGnOWD
         2eTQ==
X-Gm-Message-State: AIkVDXJu/CIVsCZ3DbD2smXxsO62j0X3P9GMu4fb7V8TQC1tb/yo7iorKYdbQSOENDszYRZHMbhoWtiQifVTWowd
X-Received: by 10.36.65.161 with SMTP id b33mr16161itd.114.1483992240129; Mon,
 09 Jan 2017 12:04:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 12:03:59 -0800 (PST)
In-Reply-To: <xmqqbmvhyn1m.fsf@gitster.mtv.corp.google.com>
References: <20170105192904.1107-1-sbeller@google.com> <20170105192904.1107-3-sbeller@google.com>
 <xmqqbmvhyn1m.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 12:03:59 -0800
Message-ID: <CAGZ79kbkTf5mT39p6mznGuCwptdVx7hc8N8P=mKo4aoV2=-JVw@mail.gmail.com>
Subject: Re: [PATCHv6 2/2] pathspec: give better message for submodule related
 pathspec error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 6:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> For future reference, do not bury a useful fix behind unproven new
> things.  The main purpose of this two-patch series is this change,
> and it does not have to wait for the change to allow test_commit to
> notice "-C" you have in another series.

noted.

The bug fixed here doesn't need to be fast-tracked IMO, because
of its history. (It's well documented on the web already)

I think this series can wait until the
"test_commit -C" is available.

In a reroll I'll drop the dependency then.
