Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F8D1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 09:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfADJaT (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 04:30:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45387 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADJaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 04:30:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so35993592wrr.12
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJnmAgYSjefoZmbRCzg5RgJsSFEBumSfzoXmg0L5Yfc=;
        b=h9ue9dlj/imDowVk+wE5cFQKpv25bq6TnA63fO1v8MrNQjVZvusee120FyZAM/KFmF
         qfwu/1pbgkArKX9wdfkJXCL3btGU1BjNUUzhg1RrTHHsmEJzo5Ay5r0DtO/z2QvjKH8q
         5LKDaTkY+vYzurYmrUrgbIa0dvH873/5qDHB1l0pSoRlzx4pgLxpLyPmLodo5wh1BZJU
         w4L6bIm75UxPXuOVmjHCUX0juGnIUZl/tf8bIq9VTF6sNGaoXfoM+YM6x4vFGD7AfmV3
         8kFuof/K6PmmI7wSXHyfyEg+MTaw3auKUYeFZ5RXvZNsGWqZtCLRgRQMa3QaxdQzIDly
         oGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJnmAgYSjefoZmbRCzg5RgJsSFEBumSfzoXmg0L5Yfc=;
        b=UVr8VO1P7K7tAWGrJD0sISKoQvzlaIzGWZfxr8p20BJlj+OJjOyimS9r1upPe1F7wv
         /wIQarcrcoffXzj3Obva1j+U3Lxm9W4AEsmwWk2PKVaQyIwP6RklYMJWG4L6gTxeriIo
         8PYFGqTSAUpy4QX9Dr5EnX3idej4oF7q8lbDLixMZ74Zze5vgNzHzdWf8qrurNsq7xOB
         XAINCsgJghsU/ro3doTXirqJdB0rCjcbGuWeC/R44XptjQA/kwHypP40NKLCm2qMrc8c
         12H0/N3HL6X2NWr/wzmSNFYLo9h+BwY+11osXfJirr9uWHndB2aVV5WuvR+EYpS685l8
         dvKA==
X-Gm-Message-State: AJcUukf+mdjbkUY8ZISOlbL44wphLJX5vBf8d0OdTKa05U817rdesVGZ
        NYz/Jcl3+xR8gwmASUYd7S0=
X-Google-Smtp-Source: ALg8bN6r20k8I1+2NBsE951t2kpI7lWJMvERMa+9sVIGbh3kMvZboN3YsoSGiNl0f4AuH9LGxv+izg==
X-Received: by 2002:adf:e1c3:: with SMTP id l3mr44493387wri.36.1546594217857;
        Fri, 04 Jan 2019 01:30:17 -0800 (PST)
Received: from szeder.dev (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id v1sm60676509wrw.90.2019.01.04.01.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 01:30:17 -0800 (PST)
Date:   Fri, 4 Jan 2019 10:30:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] test-lib: check Bash version for '-x' without using
 shell arrays
Message-ID: <20190104093015.GC4673@szeder.dev>
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
 <20190103114317.11523-1-szeder.dev@gmail.com>
 <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 03, 2019 at 12:29:35PM -0800, Junio C Hamano wrote:
> Let's treat this as an independent and more urgent fix-up.  I think
> it is sufficient to apply it to 2.20.x track, even though we could
> go back to 2.17.x and above.
> 
> And then let's tentatively kick the "stress test" series out of
> 'pu', and have that series rebuilt on top of 'master' and this
> patch.

I rebased my '--stress' patch series on top of
'sg/test-bash-version-fix', and the result is the same as what's at
the tip of 'sg/stress-test' at 1d1416a34b.

