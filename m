Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ACEC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 10:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhLNK7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 05:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhLNK7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 05:59:48 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C6C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 02:59:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r5so17041551pgi.6
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1DUBNsWKb/j65IjEU28013P1RLBAN9QI4r4VwNcziQ=;
        b=AHWEtFI1vUHOrdv4ZIFB4m5jICW+Oa1+ML4qXlqIBDxXf2f/mxUCoiAPzUCbEsPVJR
         oneMpY0pcpk3s0v/SSacV0RuQ2gxAnKwS7qZx+iYH7AMxaP2MG87I9q4dLRPDCkllMQC
         gEes8tI+c/o4Jb+hN2t4Tprc+i/LjDi3onAuQbvZ5rjfyOjUuVCYWYr+TGCcP3/kBFYn
         1Ldv2HMxvDKWzLq1DazCKR5PWn5JwrjO4zMxBK+rlKVJ+N/P13DOs7oKmsJ0yGucunz+
         bhnSOzjWbOCNAssdEkHoEnP9nayxTG1ACJ99ZvmftpmqTGCwHimwxcVDgqjjFGuaumY5
         FhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1DUBNsWKb/j65IjEU28013P1RLBAN9QI4r4VwNcziQ=;
        b=xUev/auoc3KKbwulsxnLEsCf+z52bPy4lseZkNdyySkmF6X1Sp0EnQCEexcibzNtVN
         fPma/FOcWtg1GPNH/U/8L+C/KfbBgVUoGVWZCKIOAmbwU6SI4i2MSG2w+Xfcj39WTo1+
         T3QL3z0SdF5Z/pyiwRoyK3nU2ylAjtECT3da+S7neB6RslhcCFNTkSUThyFxxN1Tyh1j
         DaUjRcBRCJ5taLFVEQdIh6b/f+jbWZpEknZABAVY1IJ6w/7lClPqdd8Ycks2xhLNGeaB
         dJ9/C0h/OBxfEKd4oSgGi6BvYtStoVdFgi7+jBv+zii1tpZU2SBAmAdcc1uGg2WGbiQJ
         PpbQ==
X-Gm-Message-State: AOAM532Hb9ITIu06zWxhvAr24Ya+J+mMncoqDYjBN7yoK8YJMr+ZfJDi
        O6BDpe58skLKpzcEuvb6mLw=
X-Google-Smtp-Source: ABdhPJxZ+C2MJgErXG2WQdULnSgjYtJfs5febCasPUd6dT4mZJzlKa0OUOcwxfZ5Q6KNVVfi6VVH6Q==
X-Received: by 2002:a63:751a:: with SMTP id q26mr3207053pgc.529.1639479587512;
        Tue, 14 Dec 2021 02:59:47 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g1sm14455683pfu.73.2021.12.14.02.59.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Dec 2021 02:59:47 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: 'Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)'
Date:   Tue, 14 Dec 2021 18:59:41 +0800
Message-Id: <20211214105941.24670-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
References: <xmqqilvvluoa.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, 10 Dec 2021 18:52:37 -0800, Junio C Hamano wrote:

> * tl/ls-tree-oid-only (2021-11-22) 1 commit
>  - ls-tree.c: support `--oid-only` option for "git-ls-tree"
>
>  "git ls-tree" learns "--oid-only" option, similar to "--name-only".
>
>  Expecting a reroll.
>  source: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>

Yes, you are right and the source is matched as Patch v3.

On 8 Dec 2021 10:08:30 +0800, I sent a patch v5 in ths series: 

https://public-inbox.org/git/cover.1638891420.git.dyroneteng@gmail.com/
