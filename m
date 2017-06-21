Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E99920282
	for <e@80x24.org>; Wed, 21 Jun 2017 02:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbdFUCeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 22:34:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34132 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbdFUCeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 22:34:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so24917275pge.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=w5IpHsoVHQyinBG7V8r3lh6Bk8PRiUU0hiynybeY3QM=;
        b=XPbKHIEEXUjvMGYn8VBP/FVu6Lj8yo+8Y5mXAlLamvqqVi9O1F41iDFkq7uMGUX7hi
         T0adOGiY6P7B3vbGGKyMEaNteW5AdPRrtMA7AZihqQqyRIylE5kbedWLJqgT3xVVvuee
         YWKrAd8eNi+j0Qp1jPiU3HhudDoK8eyEg7pGCQF3hjKaRUDDkj2Mqiz3I7DUOOZdb4mg
         7lxZVfee+qYNlNXkHOtGyVT1Lyx5MEAh8+zdq+8WLz0CiJdIgxu1ioR/BcjlXwN2CGig
         XFwXr4viNfac4sS6TjNhBX7qW5cI0e6E/KE1NlbLPYWi3HeMFl8EIDMS7+YI//wCzQlI
         Oy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=w5IpHsoVHQyinBG7V8r3lh6Bk8PRiUU0hiynybeY3QM=;
        b=X7hUN2NNysAXjXAnr4aEeNiAxDTsClVtQGRx2k8SHwvV3RmO0cUfILNXk9xoubjEUI
         BKv27wk3xQYLF83N4OCRQn9+GetHusGWaNdLI2vw+XDsyr1+VVuKY+NwjlKF67LjrJEq
         KTYwMbS9rGlRivqseqJHhZEWzkrdTShnm4x3KYvCvCskVGlB2afkJPPvx4lTV4t5oOsh
         aiSBnm4+L2R9gu5uuMW2LWlnZGrHOEvXE6wPPeTcKGnUN4yqxBRBEMJ2vnMhWUrwd9kG
         8oextqsC3Y69/O7blNiHnQKs/Os/Ejf/ZA5CyWkaw0vvZi83JiqeN/B8B/Uf/Ufr5hRq
         VHyw==
X-Gm-Message-State: AKS2vOzn+Ju6ojxlv70BuQeLNFHDgthtGY9YC6YzztED0tep1ZTsgg14
        qA9VWkSBGtauTTvGtjt9ig==
X-Received: by 10.84.239.23 with SMTP id w23mr38935067plk.73.1498012475828;
        Tue, 20 Jun 2017 19:34:35 -0700 (PDT)
Received: from unique-pc ([2405:205:850b:870a:56ff:b236:2b2d:3a08])
        by smtp.googlemail.com with ESMTPSA id 79sm32030741pgg.46.2017.06.20.19.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Jun 2017 19:34:35 -0700 (PDT)
Message-ID: <1498012463.1487.2.camel@gmail.com>
Subject: Re: [PATCH 1/3] Contextually notify user about an initial commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Date:   Wed, 21 Jun 2017 08:04:23 +0530
In-Reply-To: <87mv9290wl.fsf@gmail.com>
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
         <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
         <87o9tj86hs.fsf@gmail.com> <1497965839.2792.2.camel@gmail.com>
         <87mv9290wl.fsf@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-06-20 at 16:41 +0200, Ævar Arnfjörð Bjarmason wrote:
> Right now 1/3 breaks the test suite. That's a big no-no, any given
> commit should not break the test suite to not break bisecting.
> 
> But aside from that the general pattern we follow is that if code
> behavior changes, tests for that new behavior go in the same commit.
> 
I did think of squashing the first two patches, anyway. Now the three
of them (except for that spacing fix) must be squashhed. Not a big
issue, anyway. I tweaked the suggested commit message a bit for the
following reason,

Ensure it follows the "describe problem, justify solution, mention
alternatives" pattern as it sounds good and natural. I wanted to keep
the alternatives as I found it to the commit message to be a more
appropriate place than the mailing list archives. This could induce
others who see it to do the same ;)

> 
> Regarding the format: I was referring to the 'prefix the first line
> with
> "area: "' part of SubmittingPatches, sorry for the brevity. I.e. your
> --oneline output just yields "Contextually notify user about an
> initial
> commit" but should be "status: <short summary>".
> 
That's a good one. I initially thought it was optional.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
