Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EBE20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbcJDRbx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:31:53 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38745 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbcJDRbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:31:52 -0400
Received: by mail-it0-f44.google.com with SMTP id o19so134830405ito.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DZBY+Sak1KEKXjO0mqgfcblb51HsZ3Zh1ZYMvfeSDyE=;
        b=f7vVTHG3kq6L1vveKgDiQ9mPSFhD8GLA37e7TOF78wQIfZ1ba8FCqcdFDxgIzS6GuT
         d0uqCANGT5XSg6OOYbC1I23vGekwjEAc42Yr0tmRYOX5l5GOlSrI7R5/wSLCImr1khEn
         jW4vY74j3z70QJgdXYDYi7oxkhkb3bNtLBBEmcvTQAlYKNePEGeAJrTLJkrrqso6akAI
         eT4KOoMJPEDORd85X7G6MJ54vnRb3++9AiVmNBYvMv6KEirbubzs6JYsHvo5xNsUAvwi
         J8WRPqL+sHb0K6qWSgUdWqxw37jj/FkMXi7n45CcvP9aAiFagtUK57kaSLOnwHEcEf5G
         PRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DZBY+Sak1KEKXjO0mqgfcblb51HsZ3Zh1ZYMvfeSDyE=;
        b=a3+rypoy6llQyC/ywLagdg3x7e/kmHTdkhit3NDpYV8g69f/X1btRA0roDlZAKM5C+
         /nKfr71ffuJ8f8lWGYxW8Cft1PWL+M5ifCKv0/myMs3i5kK/YwS/NlWxPxo+Wr/6z/o2
         yS32RsKIUeziD0jkSa0Ymv0Ouibivg+F2xMPo50orXTXjDJ7NLLUCleyNhB5TqyOPcAZ
         WkPVQQOBIG3haV2EHePmaXn6Uqegeky6pcyVaSB/pW4N6flWUgSbZbr1MxEoiTicouwc
         I2gSQgFz3SBhZ1RS3ZEwiB119KJmVLGcKsNL9rfve8ZsnOz+NmCLMW9lEJiSmJC4moWp
         zy+A==
X-Gm-Message-State: AA6/9RlmhbDQo0TH4tvgo2NB7mwr5Sm/EiWzH0l1sl7mFNe8rfOGIhokBGewCiW748Is5aTQRUSXL7ZJYpyh2GnY
X-Received: by 10.36.192.193 with SMTP id u184mr22598794itf.91.1475602312009;
 Tue, 04 Oct 2016 10:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.167.203 with HTTP; Tue, 4 Oct 2016 10:31:51 -0700 (PDT)
In-Reply-To: <1475185723-36871-2-git-send-email-bmwill@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com> <1475185723-36871-2-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 10:31:51 -0700
Message-ID: <CAGZ79kax9g-FLMhPnDBP+7wJwYT884B5bGodpopo9GKgnE6+PQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] git: make super-prefix option
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 2:48 PM, Brandon Williams <bmwill@google.com> wrote:

>
> +const char *get_super_prefix(void)
> +{
> +       if (!super_prefix)
> +               super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
> +       return super_prefix;
> +}
> +

As said earlier, is the following a valid thought:

> The getenv() function returns a pointer to the value in the
> environment, or NULL if there is no match.
> So in case this is not set (when e.g. the user did not specify the
> super prefix), we would probe it a couple of times.
> The caching effect only occurs when the string is set. So this looks
> like we save repetitive calls, but we do not always do that.

>
> +       if (get_super_prefix()) {
> +               die("%s doesn't support --super-prefix", argv[0]);
> +       }
> +

Nit: no braces, please.
