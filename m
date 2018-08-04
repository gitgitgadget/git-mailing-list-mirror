Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1991F597
	for <e@80x24.org>; Sat,  4 Aug 2018 07:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHDJDu (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 05:03:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36674 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDJDt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 05:03:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id h12-v6so3871063pgs.3
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XNqoYZ1oV1qtVMkyBJzs1OymDDWNnF4LIvhLe/5unZ4=;
        b=czNymfi/zEPpV14TB2bj/gbi05L12kQs7/lOP8zce5YuMK+WDlx36kZYAw2MVWR3By
         ap8jcK5WCjfiCfqDsiEUjAvojztdsY7Bw4Ihtm+fUtC83mm7fYLTQMP2g3zEgTazzCf9
         xCRz5AOPAUPLRLWuwsNN9Qb/WyTOehXYw+/OwUQArr6ZreZbxjhygB4Ugz4+xjPMjhTu
         x1TT9Ae60zrhunkgrchx7GbyMZpSOm0btjbtm7UdJupHzjM3fyDdU5cQlz2htO40lk9K
         BFaGs/Gog3TTDyxrZGI5FammlcplVt78m4mJ4V2lKUOqSax2STXQkxlbW5dGlLDX+T4U
         SN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XNqoYZ1oV1qtVMkyBJzs1OymDDWNnF4LIvhLe/5unZ4=;
        b=ooKv2iqPglVUFgwlLUzLiIo74lMXLrGMibm8oBTcHZjYw85as968MCUHXlqWMYtA0D
         nPb4RpMLed+JDUvM0+mR1KlUhK+jvj0gHvTn04HRg1xsjaw0oQN3vGrIE6tyRzTt+cd/
         4PaWDV8lS4Ch18I8DZ8/dgI56ob8zKHYlWiAhCFTSmQrUeNuWJdLjoIATPtg61oCrVQR
         QleBr4FxfjBzU1YL5Lpmtaev+RK2VcjhZi/yEVS0TB+11//9pGa/wVj1Xxq4uQymxnz2
         CQzbYwGwdSwMNQa5E/DdrX74VuBbS12vL8rKShN+kdbuI7ZNFjnrl3rByPmr+/tNpMhx
         tllw==
X-Gm-Message-State: AOUpUlGwaQ0JkkAoOA/WuE5PapvIymkWio/TfLy5Q4gOBrnRhsgaaNNH
        YKbQ5CV1Fwatj74Zzx7TolMQ8f2B
X-Google-Smtp-Source: AAOMgpcy4SxuQq8nT2qUaAam/MYkoFaEKZA/hJNrqGLexNB0pu59DCRyyW12z+XyWvalKK0kjfGL2g==
X-Received: by 2002:a62:dec1:: with SMTP id h184-v6mr1322228pfg.197.1533366252064;
        Sat, 04 Aug 2018 00:04:12 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n24-v6sm10164330pfi.161.2018.08.04.00.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 00:04:11 -0700 (PDT)
Date:   Sat, 4 Aug 2018 00:04:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: document about thread synchronization
Message-ID: <20180804070410.GD55869@aiede.svl.corp.google.com>
References: <20180729153605.27298-1-pclouds@gmail.com>
 <20180802193518.GA29084@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802193518.GA29084@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sun, Jul 29, 2018 at 05:36:05PM +0200, Nguyễn Thái Ngọc Duy wrote:

>> These extra comments should be make it easier to understand how to use
>> locks in pack-objects delta search code. For reference, see
>>
>> 8ecce684a3 (basic threaded delta search - 2007-09-06)
>> 384b32c09b (pack-objects: fix threaded load balancing - 2007-12-08)
>> 50f22ada52 (threaded pack-objects: Use condition... - 2007-12-16)
>
> Thanks, I think this is an improvement.

Yes,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
as well.

Usually I would prefer to see comments about what lock protects some
state where the state is defined, but here the state is normally not
protected by any lock, since Git is single-threaded except in limited
places (like pack-objects).  So the documentation you added is in the
right place today, even though it's an unusual place.

Longer term, if we start using more multithreading in Git, we'll have
to reconsider how to structure the locking anyway.

Thanks,
Jonathan
