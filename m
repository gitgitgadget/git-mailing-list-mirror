Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B641F453
	for <e@80x24.org>; Thu,  7 Feb 2019 00:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfBGABV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 19:01:21 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:58455 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGABV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 19:01:21 -0500
Received: by mail-it1-f202.google.com with SMTP id p21so7700118itb.8
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7p1pgq7nTUl883QExqlpt2T+RkA7Q7QWkhl446kpTG8=;
        b=UCoDYG6tPHHYN1rOOZRyU3cRGFzibG+ZntkckDUwT6m1ySrpXDlHwGYSnU6Hc2jrYO
         LcGGfz0SAOF6zvEcFg0WSzrBW76jIBxEDvFyuLTMs2Nt4IFiUC2/TaT6qe9JriGX3QOw
         LQCHyR/vf77Ox1llFMTQ2bGqYofWjcwQaqNCla5GihjGYzb/ZnkuQSmZ5nG5jPlXTnpi
         crhkqq66IV5s5Yx+EMzLWNdxSWi9cAkG58008Ylj5/WKGVo2vOZUY2/NqejVpTTj7uuA
         hsxSNiAEJUhKcz2qUhEgHmdCqb3JWybEpkhsQLyHCaT1wjN4GNHQ+Qg5WTOa6tgdhqjN
         wo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7p1pgq7nTUl883QExqlpt2T+RkA7Q7QWkhl446kpTG8=;
        b=TgfBGDupP/4cPwJR99/2ShsbCdB/ag3/pKU9QMtf5QdjLJUAyFUMOS5PeL5iPrc14T
         ULSkgDUMb3KzCSZnkVqaGEo0Zrs2k4Syt8l2DCMaqeEuHa0Wgu5xnVqrBXMKNMbuWcU1
         25p0wrZJ/+V7mI1xjl+y7cs/V6UMXQGSlMdakl/5FiKV5hB9TvCxzhlgYGdwQhmD3si6
         MOZRM578QSoh0zlyf9jc+Zk0ivl5rkJCmArPvflyePLH7LsuSHAFNLB8Ire134Ec+Snh
         q9au0E1EN4bKGlEz6Y/ECKie5xo2fW70MrT/LAwDChap7QMIswNo5wZmicH6Rx2Kvc0W
         iLiw==
X-Gm-Message-State: AHQUAubuE18sbgi8vq0dRMIm8M/I+FeVD4heaaOuvs7hBCcDFwSZuJz/
        cjBOF6A1HKZCcbMu4GW/Cc4pGkyNh20t0qS7614s
X-Google-Smtp-Source: AHgI3IaOlnKXD53ulnnr6LTYh5GRFY/2BlFVWNlVZls/MYA4oegtlpUE8RHm8px3+5Wa00KB4w4LqBZ2TF3G0Xz+j2DS
X-Received: by 2002:a24:5f93:: with SMTP id r141mr4300106itb.4.1549497680195;
 Wed, 06 Feb 2019 16:01:20 -0800 (PST)
Date:   Wed,  6 Feb 2019 16:01:16 -0800
In-Reply-To: <87d0o4lgtr.fsf@evledraar.gmail.com>
Message-Id: <20190207000116.55126-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87d0o4lgtr.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 1/8] tests: define GIT_TEST_PROTOCOL_VERSION
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -327,6 +327,9 @@ marked strings" in po/README for details.
> >  GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
> >  test suite. Accept any boolean values that are accepted by git-config.
> >
> > +GIT_TEST_PROTOCOL_VERSION=<n>, when set, overrides the
> > +'protocol.version' setting to n if it is less than n.
> > +
> 
> In my version
> (https://public-inbox.org/git/20181213155817.27666-6-avarab@gmail.com/)
> I didn't have this "if it is less than n" caveat. I expect that helped
> with making some tests that were setting e.g. protocol.version=2 Just
> Work, is that the reason for this?

Yes, that's right. I thought that there is not much value in testing
tests that are explicitly protocol v2 as another protocol, since there
was a reason in the first place why the test writer wanted to test it
with v2.

> Mine also had more docs here, but maybe telling people that they can use
> "env" is too much...

With the ability to set =0 to effectively disable the option (because
the minimum of 0 and 0/1/2 is 0/1/2), I thought it was less important.
