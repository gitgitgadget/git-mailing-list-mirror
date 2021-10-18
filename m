Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBFEC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9460A6103D
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhJRRfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbhJRRfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:35:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C639C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 10:32:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q202-20020a6275d3000000b0044dc3987ae6so2218706pfc.12
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cHnrQ253efgjXTlAdhcHiwPUcKweiTxXEp9f76AnWKU=;
        b=VvG/TJsgpzzmZAiTiBchwNXm6ujlwyxxdtDl1R1XgiR7hY9JnSO1Mwb5HkF8+PYtjE
         SGjpD62HnGtCtiJ6tM2gqFfYPpyEiX8d1x8je3Mt6ZyxqjoCuvxVnRkZucUW2VYxauVc
         skoH4wCKNRQu4BhLcrFr6WvC+jkqxmVjI4ef0cKDNk7VwaIFOeZvG5JjSydMO0EuWnks
         eAo07IVUmeDZFH6fcQHQsE8QieN8/NUYBY5NMKR+0gOeZzGhFmY94YZBeIdXN/bQm2+5
         puN28i5Vk4FWvwzDnPydQvsSP+62hLwJH5mCdd+uoRRN1oiyYkhmjpSD9EQFNj/zdX8m
         fhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cHnrQ253efgjXTlAdhcHiwPUcKweiTxXEp9f76AnWKU=;
        b=hxQu795V2jdL4UAriObG47Hu2CzPV61Rk6a67elNyGVSBdL3W801vLphg0lk30VWcC
         ziHN7KVeGGaGZV14LumdhdIhnBlomvgOANPXeAfWerE5rBM4LABHTnZvjxnfzwiE/KzL
         7/UB3pjgOoZt7x/uMCS1EHWiwtSL0d1tBkyGSEk9ZTcmywSLSzxFl+/wwfcSEtAv614M
         TLoaoUIoqY0AbNtTvrLMrNrSGWSpDnF+HFQ2O4/nnfG01c64t32YeEeApJ8Y2+2r2olu
         jYTaVNmNj0pSQGUI5R1gyLCp4q2O83cLPlawczphZNFMTKyrAtPSSGGl9TyWHDi7a/QN
         0L4A==
X-Gm-Message-State: AOAM530WT+hmTzNrEEAwKOFd500NW4C7d6zeoPoohQahC5JDslhOOqYH
        1tQczUN6MNwRJeST3m/sZ7CnYApYnojbMA==
X-Google-Smtp-Source: ABdhPJzGdjUuaxUGMpcZEs1NhGaYIy/CNqO3tuQ4agEyjlO0U2i9NS5k5+CmFwmxkIVdFcqj9cPQtSXwfzE1Fg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c20c:b0:13a:3f4a:db58 with SMTP
 id 12-20020a170902c20c00b0013a3f4adb58mr28082316pll.12.1634578376688; Mon, 18
 Oct 2021 10:32:56 -0700 (PDT)
Date:   Mon, 18 Oct 2021 10:32:54 -0700
In-Reply-To: <xmqqzgr6w97p.fsf@gitster.g>
Message-Id: <kl6lzgr6z1a1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211018124106.542050-1-bagasdotme@gmail.com> <xmqqzgr6w97p.fsf@gitster.g>
Subject: Re: [PATCH v3] Documentation: specify base point when generating
 MyFirstContribution patchset
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The fact that we are having this right/wrong base discussion makes me
think that including the base is out of scope for first time
contributors. 

> But that does not mean master would always be the right base, does
> it?  What if you had a work totally unrelated to the contents of
> this tutorial on the 'master' front?  The person on the receiving
> end may not even know what object it refers to until you pushed your
> 'master' branch out.

This is the crux of the problem, which is that the contributor's base is
actually their private 'master' branch, but their patches go to the
upstream 'master' branch. Does it even matter that the patches were
originally authored on a private 'master'?

If it matters, the 'master' should be part of the patchset or it can
be described using the conventions of the list ("this series is based
off a merge of ab/foo-bar and cd/baz").

If it does not matter, then providing the base is not helpful.

I suspect that we are documenting --base is that we do not have *any*
documentation of this in our mailing list workflow docs, and
MyFirstContribution is becoming a catch-all for all of our workflow
regardless of whether it is truly for first-timers or not. My own docs
changes [1] are arguably guilty of doing the same thing.

As you mentioned in the v2 thread:

  Actually it is up to contributors whether they want to include `--base` 
  or not.

This is a level of discretion that we shouldn't be leaving to first
timers (as a very recent first timer, I would not appreciate this
ambiguity). This document should be recommending good, easy-to-follow
defaults for first timers, thus I think that discretionary things belong
elsewhere.

We might consider adding _yet another_ document designed for
levelling up contributors past their first contribution, something along
the lines of "Patch submission tips and tricks". This could hold
information that we want contributors to know about, but are not
necessary for a first-timer e.g. --range-diff and --base.

[1] https://lore.kernel.org/git/20210922202218.7986-1-chooglen@google.com/
