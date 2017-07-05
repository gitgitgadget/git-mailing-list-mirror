Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FDC7202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 16:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdGEQqB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 12:46:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33604 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdGEQqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 12:46:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so36646739pfh.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=+/T1jKSoYGafLDGIv/fChzGlI4iWlhJVz5/d4xUiZ8w=;
        b=QcMT3eUDinFR37VRJbBn0tcDM8WKofvVOMdYZYsrworgDpZQnMntPVLSyy38bFoaCA
         qBVFzabIsex+QKR8BwcQyetzyAsz/UdtrbhIsl34kAxZMLXyZUI/eRw4v1HhxGxt7Ul7
         BD9YvERngWy0eXcD0NDEM/9QcCEHU05lFPr5wVqfb3PDEyUBpUEXTDTwOjUfpMMO8//E
         AWPStfwhtimPWwIv4+kKaR0uuwjEmucdiQ7ss25msnKMHR8EBz57yrpfTn3XO2AxmPdS
         I+dGR7mpWPeKgtyhJgcVK/Fn3fNxYmsFwuCMTflNos9+LMoGtx6u9a3oiMMLc+XkqHBt
         Zkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=+/T1jKSoYGafLDGIv/fChzGlI4iWlhJVz5/d4xUiZ8w=;
        b=Ke/mpcvpE/zDRw6WLelSpc3NSev04I9KW5O3UI2qWNveGj8/5T+hW2qSXOGTvNZ9p+
         O5zSii8atNvRxpSHSOXadL9ujRWMl91GeK3ims9uY9S+PQE+SX87H4OiAkkKI1UEEPB7
         UzEVX8m1az3RPgbxo2Q1r0uBiCOOwrD7JZ2xB0Sh4q7EYaJdcRfw6aBDVAI+53QASHd8
         Z7zLPPfz3BjC+A7SkfkYurKLzH4uHTfsROnMkAOMl8KApjFllDyN79LTqXdGPhKgHITW
         chb8zYdbV95c0OCCt5TPjK8oVq2RHcl5Ce5OIXlleRLcbOGNbM7JP1+YCSz32ezZ3DTB
         CX4w==
X-Gm-Message-State: AIVw110qkNSovKzNDhgOu1vEP/9bud/vdLCJk1sJxdNQhM4LWUE/5AEE
        nMlzARsHqqlvVKMGxk0=
X-Received: by 10.84.215.154 with SMTP id l26mr12921400pli.244.1499273159596;
        Wed, 05 Jul 2017 09:45:59 -0700 (PDT)
Received: from unique-pc ([117.209.172.103])
        by smtp.googlemail.com with ESMTPSA id s62sm54176318pfi.36.2017.07.05.09.45.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jul 2017 09:45:59 -0700 (PDT)
Message-ID: <1499273152.16389.2.camel@gmail.com>
Subject: Requesting suggestions for a good sample "prepare-commit-msg" hook
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Wed, 05 Jul 2017 22:15:52 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

There's an attempt in progress to replace the part of the sample
"prepare-commit-msg" hook that comments the "Conflicts" part of a merge
commit message. This is being done as the "Conflicts" portion is
commented by default for quite some time (since 2014) and thus the
script in the hook is useless.

It's worth noting that it was the only part of the sample hook that
*wasn't* commented by default i.e., it was the only portion of the
sample hook that could be used just by enabling it by renaming the
hook. So, just removing that portion of the solution wouldn't be a
solution as it wouldn't be nice to have a whole sample hook to be
commented for various reasons. So, we're searching for scripts that
could both be  helpful to users and could serve as a good sample to
prove what could be done using the hooks.

In case anyone has any suggestions about what could prove to be an
alternative please send them in!

-- 
Kaartic
