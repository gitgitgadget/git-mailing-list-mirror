Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01D21FAA8
	for <e@80x24.org>; Mon, 15 May 2017 09:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760425AbdEOJJZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 05:09:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35363 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760302AbdEOJJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 05:09:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so15070071pfd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sz8rfnfzPb1ay0nx+G/ol0goKINbTiL3GXWCwCd/9WQ=;
        b=BZzNca9gqO+yNXxv81idTrudKH69MaHw2/59psKPs/lqlrALKKpe3SZf9piAmwnmCg
         /tHW8stpRQqemVQXys1mQyn6txrwTvdgFkMpSGMF74iNXuzM5oJbVlW4yLhUfu/w5Kv9
         Qwf7ZQWHtKZuYjp4rzDcAszVitaQ+l7wFmGbYwCQqSrf05vEUCYmVvxjFz9oS3VeCYwi
         2yauD54HLNSpMDgtDKF3hCP5DXFFoCQeMjqxJDb65wDj0RQQN4m/QrTum0oj6ATwG/RD
         faEBLb5CCc15lkAmLgLqOaromAjIi0/PSp0zohWUgVGKwYtJTsIMLEF8VH89EsdVwtLO
         OhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sz8rfnfzPb1ay0nx+G/ol0goKINbTiL3GXWCwCd/9WQ=;
        b=gtaSjh0EbhF6GbMrw/SFFZq1qDGE37cTytyIacL5ph0rig9XTe+hKznCbRTYcy+zL/
         Xynu0hBeBwuN1Av+TZJz0N1rjTuuUolhRIjGROzfsHMJEy6iJ40aQytIDQZ4F81MNooY
         thBLE83u0GqXklWefRjBuFFzkGQF1PA6Vz3nf5bFkzP6hd77aeS5K5GHNEaU/Gqre2j8
         XS7JQp0g6xLhlIKu666D+2Q/I4jmxx20/6KXj9fF/J0MUBYy/lM1NUcvJSt3W9+Qbg7/
         4ztty2M1fFo0EtthZrtd8fQKK4QJLlZFh59Zqv5elADmYRrn5obKaNM1WGeRbpcKVd++
         xYJg==
X-Gm-Message-State: AODbwcBr7kNP2cK25EuIuZekzqGW1b5L4HoWa+4aa2Cr0gsHLient7eQ
        BRfPJt02QHDmAQ==
X-Received: by 10.84.218.71 with SMTP id f7mr7017208plm.135.1494839353316;
        Mon, 15 May 2017 02:09:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id k86sm2128499pfk.125.2017.05.15.02.09.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 02:09:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/29] Easy to review grep & pre-PCRE changes
References: <20170513231509.7834-1-avarab@gmail.com>
Date:   Mon, 15 May 2017 18:09:11 +0900
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 13 May 2017 23:14:40 +0000")
Message-ID: <xmqqbmquv64o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Except for a few nits and huh?s, I found this round quite a pleasant
read in general.  Thanks.
