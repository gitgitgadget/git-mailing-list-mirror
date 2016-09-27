Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCE720986
	for <e@80x24.org>; Tue, 27 Sep 2016 12:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbcI0M2Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 08:28:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34758 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751939AbcI0M2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 08:28:14 -0400
Received: by mail-io0-f193.google.com with SMTP id y139so813059ioy.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cri6qIWbXAAM/Vuh0QPdgZ4tEPJlr1/H6pARbhme1Vw=;
        b=DeH1R4cN0GT+7b/GhxeHFdZSr8KlzAiBfQOqLWojUmijbziJ+nGkCTt+mlSqyFx5Cg
         2WD9aZG4d/uTLB7LgRzn/aJagZdvIMRKkC09BBsFbNOZe4bEn8qUeQ76ervzRzISKsbs
         Kze/1XAjtyPjYjxQJMZkXzC/Wn7qM6oWEOX1ugy4WRrafo6/NlC6r8a8IUDb+qt3Lhop
         aGqaoB+pdQdK7pkRimbXjQvZ17dzhNHgU+BS0/WjxeDyrLpE528vbzQ2Hgh4ALKiYNRG
         bwV9mFAD62JJZBLmobESVagvQkm8BPmogc+b6b8Y1mADBW5H+xMmDXXuMslonpysC+KH
         rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cri6qIWbXAAM/Vuh0QPdgZ4tEPJlr1/H6pARbhme1Vw=;
        b=bY0pycMO0ncwnTzpyHTTkN8kQvxGh8Yip8qWOY+oQetp2QpS1jOU4cYDPVmP5z7uuH
         /5XvfcRU7QeKCRlHR62wjIcAp3sDCXFYGRq01s7syLMwm86zC8kywQEydSr+inXWJYIs
         6ofG1mYUNISMTv4GKgnIN9OmCvmJl9eEz9BHgqNzFpYALIO4pghPxdcn7S7HVGJyq4vC
         3ECa4R5kx3zds62WH20j9H6iuBy1NDZoZ9BrbWhDZekcN35J8vhWZBw8ocTmN6MakGe3
         seqjDOjq16nZIkVoutusXyNXNqlrI+DQzwNgoJodG9bzy6JkmrkQLWK0m/nAPkRPdPLv
         rpQg==
X-Gm-Message-State: AA6/9RkRAQo8IG3PV9lFCOBDH9fc+TUy3tt15xTcdzf2Fi2B2lsMomT4iKgMQEF9HagBt5BUU/UtSRdilRc1HA==
X-Received: by 10.107.175.18 with SMTP id y18mr1197870ioe.86.1474979293359;
 Tue, 27 Sep 2016 05:28:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Tue, 27 Sep 2016 05:27:42 -0700 (PDT)
In-Reply-To: <CACsJy8A_CWgcS5za-Dha6Khgd6HqHk9UWHq7qqAeR-kns-syXg@mail.gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com> <20160606111643.7122-3-pclouds@gmail.com>
 <alpine.DEB.2.20.1606091815310.2680@virtualbox> <CACsJy8A_CWgcS5za-Dha6Khgd6HqHk9UWHq7qqAeR-kns-syXg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Sep 2016 19:27:42 +0700
Message-ID: <CACsJy8CsfPqOXReM6tzBDyVob-oSAKinoA6C6TKjSyy6Y9WuJQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 5:58 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> but then you also have to change the type of xdl_opts
>> to uint64_t, which in turn means that you will have to change the
>> definition of xpparam_t's "flags" field from unsigned long to uint64_t.
>
> I miss a connection here. This new flag is intended to be used in
> "flags" field in struct diff_options. Is there any chance it can be
> set on xdl_opts (of the same struct, I assume)?
>
>> Maybe this can be avoided?
>
> I don't see a good way to avoid it. We normally enable or disable diff
> features as bit flags and now we run out of bits. Adding something
> like "flags2" works, but not pretty. Any suggestion is welcome.

Never mind. I think I found some way that does not look particularly bad.
-- 
Duy
