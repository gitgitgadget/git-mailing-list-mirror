Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DCE1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 01:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966327AbeBNBYw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 20:24:52 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:40072 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966298AbeBNBYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 20:24:51 -0500
Received: by mail-ot0-f169.google.com with SMTP id s4so19028158oth.7
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 17:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=icgzH1oU33JfFFtS2kIziAJBC00MQShS0GCntxUkvy0=;
        b=NhaHshF2UWpkL8VbWL6F4WCOmiUoE+2JcnKcidvhn65+eHmtUkiu3FVdy8IeMTHxRD
         VJ9OX+MlWGHzizZJD2g84Hxa/QstqjRk3lnMB0C6oghsSJO6jNC88OorBo8n3rdOkvFa
         8NYwPA8flZlmt01YMkRkUgHWz7xOZ5/A2xrmndpAX0czBr3wMClp0TfyAiaw1AStYjos
         RTwyZU2jVJcKj+JjhvYBDmP4HftmWeI7MR6eUORIeev5FbjoaHo0sJd905OzprPv5GN1
         dgxUWtTHcUaq/9MGu+QVdn+XdjGs3N+PnsFPFzpFueIjZL6f7VTovw3MsPBKVcCwPpI9
         1I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=icgzH1oU33JfFFtS2kIziAJBC00MQShS0GCntxUkvy0=;
        b=p5z/m1a0G5koV4qkaZVVYGo3tJ9UHwT/Iwgvbo979RoQ7YMHUidQ3slrYlQXh3Dc3X
         rWcA8WWP6w2xfk9HWxBneqHXQaUVTJVcgISGFGdHug/4bCF2z/ZDrsSYljIo4GgZxcM6
         GE6HqAFk2vrOYAGEusGIfzE6y25m7oDt/L3FT36/kDMIf6H4oHgQodolxPmqVG1UyQSh
         vTX+ogHh+1Vj31/AIeM/fLRdHavcIInFs7c55vd7G0SiqniceQC7RKDHyCUrCi77CHUK
         BmQxUT0S8PBppXXBgiVl9XAIi9r0MY86O+UxvIFK2gWBcQK2CZy0YkCxOWjASkh1OxUe
         qpZQ==
X-Gm-Message-State: APf1xPB+KiSQIg6mlIWnDgkru+twfnNNtagg/ZLnIo5JnqjM2luGHfsq
        IQQ+UG9CJVQsquScgPF9ofhKFiPQ2ILDn2JQ/9Q=
X-Google-Smtp-Source: AH8x225flahZSXeg3/LYF4uZifVVKfZX4kcLAFbxQwSdGBcg2hZthN6Iinpm9uVBOKXhtoZftz+1tyuOyzdQ9d8is6s=
X-Received: by 10.157.31.47 with SMTP id x44mr2383969otd.165.1518571490595;
 Tue, 13 Feb 2018 17:24:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 17:24:20 -0800 (PST)
In-Reply-To: <xmqqinb0rcw5.fsf@gitster-ct.c.googlers.com>
References: <20180204093823.3671-1-pclouds@gmail.com> <20180207092141.4312-1-pclouds@gmail.com>
 <20180207092141.4312-2-pclouds@gmail.com> <c755e388-89a5-fc0f-f872-16fd5d5686b0@gmail.com>
 <CACsJy8AHa6QDmWu7TFjgW7m0pHysYkZq_WJ1QOVBVYaT4XdL4Q@mail.gmail.com> <xmqqinb0rcw5.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 08:24:20 +0700
Message-ID: <CACsJy8DYwvNGSWBP-2RNUn9xLBHUGtW1D7EuEYn7q_5f-N9Kvg@mail.gmail.com>
Subject: Re: [PATCH v2] dir.c: ignore paths containing .git when invalidating
 untracked cache
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 12:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> It's very tempting considering that the amount of changes is much
>> smaller. But I think we should go with my version. The hope is when a
>> _new_ call site appears, the author would think twice before passing
>> zero or one to the safe_path argument.
>
> Wouldn't it be a better API if the author of new callsite does not
> have to think twice and can instead rely on the called function
> untracked_cache_invalidate_path() to always do the right thing?

I am worried that always doing the right thing may carry performance
penalty (this is based purely on reading verify_path() code, no actual
benchmarking). For safety, you can always set safe_path to zero. But
if you do a lot of invalidation and something starts to slow down,
then you can consider setting safe_path to 1 (if it's actually safe to
do so). I think we do mass invalidation in some case, so I will try to
actually benchmark that and see if this safe_path argument is
justified or if we can always call verify_path().
-- 
Duy
