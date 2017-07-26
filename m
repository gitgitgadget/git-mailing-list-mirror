Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A94D2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 16:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdGZQny (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 12:43:54 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35710 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdGZQnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 12:43:50 -0400
Received: by mail-wm0-f44.google.com with SMTP id c184so83868851wmd.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVNVX7Mh8LLKOqoje+OMHVbnoKe8y7+MK2oV7Wp8lVo=;
        b=N3SakygC5XamQd82LytTrGMlUhRA0Ggn652r7SqKsA3kLrt689lqUKi9schnnUYhBc
         E4U1/kszFuhyJdNmnjnIf2V9En8f6twNiMoHNiqpsRoIqcpWXBRTkBEOelj/D3B6tbjM
         7PTfLIm3BGkFVpWLcpeHdCLuANKYqjGrK05BAAioL7F+r4UO471SxmQiBn4yQDVFfJod
         b3S/We1WZp7CJZ37dIMz9Mft5Ikgs/6GCeTWYp1sK5953jcESgwGuWYjMNdKFoTJ2gup
         +hKbXGRFd56DAxnvU9NpGhhp2H4UzmOMbSVZUbZ/K643/U5P4ummuRMUNDJmCT5bdMXe
         aT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MVNVX7Mh8LLKOqoje+OMHVbnoKe8y7+MK2oV7Wp8lVo=;
        b=ttmaB4RacumW0SsVmCL0ybY7hNPvJN9bg/55uN3z0mCX0SOs6u0oKMS8OHmqtD7AxY
         WRvxJ22IC8MgR8hU+8RWuIlucYphv5IP6+LSXdSDFnt/YHTCk/yrStHF4vdl8sA87pQ9
         EwoBa3pvJhBKczEfw6nZK4yxbO9iBODfCI8lFLDju5pACgF/VR1N0C40USj33wkn/HCf
         KHGUNmi+5MPULJGkkH1aihYVL97x44gnGr76rfCzkQdSWYfp0X8Blml9J6+I5LztYT6d
         vs6GrgWIkL/HAS2NG3ST2Uaf7s1ASMZ+3g5F2V1rk2SgYiO/PV9QYqLaD6m+QUi4iJRa
         C6Hw==
X-Gm-Message-State: AIVw112NrHBNeY0G4lTReMNjrnWRAiUZLrTxRUF99S88eSg2FQoEG2IA
        StYRT3j65CRmAg==
X-Received: by 10.28.168.86 with SMTP id r83mr1263963wme.150.1501087429120;
        Wed, 26 Jul 2017 09:43:49 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id t203sm5720065wmd.25.2017.07.26.09.43.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 09:43:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Reducing redundant build at Travis?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqo9sdhh9o.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 26 Jul 2017 18:43:47 +0200
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3056CC17-DDD5-406C-AA22-56309DF09DC8@gmail.com>
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com> <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com> <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com> <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net> <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com> <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net> <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com> <xmqq4lu7m94h.fsf@gitster.mtv.corp.google.com> <333FEA3F-BB43-4183-ADD1-14E73E668EA3@gmail.com> <xmqqo9sdhh9o.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Jul 2017, at 18:44, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> To answer your question: I don't see an easy solution to the problem.
> 
> That's OK.  Thanks for digging.
> 
> I am wondering if the attached would be acceptable as a minimum
> impact patch to address this issue.  

Your patch would still run a number of expensive operations for the
same hashes (e.g. static analysis and documentation builds). I started 
to work on a patch that moves all TravisCI logic into scripts located 
in the `ci` folder. These scripts share a `lib-travisci.sh` for common 
functions such as `skip_branch_tip_with_tag ()` executed at the
beginning of every script.

Does this sound sensible to you? I am a bit busy with non Git related 
work right now but I try to post the patch for you to review ASAP.

- Lars

