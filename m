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
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB371F461
	for <e@80x24.org>; Thu,  5 Sep 2019 06:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfIEGvC (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 02:51:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46600 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfIEGvB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 02:51:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so982776lfc.13
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2xMin6SVKAeVEdOaFVQ8z60jBoLqDd4pb+PfVQPXoo=;
        b=l+ok2/gfMvza+LcSggNsAJZ9siK9Vs1L6hPjrHibwF4TTLv3rzSn12Sqc79kfi7GR+
         JsIcYizBzVNnFU4kVOf5/JIeDoz/ENlo2vlkH4/98NsXhnSwuHuyIxT/BjewCLN6OFbw
         Rza84lV/gSmkDF0ONsehm64vy9ytWAIT3cLqdNj0rOs0va5HkI0qx3T5GX5Y+Aws3Kn5
         swGLYvALxWOe3W2vW4uFws8owdXx3YcNmHpz6Gaf8EYH6s3cA5wCyi41e9j9doDVtzgj
         mU4rqW5BDuyfJsHngTyzoS4v0ZEzsEHhAcLZdM9WCG0qMGUo5SL6ZlUHwl7xgw6uPamu
         yo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2xMin6SVKAeVEdOaFVQ8z60jBoLqDd4pb+PfVQPXoo=;
        b=QRf7mFqcrf+8M8cuHXp+zdBfjuRLdM7kaZixVs2nehRbGioSkBA4miIHJF/lma9uvP
         pnc4P00It8T+zH6zxg/ENAtJL2YaZuo3rZVxvWjVVeDzoRG0c2zu9DXxFfQ/90KHcSPY
         8+EcteBkYNqJiZz8MneOgFi/qEJlFMFiBZonf6vih2eSu1orKT+wDG+BEYsnOWdZMMYc
         b1tCkR/ThwPKtBVIt46fkMsfAedErGZvbdFC7B/HKPvxyJ3ImB/x07pNPb9/9DLesDZf
         9wHXoCyviCLEH7v++BMpJVBP2VqTafeurhMAcTL+ohE6IzNHJSfkMn9RTXvNGMuVv6Mz
         r/uQ==
X-Gm-Message-State: APjAAAUVYA+oLdUgmhzX0c/VDHotSPdl6W1L0qd3Q5A3jV6ZMGo+XVqt
        suG0zsWUncNtQp6H/MzwDM/fsWbYtXuB9GVrLH4=
X-Google-Smtp-Source: APXvYqxFxbetUDR0AoBYnX03OPSwQdQXVUEEvKkKK1kGBZOUGEUymU0PLRstqa5dqjLm/Zzhdamnh/u2bDY+VyRTMqE=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr1182737lfn.43.1567666259556;
 Wed, 04 Sep 2019 23:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com> <20190904224821.mgh4srhc22grkraz@yadavpratyush.com>
In-Reply-To: <20190904224821.mgh4srhc22grkraz@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 5 Sep 2019 08:48:35 +0200
Message-ID: <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 5, 2019 at 12:48 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> I'll chime in with what I think would be a great solution: auto word
> wrapping. This way, the users can set the text width, and not have to
> worry about manually formatting it. Long "words" like URLs would still
> get to be on one line, and we avoid showing annoying dialogs.

+1. IMO git-gui really needs automatic word wrapping for the commit messages.

Birger
