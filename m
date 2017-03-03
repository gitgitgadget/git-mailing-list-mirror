Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4827720133
	for <e@80x24.org>; Fri,  3 Mar 2017 23:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbdCCXM6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 18:12:58 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34858 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdCCXM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 18:12:57 -0500
Received: by mail-lf0-f49.google.com with SMTP id j90so16658810lfk.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HFRjyf/j+smmZkQJq18ZjD1idvwKRZZfGArQXK0t2Sc=;
        b=DeUTnfcne04R7Ovu3U+M9ZXATRy0NtjJWi+++ILGPOnj1WisPcZ35L1CqYj5K/emY1
         lFolN6awz0khTHk/R3DePIkiPtVJVWBORxc6fzeciHevUDJEhRgkfLQ55bpZhcwASqtn
         NNkbcfai3nrWy5JeAXnMaEixbL3hYSnRssXJaaLNWD6Vsrl7xR3gtqZWS/z77sUIEDjX
         yL/CQdYbsLsqDUDg5/u+2RbUa9V4J0P6zaTi03jYfo0T4wwMTbgFjzW8Gn1o4pZNVqBR
         HMZaTaM6PrGBExa4jibcps/ceTn/JlCN0p9mqtyTIYwgUq2MfBE9UFW4KlZ1gs2PFAqK
         f76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HFRjyf/j+smmZkQJq18ZjD1idvwKRZZfGArQXK0t2Sc=;
        b=lRGoBmR2oohjFB9OsJAk6VccQX1kfRDP0B2eZRRSfsKZ7KkYvvJrWbjzRKi2MwBLAg
         KvrRbnWR3iS0F6cqXJtadXK1eHHsDerQFBz90wGPOIY5SOJkViKHO0IRU+iBxw3vAYor
         YhmSRKmgcPmiCb7Qga/fH26LJ45Xh9NQoD/vQeQdf+XubTxMO2kjsp2J/qv3SIpqIYMo
         ZjNbSjlehi+LF3XPo4EL6IHjjLzWK5kS/8ymKgvoJvwHvbMzD2sW9EWHpcKkrI0X8HCH
         5+Edg87AsEMy+sNpt95pyC3kDciRuv2NeXH1OH5JMAnG0tZUPs+865MHO6FJMjEpdVyH
         zwMA==
X-Gm-Message-State: AMke39kQ8Ge5e2aX4e+7vw/2V4Gy7+SyFcKRdQowaHCyu6vOsV1cy5RL7eX0EPwP4QHFHuLOvMd1Z8WfkuqfdQ==
X-Received: by 10.46.20.94 with SMTP id 30mr177559lju.87.1488582294426; Fri,
 03 Mar 2017 15:04:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Fri, 3 Mar 2017 15:04:54 -0800 (PST)
In-Reply-To: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
References: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 4 Mar 2017 00:04:54 +0100
Message-ID: <CAP8UFD0tzH+QiNM2BMhe9qcKdD0rP9T=Ry94=EPV+=d+7cdLfQ@mail.gmail.com>
Subject: Re: bisect-helper: we do not bisect --objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ever since "bisect--helper" was introduced in 1bf072e366
> ("bisect--helper: implement "git bisect--helper"", 2009-03-26),
> after setting up the "rev-list $bad --not $good_ones" machinery, the
> code somehow prepared to mark the trees and blobs at the good boundary
> as uninteresting, only when --objects option was given.  This was kept
> across a bit of refactoring done by 2ace9727be ("bisect: move common
> bisect functionality to "bisect_common"", 2009-04-19) and survives
> to this day.
>
> However, "git bisect" does not care about tree/blob object
> reachability at all---it purely works at the commit DAG level and
> nobody passes (and nobody should pass) "--objects" option to the
> underlying rev-list machinery.  Remove the dead code.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Christian, do you recall what we were thinking when we added this
>    mark_edges_uninteresting() call in this program?  If you don't,
>    don't worry--this was done more than 8 years ago.  I am just
>    being curious and also a bit being cautious in case I am missing
>    something.

I think I just copy pasted the code from cmd_rev_list() in
builtin-rev-list.c and probably didn't realize that revs->tree_objects
would always be false.

Thanks for spotting this and removing the dead code.
