Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CEE1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 19:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeBPThP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 14:37:15 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35453 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeBPThM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 14:37:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id x21so4981346wmh.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a5XQt0Ey26tXWFGQ9CCnHW+V+WhEHdwBLf4Me3CawS4=;
        b=qsZmO6Op9inFbsFnTZrui0DPcCOoS9j8nRQIuejDS6Q0WEzt3HfgkE0suW1w4T/+64
         JmdjtgFo9vWCooIvWlBunwEPOljdISe5uxzsaUliOAZ4+bymL+dHw4McWPekv2CNUV9z
         HryhsmGSx0e2EoMQIK3tZxg4lFCSEkl5r22hhoTUyYdMYklU9r9wkqLW1GR621nJE+F/
         mOvEaPxNXd9gW91vNXX5sO3isKv+wDGeDh1CWc7W3rWyylO7bbCn/pL5Rx5LYoc/XTYB
         RTXdGa8977CUGXQlIELPvXxUzopE01t2YeNlssjBLCurlrltOYy/TP5ld+++Lgya01sh
         +c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a5XQt0Ey26tXWFGQ9CCnHW+V+WhEHdwBLf4Me3CawS4=;
        b=jB8mdGRm0/FE+zo/J22vSSgubwirL/CUFfJthbe2VRKp6Qgs8eXrOnJbj3tgMVMcH/
         y/REWpr5f3dyQfaelRurk/3kFDYDXrqmhV/tixa5NNA8RA+EHFhSo07kqyc+lB3ENqkC
         VQ/Svr0AZEvr+9nioDeBXAtdJHWzWFYQ+yV52G3lvOObMDlqd03DOrkJjDiz6b0EvVvJ
         cIuo8w9glv9gVdplYngzTrCfwAG2Ch9G3Bcl5U32Bo0RJ8Ck6WP5cppPRDyUwbASTZYW
         dHn/sBP5GIorCDbALjaKsLzQs5BoubJGWIHIyfjNonb15chFwEnmEK42+CVtWRumoeM4
         cyNQ==
X-Gm-Message-State: APf1xPBcjXFlkyER9I04GQEXWrEnSXAG5XJNxs3DE502tTGYNGfD3hcc
        RbPGD9mhULgUfP75HIuPkCM=
X-Google-Smtp-Source: AH8x224sxGVo3q6VgR3vWIRMW7XyWCj3tsE7ElrWoNUXJR5ixKLcHOPC0cyQQVnE5orpHjbfuf5Wzw==
X-Received: by 10.28.106.2 with SMTP id f2mr6212659wmc.84.1518809448418;
        Fri, 16 Feb 2018 11:30:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x190sm18031945wme.27.2018.02.16.11.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 11:30:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        lars.schneider@autodesk.com,
        Git Mailing List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
References: <20180215152711.158-1-lars.schneider@autodesk.com>
        <20180215152711.158-2-lars.schneider@autodesk.com>
        <CACBZZX7mh6TpbaKUYQkCgL0j0waO4=RhR55GuawrzLSBnqDmXA@mail.gmail.com>
        <20180216184529.GA22189@sigill.intra.peff.net>
Date:   Fri, 16 Feb 2018 11:30:47 -0800
In-Reply-To: <20180216184529.GA22189@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 16 Feb 2018 13:45:29 -0500")
Message-ID: <xmqqo9ko68bc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> (although the calloc() case is slightly different from mallocz()),
>> see: https://public-inbox.org/git/871shum182.fsf@evledraar.gmail.com/
>
> Hmm. I do think xmallocz is a bit more explicit instruction of "please
> NUL-terminate this for me" than xcalloc is. So I don't think it's
> inconsistent to say this one is OK, but the trailing-NULL one that you
> linked is not.

Yeah, I too thought "slightly different" was an understatement of
the week ;-).

