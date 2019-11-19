Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759921F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSUZt (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 15:25:49 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44989 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUZs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 15:25:48 -0500
Received: by mail-pj1-f68.google.com with SMTP id w8so3080845pjh.11
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mApYEvq+hSaIyh1FzcrDgqSOksQ1ajELbMUwHSoUAAo=;
        b=SiHbf3Pda28PFrcxUQYP/FfZnbbh5hmP3VMNPJc9rurHhWoFOqRyvHPwYnnX22IFzk
         PxnXVl47exiAJFc9Bd6DsoJ3E7p+kAjEFcwrvsj6GgGIFwsob311MliH6JQSjkADh7ev
         f64Csq3FpR+IPxoC9CGP06csfAR2QyH9joq5DqVCv6BtucgHu42nA1HdkLPLcdOdptdQ
         33XRc3wF2Kgm+imsdSMIimZ11YdmperjOdYo6Wkwv/oX8jPrxVbcRb257ItD2CqlTP3l
         QS5SPJre6dfix849dIenbbdwm6xKh2SKmZhnrk+AS1+/BOkdWvl/Lii7y6UtEO3/FKEA
         j6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mApYEvq+hSaIyh1FzcrDgqSOksQ1ajELbMUwHSoUAAo=;
        b=aEfd0hvbm7O9Cm0myDk1mSL9jZXB50oyflZwHD5nfMGb3Bd3vNZvN/zUUTAgpsn0ns
         PGp1ENVT6M7gNDZP0dzR2SG4VMrgEfCiAN6npAraEwcRS9N6B3wcZTOKI6Og0Y13nkKy
         2q7cNURtrLYjFRqkM420tHGkUgyhB7H4ZDkZT6VcN303gjJGOM8wiAQMYyJzni6na8st
         KUGZ5FHx4o/dVb0+hWPX+388+0EcZey94m5vvPajQ4AYs/YIiDsdW+tLa7acDLnQnBie
         d75r+bCbu2D0IV7fXeiSrYgUJhEF/oVzMv0TBqyYbtFVqXsGEKikA6/1c1zj3JN8TnXX
         A4BA==
X-Gm-Message-State: APjAAAXxp22P+4PKTAMVi6jDImwtw748+7Gk5lp5/qD1mVgppt5MRp/H
        mefsL1HK244O1p7MASMVsFQjTQ==
X-Google-Smtp-Source: APXvYqwNBhXN279wdIxAtG0PBP10sUU77ozIaqDc1uzd7VxFRF4nO5kD9Yp8+OmAo/b6982fueegeg==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr8914060pjw.119.1574195147769;
        Tue, 19 Nov 2019 12:25:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u3sm25271273pgp.51.2019.11.19.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:25:47 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:25:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
Message-ID: <20191119202542.GB36377@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-2-emilyshaffer@google.com>
 <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 16, 2019 at 12:11:38PM +0900, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Teach Git how to prompt the user for a good bug report: reproduction
> > steps, expected behavior, and actual behavior. Later, Git can learn how
> > to collect some diagnostic information from the repository.
> 
> It makes sense, but I do not think of any good reason why this
> should be implemented as a builtin.  I'd expect it would probably
> need to collect more info on the running environment than otherwise
> necessary for the regular Git operation, and perhaps you'd want to
> even link with libraries that are not needed for the regular Git
> operation to achieve that.
> 
> Can you make it a standalone binary instead to avoid bloat of the
> main "git" binary?

Sure. This would fix some other issues (needing to link against curl to
get the curl version, which is exactly what you implied). I wasn't
certain which circumstances a standalone binary was preferred, but I
agree with your reasoning here for sure.

 - Emily
