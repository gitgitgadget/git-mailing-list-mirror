Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C5B20248
	for <e@80x24.org>; Fri, 22 Mar 2019 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfCVLE2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 07:04:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54358 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVLE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 07:04:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so1715354wmj.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+EWAEicMX/nEhFWx5zilvgkrtmMrVY6Hx1aQS/ihZ0=;
        b=Tw6wH/QlPkz3F6w1wvTlzgxIGYlc0nk+RQfKcfCLW3+1DYhX55JM611omis/9ePtA4
         wjLTChOZZ2VqgzCcMaAwvDzBm+W7hCYXlA9T6vySrUyaQMWJJDWoDws4YmSFz+SB06y9
         nLxKHEiTydhH0lC1A6VSFjxgjWMdEMs/RzSUSWrx8UWySlpGeaHNq0quR5F0aKTFMx7N
         EMk0MUq2QbbeVT9s0Wvl0KbmTuaMrE9FYpxPsHT8I72OGODA5+LvjjFMFMymGtMfJJ3r
         ADgceNtJNznONXMGsANHeLzAN0O3/GJhWoU5paxkml27NaDbxQLktWzakMRdCCrbrzMy
         vMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+EWAEicMX/nEhFWx5zilvgkrtmMrVY6Hx1aQS/ihZ0=;
        b=nHh2kbIObWgPTcmF6FyJ3ADnGW9yVO8AWB6LiI/kifRDw9n8CvIs9456p0gLtbiNjQ
         pOBFHioxBKXyXE1nd7FBa/2i/2I1Gn3pKHiKvSPOO0+lIkRI2h29txdgNXT6qCwVAHrb
         r0zCnbHKeRs2w78CkUfoUYPpu6CWWdKxHzA/92aG81M15qwDNw9YpMhvrMWp01emFxLf
         3JGRrd30Qrgru7d+Zo/SVnYKaKO2rO/ZKS/ygiqf60RYivVvWXfMz5j0H+A7tajNprEC
         kVIPWOMexieEj66wOE6pTBaNWiV0vwj5LEU9iyCb9YQMQIejCQ2a3YoZkKlhAaWG/S5s
         vapA==
X-Gm-Message-State: APjAAAV1B92moHO/Yr52abtjVVckK88+eJnDp2ntP1VO3DocskAy0XTg
        6AjPGrcHLLHHMIzi6d5B6YA=
X-Google-Smtp-Source: APXvYqwrYBrkIrdgRkXz1gZjDQW29/yQARwT03ximjt4VfzgolJGhW/iLYEN3YcqKNK4OH7/vtZpjg==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr2482113wmb.20.1553252666077;
        Fri, 22 Mar 2019 04:04:26 -0700 (PDT)
Received: from szeder.dev (x4db501f9.dyn.telefonica.de. [77.181.1.249])
        by smtp.gmail.com with ESMTPSA id a9sm8905515wmb.30.2019.03.22.04.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 04:04:25 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:04:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] fsmonitor: force a refresh after the index was
 discarded
Message-ID: <20190322110422.GB22459@szeder.dev>
References: <pull.165.git.gitgitgadget@gmail.com>
 <pull.165.v2.git.gitgitgadget@gmail.com>
 <79fdd0d586e9086b68af1b68dc5e194a566d2240.1553176651.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79fdd0d586e9086b68af1b68dc5e194a566d2240.1553176651.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 06:57:34AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> With this change, the `index_state` struct becomes the new home for the
> flag that says whether the fsmonitor hook has been run, i.e. it is now
> per-index.
> 
> It also gets re-set when the index is discarded, fixing the bug where
> fsmonitor-enabled Git would miss updates under certain circumstances.

Under what circumstances would a fsmonitor-enabled Git miss updates?

