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
	by dcvr.yhbt.net (Postfix) with ESMTP id 65FC71F4B7
	for <e@80x24.org>; Wed, 21 Aug 2019 22:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfHUWPK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:15:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54831 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbfHUWPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:15:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so3631809wme.4
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TIGevHE34TZIFeveRNO45CLGfwIoL3IeAv7+SCzhTE=;
        b=n0DDW15LtEW5NvRIE6dtL2MLBpVZM3F3SSUxDIzlXcD67mvzyyHqv1KI9tDilHmiZX
         eOtJJAfQ2xjWAQjchVb8RdGsVlVK3TpbmDP3hHfTphYYVezDHZG+yLeqsYZ0iw+aSKhO
         p2XdqSReWeTEGq1qv0st0PeMe4TWpHY6j0o8/MTepXBIqDGMiigmR/qpn750klzQo10F
         8nDAQFl0JnRh4zxxD0E806az5QgzyjuAkJTpMLXmxT2L8Thgc7WNfcLgCoIosdppfWUX
         L4URnCFMHIbUrJCPwh9H/P62YuHedU8xJC7+3U/G6dfKnLVEm+qMMrhxdhkVj5A1dFac
         i+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TIGevHE34TZIFeveRNO45CLGfwIoL3IeAv7+SCzhTE=;
        b=WqWBVcC11ugLKDMNY8hx3ESKbJNqw2qXHItIXCS0eJkcMavV/4+Qv/jo2p9TPcJqIl
         4AKdqzQepjcXZQ/qmOOAoL22abay+zmWHYvV+/RqpAspodqcP+9b7E+KkR0Zzq1Avk6+
         xSyAnxlIlgUHFufh5bv37LydkBZh/4AsZu+/qaOaOErGx0hrHmVfngWrLAW84JIafGZu
         IOtLDAfnrLzsaC5unG50H5zA1kC+fffZZKtqFIz+O62PGrn0LP6i9tf7ynOsp29uJRX8
         07CYdez25bnZDy6kiNHTMci8/EpwMH0YAMcWH5gK4AFu8nvQD9hJu7lcnBRSKNLkEkh5
         H9mw==
X-Gm-Message-State: APjAAAWD9aJ1Ayuxr6zixjWrZxg1bB5klVV6Hg3DzD8Z0SYH6vf+F8FG
        HgD2ck9aa/5LmfpH929nESw=
X-Google-Smtp-Source: APXvYqygKMssB6uf6X0wlo1sW8TIq6ZEyip/+OG+XiwUgCC9eLI/jpdevFRzIt00gq/8xAUYt4dXDg==
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr2172542wmb.86.1566425707953;
        Wed, 21 Aug 2019 15:15:07 -0700 (PDT)
Received: from szeder.dev (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id t198sm2969673wmt.39.2019.08.21.15.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 15:15:07 -0700 (PDT)
Date:   Thu, 22 Aug 2019 00:15:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] Revert "switch: no worktree status unless real
 branch switch happens"
Message-ID: <20190821221504.GA20404@szeder.dev>
References: <pull.317.git.gitgitgadget@gmail.com>
 <538420ffd575f1705e9fb764f9d86e5d4d7f25ad.1566415112.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <538420ffd575f1705e9fb764f9d86e5d4d7f25ad.1566415112.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 12:18:33PM -0700, Derrick Stolee via GitGitGadget wrote:
> This reverts commit 65f099b3988198f0fdf3ef7a21dc01c556d21fff, which
> removed logic for avoiding extra cost in "git checkout -b" in favor
> of the new "git switch -c". This will cause a performance issue for
> users in large repos.

It always makes me sad when I see a pull request, where all the
relevant information is only included in the PR, which will not be
part of the history, but not in the commit messages...


>  builtin/.checkout.c.swp           | Bin 0 -> 77824 bytes

> diff --git a/builtin/.checkout.c.swp b/builtin/.checkout.c.swp
> new file mode 100644
> index 0000000000000000000000000000000000000000..f6dad4abb02c265ee66b3f6f76d00d59b9b524a4
> GIT binary patch
> literal 77824
> zcmeIb37F(pRrf#a46<X03c_z1GgCe3>dYjdA(>2=r6*}KnI2}zLK2GV?&_Y(bXPT1
> z)icux34uRC00rR{;pJ5jL_ico7FiV85d;D8CG1O3By6%HioE<k-*fK$ZB^AXi9sKq

Uh-oh.

