Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0349A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKFKD1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:03:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44605 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKFKD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:03:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so18454486pfn.11
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RrHRDyK9yjLsJ9ZUUtDqaLuyGtGAqXNxCg2lDpcSGVI=;
        b=st6p1y9qoBm60H42PYpUtYgJ9erocgnhQSHrxrNeoJk89ePaOOgAMfSUTBznKXXWWY
         KJ8pY30QgDOmqqu/W0pik4Vgdfx7/1Vuk6YhI8E6DINaQ1WH91ElLoMUfGaaLuGfpKBp
         sEgtN3ZzVqGUsQPhgKK2ijXh7L2aS+xT5FSD0+0KUnjnPYK8INppcqbXY2esZHHFOuJu
         JIhWpZgZarweZ7Q+fgZjypSSTAr8TTNtZMvMRNh3UW24/qZ/mPrjrLffi85R4HTHlTTf
         iLY62ZcL2XEP54at3BO88JttVcDGgdXgcI25RGRsu9mBp4u2bo0OF/GBMD+mPo6IgGOl
         QFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RrHRDyK9yjLsJ9ZUUtDqaLuyGtGAqXNxCg2lDpcSGVI=;
        b=PwHHFrsloPRQFpyap/DRbcFSeW+M5hUnUNPiXnes5tm9yi7pLOKglr3zsk+wtjcY0o
         BCPvfTPRKGCfbrNbNnVXFeoiTXcjS0g8GjNLjh5XM7xafjxI0x6ykAMVBfyP1Xzo1GYq
         TWFrDfLJbUnIRQcdM+VNnOksvyvi1/lgq2RIstUZZ6ngeoYSZUBLeQCEY4McJYCpYM89
         GDGutq0clZaEWI6YoNDMuGbrSL9x8V2/Vj+5ZJ8BiaQsQb5VPMDcbnSG6bV/JO9otHvf
         CNd5/XURnNOuYlivXmEPNcmhJiBti/zPqEUF690DMbP+19H8gi0yqnI2wX+oOHUjIPed
         bbGg==
X-Gm-Message-State: APjAAAUIo4EA+f2DvBNEGMREEP/9xI2Bpq5uCySjNSDNavmI4f61+dRg
        7X3MoqSs6KIeFoWTm35jV8o=
X-Google-Smtp-Source: APXvYqxXreXy+Kapg/ZJYI1I5Ed9718FNLSXg5u6HPv8KJDPo4wa3JZS9ihIlDR1Wpd6vMAagez/Mg==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr2250954pfr.23.1573034604596;
        Wed, 06 Nov 2019 02:03:24 -0800 (PST)
Received: from localhost ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id f189sm32485108pgc.94.2019.11.06.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 02:03:23 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:03:22 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191106100322.GC6351@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
 <20191101165921.GD26219@sigill.intra.peff.net>
 <20191102010215.GB17624@danh.dev>
 <20191105080010.GA7415@sigill.intra.peff.net>
 <xmqqftj1yeo5.fsf@gitster-ct.c.googlers.com>
 <20191106040314.GA4307@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106040314.GA4307@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-05 23:03:14 -0500, Jeff King wrote:
> >     3. You are dealing with a project originated on and migrated
> >        from a foreign SCM, and older parts of the history is stored
> >        in a non-utf-8, even though recent history is in utf-8
> > 
> > to the mix?
> 
> I would think you'd want to convert to utf-8 as you do the migration in
> that case, since you're writing new hashes anyway.

Sorry but I'm confused.
If we're migrating from foreign SCM, we could make our commit in
utf-8 (convert their commit message to utf8).
Even if we need to synchronise history between the foreign SCM in
question with git, we could use i18n.logoutputencoding for the output
comestic.

> But I think a similar
> case would just be an old Git repository, where for some reason you
> thought i18n.commitEncoding was a good idea back then (perhaps because
> you were in situation (1) then, but now you aren't).
> 
> In either case, though, I don't think it's a compelling motivation for
> optimization, if only because those old commits will be shown less and
> less (and even without modern optimizations like commit-graph, we'd
> generally avoid reencoding those old commits unless we're actually going
> to _show_ them).

I'm not sure if we're misunderstood each other.
I've only suggested to encode _new_ commit from now on in utf-8.
Reencoding old history in utf-8 is definitely not in that suggestion.

-- 
Danh
