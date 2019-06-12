Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030A41F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfFLThw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:37:52 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36616 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLThw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:37:52 -0400
Received: by mail-pf1-f180.google.com with SMTP id r7so4382730pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nh5h+fux1g0izuLRWZ9qdqVm5rzLOOlZVjpGWoN/4zY=;
        b=p+NK+UratQLn5V4+FwpaSiyz6g9WGC2fVUM2V++VcNCbclIVmBhLFEtemIJsEP26/s
         xS0TBE3teikQAXwiHE8uTknW8q90p10djM0+imQ/fucTMIJrsJ5JL/m6CFeOsP7Ut7iG
         f9GXQBFektFhHQOeJ9ytG62F59SHa78qVgbcWhG7dZzOGYU7ByvQLhDbbmp15srJg99g
         EaJih4mJPf1q//2wz84GUtEC7NXh4ulSQ8UnF/CCuTOAtV3OvSZ6g6EfcIFQzRzQo0P/
         kkMvIPh87aB0YBk0teEbr+Q6sarNgBLRyqDagWWNNoxeTLdWEWJ5FPVA4Eg9UmfAY6do
         E4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nh5h+fux1g0izuLRWZ9qdqVm5rzLOOlZVjpGWoN/4zY=;
        b=tgqaEfRx+c/qYE/FPns5yK5ve8hBPPicm+X38J3UPsHK6IV1TmSO/5cw6TUYKeVCPB
         E5e3aeF4anXxNqVgl3j/JUoejdRsm2gpOmmY2yJHHB6dLnVKPNuj0EDbLbYSPr1yDWlv
         GG3Mby4r5THav2F/qFvtTYDdHUFfJxhWdIXz5IWRc58kwJ5pvHCOk9a9ECsHIWlcMnbe
         TL7goLppg4BtktHuQuNwrxqp++RRavOy/ufmQmjF5Zu00CEmDs/GHA2LcyonHUwmUtDE
         NMTfTgtmpYgWjlWbbZFhRmWGN/wlVN/sBfmc3mWoSOOrnhMFMNpWp8X7WMENHkBYLCam
         smPw==
X-Gm-Message-State: APjAAAVWEBr8A4audZtet1k0bSd9raHCY6YepvNgawpqkOThMf0uctvm
        jPAKKaampHb+LpxOiMmLW/w2w//UoRc=
X-Google-Smtp-Source: APXvYqy3JKGP3CE3o0w83D89msF05w33CDdz2/rXGdyjfgab9gAtE7lPSyZKxE9lHJIz7qRnzxXYvw==
X-Received: by 2002:a63:5726:: with SMTP id l38mr27714958pgb.344.1560368270989;
        Wed, 12 Jun 2019 12:37:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d123sm386007pfc.144.2019.06.12.12.37.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:37:50 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:37:45 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] revision: remove stray whitespace when name empty
Message-ID: <20190612193745.GB233791@google.com>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <20190609130004.GB23555@sigill.intra.peff.net>
 <xmqqsgsho145.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgsho145.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 09:29:14AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Your patch only helps with this at all because you're using the "tree:1"
> > ...
> > because there you'll have actual names which cat-file will choke on. So
> > it seems like this is helping only a very limited use case.
> > ...
> > Alternatively, it would be reasonable to me to have an option for
> > "rev-list --objects" to have an option to suppress the filename (and
> > space) entirely.
> 
> Yup, I think that is a more reasonable short-term change compared to
> the patch being discussed, and ...

I like this too. Starting work on it today.

> 
> > I think in the longer run along those lines that "--objects" should
> > allow cat-file style pretty-print formats, which would eliminate the
> > need to pipe to cat-file in the first place. That makes this parsing
> > problem go away entirely, and it's way more efficient to boot (rev-list
> > already knows the types!).
> 
> ... of course this makes tons of sense.

Probably not going to start work on this now, but I will make a note to
myself to have a look if I have some spare time soon, and keep an eye
out for reviews in that area.

> 
> Thanks.

Thanks all for the feedback, I'll have a reroll soon.

 - Emily
