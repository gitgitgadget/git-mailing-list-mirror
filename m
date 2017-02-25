Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46207201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 00:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdBYAyz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 19:54:55 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35970 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBYAyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 19:54:53 -0500
Received: by mail-oi0-f46.google.com with SMTP id s205so18513489oif.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 16:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UyY19+DlRiYRjaV1S7ZJ7SQa8YmjQV8/olj6ojqjE1g=;
        b=u2tCQVBeIVGt0j38/QfRhteUPEFIuNCssiYZ6vhVlxZ/uMvd0SPf8ZfoZOWHMbgtBF
         82hFKf0o6W/UrZUcSnhq8FhnfWi1ub/WQzW107TefAXO6De7o78UbyMbkhVVrFLbko1M
         DFSbOhqqojpNxlah8Jo9HtX/cInMrQkYqTaJHzj7ch0q3c9KCt6Heyp1X0e3obLCC5Uu
         /epuyBWpMc2jLWbfibpqrRcRdtGb61gzbSco2LvdLARl8zkeiURr4cHbASk8R6DaC0XC
         ulNhGDydNBuw5rtcnoNYVEOp3+S8jJBnBEeF/HlNpRyLmeHqArmB1CisAFXaCFetYzYn
         fVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UyY19+DlRiYRjaV1S7ZJ7SQa8YmjQV8/olj6ojqjE1g=;
        b=IwAgAmzi6V59mufeoWGHVB1csfOJL8TJCAuUypcmcoCBL48WF0PLAaPq8RvGyC43oQ
         RzUm+ItxpvrzPd0GMz60btaffy0F/bapmyW4ot3Z1vNnhIuqpSz1faXnKGZVOb+XFXCF
         vqVU2haHpA5P+AODx3dtBX73VTeBpdcOpqmgyuI15LKXplCJ/NEuIoI3eH90GbklO1hN
         VvljKzFxLvOxiwxUskr6fJJ3ifzZjQhbcyaTpXdoUox8F43+zXMYYxLEh2TCaP9IZnM+
         hUJPdOMBDLk4h6IloDvdkFt4Cq4feQSoEBuDezUYL5BnKj6IJLINAKdtQBvWDWf2YkoX
         XCoQ==
X-Gm-Message-State: AMke39l5AuTmuArXP7m7LAKhyVYXDFggNOVx1ryJRPf1g9PYXovLtRqlYL9hQm2Pb/OpVNscaJjtk1ROs3+onw==
X-Received: by 10.202.219.9 with SMTP id s9mr3329307oig.88.1487984091955; Fri,
 24 Feb 2017 16:54:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Fri, 24 Feb 2017 16:54:51 -0800 (PST)
In-Reply-To: <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2017 16:54:51 -0800
X-Google-Sender-Auth: G7qfkrBiC8vCVz0vResPyNw2Q78
Message-ID: <CA+55aFy6G1QF3Msy2DZbyhFmn974wBeXVuZK78pJ8FgkyeU85g@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 4:39 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - you'd see in the "object->type" whether it's a new or old-style hash.

Actually, I take that back. I think it might be easier to keep
"object->type" as-is, and it would only show the current OBJ_xyz
fields. Then writing the SHA ends up deciding whether a OBJ_COMMIT
gets written as "commit" or "commit2".

With the reachability rules, you'd never have any ambiguity about which to use.

                Linus
