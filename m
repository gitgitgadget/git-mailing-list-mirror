Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF54C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 23:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF8761244
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 23:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhHOXId (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhHOXIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 19:08:32 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37FC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 16:08:02 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id d15so3994482vka.13
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GQHGNOHZuiqm4VjBKeqr37npp3zQwGiOYfhMR432LSM=;
        b=pfcej5b7XH5oQP42YvKXIRFLlN81IOFhwETyXt54PJwx06pLyBrKHiEwPS+f0K1Rad
         XVoebYahv77CuyAGtXKkK2ZDgkLm09E2odo2OrtJ+0dJ+Zj61k5oVZmQZvQtfpgvxgUZ
         UBBlhZYrF/kWaNzj78e/aZafJfzbCWFb4qjVJzfKamL4EM0tRG/Q7wmwgdY5A7kQu916
         /fbcEfv7pgpjfyU1A9m3GyyYiYcOnALQe1RAnieC3LW6m3EIXi1sU5WdBEoVfaCjcOin
         cd1LrsnFRMQz+qufUODOP9A4zY342rBQ2orofResAL9MWjD003F633PorudyGFEOQ/w/
         ZZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GQHGNOHZuiqm4VjBKeqr37npp3zQwGiOYfhMR432LSM=;
        b=lfI1aE8otQE1GMPmi37LFFTGs3kUZYAkm500XfamUuLEsdZAiXY+niYqB5fxJns7Cn
         O/2Kn70u/c0EqGIk27t16i6vMdo2Ynov7+O1rDYyMd0fcnzPmb76yicmfNshF4Or1n2B
         rtcI+RInn/MLTXIqm3gyBMqe4RCvz3ht8fnMBbnOInTMILGJDZhpAF75Wi8MpKhzpVpw
         vB7T/ftyAz6Dx7xrrBAmH2k/9cRd8T2/v0yS1fqHDubMwIG0KzD1TPAwelNzyr39qwVH
         tyDPTUPPcmJqVeeRDz/GwggGWENk83jXmWfEAsWioHBIw2+7R4D951sKY+5ImchyywU6
         SvqQ==
X-Gm-Message-State: AOAM5339GZ9RL+gf8DtFLsnFF4bJRFVxznnW9E27g5K1876xglZNo+sm
        sbcRct4PHKtdbqkNni06fzIHmQbyeTQJFXqhzhER6dwxz+k=
X-Google-Smtp-Source: ABdhPJyPsKE4W/QWOC9p3te7Hk9IuIRTQgOlYmhgbVulcg2QP7QSFlbTnnTBcBh22KZXTPG6n7Aq3XtSIYNYpTwezec=
X-Received: by 2002:a1f:28c6:: with SMTP id o189mr7526939vko.22.1629068880458;
 Sun, 15 Aug 2021 16:08:00 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Sun, 15 Aug 2021 17:07:34 -0600
Message-ID: <CAJfuBxxT_7weC8_O=KYScSbDcSeBdb3v5d_gtn-NXzW_fKLrsA@mail.gmail.com>
Subject: git format-patch -s enhancement
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi all

git format-patch -s is sub-optimal :
it appends the SoB,
which falls after the snips
---
changelog ...
that the commit message may contain


So it misfires on any maintainer scripts
expecting the SoB above the 1st snip.

The workaround is manual SoBs above any snips.

I note this in -s doc,

           Add a Signed-off-by trailer to the commit message, using
the committer identity of yourself.
           See the signoff option in git-commit(1) for more information.

"trailer" is really "document current working behavior"
(normative docu-speak, so to speak;)

Ideal behavior is to find 1st in-body  --- snip
and insert there
