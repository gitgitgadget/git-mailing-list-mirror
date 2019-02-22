Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CAF20248
	for <e@80x24.org>; Fri, 22 Feb 2019 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBVRym (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 12:54:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46960 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVRym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 12:54:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id i16so3266622wrs.13
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gYPkYVDB8ZDHA4TSG38L98qM+OEKAzi3sMk2bP/SVgY=;
        b=NcClNx1KQTPmAbygfhjyOvSp1EhmB250L1V03UXLMfO/uwRYSR54EVpqqPH29pGmY9
         FUMRlC1GHT+bbUFiNr2nmUpJ5AIcFVAywfimeYKsM0CSR2o3C7TvBq0fnPomFnYGAyWO
         0TJ1wmie2ozRaxAiGJmEjtCTco7YQmMs6k0I/k2PmJoaFHA2W14DkCo9bDCRYwefZBAA
         9RjT1L8hA8uW0u+QFSE5P2UNZ8pv/6KEahLzK/cI3Pxfdnqzgx4GGg/l1nuggZD9DHGl
         6uX49YyfcEeBuWKloZHII6se5r4dFN57KlO7IWPX1YZihvc03ZS9FJPbZC84Qu7z8u2y
         KWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gYPkYVDB8ZDHA4TSG38L98qM+OEKAzi3sMk2bP/SVgY=;
        b=SODB9sf22ZCcBHoCp15VdtD1EcWIiwg6rZIzLBJIvptHxiQFcm1G9otkC3N28NiEjp
         LxXHhlaFmLcEcouecEbyIKk5bsEBHzCl617LXVV66G13N5FjXez/7yEshQaj5Ivs8ESb
         H56Cxy62n7qvIpzIyHAFVosUhiFADxv6iO+Cjoxl4uiWfPExjXF2iFFNUceRaZ4PFDu1
         VLhjxFKj+Ry5+CjEbP83kOGzUs89xV/53oGzazUR2g8k1NExA5X10DiDtyASKdXuO/NZ
         LxZTs7ekbtFebJwPczShKhRmNDlsdcL5dQS7apDOkkKopbRWFrhI32PnQihLVsDZkE3Z
         EA3g==
X-Gm-Message-State: AHQUAuZ3TphmdSZsrfnxNP4vm9Vi7raEAOCB/g0QfMxkzewS9donNYVe
        rnieAyI2uCWpCycM2UcjpqkgIXmh
X-Google-Smtp-Source: AHgI3IYhpFCLQgUSoCpq/cfN4Hu1gwg6Jtgv+SliH9Wwtyusy999uLuyyywvai0Vy2YjkEPXDEkeRw==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr3748249wrw.269.1550858080438;
        Fri, 22 Feb 2019 09:54:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n6sm2105970wrt.23.2019.02.22.09.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:54:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: notice failure to open cover letter for writing
References: <xmqqlg28snv0.fsf@gitster-ct.c.googlers.com>
        <20190222062606.GD10248@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 09:54:39 -0800
In-Reply-To: <20190222062606.GD10248@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 22 Feb 2019 01:26:07 -0500")
Message-ID: <xmqqo973r9nk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd suggest s/F/f/ in the message to match our usual style, though I see
> this code has a lot of capitalized errors already. :)

Yup, I'd prepare a prelim clean-up before this step.

>> +test_expect_success 'failure to write cover-letter aborts gracefully' '
>> +	test_when_finished "rmdir 0000-cover-letter.patch" &&
>> +	mkdir 0000-cover-letter.patch &&
>> +	test_must_fail git format-patch --no-renames --cover-letter -1
>> +'
>
> Cute test. :)

Those who can find this "cute" would probably know, but for others,
this is a trick to test codepath for "cannot create a file" error
without requiring SANITY prerequisite.
