Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB4420357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbdGNO1r (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:27:47 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34868 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdGNO1q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:27:46 -0400
Received: by mail-qk0-f178.google.com with SMTP id p73so13176792qka.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C5Cjxw9NIu46P7VgFq1Ha12AdPW+kff05ecUmOz/Sjg=;
        b=lNafKK4fl3J+KfsnoXCaUpZD9XcP88liEGokRJ8S+EuwSOyRlqLXFvKmd/5n5BAPat
         vSQgW59eYBarcDqyWgnzB7TSEgouXRMOZ06DbEleDdJOZmJtKA3hYwBHRGzV+deRI1Hu
         /8G051HbwLlkoeVIkYHDbx0+YIIhsIXlEt8IUukBRDFLc+i6397RTx8YKAXqpcTu+O1z
         xT5LOSZmYDLOQ/jhK7rs4vflEy7Qr4hyKMFObr47YiBXeSdgkolQqI1hTOEl2blHwbHQ
         3NYIPCiiN6c5YwtxxaP2j57rFKMMo78Pkl+YvJrg9fq0MJ9vCxKIoFr7iRD58dECqSZB
         6sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C5Cjxw9NIu46P7VgFq1Ha12AdPW+kff05ecUmOz/Sjg=;
        b=Q1CIr74AUmycXSQZDTT1Q6SzoM0YTIBaEJ8ouASamPh/FjCaz+L/A/1XwfmeQfqr0V
         dnjusxBc752oYBl/WBkRevvFlqtEJGAoroYfFC6NXQZkMIAVNYB++TNLxzn3iUDHt2o2
         Xk1cCHYDA11uBEtDxZepoRI3rHtlUWrFM5ugb8pCf2fNqTlI5gxQ/vwOlf5aig7aFx8o
         OT7lnkkdoAnI0YpH7Kh1ghd8miQyAFqKLfR2or4lBBgSl4wjriek8p8I6V/1qFWc9/a+
         SU8Szy5TgP4L1gwUkOw+42SJxRUcgthN9IFdNRlpo2D82suMeW0a6IcD/PHBhGpc7iej
         GLLA==
X-Gm-Message-State: AIVw111IJ8MECACCu/3EkudCJ0nLs3JShIlA96h0Ay9j332jLFIXPA+J
        mse5LYzMrhIr3Yvs1SWCPb2NqN4DzTGq
X-Received: by 10.233.235.132 with SMTP id b126mr12209934qkg.262.1500042464857;
 Fri, 14 Jul 2017 07:27:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.31.54 with HTTP; Fri, 14 Jul 2017 07:27:24 -0700 (PDT)
In-Reply-To: <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net> <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
From:   Dave Borowitz <dborowitz@google.com>
Date:   Fri, 14 Jul 2017 10:27:24 -0400
Message-ID: <CAD0k6qRdq7n=LM7TFJYKvC4uiMMCus8kff-Lm28GiC_G-Feb2Q@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 8:11 PM, Shawn Pearce <spearce@spearce.org> wrote:
> In another (Gerrit Code Review), we disable reflogs for
> the insane refs/changes/ namespace, as nearly every reference is
> created once, and never modified.

Apologies for the tangent, but this is not true in the most recent
Gerrit implementation. We update refs/changes/CD/ABCD/1 and
refs/changes/CD/ABCD/meta in a single BatchRefUpdate, and we set a
reflog message on the BatchRefUpdate instance, which updates the
reflog for all refs in the batch. The reflog message on /meta is
important, and arguably it's useful to be able to correlate that with
the reflog on /1.

If you think storing reflogs on patch set refs is going to be a
problem wrt on-disk storage, we should discuss this offline :)
