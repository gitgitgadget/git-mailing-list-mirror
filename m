Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD1C4361B
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3913564F2F
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578578AbhCBPZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350744AbhCBMq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 07:46:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D52C06178C
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 04:35:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v5so30969976lft.13
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2qrRqGJ6oKWpa86gB/fj653WkeLsBaqXJpxwDuC7/pE=;
        b=myGGV9j5yKduGwbU7GFakmmbdZfUA/J2zfG6sU+qJhjxnO3c09i4ptA+1GfyktoLym
         uW2UcjakavIlbZw0QcxoOomi/403FAaHwMpkOVPUqUPwQ6MSL5PHWJQfqQ4AKg/delUr
         SSnuWYFjJqSxOaIlBF1sJf0RNpcveVhXhaWOOhBl4gjec5m60AbUHnJHA0EQNKVUU74V
         hYzz7LUaowrAtyhqJPFPNgCr6yAF1rXzgXi7pu8r55xIK3fXphz7yC51J5dBj1v5/YQk
         VFSXyZuWtMECvXbJEeh8GdjSWvn8XZW+lMS9jYBRKfYOJcKlEuVdAfAC7ScGsHRIiTgF
         Ac7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2qrRqGJ6oKWpa86gB/fj653WkeLsBaqXJpxwDuC7/pE=;
        b=m8c598X9vPVz63U0YuY32R5EoI/AHXDYO0SAywv2ToRKXPm8IglAsk3xArPWkK93Fw
         S+iBhLgLQCntkTaQZz2LccPM0vdb5TrIXXizT6LtdIBrURtWiqkqLGarO4MX55vwyI1Q
         2K9C/h7F149HE3QIFOasPyCS2VolioKCTdZFTCKuEOcScHIPyRm+wu6g5GRsUXLObLss
         41kAWcWFu7vWvy387qz4OSqTheQ6N5NUl2Sqf6ffvYLc/yB2t6/1IhgYoMjM46d8SKEF
         IkVNuw+oUbKqK/V7F6HCPlng2BOEILANXN2RKgcwsNXil/OQsGW4ikgvIMAlDPRqmfmU
         OUVg==
X-Gm-Message-State: AOAM533hqY3v9oJ6UjJAqywf7nQUCHdFyNmaX+oAfa97RwJi3oSWu6gu
        CDZIrnDdLa2/gLHPSk/opHM2poZ03qbkp1v74yTp65Chnng=
X-Google-Smtp-Source: ABdhPJwOXOpIJRIf7cpk2lLEFa0ZJ7+JTGiIE4uXm/5y8HdcUzwE4UbWBvzBugjTpftwF8Oc+ACY7/2TAdUpmGz5VUI=
X-Received: by 2002:a05:6512:308f:: with SMTP id z15mr12148201lfd.409.1614688515141;
 Tue, 02 Mar 2021 04:35:15 -0800 (PST)
MIME-Version: 1.0
From:   XonqNopp <xonqnoppp@gmail.com>
Date:   Tue, 2 Mar 2021 13:35:53 +0100
Message-ID: <CAJU-ojOhSpGraS=Cwy=kMNxNgN=T=o7Eq-BxcAfSLHMzmtAm9Q@mail.gmail.com>
Subject: =?UTF-8?Q?Proposal=C3=B6_git_push_=2DF?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

Thanks for everything you do, git is really an awesome tool and I
enjoy using it!

I have discovered some months ago that it is more safe to force a push with
git push --force-with-lease

But since then I keep wondering: why is this not the default? Maybe we
should have --force (which would be with lease) and
--force-without-lease? That would be more logical for unaware users...
However, I would completely understand your reticence to change this.
I just want to propose to change the shortcuts:

* "git push --force" shortcut would become "git push -F"
* "git push --force-with-lease" would use the shortcut "git push -f"

This is just an idea of mine, I wanted to share it with you. Feel free
to use it or not...

Cheers :-)
XonqNopp
