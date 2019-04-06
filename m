Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A7E20248
	for <e@80x24.org>; Sat,  6 Apr 2019 20:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDFUiF (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 16:38:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35515 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDFUiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 16:38:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so2908607pfh.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7T5NieemERC/UnWruQsuKPCeedbVdCWILC7O8nRymY0=;
        b=BtO2t1Gbn9drLioGbL/i3CQufIFlhrPFtoShGguyBODHWgUrJCc3TNpFegA9hFKY87
         C6tpXpC2YEaUomUYVsuRQDrq1UsEo95+ob08lnJPa4/SCHWC+dcmmcJoqAMvtK7LdJ3d
         z57BzXV0sl721h2vbB/yT3UuEVY74sdn2ATbyhlH4apEbFnpAuiefUCEPLKy12XI8yAI
         WjoonpwD9UgTJ3y/Samj3+F/EKJ5zma+KVNGw7cuzRV1mlfLa5duwzyu0oS2cQNUNKes
         8CPJYizC7327uV+YlE7Q5K6+8P11EcgjgqtoQdASiuzFxluDhXmddSiwTklUANY3KYTp
         ZsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7T5NieemERC/UnWruQsuKPCeedbVdCWILC7O8nRymY0=;
        b=SPAGxkJc9KjvvKhHzsBtncyz5uERz4L8Wi3f/28WJWI/l9FfpPTnovnynMG4Gr5Te4
         PNQ1SMy6qtABWWen9ABRvQNVTelZ1bYRHFtI79+88fP6YMTTQRB2cDV38oQCoLJlxnB9
         pX6xuM8gPApwXo41zRewvarJaaW04UvtFYpd60PpBaUtH0aulk5m+rNwtdwbwvBMvFgS
         UcrzMSh62Hb0RFmckhC3IZNe845Z/AhkM5l4CKT/wBixNSq05Adrb1/ujHXq95udfPJQ
         rPy9MIneu7kgN33d9b3sTrbygFnOk5t0mdX3QUtN88kjhGlAtR2DdvrUaCduccTXQOFf
         0oNA==
X-Gm-Message-State: APjAAAUFPo078/1/UDPmHAA5UhS+SWgeSzaNKPicYxkpljxeWzUoLtbw
        pH9l6c6QWcjwSF+XiMdkFq8=
X-Google-Smtp-Source: APXvYqzCLqMNzAgl49h4aB8db0yCpgAzTHYoCb67/HnjiIhLsCC2k0i2qpUMIFRus8qyQNcZ1E91kA==
X-Received: by 2002:a62:e304:: with SMTP id g4mr14091792pfh.71.1554583083759;
        Sat, 06 Apr 2019 13:38:03 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id e4sm37637640pfh.146.2019.04.06.13.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 13:38:02 -0700 (PDT)
Date:   Sat, 6 Apr 2019 13:38:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/4] rebase: teach rebase --keep-base
Message-ID: <20190406203800.GA6147@archbookpro.localdomain>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <87ftquapfy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftquapfy.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 06, 2019 at 09:44:49PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 01 2019, Denton Liu wrote:
> 
> > Thanks again for your feedback, Ævar! I think we're both on the same page now.
> > Hopefully I've addressed all of your high-level concerns with this patchset and
> > we can move into a discussion on implementation detail.
> 
> Late in replying to this, have been off-list. This also applies for your
> v4.
> 
> The current version you have still doesn't explain the "Why would we
> redundantly rebase every time in this case..." question I had in
> https://public-inbox.org/git/87tvfma8yt.fsf@evledraar.gmail.com/
> 
> I *think* it's closer to "it was easier to implement this in terms of
> --onto, which happens to behave that way now" than "it must work this
> way for --keep-base", which is fair enough.

Correct, the reason why --keep-base was not lazy initially was because
"--onto did it that way". You are correct in that --keep-base should be
lazily rebasing so I changed --onto's behaviour in 3/4 because it would
also benefit from laziness. Thus, now --keep-base lazily rebases because
--onto also does.

> 
> Although I see when I forward-port my POC patch from that E-Mail that
> one test fails now, which is good, that wasn't the case before, but it
> looks like that might be testing something else than just the lazy
> behavior.

The test fails because the patch disables fork_point if --keep-base is
set. So, with the patch applied, C is rebased even though it is excluded
when fork_point is set.

> 
> It would be good to know in terms of commit message or (better) explicit
> tests so that if we teach these various rebase modes the same lazyness
> --fork-point uses in the future it's clear if that's OK or not.

Sorry, could you please clarify what you mean by the "lazyness
--fork-point uses"? I don't understand what laziness is introduced by
using --fork-point. Also, are the tests in t3432 not sufficient for
testing fast-forwarding (aka lazy) behaviour?

Thanks,

Denton
