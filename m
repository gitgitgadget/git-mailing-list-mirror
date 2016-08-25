Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8D51F859
	for <e@80x24.org>; Thu, 25 Aug 2016 18:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbcHYSM1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:12:27 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36708 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcHYSMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:12:25 -0400
Received: by mail-it0-f44.google.com with SMTP id e63so287518778ith.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f+MocNldeVyKRDX2kchLyai26bb5Lay5kgulfflLYtY=;
        b=fVby5xu0YdaGtVewhNAut4SNPAa8ipD9DpA3X5GC94WhPdzrpt+iCsogm21wm5s1X1
         el927hyrJYs1/7Pr3U3qN4LTk0TQqWiaFA7CR+afxaS+nwXQ5qn4QgUj25H22O709NGV
         B/iFHPkAR3HsXJWyGbpL/aZXlZBOrQIm46x9Wy1hyNbh2t+IKtPdmHfkTwQwoc6hwsk6
         S8WaPol3rurI8QR18JaH3SpNJQgBprTQ5rFZ+80oIsh3704hOS7Qx8qfGp1ynFgjlpU3
         f7YfsE8x7FIALnGkP5JApq/cQCQUiFxGx/4TchfvOTFKNCpmT4iN7c/QEcG9AdYPRuMH
         O6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f+MocNldeVyKRDX2kchLyai26bb5Lay5kgulfflLYtY=;
        b=Otb8UMNmnkCFuGv1VxO7CsqpW9Vq3QjtlgGkV/e6C4rIINbZtEH6ntwGNr4wHdTjUr
         u/F6jVHSHz3HXSa8gdMGpsewvarKVG4awFnO1KxBAFWoPTq5dwuPHcjfaZdcbZzIVA0I
         JEG2wNknWegk1je70SDEFJUSgQ8Z2L0dzmHGfI3HaO1z6VGXg2FP44zZXH8405CMRlk9
         YCgXZlzzpM9pWiA4Iw7fXHPWzpIAVlUSNaSK05BqG2rrBqQqeksscR9mFIxOz43pnjR+
         ufHqt0ceD7sGMI0HipKGAMwdayyrmlhJfTR7EC7H4srbeC0TOEmKNQYvzU2oHW/lnreb
         wL4w==
X-Gm-Message-State: AEkooutH855qNF27bO7UIxNTotoftT83dP+hW1JZGxgcl/WBRSsCUixvtjY4/nG8Z1bJaBEtEti7PV/Fh/raniLE
X-Received: by 10.107.178.129 with SMTP id b123mr12167720iof.83.1472148734484;
 Thu, 25 Aug 2016 11:12:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 11:12:14 -0700 (PDT)
In-Reply-To: <20160825110752.31581-4-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-4-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 11:12:14 -0700
Message-ID: <CAGZ79kbEoYVM_+MWkajT2pHN1OKZXATe5d+Dv_uSJ7dyPGxUeg@mail.gmail.com>
Subject: Re: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +int packet_write_fmt_gently(int fd, const char *fmt, ...)
> +{
> +       static struct strbuf buf = STRBUF_INIT;
> +       va_list args;
> +
> +       strbuf_reset(&buf);
> +       va_start(args, fmt);
> +       format_packet(&buf, fmt, args);

format_packet also takes care of tracing the contents,
which was a bit unexpected to me.
Do we also want to trace failure?
