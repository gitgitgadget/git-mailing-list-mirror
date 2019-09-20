Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8821F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfITRmT (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:42:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35045 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfITRmT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:42:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so3088787wmi.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z/6NuGUOZMUgAZDyXSpkHI6qsHpxWrMVwiGF9YPcfdw=;
        b=gIBj9eqkzzMV8Zr7x677UC+1Bqf19w7cIqVvuOg1lvuUmvOUjDznY/0HvOtJW1efe9
         alrj42ZHmpo6sxMfB1HTt/dT3R1nPi4ZW8D+DzGB8I8DnhkliT/Bek0J4GIO9uCPedzk
         pI3MbVY4e5aqhGNAvB2Jn2KFe4jE01FExtpDSiggH+gBMxjFFtSI4EqEYJy7wxM2q80U
         5SlISq+YLpIut/OmZxbCb1h2eCb1OVBay9a4K6+PSOHPOyJMUS/PKjSGcPjUZEMdo8uW
         MI/Ca8lZn7Luo1KIzK+UrLY5F3aCarfhuHzsW9H5n2WC0mSroGm3SC29XRjBqd2vzkQB
         DR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z/6NuGUOZMUgAZDyXSpkHI6qsHpxWrMVwiGF9YPcfdw=;
        b=VTbcm95BTSz90dYFN7lzaz928VHr4FJ1LkuIxzqIVw/ouSxmWMUwV2qCjgrzwc6k8O
         VVhOdWPffTBZnTLYpJXfwvvSfPLV59cA28ZrdH9supXcjLkTs1gXEI23NReAl2bTYHLS
         VpGX089y7g/KsLloBdEm8O73w0/4m1IXnGx35OYQz97qiDGAHHX2dHiHJ3OjJ8c46b1O
         yc+bsYiuOw31VrOhpAMzCwjT44nap5JCMcHoImXoMnZmWAw5KiGpqNIUM9U+dQTAonXD
         GBpZ3AQyqzjYxDyuCJlKohfZrwjvhqUJfWJe/lsjpzM7P6/UcnBRhagU4EXyJk9dCcFz
         PvAA==
X-Gm-Message-State: APjAAAXZ7h5JNVcfGezCQPr8ZYLUW0AE4DFUsCRTxPCnql6vthPz87gQ
        9HeFP8MEW5MLrnEvSTiQuIVlR3kJ
X-Google-Smtp-Source: APXvYqzHjfkgO/IeASv/3B3mnGmDY1b/yXRoqe0c0/kdxmWvMsd4Z/Z+Vq8HPiQItt3s2noHSVEe1A==
X-Received: by 2002:a05:600c:2193:: with SMTP id e19mr3539632wme.2.1569001336029;
        Fri, 20 Sep 2019 10:42:16 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id a13sm5215670wrf.73.2019.09.20.10.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 10:42:15 -0700 (PDT)
Date:   Fri, 20 Sep 2019 19:42:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190920174213.GB2988@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <38877cbe-084f-8da5-957a-6d545cf860b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38877cbe-084f-8da5-957a-6d545cf860b1@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:21:53AM -0400, Derrick Stolee wrote:
> On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> > The 'if (deref) { ... }' condition near the beginning of the recursive
> > name_rev() function can only ever be true in the first invocation,
> > because the 'deref' parameter is always 0 in the subsequent recursive
> > invocations.
> > 
> > Extract this condition from the recursion into name_rev()'s caller and
> > drop the function's 'deref' parameter.  This makes eliminating the
> > recursion a bit easier to follow, and it will be moved back into
> > name_rev() after the recursion is elminated.

s/elminated/eliminated/

> > Furthermore, drop the condition that die()s when both 'deref' and
> > 'generation' are non-null (which should have been a BUG() to begin
> > with).
> 
> These changes seem sensible. I look forward to seeing how deref is
> reintroduced.
> 
> > Note that this change reintroduces the memory leak that was plugged in
> > in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
> > case, 2017-05-04), but a later patch in this series will plug it in
> > again.
> 
> The memory leak is now for "tip_name" correct? Just tracking to make
> sure it gets plugged later.

Yes, it's 'tip_name' (the one returned by xstrfmt()).

> > -	if (deref) {
> > -		tip_name = to_free = xstrfmt("%s^0", tip_name);

> > +		if (deref)
> > +			tip_name = xstrfmt("%s^0", path);
> > +		else
> > +			tip_name = xstrdup(path);
