Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E3720248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDICa7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:30:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40980 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDICa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:30:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so8450971plj.8
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s536MZj/u4yjf4NAyxaPxQuvj37HmG7CawOpT5ifeGU=;
        b=c6+NJKXx1WG3/r5VXxeKBbePV2ryL2CwgB9pc87MoY76kamwwnxhw6n4AG+Zr6f3ED
         eUQuDQgXJNEQT22B2YOHk5HszXykE8Ngan3b3xh4Vo6/ep624KSHqG0bwC/hZzlmSTiV
         s3J+jfoYZS1YnCcTxEoU4JGz0NWpqoA0cnY1TRcMwHNNEtgNPL3yfTVkCwjcZkNmTa7B
         uFM5O43zqdrDfcKMrdH/X3gz5LSujinf68mIvWToXX3oiBEmPdCP/oyUfsnClkrteJNB
         RAYFmtfo9rTviYuA2+cXSHAZNfNGLxb/uad8nVWQH5CdKtk8zIZaxjbT9n5TkMMv+DOJ
         yW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s536MZj/u4yjf4NAyxaPxQuvj37HmG7CawOpT5ifeGU=;
        b=pln9pW96Ppuk6o43PwjcKSEifX/p3ialxQ+wg8xPMJ7GI6L8xzXYrdZaqea5cqE0tx
         YLWZKzK+Hxyg5DIb5TaX3xv967xXHn5iIGVyIV09LkVxex8em6GDCKA9Fu82SfvRbaqq
         eAT8xX+ND8VQQJNYM6N+kQXHiyS0UNJ5QlEIWtAcQxPUU2eOlWC9MppAwF2HjYpOt9dZ
         Fz7Gow16IU/gc8BJ+JhwuGrDIrMYdTzQy6SVkaYDQne8NFIK7im209Md1jIqcHiCtc8e
         BVnHI9IAbwntsycwswifbPVeH+HhxRTTMvKay4umXEalGwRaMM1efDkLQyH3GYArNZNA
         Go2Q==
X-Gm-Message-State: APjAAAUX/i16Nq1b4VtZKgYpV9zIjoYmSaZBZT+Xp/OsPE8VedUXXSmd
        rnX4g2Qgeg9VeA1ifPGNUTO2lw==
X-Google-Smtp-Source: APXvYqwVJteZPEHGsmXQVRvOCCoegEm8jf+DIWQ9HuCcrzd7XkkFjb5NQ3cJ4q2+0jj7l2FdZv8r/g==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr34464048plv.113.1554777058015;
        Mon, 08 Apr 2019 19:30:58 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id 75sm56641033pfr.55.2019.04.08.19.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:30:57 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:30:55 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190409023055.GF81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
 <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Mon, Apr 08, 2019 at 03:44:25PM +0900, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Fri, Apr 5, 2019 at 2:24 PM Jeff King <peff@peff.net> wrote:
> >> On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
> >> > > +   git cat-file commit $commit |
> >> > > +           perl -lpe "/^author/ && print q(parent $blob)" \
> >> > > +           >broken-commit &&
> >>
> >> > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> >> > dependency?
> >>
> >> Heh, this was actually the subject of much discussion before the patches
> >> hit the list. If you can write such a one-liner that is both readable
> >> and portable, please share it. I got disgusted with sed and suggested
> >> this perl.
> >
> > Trivial and portable 'sed' equivalent:
> >
> > git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"
>
> Looks good.  I had a bit of head scratching moment when I saw that
> "perl -lpe" one-liner; this sed expression may not be crystal clear
> to those who are not used to, but it is not so bad, either.

Should I take this as your endorsement of putting 'git' on the left-hand
side of a pipe? ;-).

Thanks,
Taylor
