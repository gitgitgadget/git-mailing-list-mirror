Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E977F1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 16:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeHDSVO (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 14:21:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeHDSVO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 14:21:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so8245245wrr.4
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SX7LNH5JQn8a45nlq4Phi4aYjoJWkDPGGDJcB3yf31A=;
        b=jsxSYGY9xkX1DkLyHpPtmq8n9VBpM8CJXlyQeNvaHtq9FJuy0eXu/mGoeVbmfZBG25
         l2TtjCSCjgLdYrOFGvazUqGVkY+3rg021/nPBLQkW9P596MMYzeuXMlN3J91f6+PYEZe
         8O5yjovswG/USp5e/6qvJ8laC9QgMi8jv0O07YntEr6/g1YB9AnnWOxCV0R0jbBXhUhb
         6TPavEml6g5CYCEE4ojvAfzJMYsbsC3O8QTzYOGvoOal+62vmRIisn4Rwfg665mjrDHM
         XcftSFXiX12v2VpJoDx53/Ow1J/X+f5Qj5hkijowEzFMFyx2QL2BEdpOmElha4g1dEiX
         gLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SX7LNH5JQn8a45nlq4Phi4aYjoJWkDPGGDJcB3yf31A=;
        b=EdZOz8dKT+p2+w32pfof+EVF9NYXQP6lEjC12tfaYvjP4Kq3N1EVpSh4MNnU3QNN6s
         Gv7DpTAVyRR0blZIldFThn2RMb799gQCQkCzUjKvf7TcddF+Y7IX1i09X83WZkU7x3p1
         bBudx0luShGbJHpAwBVKcsoGhnp3gLWK3MMSD56XAWh1IO9MvxmhqPOxbtPWjw0NAuwu
         tklAb54NLJeJ9+Riyunjcc8B6wSK2uXjqtkBBZA888J/4lL9+Tr0Ksskjgnhbk5Uast7
         Nc9C6fTGRxgaljmWQnWi8u2UW2DgP+YhFqPKd8LTHhmf32+foduiXeOXiTR/Y1Lu23q5
         hWrw==
X-Gm-Message-State: AOUpUlGyHWarddKzSyCmRu/u7SAEkbTt0FxzqFDph29DiAagpkdW7azT
        f7NFP73/BOBu/QuScHkMeze27Q==
X-Google-Smtp-Source: AAOMgpd0328jo1l3sol4Fy29LVkPQ2eCiTuFMEysa7wKebflllyUk83fPhvzQNvEQXa4PKqnVc0Vrg==
X-Received: by 2002:a5d:458b:: with SMTP id p11-v6mr5382982wrq.122.1533399602537;
        Sat, 04 Aug 2018 09:20:02 -0700 (PDT)
Received: from 1032a7a09014 (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id f8-v6sm8573242wrj.9.2018.08.04.09.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 09:20:01 -0700 (PDT)
Date:   Sat, 4 Aug 2018 16:19:56 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] recover: restoration of deleted worktree files
Message-ID: <20180804161956.GA6@1032a7a09014>
References: <20180804142247.GA7@e3c0ce5ceb57>
 <20180804142416.GA6@5f28dc333bbd>
 <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 04, 2018 at 08:54:49AM -0700, Junio C Hamano wrote:
> 
> My first reaction was to say that I am not going to take a new
> command written only for bash with full bashism, even if it came
> with docs, tests nor Makefile integration, for Git itself.  Then I
> reconsidered, as not everything related to Git is git-core, and all
> of the above traits are sign of this patch _not_ meant for git-core.

Yes, obviously I was not suggesting that this would be mergeable with
the bashims, as I mentioned in my cover letter.

In any case, it sounds like you're not particularly interested in
this, although I certainly appreciate you taking the time to suggest
improvements despite that.  There's some good feedback there.

Cheers-
-ed
