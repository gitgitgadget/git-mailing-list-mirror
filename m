Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E24A1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfBKTU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:20:59 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48047 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfBKTU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:20:59 -0500
Received: by mail-qt1-f202.google.com with SMTP id m34so29617qtb.14
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 11:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GbsQ2ZjGti1qIhykXrHh/mxp/FTyORqRUJzF02lw+ak=;
        b=NYzCrKorUUamiDdSgfl8nTkB25hftgOIGyE2QpLAVw2pFgQibEUWKoXzFCdXGUdwnu
         QdfWoVXZ0YNanKTtXWhZ0YZX4OMvtQB8jpFRi1siZCreE/gF5lwUBpvgNHdoO5RgbOoD
         uFQqouIXaKa7K0enBWcrH+45LfRF8UKvwyk+FvwQcDuo58WLoRCglhhEbt3obG3vDhJZ
         rQ9zHdASmfBzHENerX/nQVFpSadZboa5OvqDZ5WuVC0+RWISmjPeA5dQ+5K+cFCXUzsM
         9DGeVOfum7IYRtB00yptbCBPRZ1AkZeFK8FEtsHrsP/eWQ+FRgBYN2CfL2hNr1YZTJh9
         Xxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GbsQ2ZjGti1qIhykXrHh/mxp/FTyORqRUJzF02lw+ak=;
        b=OCuB+QTnJn/xz2TKojZpR0v3lJywXWUwWtjW8zUl7XxSFwMCjs8RoeXDsp4wi2pbyl
         KFaPKUrNLHFgN1qchr3zI8PomdO5adtvV+FC1Bz299ms6kDOiz+z65lBvhZjKoVtfJUM
         MAjNaZxvxj99ksr/6y3r0gRdrE4Qz3t52Ex7n+dxx/PvTbI3jN1z7Eo/k5M7E0WFV2Gv
         uvVrk2qtBB2VVH+pWzr6MhUUvDgnpf6GvzeB+RAYqnxUYkVEZWcz/uHAQIMklwC6s7sH
         M+wrNYsjMggHhIC31byQwZkUU+TBLcDiELZewqd3j6ozPftBgk3arjXLhD0rsXw0hMAJ
         g3SA==
X-Gm-Message-State: AHQUAua8N3RC5u/upNY6UszNviGI+WkV0v70M2EHb84pmewXu2+FiI1h
        S6bsJTmjL6x2s2+BTEZU25uk3fsHPwoF/yHc6IJ3
X-Google-Smtp-Source: AHgI3Ia2QFwaYnmwfOgKIBsTf2L+AAGH1kuWmfh/zu52Vs6p4K3XmNxnaRc+PivBjd6PGuibrNXGlm8jUbQL5beBitVZ
X-Received: by 2002:a37:4788:: with SMTP id u130mr21599187qka.60.1549912858165;
 Mon, 11 Feb 2019 11:20:58 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:20:54 -0800
In-Reply-To: <20190206212928.GB12737@sigill.intra.peff.net>
Message-Id: <20190211192054.80935-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190206212928.GB12737@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 8/8] remote-curl: in v2, fill credentials if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Feb 05, 2019 at 04:21:22PM -0800, Jonathan Tan wrote:
> 
> > In post_rpc(), remote-curl calls credential_fill() if HTTP_REAUTH is
> > returned, but this is not true in proxy_request(). Do this in
> > proxy_request() too.
> 
> Can we do this as a general rule? If we look at the code in post_rpc(),
> there are two cases: when large_request is set and when it is not.
> 
> When it's not, we have the whole request in a buffer, and we can happily
> resend it.
> 
> But when it's not, we cannot restart it, because we'll have thrown away
> some of the data. So we send an initial probe_rpc() as a sanity check.
> If that works and we later get a 401 on the real request, we still fail
> anyway.
> 
> In the case of proxy_request(), we don't know ahead of time whether the
> request is large or not; we just proxy the data through. And we don't do
> the probe thing at all. So wouldn't we dropping some data for the
> follow-up request?

Thanks - I'll look into this. Maybe the best way is to somehow make the
v2 code path also use post_rpc() - I'll see if that's possible.

In the meantime, do you have any other opinions on the other patches,
besides introducing a prereq [1]? I don't have any strong opinions for
or against this, so I didn't reply, but I slightly prefer not having the
prereq so that test readers and authors don't need to juggle so many
variables in their heads.

If everything looks good, I'll suggest that we drop this patch from this
patch set for me to work on it independently. (Having said that, this
patch set is based on js/protocol-advertise-multi, which is still under
review, so it is not so urgent.)

[1] https://public-inbox.org/git/20190206213458.GC12737@sigill.intra.peff.net/
