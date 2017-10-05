Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127C51FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdJEVQs (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:16:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38798 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdJEVQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:16:47 -0400
Received: by mail-pg0-f66.google.com with SMTP id j3so912170pga.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MIW9pegJeq0jDBaCgpFFSKpUIySl6pg5p/vuIdGHZU=;
        b=tGlIxoNbALS+R9y9whwP4ZoVGNJRUagRkVBh1weiim3wl1mCKK1UModIb46xtGkqtu
         BJ9TeqZrwLRuYGp/utL3ZyQUkciSLuwz995mpNT4R14gpGU4h+sPkYeYbzIBT00UtCv7
         ZG8D1wn7nJHRpo18Mr4+RB2p9Q7Ji07lGIZG9hh2PNIH6bEDk+NNMoL8/GpWqsnAHs5O
         tCKCj2fNaqarSIfcVp7wRWY9BQiQwCjMTD/qfZ0D3gJThaZAtgCXDaD0OxlqsR80VLlk
         Z68w2NkimTUtL1WOkn5KZ/qpVmxxFivlwo0jcqInS38jIljKnQPQReEVv6rrx67L1B3N
         QDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MIW9pegJeq0jDBaCgpFFSKpUIySl6pg5p/vuIdGHZU=;
        b=c5TvU+HNFYODrwJZGFM5EEOIEMvzIiKFIlXg4UnZzNoFWy6ToGh7o6EAG8cvqWHIff
         Oo0RLPNKxqYPNvfX8T+RLNuvKjxHu4x+VgYoADvhJulyD+mLTD7YJA0LuzngYlARsfo0
         4xOvaVSTxY8hM0/HF9jRCHbjnJrYWZH3RQDLf9mUQi7dxUOPwts5RtikeN/vn7fcnaNz
         szZ/UEzt8NGl2FlfgTdv1UAuPzttaDkehzj1ftNdoNx8c+ZYrmirHLKg/SkN+9k7KHiO
         mrUij8enC6PB8yo/2enHImsCi85JT/LsQ+gL1s0Ur6leb+E8efFwPYBqyS2PSC/MC03R
         sQEQ==
X-Gm-Message-State: AMCzsaUrpu3w3OxUF2bvbkzx9fJV2nbjjxRSC2d9wopeiEW7dzMl/Wl/
        AiVC64YyaF7uyPx+4dz5FV7zYj/i
X-Google-Smtp-Source: AOwi7QBSujMCUO4ureFTOrNISGLzhSGufffPbDFnwaeRqCGPI6XBrSGHfSHaKH69xFT9lI12/kvOtw==
X-Received: by 10.98.34.130 with SMTP id p2mr42160pfj.108.1507238206738;
        Thu, 05 Oct 2017 14:16:46 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:960:8965:26b6:313])
        by smtp.gmail.com with ESMTPSA id r9sm14063770pfd.6.2017.10.05.14.16.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 14:16:45 -0700 (PDT)
Date:   Thu, 5 Oct 2017 14:16:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     jameson.miller81@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        bmwill@google.com, sbeller@google.com,
        Jameson Miller <jamill@microsoft.com>
Subject: Re: [PATCH 0/6] Teach Status options around showing ignored files
Message-ID: <20171005211643.GC88769@aiede.mtv.corp.google.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

jameson.miller81@gmail.com wrote:

> This patch series is the second part of [1], which was split into 2
> parts. The first part, added an optimization in the directory listing
> logic to not scan the contents of ignored directories and was merged
> to master with commit 5aaa7fd3. This patch series includes the second
> part to expose additional arguments to the --ignored option on the
> status command.

Thanks.

> This patch series teaches the status command more options to control
> which ignored files are reported independently of the which untracked
[...]
> Our application (Visual Studio) has a specific set of requirements
> about how it wants untracked / ignored files reported by git status.
[...]
> The reason for controlling these behaviors separately is that there
> can be a significant performance impact to scanning the contents of
[....]
> As a more concrete example, on Windows, Visual Studio creates a bin/
> and obj/ directory inside of the project where it writes all .obj and
[...]

I see this information is also in patch 1/6.  That's a very good
thing, since that makes performance numbers involved more concrete
about which patch brings them about and it becomes part of permanent
history that way --- thanks.

But it took me a while to notice, and before then, I was trying to
read through the cover letter to get an overview of which patches I am
supposed to look at.  For next time, could the cover letter say
something like "See patches 1 and 2 for more details about the
motivation" instead of repeating the commit message content?  That
would save reviewers some time.

Thanks,
Jonathan
