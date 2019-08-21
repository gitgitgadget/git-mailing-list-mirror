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
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C8F1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfHULHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 07:07:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45139 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfHULHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 07:07:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so1591393wrj.12
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/D9dt8iDY0kZ5BOrHFBnGux+QXkFqHquQ4DgWT4+6i0=;
        b=CAluSD+E7Pktu7hyal7OTkuHXqY6oAhJjz0U0YASmOUz2n/VYas1ZHL8sPDHjzslFu
         ER7VCPWkKKzL+ZHS7d7KX+BNTd2D2RzTsUk44I6ohRRvksQG3Eha7vqAazlwZOdq3AsW
         iSFv4OgeB4V/rx0Bx7jNA2Am9ZtP6KI7IYpO+Y3h3KpEkZTILPmoj9VjuzEkYuKYbn/j
         z2JXOzKcJRqg3UMzkmwOcL/Unu7u80YlPt5tcaPMpB3SqOLc986HMwvIzt3Kg3CevXlj
         xvdIx7FZzQTVAey6+mnMi+OipCxHJyeJwPAMjiHzyv5A5Y1hGCHQdTvCKYd/HjjkH4UH
         2t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/D9dt8iDY0kZ5BOrHFBnGux+QXkFqHquQ4DgWT4+6i0=;
        b=J6QlQdivraCcJgoBzModA1aoXEdZxX+SGcQDSejDhHN7t26EZ3s5MNzGdeGUv5YbNk
         xZVVinqtz9T0SkPc9Czcrxl+dtdHxSrqeOw9C3Y2pstVT7gQvIdqdNMzRUGXH4y+xg6g
         Zm6vtHFo5d1xatUJ48vKDq/4bmns4gxCkfzKP8cuvpamfW0u0YWPbg9xmm8R+7ATBye7
         olwwpcf9LdbFtB0EJ750hjrPBjCZimBUNg9ApXJWoD1eOiMI/5b5pOnEkMR9ConQk3Io
         RJNKI+LiA0pBifxGDiqF6aNBJsLmeBRx/iT5MqxQHiQGDfKanhxpQT1Kg5Kwwc/Z3/Uc
         zSyQ==
X-Gm-Message-State: APjAAAVpfwH0dPEPI6BG623Rym1j494CY/wOZnmrCgWUAzp9WIOFjQJP
        Att9WtMfZgh2AEAhfhehOYw=
X-Google-Smtp-Source: APXvYqwuAYGU4bDY1nFAk8gWciY/WLLM0tlIuG6BPCh3hICCpIzZaYvFzS/0SFhi3oDe42xMUAMIGA==
X-Received: by 2002:adf:c7cb:: with SMTP id y11mr33775582wrg.281.1566385640829;
        Wed, 21 Aug 2019 04:07:20 -0700 (PDT)
Received: from szeder.dev (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id f197sm6957178wme.22.2019.08.21.04.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 04:07:20 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:07:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
Message-ID: <20190821110717.GX20404@szeder.dev>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <a3f8b468-5ee5-4056-db67-bb8ba5390002@gmail.com>
 <20190819130323.GU20404@szeder.dev>
 <5611dad6-94fe-e4e1-c06d-7dd0642be3ae@gmail.com>
 <20190819150245.GV20404@szeder.dev>
 <6a576e13-79e6-43be-c4a8-065e7a8310ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a576e13-79e6-43be-c4a8-065e7a8310ea@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 12:12:32PM -0400, Derrick Stolee wrote:
> On 8/19/2019 11:02 AM, SZEDER Gábor wrote:
> > On Mon, Aug 19, 2019 at 10:50:48AM -0400, Derrick Stolee wrote:
> >> Note that I don't include the "without patch" numbers. For some
> >> reason the path provided is particularly nasty and caused 20,000+
> >> missing blobs to be downloaded one-by-one (remember: VFS for Git
> >> has many partial-clone-like behaviors). I canceled my test after 55
> >> minutes. I'll dig in more to see what is going on, since only 37
> >> commits actually change that path.
> > 
> > Don't bother digging into it, I know why it happens (and how to avoid
> > it! :), but don't have the time right now to explain.
> 
> Great!  I look forward to your explanation and fix later.
> 
> Just to be sure we've got the same issue, here is a section of the
> call stack in the hot portion:
> 
> line_log_filter
> + queue_diffs
>   + diffcore_std
>     + diffcore_rename
>       + diff_populate_filespec

Hmm, interesting.  Certainly most of the time is wasted in
queue_diffs(), but in my perf measurements diff_tree_oid() is
responsible for most of that, not diffcore_std().  This might still be
the same issue, though, but perhaps VFS for Git shifts the balance.

We'll see, here are my patches to address that diff_tree_oid()
slowness:

https://public-inbox.org/git/20190821110424.18184-1-szeder.dev@gmail.com/T/

