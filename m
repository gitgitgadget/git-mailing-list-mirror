Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E0C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 07:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiBJHMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:12:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiBJHMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 02:12:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8BED6D
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 23:12:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i6so6757348pfc.9
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 23:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=JvRb+yUuIAJkikvHSQBDuOwZ79mn3R+Wr9Bds3XTJzs=;
        b=DxC20LWXYmco1QPkLAxAEgGodxP9a632DBpVOdI88TH4ElJ6fvKx4RrP0lbP3zsATA
         JVJHazslP/xkKkGzpe7v5vaf9eD+S4lGqBF+EbvatT7Jx9g6/uOQ9LVXu61M/Nj/CS/q
         Q9hZRDvyLDENhxgGCCZ5SJothJr6A0WxhA56cpaqERtPBuubIwvgZL/t0GPvhnJVdCvi
         syHt9aK4Vs/iK8P3V8Z5mVxLGifIaZUer1+FNnTJQoHCNnpYC+RAQbKR1cNWKEztNYEI
         9vgtJUw84rSPvPK2d9D4IQBRPRP8q/7+qYRDHDrH4LFQYgraG9nCeyR32kWDX6Fzw4ZD
         lmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=JvRb+yUuIAJkikvHSQBDuOwZ79mn3R+Wr9Bds3XTJzs=;
        b=GPOJM7l2qhlS1fto8w7KBBuFA1i6Ghk13eQNfQkNcTLy7GXnn97Nl7TxwQ7D61K0gY
         KWBzuCgaT3XTX5eYFo5e/EQ+TOvBsq5YLbxJRbg60tkptbESeYHD/8mAJEKnOkKoKOiB
         MRXqqIHbDAmSWH9t9W0Yy7yScRVM3jMGm4PnxvnFnVIGBwt1tcb8VvsYG+wwC00PXzfq
         1B3QTrnGcqPsGTjfME9+LLEHeC660ulZBDPDkekRNdYvMm1okM3QhIHiRk/Vjqdp4Vpt
         +dqKVzU04Y5FKGW02LGgtwgJultXxcRQPim5VBkU5rLneeIWdLC9XVveB+O/1lvUoKqN
         lFKQ==
X-Gm-Message-State: AOAM532iuXkwN8VtYraOU5Bcat2ewaW62G1/EeO3oa8D3e0pSjjYbpSR
        8nWVSwgM0VziIVS+kf6ye2g=
X-Google-Smtp-Source: ABdhPJwYrF98CPDgu+uWhipRdsek08Cx6CnoG2EwTV4adj2fqeFjXFVyCqJ7s2y0RfFkmyn8a+RyLg==
X-Received: by 2002:a63:8543:: with SMTP id u64mr5209695pgd.600.1644477121031;
        Wed, 09 Feb 2022 23:12:01 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id d10sm21908564pfl.16.2022.02.09.23.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 23:12:00 -0800 (PST)
Message-ID: <bc36eab7-62ae-2e67-aa4f-cceec5c86012@gmail.com>
Date:   Thu, 10 Feb 2022 12:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
 <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
 <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com> <xmqqleyjxzs4.fsf@gitster.g>
 <c64e52e1-3916-dc7a-60d7-98c324814f0e@gmail.com> <xmqq4k57xlot.fsf@gitster.g>
In-Reply-To: <xmqq4k57xlot.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick response.

> > I have a few more questions regarding contributions.
> > I have seen that some command documentations lack consistent synopsis compared to other commands.
> > Is it on purpose or are improvements to those documentations welcome ?
> 
> That's hard to answer, as what you perceive as "lack consistent" may
> or may not be consistent from other people's perspective, without a
> concrete "here is the comparison I am talking about, and this makes
> the two comparable" patch.


Here is an example. The synopsis of command `send-email` vs synopsis of `commit`:

```
git send-email [<options>] <file|directory>…​
git send-email [<options>] <format-patch options>
git send-email --dump-aliases
```

```
git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
	   [(--trailer <token>[(=|:)<value>])…​] [-S[<keyid>]]
	   [--] [<pathspec>…​]
```

The `commit` synopsis has a more verbose overview of all the options available compared to `send-email` synopsis.
