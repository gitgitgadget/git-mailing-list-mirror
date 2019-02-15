Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367DF1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfBOSXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:23:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33989 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfBOSXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:23:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so11387610wrg.1
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=INhaUe5kSv81NTKn97dRJny/93pI9nqbtkzX1eo+TFo=;
        b=Zt5IJq0WpTkLtPChh7PJYNFs+3gU63uSPvAiIPoWPKG9hcYRILRQNlp0U1vB6kRmgj
         dZCqKi5gvJGKQX2pquwBId6SvDmtCJQ22mlHZEjBTUk0EPs3vZJ20inSp+lc4SEp+v9e
         rcjN/dwBEpzGD0dL9dWVa44+u2aB0iDYhYyb+flvA7OfSYSVWAfv6+euOZyIgrzz+tqc
         eo8sbjJewaVsRdr4JfMN6nmKfeFVhUAVnJ6dIIu8MixI93YHmBR9h+2FROfzOzadqB3M
         LjuylfczOJonGY0ZJF+n+AQ4Ma7081bSEPBYMZ5SCLlo5MlvNHpmVF89XrI6VRZ1VXMg
         rNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=INhaUe5kSv81NTKn97dRJny/93pI9nqbtkzX1eo+TFo=;
        b=t3hR+9JRQcObNTiGojn8E+msKgrewofU292Rkc+TXnafmjHTapIbVTRaYWvQuU+h6q
         mRzyoUce69JkzF3vM6z3Bt60i1e01oUYvU6WkVf4qSMszao0o3C3YIa3+rwSTV01GMvM
         wHEyytbbo7jsxnkpNpwHeuHdxrzkw/NF7/5uC5AGzLZIuUszJDGio1q3na3fX9mPIwBM
         3pAUWirNaEhQuwHO9p2Js/CxsLouFxtlHOGVY74xY9v+CL4b7zSdsnSuzn4SprbkIo/j
         cNA14J4nvVDt052xbHg2T0FXOxrbjRJDh55AqYWafSnVHsifI9VXROlHWPtH1kU5CpY4
         Y08A==
X-Gm-Message-State: AHQUAubfVEB71N6Y8L6lvpHuNF3BENdOTF4fRDRqVqPwyQ10FlQa2S2n
        QmDq/qsFFFG2AFBcGbbx3fRDnA2A
X-Google-Smtp-Source: AHgI3IaLgRNXmWCc1HSYl6eEWLxE8qnjisHEe+p7HxXjMSSs7Ehf3Uaz9wKIq+I+Ggmc0Vrct7siZw==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr8661339wrp.227.1550255010864;
        Fri, 15 Feb 2019 10:23:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm12402724wra.46.2019.02.15.10.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:23:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/8] technical doc: add a design doc for the evolve command
References: <20190215043105.163688-1-sxenos@google.com>
Date:   Fri, 15 Feb 2019 10:23:28 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com> (sxenos's message of
        "Thu, 14 Feb 2019 20:30:58 -0800")
Message-ID: <xmqqlg2g6hcv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sxenos@google.com writes:

> From: Stefan Xenos <sxenos@google.com>
>
> This document describes what a change graph for
> git would look like, the behavior of the evolve command,
> and the changes planned for other commands.
>
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> ---

It would really need a summary of what changed since the earlier
rounds, if a series this size wants to be re-read by those who
helped the previous one.

I briefly looked at the patches (and the diff against the previous
one that has been in 'pu') and saw a few comments that say "needs
further work".  What's the intention?  Unfinished but soliciting
further comments and sanity checks to help polishing the finished
parts (if that is the case that is perfectly fine, but it would help
those who want to help if you are clear about it)?

I'll read them through laster today or tomorrow with fresh set of
eyes; thanks for working on this.

