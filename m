Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6E5202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbdJQHSD (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:18:03 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50755 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbdJQHSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:18:02 -0400
Received: by mail-it0-f50.google.com with SMTP id 72so1269721itl.5
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+mYIiZsQzOti20Zrew7J69OSrhY1t6+Nxd8Mpob0r0s=;
        b=NYS4gGaI05Cb8hJO8xPAlJmQayMGZeotAv5rLPxYWp05knVjAR+1lr8qWWflhGJKkb
         jRWl0CWYUfqINuvOKEQpye9JC7XE3wSNCyP62X49oOSe7eS1YJavdXiLd6KEcg9gL30e
         7U5XizKUiSMaaZ08W5LSDGbjMorbIOZLKzhH++JzqjCKRKSifQyjHFFydlsnTQZs7o3g
         9/GsI8AfmT/WrENQS/LoCWRDf6u3t80TfEk74Dbo92mBg7m+j4o6Ti1aH0lKU4tPaedQ
         v/r/mAiwU1V5ekArHZ1Pg/jsRrpmhNkpxwlq6bk2CzTLzCAqZK/eSgKq7FcSZRmK1VFi
         hUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+mYIiZsQzOti20Zrew7J69OSrhY1t6+Nxd8Mpob0r0s=;
        b=kzKBu1mVfuwpkQopm9Pq6+jE+ff0OAhFNbPjm0/r+DOYpADYxfODgVHEwZvmVuemur
         F6nK92L6ccQpRKAjwW6G8mIl9rlMZ1TYWCxyIFo3lxoMEtbTiaJWsVBGLgY2bByNMMYK
         /zjZ+UjW726R20Aty74xkbmiJDAJWT6Ywin456yzcGaf8XpgNmneiIwLH+pvWUH6PcRM
         ZlHJ8mpvLWPsUDuPooUs7s4o7fOtjsdJvDxGL/wAoRpWeh1Qn6o8XoDDEG1owSSBqjRc
         UbTS3aK75QqXup5+N91bzVdMDThNgIPCinPLpaNgZ/KCIyPG3Hxo27PJap9XGR4Lk52e
         l50g==
X-Gm-Message-State: AMCzsaWd0qAcAmz2edw48W94JkW1x36jikSFC0R6qXtPrJLfgbfI+PdM
        tCDI2guiiuFtv9h/2fksboVhB/lB
X-Google-Smtp-Source: ABhQp+Tu7AJwXexJn6ZHs1apH1AOAZv4JlxS/RozDorY+sMX3udZVj+oMtasdySr8CC7TyL8tgJdEg==
X-Received: by 10.36.185.4 with SMTP id w4mr4055346ite.77.1508224681264;
        Tue, 17 Oct 2017 00:18:01 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g26sm4478593iob.34.2017.10.17.00.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:18:00 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:17:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] Re: [PATCH] check-ref-format: require a repository
 for --branch
Message-ID: <20171017071758.ltzustqxcbp3yet7@aiede.mtv.corp.google.com>
References: <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
 <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
 <xmqqefq2nt7w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefq2nt7w.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Handles the nongit case in strbuf_check_branch_ref instead of
>> introducing a new check_branch_ref_format helper.
>
> I view that as a regression, actually.  Don't we want a function
> that does not require a strbuf when asking a simple question: "I
> have a string, and I want to see if that is a valid name"?

*shrug* I found the change easier to read, and it also sidesteps the
which-header question.  It also ensures that other
strbuf_check_branch_ref callers are safe without having to audit them.

But feel free to tweak that back if you like, or I can tomorrow.

Jonathan
