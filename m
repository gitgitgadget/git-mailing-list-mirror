Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150571F597
	for <e@80x24.org>; Thu, 26 Jul 2018 19:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbeGZUe2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:34:28 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:56400 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeGZUe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:34:27 -0400
Received: by mail-vk0-f73.google.com with SMTP id k74-v6so1029606vkk.23
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yg14MtC1KL1H7VKWToXVwgncmvYd2dBy3wTj+ihZWGw=;
        b=rEcDfT3mRXa+iQQsCYOCAB83nCAlIb9EacO+1xvatDhR2mRfyBYCin08zGAibVHNpp
         iady4CFPu7VSfC6SxdfDKArQGhtvRLAjsW352hYly2vuKxmRkldSt2beSFspZzlH7Xb3
         I9N93JsXzhttrRUSq0L83Fx3a17BjhITrEWrkaEJ0tujJUCdltFB/NPDtBJi8ATOspxd
         a1L71kkDbyLBn7vakIkyiemW6zclsYiEfxgkez9PUSTZ5pQDe+TebLn+Aq8vWcIEbHbL
         i6htmoe4FYilhu+TNstwYuctcIBZ1fnHwXtjIS7vCnqVm5PTcQfjeLnF5BBxh5tJ2HEW
         IRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yg14MtC1KL1H7VKWToXVwgncmvYd2dBy3wTj+ihZWGw=;
        b=MjqAQb7iIfizqOu6sT8bVw/QBealE+mjkeUUzWeZ5GMjuUMj5gZtUTcweKyoqgp56i
         8zpkA5FzWtCleOOf5gy7p+9HfFYWMfPorvm6CQCg6A1tGdQBJS72pqZwTpV2JO+i41qB
         woxDWP3dhZtC1aUcTq68QhDZWI5/HDhDmxq3+H0YzYw1EEmTy4K+caYIV2OafBZPCNSU
         xWINhwGlhIATawMtCqKEVRphYBjtuTPd/ar2XqJRVQrPxVabCtxU+ohTJ6zKDrd6kPJy
         Ix/hXabeIQrWzvWXFw7l8k7iuO5vaBxd0WU08YDCFrXHKwwfdOwfZD5ewFP5KnVdwrTm
         elYw==
X-Gm-Message-State: AOUpUlF9EtdKsUnFK0i5UXNRLgQiJacch/DYT2Gt0kEzB67bPBYV1mv1
        VLl6ueEbzqnVkiB7WpHyW4FFGLZcEAQoKYD2dqMg
X-Google-Smtp-Source: AAOMgpfnTXxUAPvcFFUcPis5lEMSpj86AefrU1hKdXtKbyIsYsRRawHN5W2eU6NTkSMYQb1eCWzTdcyF5epHbZ0KNqtk
X-Received: by 2002:ab0:2044:: with SMTP id g4-v6mr1442594ual.15.1532632574334;
 Thu, 26 Jul 2018 12:16:14 -0700 (PDT)
Date:   Thu, 26 Jul 2018 12:16:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807261233300.71@tvgsbejvaqbjf.bet>
Message-Id: <20180726191609.176343-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.1807261233300.71@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hi Jonathan,
> 
> On Mon, 16 Jul 2018, Jonathan Tan wrote:
> 
> >  t/t5552-skipping-fetch-negotiator.sh | 179 +++++++++++++++++++
> 
> This test seems to be failing consistently in the recent `pu` builds:
> 
> https://git-for-windows.visualstudio.com/git/_build/results?buildId=14337&view=logs
> 
> Could you have a look, please?

Hmm...on my Linux computer, this test passes on both pu (as of the time
of writing) and 838143aa5c ("Merge branch 'ab/newhash-is-sha256' into
pu", 2018-07-25) (pu at the time of that build, according to the website
you linked above). If you could rerun that test with additional code,
could you add a "cat trace" and show me what the client sends? When I do
that, the relevant parts are:

  packet:        fetch> have 9ab46928dc282aa09f4dbf96893a252e058e7e8e
  packet:        fetch> have dc824fafb05f3229aedf1f320bbe572e35364dfe
  packet:        fetch> have caef059de69917b9119176a11b88afcef769331d
  packet:        fetch> have 41bd8dc092ee110ba80e350a346ec507ab2e42a0
  packet:        fetch> have e9a2c092a8e911567a377c881a7f6031e7f892ea
  packet:        fetch> done

which is exactly as I (and the test) expect.

Two possible reasons for the discrepancy that I can think of offhand are
that (1) my computer generates different commits from your test system,
and (2) the priority queue pops commits in a different order. For (1),
that's not possible because the SHA-1s are the same (as can be seen by
comparing your link and the "have" lines I quoted above), and for (2),
the code seems OK:

  static int compare(const void *a_, const void *b_, void *unused)
  {
  	const struct entry *a = a_;
  	const struct entry *b = b_;
  	return compare_commits_by_commit_date(a->commit, b->commit, NULL);
  }

Let me know if you can observe the output of "cat trace" or if you have
any other ideas.
