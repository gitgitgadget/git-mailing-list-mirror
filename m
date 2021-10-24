Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75130C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFF560EDF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJXR15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhJXR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:27:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD8C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:25:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so3670048wrd.13
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:subject:from:to:date
         :message-id;
        bh=tJeXKvnXNCqLTcjmnH2DojUc52zStGLA81g2b6qakd4=;
        b=WKfHfjl1hdYxZTVbIRlFy2KFH1c0ot2k0nNHWb1F85oPCD+Lv59QhfpSncos7iYTDP
         z0IpU9iN1CnSPtS4JhNLBNS1Oq1sQYKkCZgVqZCz3l13bJsphI7mTeVw04+w9/EzA/i6
         B5/asHyM3n0lHPV38qKDLAtWX+pvhr9UVqlIBcWO29JJwJvzvmEM2XnoAvcjnmZNq6w1
         jLDyk7TTJ6nf2As81q/SvC8jjSo2CWOiPDYYb86ybwfDPtnYKhtNPVMJDsw30wydHgc4
         +cjOr5d2zg57q5HbnYitSCuumBWOmh24RUETwp+eutU51cRHQXTq46mxvXWO6Nv1kOI0
         x3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:date:message-id;
        bh=tJeXKvnXNCqLTcjmnH2DojUc52zStGLA81g2b6qakd4=;
        b=zdhlGHQcY8BIfwYvoOK5v6FRsLi44R05qd1ofdl0qLWzjoi2SL0k0d4jVAs1kMm9u9
         u793PgNTGNGg6BLvu69usK8RTj/ZHnt0TOSbT+yV2sh246mpWRFBdS0Mq0CvbSDdIzsL
         gXAj2jkHFCgEMUETuLoci7jTYnGFqrjiAsDLSiguz7lpSOmGkWPeaTNjAPlrbdRHpVW6
         rC91DkOfxSqY6pjAttTHgIIdmRcWYYOmZo5NMtqIhqp99OKj/OaNTCYKVd7k/gKFw3lH
         gxxPiHA/ZuJaRH4NBCaZ0HfZol/K92lDTbciws9ikof26cDg1C2B4wyDCYqhrUFWM5QJ
         E34Q==
X-Gm-Message-State: AOAM530jrYAEpEjPasEsdbCt5Gcwc6BqRxC0J5k05X6fYZfyXfJZzeF3
        1E/TQ6zrZDNDHPY7fk+INkYF56Ad/6k=
X-Google-Smtp-Source: ABdhPJwHh5adFBVdsfDA3Z6vEsO1HXxeQuGM4fasAOVkFmXorQGw4YiL+2fPpzuLRdgWUafrqG+d4A==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr16646478wrm.181.1635096330310;
        Sun, 24 Oct 2021 10:25:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:2c2:db70:f896:2223:eb4e:b5ca])
        by smtp.gmail.com with ESMTPSA id h14sm9721763wmq.34.2021.10.24.10.25.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 10:25:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
From:   "Robin Dupret" <robin.dupret@gmail.com>
To:     <git@vger.kernel.org>
Date:   Sun, 24 Oct 2021 19:23:15 +0200
Message-Id: <CF7T869H4UYO.3GYODDJ6QKL27@MacBook-Pro-de-Robin-3.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In-Reply-To: xmqqbl3u5fhy.fsf@gitster.g
Cc: Jeff King <peff@peff.net>, Robin Dupret <robin.dupret@gmail.com>, git@v=
ger.kernel.org, Robin Dupret <robin.dupret@hey.com>, junio@pobox.com

Hello,

Sorry for the late reply, I'm not really familiar with mailing lists.
I resent the patch with an ammended commit message.

Actually, the goal is not to add any maintainance burden. I just thought
the original prose was not really intentional. Feel free to discard this
patch if you doubt it brings any improvement to the code.

I'd be happy to send a more substantial patch later if the opportunity
arrises. :-)

(Thanks for your comments and again for all your work on this great
tool !)
