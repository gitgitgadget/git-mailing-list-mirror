Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1881F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 17:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbcHURKP (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 13:10:15 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38685 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbcHURKO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 13:10:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id o80so109745971wme.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NfZXbOJV3SoIYPu4fDiRDtd/8L3LnEE1WaYF5pDaaOQ=;
        b=LmYEASujspC5gQ1P73ekq1TMpy9B5X7lDaHkEF8z1zq0gKy33JdbkyDZ28VnZgSZkq
         kqx3Be+qEyMv0fp3kVnnbJoSAEVqiyjm/DbZNW08ZZD/TpEaMTD4285ElLzou9n97/eV
         sMyKbNxLRymKgLUMd0uTQ9ST0TCQMC7XV+GWzSr6+KEJMW6n/LEpSZ+H3gc0KOUml4Jh
         CR+kRTRVU4MJK8DDIw48mUTemisoHfQwEr4G+JaPls6SEDHNLnynGz2f1QybIHGPDWjM
         VvWlllZI/2+VTTrTUugtdcWN7tK6Gd3M0lfYdkLlYE2rEYW6dbi20cmyKR5+QJB1dUMW
         srJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NfZXbOJV3SoIYPu4fDiRDtd/8L3LnEE1WaYF5pDaaOQ=;
        b=NPpyY5khz+k1QDO0C1IwZMoPVUdEo+Ww/kAajxvDdCHSXSvJoiWc5BYEQwtG3UzsrP
         QEkqdSBUe8hDg4uMluf0kI5tycx5TgaTTEpQM8fSfz1tYWtCtuZ69+hNW33T2YlSOd4K
         naF9cdd0YtOlOHj7CjAgQHI87YGieRqxIf93LI/6V9AwvMZpvzgDOLyiBcbDpCmRfv6K
         u9ShSz+Ezb5hb9qx+rC8HBVwiCnU50p61xndUp5iFPC6S1C90Ag54ghnOo7VcyzTeR2A
         /sN2nKpOeqsEwoDq/nyOMFM9Y2UVfHgvMPwK+LVe71ig2K93vR/ZP91fNg1XUVcSreFN
         ckRQ==
X-Gm-Message-State: AEkoousz6W/Jk1ykMNZc2M40N/4L2MaEU6FOwX3ziLUVkCRYI0cz35BdQTQ5VvmTS84kYQ==
X-Received: by 10.194.144.114 with SMTP id sl18mr14066667wjb.123.1471799412265;
        Sun, 21 Aug 2016 10:10:12 -0700 (PDT)
Received: from [192.168.1.26] (deh62.neoplus.adsl.tpnet.pl. [83.23.111.62])
        by smtp.googlemail.com with ESMTPSA id lv9sm18798629wjb.22.2016.08.21.10.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Aug 2016 10:10:11 -0700 (PDT)
Subject: Re: Minor bug: git config ignores empty sections
To:     Jeff King <peff@peff.net>, Eli Barzilay <eli@barzilay.org>
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
 <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
 <8737m63phh.fsf@linux-m68k.org>
 <20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
 <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
 <20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net>
 <CALO-guvVMFitNdGYEonXZ9rh8g8=L9gZojXVUu7FO2_0ki24EQ@mail.gmail.com>
 <20160816123631.ckbvzustl2j37gdx@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <968003ae-4f62-ebe9-f7af-53b4e1bcf7fd@gmail.com>
Date:   Sun, 21 Aug 2016 19:09:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160816123631.ckbvzustl2j37gdx@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 16.08.2016 o 14:36, Jeff King pisze:

> What I think would be much more sane in general is to parse the whole
> thing into a tree (or even a flat list of events),

List of events is cheaper on memory (though I don't think there is
an issue with size of config file), and can be turned into tree
and DOM easily.

>                                                    marking each
> syntactically as a section header, a key, a comment, a run of
> whitespace, and so on. And then do manipulations on that tree (e.g.,
> walk down to the section of interest, add a new key at the end), and
> then reformat the tree back into a stream of bytes. That lets you
> separate the policy logic from the parsing, and do high-level operations
> that might involve multiple passes or backtracking in the tree (e.g.,
> walk to the section, walk past any existing keys, walk past any comments
> but _not_ past any blank lines, then add the new key).
> 
> There are other other upsides, too. For example, the current code cannot
> write multiple unrelated keys in a single pass.
> 
> The downsides is that it's a complete rewrite of the code. So it's a
> _lot_ more work, and it carries more risk of regression. So please don't
> take this as "no, your solution isn't OK; you have to do the rewrite".
> We've been living with band-aids on the config code for a decade, so I
> am OK with one more.

So how 'git config --show-origin --list' works?  

Ah, I guess it prints as it goes, instead of parsing config file(s)
into stream of events, and printing from those.

-- 
Jakub Narębski

