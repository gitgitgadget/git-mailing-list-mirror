Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3E81F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 21:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeK0IQX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 03:16:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44120 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeK0IQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 03:16:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so17134295edd.11
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=py5fznEVZ9KSaMRv51X/rjdnTDaDyw3iIiHsduZ7wM4=;
        b=jZfyAwdtPxaoYsw9OwxQ3ukDQ77+M6gRpHyd/AqS9V07WpVKG8PJDndV+5WI3deF9e
         I02z/3f36xNIlush8J6u5HjtAMfa9tbhVbkifxx49rBfYeh62NdNwHUeQ+xYuPTd1Zi7
         bBnxE9QMq0+aXgjIiEfJM5jtcUfIm5ieN6257y9rupGp3Ul91XP7y9CkdFEXX0vM+Kj5
         sEVK7USHWdjjAeD4/6ZS3p0N2c8PKm3BJgZrmEpJKq202eEhP16I8noJKvwkI2civ+Ut
         byXXBvxzzRtcY/grc34WTrq6UYlr5AzBGTb94b3+hQvBb1Tm8sfHg+jVRNgvwi+KFySg
         83EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=py5fznEVZ9KSaMRv51X/rjdnTDaDyw3iIiHsduZ7wM4=;
        b=ZA93OYfiaBFxSz7lvW+HvkCcTTKczd9PkIp7CZaP+f5Ax7NHdhoM3+NSiB28rE9tVf
         kAh7gGny2sndDbf4feFu09knlmmyj0WO+E9wDuIH/s6PphSKBcqicm4FYiPLwBz5fKnZ
         t/8+sk9Uwr4qp9qQ6Ipj8O+DYBDtgvtffoa9Jlao4saCM8uhv/ayWWcSc/U+3FCbe8Hn
         2lOHw/bglY6dLtaFIv6PjzHi+DjJ1/wPilvs5269/fZBTh6fhMBP70RQYDT94bfggMY5
         EJnloTDpWGbnYEVPBdK0wrhEqYbmyHR6HItRhehPeQePAPsUSglS9GnkWOrydfM1RolS
         1g0w==
X-Gm-Message-State: AA+aEWaFRH/Lz1OD0IT47/yOqMNgu62cr5KqrLpceZoQUZmiyYF9JIQH
        +BXupT4TYHmA0sULIPEKwYxOsWXgsnaWDKg2s3tScQ==
X-Google-Smtp-Source: AFSGD/Un4mVJ9F/zubTCd+hA1xyWGtxO1sbngp35IJT6572/JROJ6fXIGLA12/miu5GZ2q3vPL14PMj+iUOs7xE8ulI=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr8978106edy.231.1543267255359;
 Mon, 26 Nov 2018 13:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net> <20181123111658.30342-1-phillip.wood@talktalk.net>
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 13:20:44 -0800
Message-ID: <CAGZ79kZXW3YoptBzG_Bhjpnh6-7AYTWwT5tcrow2SDwNoF65ZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 23, 2018 at 3:17 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks to Stefan for his feedback on v1. I've updated patches 2 & 8 in
> response to those comments - see the range-diff below for details (the
> patch numbers are off by one in the range diff, I think because the
> first patch is unchanged and so it was used as the merge base by
> --range-diff=<old-head>.

`git range-diff` accepts a three dotted "range" OLD...NEW
as an easy abbreviation for the arguments
"COMMON..OLD COMMON..NEW" and the common element is
computed as the last common element. It doesn't have knowledge
about where you started your topic branch.


> For some reason the range-diff also includes
> the notes even though I did not give --notes to format-patch)

This is interesting.
The existence of notes.rewrite.<command> seems to work well
with the range-diff then, as the config would trigger the copy-over
of notes and then range-diff would diff the original notes to the new
notes.

>
> When trying out the new --color-moved-ws=allow-indentation-change I
> was disappointed to discover it did not work if the indentation
> contains a mix of spaces and tabs. This series reworks it so that it
> does.
>

The range-diff looks good to me.

Thanks,
Stefan
