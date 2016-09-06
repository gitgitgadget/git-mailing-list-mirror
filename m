Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E541F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938711AbcIFQr5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:47:57 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36424 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938709AbcIFQry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:47:54 -0400
Received: by mail-oi0-f48.google.com with SMTP id w78so109571378oie.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6/kBxTf7xx1sfRX77MJ03OU/xFTIYghy43bkRE9uHbk=;
        b=bTw9OA8xCrN96bjCQ8lhCYN2R5SFoklml0IB9zNetdBvlJ3y8WaNcuoBrwAwdoC0dV
         ZPOLjqpQ3eomlJ/G7uutjRGW8Fe3pGNgRzQbSXAmiP+gSrkrFOTRZMXSgKr9U70jt2rd
         nXjyPTXbOZsU2FofYiBIcwduQpL6ZPEpR6G1yrnolHka5R3JMkYyVsLRYFZxHsoM7tyy
         pelGvTteWnjXgl6FC5gxgCCh3HdYkmpm8Z57vgpdPTGNzGzNxuhkzaltQGWPQQuWWl+s
         /4dDKC2V3XOTblDQM77kGvlpwMiitbf1Hvs8Xg7dcxwStPrBMb2CgMYucxtjsieHTlhO
         9fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6/kBxTf7xx1sfRX77MJ03OU/xFTIYghy43bkRE9uHbk=;
        b=SVxAUv8kcoc0hLm2sHChr/JwAuBWTdEd6rq+YYtb6O3/eJKiSCa5UL3NekZex72WKQ
         rOdh0Cf9PNJ3I325MXYSMWIp9YBXuEzgDEqgzlZbqpopJHj0zAxL1urZEIApfcYOPZjX
         nF46FtYMItDyOG8gdn4FqMWFKKx15a3Sd8oGaGdUAjThYJSnSlaBXyPblX8P4HnerCM+
         23Lue2EEHjObS+9rw8yas/Yo6+6jb0czInLLPWIbG0EJfVdDKkkgXwk1yC8Bj20EJ48O
         kVKaRd5nXZEugOmqFXg04xfUdTbkEELxNzDL1VrfgySqOq5CSYT63HS78tKdgpe6oDxU
         /qDw==
X-Gm-Message-State: AE9vXwMB8u/oTmI6LnLPRm/qsRtlgQex0xcuPVk3EvH1VQb66Jmh+WLRUj4qYHcuf0p2Sm+ifxLuaqZNLoP12cmO
X-Received: by 10.36.227.73 with SMTP id d70mr28759673ith.97.1473180473734;
 Tue, 06 Sep 2016 09:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 6 Sep 2016 09:47:53 -0700 (PDT)
In-Reply-To: <xmqqoa41p59i.fsf@gitster.mtv.corp.google.com>
References: <20160904191435.14144-1-stefanbeller@gmail.com>
 <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com> <CA+P7+xqx4PHHoKT_PK5s5eOtZMG9QJTSHED_=+BHZ=U330AQtw@mail.gmail.com>
 <CAGZ79kYPtvJ7iF8G5ihUCa5NwvDFa_Rzh+N7ar9QA2x74p2Z9g@mail.gmail.com> <xmqqoa41p59i.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Sep 2016 09:47:53 -0700
Message-ID: <CAGZ79kZXbWUg8vQaPWCxjf=hfRH3k=cZwvC3o_D9gN4WmnyhUA@mail.gmail.com>
Subject: Re: [WIP PATCH v2] diff.c: emit moved lines with a different color
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 6, 2016 at 5:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, not running xdiff twice would also remove another worry
> I have about correctness, in that the approach depends on xdiff
> machinery to produce byte-for-byte identical result given the same
> pair of input.

As we use different parameters to the xdiff machinery (e.g. context = 1 line)
the output is not  byte-for-byte identical.

> The output may currently be reproducible, but that
> is an unnecessary and an expensive thing to rely on.

My original design was to not store the lines in the hashmap but
only pointers to them, such that the additional memory pressure was
assumed less than storing the whole output of the xdiff machinery.

That point is moot though in the current implementation, so it
would be better indeed if we run the xdiff machinery once and store
all its output and then operate on that, even from a memory perspective.

>
> You may be able to save tons of memory if you do not store the line
> contents duplicated.  The first pass callback can tell the line
> numbers in preimage and postimage [*1*], so your record for a
> removed line could be a pair <struct diff_filespec *, long lineno>
> with whatever hash value you need to throw it into the hash bucket.

Yeah I guess I'll go that way in the next patch then.

>
> I know we use a hash function and a line comparison function that
> are aware of -b/-w comparison in xdiff machinery, but I didn't see
> you use them in your hashtable.  Can you match moved lines when
> operating under various whitespace-change-ignoring modes?

Not yet.

Thanks,
Stefan

>
> Thanks.
>
>
> [Footnote]
>
> *1* You can learn all sort of things from emit_callback structure;
>     if you need to pass more data from the caller of xdi_diff_outf()
>     to the callback, you can even add new fields to it.
>
