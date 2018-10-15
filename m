Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C201F453
	for <e@80x24.org>; Mon, 15 Oct 2018 03:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJOLer (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 07:34:47 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36793 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOLer (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 07:34:47 -0400
Received: by mail-wr1-f42.google.com with SMTP id y16so19517034wrw.3
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 20:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lm2HYyAwabnyliFQdsht+/uDu+o2b/zt96kp3/FasHA=;
        b=SzrTk3k/L8KkwHwfhv8VE2iMh2NBqj7/657Zn87JmG8Juieb3g6+ZjgDCSeRkjKeBM
         /yc0o6qESM8eTAhfKjki0qPVcxgy+pHIEYdxkA/5n6rURsUiaSfu9xlkOF9vEvPlRTpu
         pM62XfunJiCxN+cownOF3Kbz5X+R4tnYZey/2Ly0vvfUGNVUbcC3Zv6j3YAWPtWV104C
         AEGxIKerpy93kCgmuJcaye8hGIjKEtTJMO6LpN79hg1tzGTy1aLVTiqKz3Yuswg71J4A
         JXNA/wEMGYF3Wo4mhfLzJA/xUHV5ulswGqmEwKKsc3Qm04zdlJBrLhTZhOJzYHLW8t09
         gn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lm2HYyAwabnyliFQdsht+/uDu+o2b/zt96kp3/FasHA=;
        b=Fu95qgmAhmcTCdRv1LTGlt0pn5t/uiaN1zQfMDu+0tZQf6lF8gyNzmtq1lzkdNpn9i
         jxUkOxljCANfOIzFnOEzJFXQuLJJdup91mEgrNXKfBVlpnHYRRDWJGJylxpnteJixzQ1
         8+W/KecLanxuJv/iqoIvD1CLX8akC2LGTmf9PWcDjash3W+zbBIqPoIKJDyNXrZ2Cj7a
         HJJzYV2zAjZg/fsfOOZWBVZBxpJJD3wkBAYAvoinLn9RxhnSZQGSR57Ccha5u1XK0y93
         PQ0s/6o4EoU+Sg195HqHa8JTOEXu6EAYk8z6zsI3Fd6TxRLfD4P5A+Y7JpgXrasK+BDw
         Gv8g==
X-Gm-Message-State: ABuFfog5T/HvluQvxAn2xB0wO1pqeFIFYP85I/5oI/JIORqBhaj1LNr8
        iENTRtUF6/fWYRAU/T+VpEk=
X-Google-Smtp-Source: ACcGV62+JnJ3tdjOE1Gt2vq/4/ybjjG2NCPVaKIlfLo4bfqPbI2KEuEH32AG+DimDXQfCYTub1G6zQ==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr12447690wrx.215.1539575483546;
        Sun, 14 Oct 2018 20:51:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f16-v6sm7162418wrw.89.2018.10.14.20.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 20:51:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] headers: normalize the spelling of some header guards
References: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
        <20181014235950.GA13510@sigill.intra.peff.net>
Date:   Mon, 15 Oct 2018 12:51:21 +0900
In-Reply-To: <20181014235950.GA13510@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 14 Oct 2018 19:59:50 -0400")
Message-ID: <xmqqmurf6f5y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm in favor of normalizing even the ones that aren't illegal, though
> I'm OK either way on the vcs-svn bits if they're going away anyway.

I'm in favour of normalizing even the ones that aren't illegal, too.
