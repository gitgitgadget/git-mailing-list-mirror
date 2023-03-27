Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95456C6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 22:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC0WSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjC0WSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 18:18:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA616125
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 15:17:59 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m10-20020a17090a4d8a00b0023fa854ec76so5223526pjh.9
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679955479;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3IBu7vncXS5mPreq5Nm5y5Ta7L0x9Sip6ADWd11c5XU=;
        b=pbFv9ZL3L2aia6tcnu6/K/hFf7odL1IZ78sf6hVNW4ohchEBRywfHN+1xhg+kcsKna
         8J0WtPQnl38XHxtuUVTE0DCirkthskZ4Xyi7JSJxr9gGl3wUQ9DAL7y0Hz6T8cD0TpgQ
         i5w/B9kLEfU49HTFV1E2A54jf78jtzAO++0n2jRqsCLfXeLFYNBkDWB7ASvpbpR/UioZ
         bqdcgw72GiHRE+GULb/9MZFj0crByRtlV43bYoe7OhXLeScci0sJAhrTdHx7kTUM60G6
         P5CqfLrb1GvEAcUES2f4uCDkUJeA6Ln+Ot0/8NIFQfhR/l1sNUv28/l2sZJUAk+m4CSv
         L6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679955479;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IBu7vncXS5mPreq5Nm5y5Ta7L0x9Sip6ADWd11c5XU=;
        b=fuEAkLVlZNdBxUoGMSvsigUACa8rvIY0qX2tCdQ0Ht8LnXI+/09IC3d1FWpjt5GelW
         pjMreyHkiIQztl9t9UAUFR17xNnP/+VELhrg4vQaIgmTCKICXaUHKXEvfWizBRxLFwyO
         7UnceWm7LqdAkUIgCRHBvy116f36gok1HeURCg26S12kBy4EGNTOecBnIry1pFu7f6HL
         4+fR9LbXkqBf0antdRifILw1GKfwm83XTDirLM637/k1pXersTWZ+BJtBN1IP/UWiGRc
         3DMcG8oTukIfKTE/fw2qW2E/Y53UfaB4KmpCyeUBckcPTGY9sTafdEuxHUEQg4JMxtdS
         dKMA==
X-Gm-Message-State: AAQBX9ezGsM9DX7sn3tPOVe4qBvY3UtOUrHrt/HDryvISdfz6hScR/R0
        8AmpTELV8aqbDoz3oiCNrxfNwbP5HpYra+OFw9xOupsr6XnOAzGETPZseKy4hcigEJa5FIopqrq
        BOHIfAc4pgKUhJfls/eeBE7REhcdP/gcZgRPzHeMzI4x2VTdMY1B81GfRXyQxeN4=
X-Google-Smtp-Source: AKy350YeIfi/Tz1tD5Wf3aF/ooZ3VCmVX7g0RaYFdBALEBHeCrPuqV9v7f/FZL2ftNE87cY+cdTuPvj7tlWVvg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:50e:0:b0:50b:dfee:48a6 with SMTP id
 14-20020a63050e000000b0050bdfee48a6mr3643127pgf.5.1679955479223; Mon, 27 Mar
 2023 15:17:59 -0700 (PDT)
Date:   Mon, 27 Mar 2023 15:17:47 -0700
Mime-Version: 1.0
Message-ID: <kl6lsfdpdek4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
The goal of the meeting is to help reviewers learn from each other, and
to get better quality feedback up to the list afterwards. We run a
session every other week, and you can find the full schedule on
gitcal [1].

This week, we'll be discussing Jacob Keller's changes to "git blame
--contents" [2]. Let me know if you're interested and would like to join
(off-list is fine), and I'll send you an invite :)

If you're interested but can't make that time, let me know too! E.g.
there has been some interest from folks in Europe, and we'd be glad to
schedule Europe-friendly sessions if that helps more folks join in.

See you there!

[1] http://tinyurl.com/gitcal
[2] https://lore.kernel.org/git/20230324170800.331022-1-jacob.e.keller@intel.com/
