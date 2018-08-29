Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AE31F404
	for <e@80x24.org>; Wed, 29 Aug 2018 09:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeH2Nda (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 09:33:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45982 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeH2Nda (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 09:33:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so3417848eda.12
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qs2OhsC0H4tKPuqjDECWyKB9Wfo5ClGv8lR0PvikY90=;
        b=J8B5BA3b8oL7rjvtWLUsf6ScfGxUzAcxvGxMZcWCdRHfEE11PsKcvBC8tj0uLz7uVl
         p4tSeF1QAlE2AhNBJT9hKr0ubFRzdkMna+b+vpJxJoLQJpbA00qvO2Qqh2+EOIAQ+5uj
         0vdXkYGIrDy0/s70bz8X4OlyUdCP2RJF2MQ7MR9p05A1mZaSnBlV8FY+szWvBdtg+9jD
         76Q5u3Nnw04lL1cL6EAiY6cY12MlmrbHOaNOY6m1j644H5lLi9jFTj3neT3LIJIT1s3H
         evKaZGB80G7HqS3V+d95KTqbED7uuYLCwQ7ya8PVhEUK9d17/mrrpDDPtEpwZRwFw4d2
         slDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qs2OhsC0H4tKPuqjDECWyKB9Wfo5ClGv8lR0PvikY90=;
        b=mDSNXMVyIY32ZJ95M3RlqUpsVIJSI75wrT6ePyKZ8OwV+svauBZhEtnfbtjsEZPhuC
         2xBI4LrlXE34gaQ7lmk3EkpfdacA/sIpBd85KkSahZcVdamEaBscWl+5nVH8PXXkC57C
         PPTQlfmxUeT7Q3uU868VpgtlDcwNJ6ltdjqLEFD5PB6142XMr2Wi7eb4APpmhm7mQz/U
         ZZlHhME7I+rTB+srg/QnPLR/rY/6rb9WJ2NkIz+lgonwPUDquWg99Lil8yqZ2KzBm8bN
         2F/FZX9F2QOGrNSDZr5gNVaiTVdAE/aTqQB2bk5TJytyHSRNo1YBIQmBgss5s49/qL0i
         MqdQ==
X-Gm-Message-State: APzg51AsOGymnq9vLEWZ5LR1DQL5BVXTKsf89h4hJSlz/BTeuq5M/nmn
        eA/c/TLYryjDBoBlKKezugD1qI/rjnY=
X-Google-Smtp-Source: ANB0VdbtC0963Qva7KHOKSkx+jK+bCr81DFrnIcg31Fl8WJCTnMwO199GGdAYxLbuQNiYv1mTYsNSA==
X-Received: by 2002:a50:8466:: with SMTP id 93-v6mr6823956edp.304.1535535447132;
        Wed, 29 Aug 2018 02:37:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1487012edo.39.2018.08.29.02.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 02:37:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] Base SHA-256 algorithm implementation
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180829005857.980820-1-sandals@crustytoothpaste.net>
Date:   Wed, 29 Aug 2018 11:37:25 +0200
Message-ID: <874lfdecoa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 29 2018, brian m. carlson wrote:

> If libgit2 would like to import this SHA-256 implementation, they're
> welcome to do so under their normal license terms.  If not, that's fine,
> too.

For them and anyone else interested in such re-use, can you elaborate on
which parts?

It seems to me that aside from t/helper/test-hash-speed.c and
t/t0014-hash.sh everything being added here modifies existing files with
many authors, and would thus also need their permission to re-license as
anything except GPLv2.

Or do you mean whatever fixes/changes you did to libtomcrypt (living in
sha256/block/ in this series) you consider e.g. LPGL instead of GPL?
