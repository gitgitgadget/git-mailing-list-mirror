Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B3321841
	for <e@80x24.org>; Tue,  1 May 2018 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeEAKBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 06:01:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45549 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEAKBS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 06:01:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id y14-v6so15319572lfy.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iq93ker7rF/uY285xqOhn7A3bYXMVzhPjNqdjRI1uT8=;
        b=pTK4shBOxNEby/YwVd5VNelLR/D3X9Oe3IPw6Epu35Ay5SeurLrvpSBtLudHu8euX8
         2rRjbu4nuv/QV6rVeKAbgw8sFV3RrJg3B9YI9laB/8lK7ZRHv5JAmLRRfYPsim3Vtp+1
         6yDJN6FoN8cXEnI/i6kd/829KUQuII6IUzfi08RiYPl87Cn0x9DP7bpClHjCClWe2QwP
         7+c2PydOipt2zVS5XzkRd86/calASzf86H+YjPB0q0qatlYAAmk9ulmeurhOaO8wQMBt
         ntsEmTt5vw3ezrUn+tp8FXRlTkipkYsRtmJa9ZR/RdUQSCv+VT2sLszKkIpEKZzBTLnG
         42Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iq93ker7rF/uY285xqOhn7A3bYXMVzhPjNqdjRI1uT8=;
        b=h4E9BZxmiNlp7KllXkfnypPuZSIJ0Lfy24OSxBORDIoTfeO8/z9qrrUry7Xc9QeaHa
         Da8e92olDYLBld6bPD6TCC9EPaJeoQM9jMeRrJsVgA5mTZ79Z1fWGWdz3uv1r4TksU8z
         xoIIp+/lXCqnyHd2OAt9LTSDD/Z+LOsPKgj2hSmWgHl3cmkxACuK/kB87q9obwypq6lr
         dYD+k5Oxfw7eYLU56R1tARWnfz9piAq9KimcGvmT4Rwf7MMgXaow4nZhfd4TeVHG5or6
         tsvKPsxJ01wDhWtLhMwE7nvx/rUylz+6iq2CWWXtdAm6eusxx2qpEEczFhx126mBo/Xq
         W/PQ==
X-Gm-Message-State: ALQs6tBB70KzhvEmHTUhCvwgff8CtcTHwJBgwdyLwnldR3+6pV/v0web
        3gJURiOtJ4fT5aZMI/N+kBg=
X-Google-Smtp-Source: AB8JxZpk7Dk1VCZQKKBH6y3a5pBH0zsqhpto5gZGBunM6edp8eTJp8effHquqsvvv6jRigl3wqlYMQ==
X-Received: by 2002:a19:964b:: with SMTP id y72-v6mr1773934lfd.96.1525168877494;
        Tue, 01 May 2018 03:01:17 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r137-v6sm1945587lfr.17.2018.05.01.03.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 03:01:16 -0700 (PDT)
Date:   Tue, 1 May 2018 12:01:14 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/41] packfile: remove unused member from struct
 pack_entry
Message-ID: <20180501100114.GD15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-5-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-5-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:14PM +0000, brian m. carlson wrote:
> The sha1 member in struct pack_entry is unused except for one instance
> in which we store a value in it.  Since nobody ever reads this value,
> don't bother to compute it and remove the member from struct pack_entry.

Never used since its introduction in 1f688557c0 ([PATCH] Teach
read_sha1_file() and friends about packed git object store. -
2005-06-27). Good riddance.
--
Duy
