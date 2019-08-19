Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FE61F461
	for <e@80x24.org>; Mon, 19 Aug 2019 15:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfHSPCv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 11:02:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54923 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 11:02:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so1920362wme.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hRKx4cjO2/QsQwNtXc725z2+nPwX544pF30wIbj+jJ0=;
        b=g2ssaQY4pZ8L9LXJmcTH0JjXjYRXez3reJBHWKvZKB2jIlg1gjCsIRe0N1ubj4ROtm
         /43EV7Ec+xotQlvNfHih3GjhXW0HfoKjciCgDsfxDkduEkhUs/nmPb3GoEpOVTsiz9eo
         mo3zVF14okmOAPsPskyQQFO3JVqHQQnO5V7W3/rVzOD+h2RB0YP9rLKG7U54BRuubceI
         FnLf/E05pre6AdxPdgBzwDneTwAOuLwO69DCyQQ5ZoXMX2E5AWr5BxAEqhCLof2o7sRM
         ZXrBYmnUmju5cOVzXRmTfURQ/VC7vmN2D77SUGzgAtDwWQGXHje6cJBnGfI5qmClW39I
         8Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hRKx4cjO2/QsQwNtXc725z2+nPwX544pF30wIbj+jJ0=;
        b=KaIpDi7mIR1L6aNshGVzpWjBAWAXxu2EJEAKfdvrVHbdktPrrDMrd69BUawcXm+eqr
         8odEs0KnHZZE46rRjPDmzFULTezD1q3mCJ3R5BOePTKoYS4/FC6/Y51yC9fC15n8J1MG
         EbIJXNUHciyj0l1EOcDq4zacEmRRVCi7XG2IAxPBbEdkyxSWYx8OG9J9NNfv8E088Fcx
         3O46fK0A2SoIT1cTDlijEscPiPYjSw0Vbxp/MiOVBEfJdpAoVrcr43SqKekvxOmlxrT7
         ooq7eVENBvmtK1ZqZaTrsF8f+lAXFE++RHNfNGp/jOycaiY9wwAxg7Qj4LswWdCg6r+S
         xT7w==
X-Gm-Message-State: APjAAAUZY5esrjfBmLzI3Ddcj9GYj9mNI+BRmZBvyib7oZcIEFc7l1T/
        uJBH4BCjVW1BmCd+UT+iNu0=
X-Google-Smtp-Source: APXvYqxa53W+h3WKxmiQmZBWiuxSHiFGRH6s3Sdoa/5SDWa8qVYrG69ECeTKhXQ8QtU/ePS5N71zGw==
X-Received: by 2002:a05:600c:48b:: with SMTP id d11mr21678787wme.55.1566226967978;
        Mon, 19 Aug 2019 08:02:47 -0700 (PDT)
Received: from szeder.dev (x4db60b9a.dyn.telefonica.de. [77.182.11.154])
        by smtp.gmail.com with ESMTPSA id i18sm17050682wrp.91.2019.08.19.08.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:02:47 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:02:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
Message-ID: <20190819150245.GV20404@szeder.dev>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
 <20190819130323.GU20404@szeder.dev>
 <5611dad6-94fe-e4e1-c06d-7dd0642be3ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5611dad6-94fe-e4e1-c06d-7dd0642be3ae@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 10:50:48AM -0400, Derrick Stolee wrote:
> Note that I don't include the "without patch" numbers. For some
> reason the path provided is particularly nasty and caused 20,000+
> missing blobs to be downloaded one-by-one (remember: VFS for Git
> has many partial-clone-like behaviors). I canceled my test after 55
> minutes. I'll dig in more to see what is going on, since only 37
> commits actually change that path.

Don't bother digging into it, I know why it happens (and how to avoid
it! :), but don't have the time right now to explain.

