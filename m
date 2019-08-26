Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECD01F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfHZTSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:18:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38596 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHZTSp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:18:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so16415943wrr.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OpmxTHA0KTsQrUQac6fQH4AKlK5/e/bc8QMLAaHqrXo=;
        b=aWmPZoaUoEygPRlEsqtywdcRzk9tDZ1ZpRKCz8VaZrqzihWwgFzGeUUY+r65yNjyaz
         09CM93nveWPn0M/7J7uLpFprr1AJk7CgnRs4Kma6/8nYP++HK/kf1vgPq3IDaI37+zWM
         u2xh/PNQC1hCQFlmoUuRP8C0MlwoWLyYNmAb2nssukz8R7jz/usbmbXrzPv3CPVYRf1g
         t54QhQFpm+qAy0F+EDyYeHIFKm8MMw/CvWHCsMuNASe0o54HiGyHRkPUrQRfSzPovTR1
         tjY456PE7QWLplDSWGqU1pNhN32NpgDO99Fk86aqMF7fl/0pz4f+aGE9qF4WPCLlAiqg
         q5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OpmxTHA0KTsQrUQac6fQH4AKlK5/e/bc8QMLAaHqrXo=;
        b=PEzn8p/3k7H+FvEMuUfb3YBcEgpdgulftib8Y/bqBwxyBGk6zDZTh4cqzycOQ305R2
         11usfa66XgEjrKMf1AOs/u6qutXfeEhj/Fs77kgfbvE9ZyJfU3f8IOQsuA8R0NSGG4kE
         cq/H1V49+IrpFnoaN9KkUWLEM2FJ1D3S3jJNd2zqWg+bPLYsVdMVDSNEZkrWzLm+fJpI
         sQEOIEpWS5EOwGBmZD50Y91D7Bzxp8GzlxOse23YA9tHFqAU3ZQaQdB9vpwEKOg2M9Sq
         pZ+82hK5wad3gh06tAMCAEJFQW56rgxJArYl1VuS+ozlF/Q+25G/6XBuREELisSBHfF1
         Qvxg==
X-Gm-Message-State: APjAAAXaGnHCNL8BokkiPqithkfb11F+5CZfcuxGEawgF+ZO+/3QjM4m
        y+SSuCAoYfJyvItIZ13wMeQ=
X-Google-Smtp-Source: APXvYqwOQhQVSGAMCJ4z/L0usS99Ys2m3tf3dJrkFPOVeT95y4I3Rr7rB9bpON7YIfk+YWt5tiOZsw==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr24276253wrx.180.1566847122987;
        Mon, 26 Aug 2019 12:18:42 -0700 (PDT)
Received: from szeder.dev (x4db5125e.dyn.telefonica.de. [77.181.18.94])
        by smtp.gmail.com with ESMTPSA id p19sm302495wmg.31.2019.08.26.12.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 12:18:42 -0700 (PDT)
Date:   Mon, 26 Aug 2019 21:18:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned
 repos
Message-ID: <20190826191840.GS20404@szeder.dev>
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
 <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
 <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
 <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
 <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 08:42:56PM +0200, Albert Vaca Cintora wrote:
> > Why don't you wrap your clone in a script that calls chmod -R u+w .git after the clone? This seems like a pretty trivial approach regardless of your workflow. This works in Linux, Mac, Windows (under cygwin-bash) and anything else POSIX-ish.
> >
> 
> Wrapping `git clone` should work as a workaround. Although if that
> doesn't break anything... then why were those files read-only in the
> first place? :)

Those read-only object and pack files contain all the version history,
and, therefore, are precious.  Making them read-only can protect
from accidental deletion.

> The fact that, from a formal point of view, those files are immutable
> doesn't seem to justify them being read-only (or, at least, doesn't
> follow any convention): there are plenty of immutable files on any
> system (eg: all binaries and libs, application assets like images and
> icons, pid/lock files for daemons, etc.) that are not made read-only.

None of those files are actually immutable: the next update will
overwrite the binaries, libs, and assets, stopping the daemon will
remove the pidfile.

OTOH, Git's object and pack files are indeed immutable.

