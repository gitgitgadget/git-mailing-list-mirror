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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB521F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJHWxv (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:53:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJHWxv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:53:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so10615131wrd.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I/yAKCPOBmDG9E3hqUzPUWbCHXEaCX5H6CiV6nRj5jE=;
        b=jMmL/u7XcR6XJe+NTTMfecEvrMsIUEQ2+8nno0iAS1VLFkjPac2MxUYdDKGtNv0iBJ
         18pDFULDukD6513l4Dl9U8qx+41aJNpAB7/5fJ7Uckz615dsMiTGKzKtA6+RGr4N/OSm
         62Jea0U+jxZeBYnazlzKmiaDOJkBTPPUZ/mPOZrAxvXevFI9JDBYNbRaaGwZMOGMPU5m
         BvAoUmP/jP8jOeuAceqq12q1zu9V3hicr6fV2xJOelq60zbEfCCP1G8jVzUhmDYTYh1t
         vcIIp11DlP2vXHRsgoqR0IQSg/B8Xamnt8HZMO2LFyJr8YSyrjHD0AfSQT4SDUt7R0ap
         sPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I/yAKCPOBmDG9E3hqUzPUWbCHXEaCX5H6CiV6nRj5jE=;
        b=bbdEeIYNGRctoEB2SMp9/IFe/Jr2DEx8YVHmI5QibFBbPFCdg+Y+O+jx/FVDnfgF3k
         yi/g9i3eyuyyvqfeaM8x8j5SUV2/kMGKooCbc7WXcqg4TnUGSg2CgCTmd7Jz5Qp3iv9i
         8dnm0uaq+8Uh01bZKJdfZO0uVL14vqmpFCqzWBaWLWM7zRs+TUYKPjLR3rzyKtCIFd7+
         3js45zFsmoGGzV31+dX2E2E9p99MfExQWpu48AGE99Th36W4UaR643Ptn2EC6iDLIHAO
         UcBXMWMuSaHCwRaDBYm4p9x/kU5jhD4YLXyLr0Sk6nbM4S8Msuqk/QZcsYejox4IrNUZ
         dEpA==
X-Gm-Message-State: ABuFfohXF5QraUlIuOaxjACM+mIeJHEJ5XKD2U7Iu2YF0bT0eMw4o0u1
        ImXiJ9E7bS27iLPyTgVLutOAKcEf
X-Google-Smtp-Source: ACcGV63j96PyzfCeMIj7V2ynalMnTzvBWBrT2nsC5hn+gxlwKqoQsndfFxXF6lIKlaUnKBwOjA+oyw==
X-Received: by 2002:adf:e784:: with SMTP id n4-v6mr18243364wrm.187.1539013290157;
        Mon, 08 Oct 2018 08:41:30 -0700 (PDT)
Received: from localhost (x4dbd30b5.dyn.telefonica.de. [77.189.48.181])
        by smtp.gmail.com with ESMTPSA id t194-v6sm15281662wmd.48.2018.10.08.08.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:41:29 -0700 (PDT)
Date:   Mon, 8 Oct 2018 17:41:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
Message-ID: <20181008154126.GY23446@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <871s9fjbcb.fsf@evledraar.gmail.com>
 <20180927142336.GJ27036@localhost>
 <87zhw3hsiv.fsf@evledraar.gmail.com>
 <87k1n6hzwu.fsf@evledraar.gmail.com>
 <878t38a3pg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t38a3pg.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 04:54:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> Thanks. I had ~400 runs of the tests I ran before and they were all
> >> OK. Now trying also with t1701 (which I hadn't noticed was a new
> >> test...).
> >
> > Ran that overnight with the same conditions as before. 2683 OK runs and
> > 0 failures (and counting). So it seems like the combination of the two
> > fixed the split index bugs.
> 
> I forgot I ad this running, and got up to 45482 OKs and 0 FAILs before
> finally Ctrl+C-ing it now :)

Yay! \o/

Thanks for testing, and I feel sorry for your poor machine...

I will send an updated version to address the (minor) points raised in
[1]...  well, most likely not today, but hopefully soon-ish.

1 - https://public-inbox.org/git/20180929091429.GF23446@localhost/

