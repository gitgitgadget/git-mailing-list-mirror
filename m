Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3816D1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933698AbeAHTtL (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:49:11 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:47047 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeAHTtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:49:10 -0500
Received: by mail-qt0-f174.google.com with SMTP id r39so15062970qtr.13
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ekbEgWqE6ahwATCu0v7hr6aXt4DOB8zKx0VNzdItyGM=;
        b=GHujcIs0kDnT5+k4eVUeS253uD+Ev03KuSFdd84kaWUml7akf2uNYTYO4MOkF+ziLC
         63wJic3GhBji2L1wJylv7RigSF2F/+jjvjm/rqZ+ePw2Wr0ATYSdMI07RvpvsTXHUzZz
         ByzqMtVLKpBYhKrVyZczvqtJoyZTUC3MOWthF32mZwnNc9Jv3ijkiiJi2wE2VL5/8/me
         Om5C4S0JPBeIv+GfALK4l7PYUS51m4btWtov7AlXDSBSGtGGApDay29hWhSi77qw21BX
         fFmfYf0qREqrBg1X9c3YrGRRkBcEBL6yDE7jnjk/ey/JnlGb53Zb1w2sWjpvuoVkwPO/
         Wf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ekbEgWqE6ahwATCu0v7hr6aXt4DOB8zKx0VNzdItyGM=;
        b=fA7BHB/ACwd+XJy3tNcqLkquEZuBgdpJM/xU4h+ZhjOV75+Osgepy6g4KVGowNQPGl
         /fuB+qpoz/fvXfqlRNmOdX4abr21FiCCJ3rL8HH/6ikrCLHXSUMR/HBRjEqHdUD5QaCU
         aVkgyEA0tvsjkMv5uMrw/WDZRdEj/OT9oxvs7oZxbkW60iOr11E3w9v5zcQINYu3ZseE
         ldMbtCKdpF3GeKhdF6YV2ohyt7Z/Hag1sks1cOpNI++vnI9+sYcM8HF1Kv6NvpGdj3ki
         XIfp12x1DDw4Km9wkHO6qe+LW6PLRVeDAxB+De09Mib8B4Xr3q9vpzm7P0FdwrIYy/TR
         8i6g==
X-Gm-Message-State: AKwxytez5oKULHGXfTDHZaRxzpUJwwaBChmDhK5qAJqJnOnn8CKg22dF
        ZuodZ2ZFY5qkpW3zOJTay2sl3Pv6
X-Google-Smtp-Source: ACJfBotjE+WHTkWVFmlEXEwr3w7cFvisCFYJjiFp4ebd36RgHEi6/EGWL26VHvk7jwH3fzil/XDy5A==
X-Received: by 10.200.49.6 with SMTP id g6mr16809940qtb.279.1515440949992;
        Mon, 08 Jan 2018 11:49:09 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n3sm7975351qte.14.2018.01.08.11.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 11:49:08 -0800 (PST)
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180108154822.54829-1-git@jeffhostetler.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
Date:   Mon, 8 Jan 2018 14:49:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180108154822.54829-1-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/8/2018 10:48 AM, Jeff Hostetler wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This is version 4 of my patch series to avoid expensive ahead/behind
> calculations in status.  This version removes the last commit containing
> the experimental config setting.  And removes the undefined return values
> for the nr_ahead/nr_behind arguments as discussed on the mailing list.

While I like the simplicity of just turning this off completely, I do 
wonder if we could come up with a better user experience.  For example, 
could we somehow limit the time spent computing the before/after and if 
it exceeds that limit, drop back to saying they are "different" rather 
than computing the exact number of commits before/after.

I was thinking about something similar to the logic we use today about 
whether to start reporting progress on other long commands. That would 
mean you could still get the ahead/behind values if you aren't that far 
behind but would only get "different" if that calculation gets too 
expensive (which implies the actual value isn't going to be all that 
helpful anyway).

> 
> This version does not address "git branch -vv", but that requires
> passing data across the for-each-ref barrier and that seemed beyond
> the scope of this task.
> 
> Jeff Hostetler (4):
>    stat_tracking_info: return +1 when branches not equal
>    status: add --[no-]ahead-behind to status and commit for V2 format.
>    status: update short status to respect --no-ahead-behind
>    status: support --no-ahead-behind in long format
> 
>   Documentation/config.txt     |  6 ++++
>   Documentation/git-status.txt |  5 +++
>   builtin/checkout.c           |  2 +-
>   builtin/commit.c             | 18 ++++++++++-
>   ref-filter.c                 |  8 ++---
>   remote.c                     | 50 ++++++++++++++++++++----------
>   remote.h                     | 12 ++++++--
>   t/t6040-tracking-info.sh     | 73 ++++++++++++++++++++++++++++++++++++++++++++
>   t/t7064-wtstatus-pv2.sh      | 69 +++++++++++++++++++++++++++++++++++++++++
>   wt-status.c                  | 41 +++++++++++++++++--------
>   wt-status.h                  |  2 ++
>   11 files changed, 250 insertions(+), 36 deletions(-)
> 
