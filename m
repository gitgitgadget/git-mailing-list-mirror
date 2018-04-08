Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75CB1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDHXK5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:10:57 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36699 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeDHXK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:10:56 -0400
Received: by mail-wm0-f41.google.com with SMTP id x82so12584162wmg.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=y4kK/ekOcNYpi6NYQHBGFp8YxZqSXqYhnfWEf1AtDko=;
        b=lZIgpDgJxQWlF1CwaYA9pwa1JplK2z0f+bgedrVhnfvtwQ7AS45ESXb0Wls9iNd1c/
         2IVcG//bd5LfT3TpsQUJ7IXHgdWNYMFXYVAN0ROT1JHU+j3IowhIvB8kHCN2GqCXj4u0
         6U+CnTKTLX6KIIBIT1ev5NvWNBiqzKG98n4AqBHyC+HGUstNabXthJ22avX7ULhsoBcL
         eQqNXem/bdW+RGcmMNHNwYLpMY15CZXV1MfYICQP6mdFlCtEucFmjQlHtc8v10anhP6M
         c4jYXHFRMc24R0KYxyd4/F8jBOmah+VJ/csu1A4ZujX9wJbeJpd2cysTBe5MUmJgi0VW
         UHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=y4kK/ekOcNYpi6NYQHBGFp8YxZqSXqYhnfWEf1AtDko=;
        b=Zk3eHI3ht6NUFJRDgxsWhpD7FnkFo81s3sgR17uxKxg6bMjy8kRPAknFGQXPZg3ds1
         ILooboDerRKVaz/WqN3VPtiXxNelDnshazZuy/lJZD9G/3lHC4dJ9iiTGk/EQSVmOxLf
         J4wpPdaKwkGIIZtgQJ6Ud1PBLcYJ5ck6cQjv1tHMi4qqDZHTS6GgmBJps2x3a6eSfHw5
         hEvL6J8IHNC4/3bcH2KIBGC/5VXrrQG2B1ckM+9trFokCzOO92HdjM0SXeKG12fk01qQ
         9Z4J9eMcvkZVIlZvqpDe6rkKOJN/KbRm7jOT2j+tA8ABprYWs+rW2k2FxYR/qIdxsgwk
         Hb/Q==
X-Gm-Message-State: ALQs6tCjEY5flwpCbRG9sCiGlzGhPQfigeqgY+WRzVLUPmAH7jdKHAkD
        S/IJEU0jaB45hrf19z/tbSs=
X-Google-Smtp-Source: AIpwx49vljl1nqvkPHOcYaPpemUI1T6N8+dEf3/3/SId+IMn665LCs13uj83igCVReTl2LRTSnWIkQ==
X-Received: by 10.28.134.138 with SMTP id i132mr17384208wmd.101.1523229055271;
        Sun, 08 Apr 2018 16:10:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m35sm20484374wrm.59.2018.04.08.16.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:10:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] filter-branch: fix errors caused by refs that point at non-committish
References: <5ab7d550.dc96620a.4b512.feab@mx.google.com>
Date:   Mon, 09 Apr 2018 08:10:53 +0900
Message-ID: <xmqqr2np8fb6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

> References: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
> Content-Type: text/plain
>
> Sorry, I forgot add a line of "Reviewed-by".
> I'm gonna send the fixed patch again.

Do not worry too much about this.  Reviewed-by: added by patch
author is seen rather rarely, because the following sequence of
events need to happen:

 - The author sends a patch vN

 - A reviewer reviews vN and says "This is now Reviewed-by: me"

 - The author re-submits patch vN+1, where the only difference
   between vN and vN+1 is essentially _nothing_.  Except for the
   addition of "Reviewed-by:" by the reviewer.

But our typical patch injestion cycle is much faster and often the
last step does not happen ;-)
