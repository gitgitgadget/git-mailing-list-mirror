Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB751F453
	for <e@80x24.org>; Tue, 12 Feb 2019 12:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfBLMoa (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 07:44:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35320 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfBLMo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 07:44:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so2546679wrx.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 04:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=waM+eMkX0idD+SHnTLcJgJvi9tJ0/HBv8fSpaLGFurc=;
        b=A+AI4tFr2ILVA9G2emF7NVekI8TfMhifd10JjMR551lPyC/Ex37WF6AwC5jxpQBNR9
         f2FBCIoQnBO3BNc6XQgjhv/EePp4ZWnqqtx1XjopaRY7y+FlL7HsYncmZaj8KzqwK1Ok
         dtk4xz33HZyhSCgbXFsC2xkfsDMD190/+KgivKNQufElLH1pEDwIcEJ2siSQQ6YoA8K6
         LP+I52PIIuXzGR/TkNRh4Hg1K57TXN2xoxHrWQJp+Gyj9srVugh9R+w7s41yyOSvHe47
         div41tFpdyWmcHKDDEsTfhE/5PyQBxNYVEqw7aTZaoiaFX1L0GdwSJcXn+Vogf7s/9CV
         XPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=waM+eMkX0idD+SHnTLcJgJvi9tJ0/HBv8fSpaLGFurc=;
        b=DdB6b7z5kjp2d/wRA5bnQe7Q2O/Vr289kGkHujUaydGX6rNlR2OPUo7d/HoY2zd1DZ
         8XyhfCO6NcpRLmLOn0Eybl8KNtSp+JhFZyvOHe7Tlu4HIDoRMIzZkRk05GgrvWQ4ykDz
         EFHfw87vpSI02ML/NiZRc2aiVaD8eSkzv5CDXRQZZWPld03gntitSk8vOua5+nKX79Rx
         eaUCijeoAY21gu6rfxbC3W1Ze5ICVCHaKt4672NNJ8NRtAZ5QCHKSWpnWkcycq2hPc5S
         uWvPuceE41NXszvfbZ2asEf1D4HFppn9SVhsZ+W+/sv+NY7L7PdF5zMFrmWQTMWYEMPk
         ViHw==
X-Gm-Message-State: AHQUAuZsiNFagbYQstGuQlSFb+R7FXXqbYDe5J3Zsd/sLWmCviCHDAup
        51pT+R2ZoULjyf8cbgrPb8s=
X-Google-Smtp-Source: AHgI3IaQffmayEyAjS+w54m7MxK2gbpdEIoli5eFnb/GVFj7NyDvXznSXMaKWSyNDmB1vVVMT/wpRw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr2979055wrv.126.1549975467866;
        Tue, 12 Feb 2019 04:44:27 -0800 (PST)
Received: from szeder.dev (x4dbd7e49.dyn.telefonica.de. [77.189.126.73])
        by smtp.gmail.com with ESMTPSA id h13sm4511834wrs.42.2019.02.12.04.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:44:27 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:44:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
Message-ID: <20190212124424.GF1622@szeder.dev>
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
 <87sgwtjjbk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgwtjjbk.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 01:13:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> As seen on https://gitlab.com/git-vcs/git-ci/branches there are
> regressions since 2.19.0, e.g. we have hard compile errors on BSD now,
> and maybe AIX. I haven't dug into it.

Where exactly can we see those?  Could you please give us a link
pointing directly to such a compile error?

