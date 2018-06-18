Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808F81F403
	for <e@80x24.org>; Mon, 18 Jun 2018 18:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935548AbeFRSFU (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:05:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42366 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935531AbeFRSFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:05:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so7885422pgu.9
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rt1OT35ERXd2flazAxjnUbexA69zy6pPmhZEYnCwSAk=;
        b=P8smUmZp96Hfvx8w4TS8e91olB5kYKrOMTPe9IFiEKTVJYO1F0oAxuTBUmpRctMf4Z
         8WHB8AWr8bvRJP3uJLDGUNHJ6Vv3jNnFvKMdnYSN5GyZ/Y+EA7TR41yp1jvaqIlc4Txs
         GklPBoKSZwAmaDEZ0bksjUkEvPag70sxtQQ0Ic7vgjG/OQ9pLVskyZABl9LKWbTBrjGD
         2Fll2NH1E1E5D1s1ptemnYLs5gV9pMUH+kNLm65xEPGDwViBHkrDvjRLQswOaFKBP8DL
         TAO9Ne2B+/E4Ucbx0K3aAnqOQMduyKuO/KbqZPlQq76mTerl/jxNpE/7VjY/xEm7kFUQ
         juBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rt1OT35ERXd2flazAxjnUbexA69zy6pPmhZEYnCwSAk=;
        b=HYjL/1UrVot49kjnWVtsuCIqbi0f3qUc6SQ3d/0kL2x00K7Gxb03digj7a3bLDDeAz
         /nmT3rLuVsHL40BQnroyvkEGggo0VhVc8GdPUz6TQl5q5CyvFPu44ND82Qu4uRnwmpCj
         MOQoyX2QX6xpMfOci/ShOOwJ7gvjaSWCjwhNI20V6MgLffTPC5Jl94yYPBkj8muEkLFZ
         zZHe0Am2QCSIEW6ycyiQNTVHzIaGk5m2rM9JGE4ZnekMWJ9BJyUKL7QQKL/pA/bDYAcE
         ZdfgD4b+5WVK4n2fQqbDV55V0YS3+OwWkFszKOR+iQjSgVFOJHAZv+wO8JwCPTXFyY7a
         W07Q==
X-Gm-Message-State: APt69E2IAnzbPS4uuD5lyquXVx3X2mBN6LMZgzwj3Rtavb0WeMsJkMWE
        r8ha2Ba2Buy6ksYKa16Tj1FJ5/8Wu5c=
X-Google-Smtp-Source: ADUXVKJXiZPnK1smNPTWhSFfm/eJ+s0Xw50l2fy/bzpKjsE/7Sh+afzb8ilIfNutLuk/q7SYA69ZMg==
X-Received: by 2002:a62:3f4f:: with SMTP id m76-v6mr14623808pfa.109.1529345118890;
        Mon, 18 Jun 2018 11:05:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p1-v6sm23291861pfh.58.2018.06.18.11.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:05:17 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:05:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 0/8] ref-in-want
Message-ID: <20180618180516.GA73085@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <xmqqwouzycey.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwouzycey.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Changes in v2:
> > * issuing a want-ref line to a ref which doesn't exist is just ignored.
> > * fixed some typos 
> 
> Do I lock some (logical) prerequisite changes?  On 2.18-rc2 they
> apply cleanly but the series fails its own test.

No this is an error I made in this version of the series which another
reviewer pointed out, I have a local v3 which addresses this (by
removing the test since it isn't necessary anymore).  Sorry for the
mistake :)

> 
> t5703-upload-pack-ref-in-want.sh
> expecting success:
>         test-pkt-line pack >in <<-EOF &&
>         command=fetch
>         0001
>         no-progress
>         want-ref refs/heads/non-existent
>         done
>         0000
>         EOF
> 
>         test_must_fail git serve --stateless-rpc 2>out <in &&
>         grep "unknown ref" out
> 
> test_must_fail: command succeeded: git serve --stateless-rpc
> not ok 3 - invalid want-ref line

-- 
Brandon Williams
